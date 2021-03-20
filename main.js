requirejs.config({
  baseUrl: ".",
  paths: {
    emulator: "emulator",
    async: "lib/requirejs-async",
    jquery: "lib/jquery.min",
    "jquery-visibility": "lib/jquery-visibility",
    bootstrap: "lib/bootstrap.min",
    jsunzip: "lib/jsunzip",
    promise: "lib/promise",
    underscore: "lib/underscore-min",
    "webgl-debug": "lib/webgl-debug"
  },
  shim: {
    underscore: { exports: "_" },
    bootstrap: ["jquery"],
    "jquery-visibility": ["jquery"]
  }
});

require(["jquery", "underscore", "emulator"], function (
  $,
  _,
  Emulator
) {
  //var Project = require('./project');
  //project = new Project('./starquake.json', 'starquake.asm', 'quake');

  var root;
  var layout;
  var eventHub;
  var emulator;
  var project;
  var log;
  var breakpoints = [];

  function navTo(srcfile, lineNum) {
    alert("Navving to " + srcfile + " line " + lineNum);
  }

  // Beebasm Worker
  var beebasm = new Worker("beebasm-worker.js");
  beebasm.onmessage = function (event) {
    // Single breakpoint resolved
    if (event.data.action === "bp") {
      for (var bp of breakpoints) {
        if (bp.addr === event.data.bp.addr) {
          bp.fileId = event.data.bp.fileId;
          bp.lineNum = event.data.bp.lineNum;
          bp.col = event.data.bp.col;
        } else if (
          bp.lineNum === event.data.bp.lineNum &&
          bp.fileId === event.data.bp.fileId
        ) {
          bp.addr = event.data.bp.addr;
        }
      }
      eventHub.emit("breakpointsChanged");
      return;
    }

    // Handle errors
    var stderr = event.data.stderr;
    if (stderr.length) {
      for (var i = 0; i < stderr.length; i++) {
        var line = stderr[i];
        var textNode = document.createTextNode(line);
        var errMatch = line.match(/(.*):(\d+)(.*)/);
        if (errMatch) {
          var error = {
            srcfile: errMatch[1],
            lineNum: parseInt(errMatch[2]),
            message: errMatch[3]
          };
          project.errors.push(error);
          var a = document.createElement("a");
          a.appendChild(textNode);
          a.href =
            "javascript:navTo('" + error.srcfile + "'," + error.lineNum + ");";
          textNode = a;
        }
        log.appendChild(textNode);
      }
      eventHub.emit("errorsChanged");
    }

    // If compilation succeeded, boot the disk
    if (event.data.status === 0) {
      breakpoints = event.data.breakpoints;
      eventHub.emit("breakpointsChanged");

      eventHub.emit("start", event.data);
    }
  };

  function buildAndBoot() {

    // Clear existing errors
    log.innerHTML = "";
    project.errors = [];
    eventHub.emit("errorsChanged");

    // Unset all source breakpoints
    for (var bp of breakpoints) {
      if (bp.lineNum > 0) {
        bp.addr = -1;
      }
    }

    // Send project to Beebasm worker
    beebasm.postMessage({
      project: project,
      breakpoints: breakpoints,
      output: "output.ssd"
    });
  }

  function toggleBreakpoint(bp) {
    for (var i = 0; i < breakpoints.length; i++) {
      if (
        breakpoints[i].fileId === bp.fileId &&
        breakpoints[i].lineNum === bp.lineNum &&
        breakpoints[i].col === bp.col
      ) {
        breakpoints.splice(i, 1);
        eventHub.emit("breakpointsChanged");
        return false;
      }
    }
    breakpoints.push(bp);
    beebasm.postMessage({ action: "bp", bp: bp });
    return true;
  }
  function toggleBreakpointOnAddr(addr) {
    for (var i = 0; i < breakpoints.length; i++) {
      if (breakpoints[i].addr === addr) {
        breakpoints.splice(i, 1);
        eventHub.emit("breakpointsChanged");
        return false;
      }
    }
    var bp = {
      addr: addr,
      fileId: null,
      lineNum: -1,
      col: -1
    };
    breakpoints.push(bp);
    beebasm.postMessage({ action: "bp", bp: bp });
    return true;
  }


  root = $("#root");
  emulator = new Emulator(root);
  /*layout.registerComponent("dbgDis", function (container, state) {
    container.getElement().load("dbg_dis.html");
  });
  layout.registerComponent("dbgMem", function (container, state) {
    container.getElement().load("dbg_mem.html");
  });
  layout.registerComponent("dbgHw", function (container, state) {
    container.getElement().load("dbg_hw.html");
  });*/


});
