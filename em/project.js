define(function (require) {

    return class Project {

        constructor(filePath, mainFilename, bootFilename) {
            var self = this;
            $.getJSON(filePath, function(json) {
                self.files = json;
                eventHub.emit('projectChange', self);

            });
            this.mainFilename = mainFilename;
            this.bootFilename = bootFilename;
        }
        
        errors = [];

        getMainFile() {
            return this.files[this.mainFilename];
        }

        getFileContents(id) {
            var dir = this.files;
            while (id.length > 0) {
                id = id.substring(1);
                var foo = id.split("/");
                if (foo.length > 1) {
                    dir = dir[foo[0]];
                    id = "/" + foo[1];
                    continue;
                }
                return dir[foo[0]];
            }
            return "";
        }
        updateFile(id, newVal) {
            var dir = this.files;
            while (id.length > 0) {
                id = id.substring(1);
                var foo = id.split("/");
                if (foo.length > 1) {
                    dir = dir[foo[0]];
                    id = "/" + foo[1];
                    continue;
                }
                dir[foo[0]] = newVal;
                break;
            }
        }

    };

 


});