var is_initialized = false;
var pending = [];
var stdout = [];
var stderr = [];

var Module = {
    locateFile: function(s) {
      return 'beebasm/' + s;
    },
    onRuntimeInitialized: function() {
        is_initialized = true;
        for (var pendingEvent in pending) {
            onmessage(pendingEvent);
        }
    },
    print: function (line) {
        stdout.push(line);
    },
    printErr:function (line) {
        stderr.push(line);
    }
};
  
importScripts('./beebasm/beebasm.js');

var compileFn = Module.cwrap('beebide_compile', 'number', ['string', 'string', 'string']);
var dbgGetAddrFn = Module.cwrap('beebide_dbgGetAddr', 'number', ['string', 'number', 'number']);
var dbgGetFileFn = Module.cwrap('beebide_dbgGetFile', 'string', ['number']);
var dbgGetLineFn = Module.cwrap('beebide_dbgGetLine', 'number', ['number']);
var dbgGetColFn = Module.cwrap('beebide_dbgGetCol', 'number', ['number']);


function hexToBytes(hexString) {
    var result = new Uint8Array(hexString.length/2);
    for (var i = 0; i < hexString.length; i += 2) {
        result[i/2] = parseInt(hexString.substr(i, 2), 16);
    }
    return result;
}

function registerFS(module, files, dir) {
    //dir += "/";
    for (var fileName in files) {
        var fullPath = dir.length ? (dir + '/' + fileName) : fileName;
        //var fullPath = dir + "/" + fileName;
        //if (Module.FS.stat(fullPath)) {
        //    Module.FS_unlink(fullPath);
        //}
        var val = files[fileName];
        if (Object.prototype.toString.call(val) === '[object String]') {
            var isBinary = fileName.endsWith(".bmp") || fileName.endsWith(".bin");
            var rawVal = isBinary ? hexToBytes(val) : val;
            //Module.FS_createDataFile(dir, fileName, rawVal, true, false, true);
            Module.FS.writeFile(fullPath, rawVal);
        }
        else {
            Module.FS_createPath(dir, fileName);
            registerFS(module, val, fullPath);
        }            
    }
}


onmessage = function (event) {
    if (!is_initialized) {
        pending.push(event);
        return;
    }
    stdout = [];
    stderr = [];
    var status = -1;

    event = event.data;

    // Resolve breakpoint
    if (event.action === 'bp') {
        var bp = event.bp;
        if (bp.fileId) {
            bp.addr = dbgGetAddrFn(bp.fileId, bp.lineNum, bp.col);
        } else {
            bp.fileId = dbgGetFileFn(bp.addr);
            bp.lineNum = dbgGetLineFn(bp.addr);
            bp.col = dbgGetColFn(bp.addr);
        }
        postMessage({
            action: 'bp',
            bp: bp
        });
        return;
    }

    // Find source location for address
    if (event.action === 'dbgsym') {
        var addr = event.addr;
        postMessage({
            file: dbgGetFileFn(addr),
            line: dbgGetLineFn(addr),
            col: dbgGetColFn(addr),
        });
        return;
    }

    //try {

        registerFS(Module, event.project.files, "");
    
        var before = Date.now();        

        
        status = compileFn(event.project.mainFilename, event.project.bootFilename, 'output.ssd');

        var after = Date.now();
        var result = null;
        if (Module.FS.stat(event.output)) {
            result = Module.FS.readFile(event.output);
        }


        // If build succeeded, resolve any source breakpoints
        if (0 === status) {
            for (var bp of event.breakpoints) {
                if (bp.addr < 0) {
                    bp.addr = dbgGetAddrFn(bp.fileId, bp.lineNum, bp.col);
                }
            }
        }

        postMessage({
            id: event.id,
            stdout: stdout,
            stderr: stderr,
            result: result,
            status: status,
            breakpoints: event.breakpoints,
            timeTaken: after - before
        });
    /*} catch (e) {
        console.log(e);
        console.log(stderr);
        postMessage({
            id: event.id,
            exception: e.toString()
        });
    }*/
};
