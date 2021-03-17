define(function (require) {
    var $ = require('jquery');
    var _ = require('underscore');
    var Cpu6502 = require('jsbeeb/6502');
    var canvasLib = require('jsbeeb/canvas');
    var Video = require('jsbeeb/video');
    var Debugger = require('jsbeeb/debug');
    var SoundChip = require('jsbeeb/soundchip');
    var DdNoise = require('jsbeeb/ddnoise');
    var models = require('jsbeeb/models');
    var Cmos = require('jsbeeb/cmos');
    var utils = require('jsbeeb/utils');
    var fdc = require('jsbeeb/fdc');
    //var Promise = require('promise');
    utils.setBaseUrl('jsbeeb/');

    var ClocksPerSecond = (2 * 1000 * 1000) | 0;
    var MaxCyclesPerFrame = ClocksPerSecond / 10;

    // *** KEYBOARD 

    /**
     * Useful references:
     * http://www.cambiaresearch.com/articles/15/javascript-char-codes-key-codes
     * https://developer.mozilla.org/en-US/docs/Web/API/KeyboardEvent.keyCode
     */
    var keyCodes = {
        UNDEFINED: 0,
        BACKSPACE: 8,
        TAB: 9,
        CLEAR: 12,
        ENTER: 13,
        SHIFT: 16,
        CTRL: 17,
        ALT: 18,
        BREAK: 19,
        CAPSLOCK: 20,
        ESCAPE: 27,
        SPACE: 32,
        PAGEUP: 33,
        PAGEDOWN: 34,
        END: 35,
        HOME: 36,
        LEFT: 37,
        UP: 38,
        RIGHT: 39,
        DOWN: 40,
        PRINTSCREEN: 44,
        INSERT: 45,
        DELETE: 46,
        K0: 48,
        K1: 49,
        K2: 50,
        K3: 51,
        K4: 52,
        K5: 53,
        K6: 54,
        K7: 55,
        K8: 56,
        K9: 57,
        A: 65,
        B: 66,
        C: 67,
        D: 68,
        E: 69,
        F: 70,
        G: 71,
        H: 72,
        I: 73,
        J: 74,
        K: 75,
        L: 76,
        M: 77,
        N: 78,
        O: 79,
        P: 80,
        Q: 81,
        R: 82,
        S: 83,
        T: 84,
        U: 85,
        V: 86,
        W: 87,
        X: 88,
        Y: 89,
        Z: 90,
        /* also META on Mac */
        WINDOWS: 91,
        MENU: 93,
        NUMPAD0: 96,
        NUMPAD1: 97,
        NUMPAD2: 98,
        NUMPAD3: 99,
        NUMPAD4: 100,
        NUMPAD5: 101,
        NUMPAD6: 102,
        NUMPAD7: 103,
        NUMPAD8: 104,
        NUMPAD9: 105,
        NUMPADASTERISK: 106,
        NUMPADPLUS: 107,
        /* on numeric keypad in eg Germany*/
        NUMPAD_DECIMAL_COMMA: 108,
        NUMPADMINUS: 109,
        /* on numeric keypad */
        NUMPAD_DECIMAL_POINT: 110,
        NUMPADSLASH: 111,
        F1: 112,
        F2: 113,
        F3: 114,
        F4: 115,
        F5: 116,
        F6: 117,
        F7: 118,
        F8: 119,
        F9: 120,
        F10: 121,
        F11: 122,
        F12: 123,
        NUMLOCK: 144,
        SCROLL_LOCK: 145,
        VOLUMEUP: 174,
        VOLUMEDOWN: 175,
        FASTFORWARD: 176,
        FASTREWIND: 177,
        PLAYPAUSE: 179,
        COMMA: 188,
        PERIOD: 190,
        SLASH: 191,
        LEFT_SQUARE_BRACKET: 219,
        BACKSLASH: 220,
        RIGHT_SQUARE_BRACKET: 221,
        NUMPADENTER: 255, // hack, jsbeeb only
        SHIFT_LEFT: 256, // hack, jsbeeb only
        SHIFT_RIGHT: 257, // hack, jsbeeb only
        ALT_LEFT: 258, // hack, jsbeeb only
        ALT_RIGHT: 259, // hack, jsbeeb only
        CTRL_LEFT: 260, // hack, jsbeeb only
        CTRL_RIGHT: 261 // hack, jsbeeb only
    };
    var audioContext;
    var cpu;

    var running = true;
    var lastShiftLocation = 1;
    var lastCtrlLocation = 1;
    var lastAltLocation = 1;

    function keyCode(evt) {
        var ret = evt.which || evt.charCode || evt.keyCode;

        switch (evt.location) {
            default:
                // keyUp events seem to pass location = 0 (Chrome)
                switch (ret) {
                    case keyCodes.SHIFT:
                        return (lastShiftLocation === 1) ? keyCodes.SHIFT_LEFT : keyCodes.SHIFT_RIGHT;
                    case keyCodes.ALT:
                        return (lastAltLocation === 1) ? keyCodes.ALT_LEFT : keyCodes.ALT_RIGHT;
                    case keyCodes.CTRL:
                        return (lastCtrlLocation === 1) ? keyCodes.CTRL_LEFT : keyCodes.CTRL_RIGHT;
                }
                break;
            case 1:
                switch (ret) {
                    case keyCodes.SHIFT:
                        lastShiftLocation = 1;
                        return keyCodes.SHIFT_LEFT;

                    case keyCodes.ALT:
                        lastAltLocation = 1;
                        return keyCodes.ALT_LEFT;

                    case keyCodes.CTRL:
                        lastCtrlLocation = 1;
                        return keyCodes.CTRL_LEFT;
                }
                break;
            case 2:
                switch (ret) {
                    case keyCodes.SHIFT:
                        lastShiftLocation = 2;
                        return keyCodes.SHIFT_RIGHT;

                    case keyCodes.ALT:
                        lastAltLocation = 2;
                        return keyCodes.ALT_RIGHT;

                    case keyCodes.CTRL:
                        lastCtrlLocation = 2;
                        return keyCodes.CTRL_RIGHT;
                }
                break;
            case 3: // numpad
                switch (ret) {
                    case keyCodes.ENTER:
                        return keyCodes.NUMPADENTER;

                    case keyCodes.DELETE:
                        return keyCodes.NUMPAD_DECIMAL_POINT;
                }
                break;
        }

        return ret;
    }

    // Recent browsers, particularly Safari and Chrome, require a user
    // interaction in order to enable sound playback.
    function userInteraction() {
        if (audioContext) audioContext.resume();
    }

    function keyDown(evt) {
        userInteraction();
        //if (document.activeElement.id === 'paste-text') return;
        //if (!running) return;
        var code = keyCode(evt);
        if (code === utils.keyCodes.F12 || code === utils.keyCodes.BREAK) {
            //utils.noteEvent('keyboard', 'press', 'break');
            cpu.setReset(true);
            evt.preventDefault();
        } else {
            cpu.sysvia.keyDown(keyCode(evt), evt.shiftKey);
            evt.preventDefault();
        }
    /*if (evt.altKey) {
            var handler = emuKeyHandlers[code];
            if (handler) {
                handler(true, code);
                evt.preventDefault();
            }
        } else if (code === utils.keyCodes.HOME && evt.ctrlKey) {
            utils.noteEvent('keyboard', 'press', 'home');
            this.stop();
        } else if (code === utils.keyCodes.INSERT && evt.ctrlKey) {
            utils.noteEvent('keyboard', 'press', 'insert');
            fastAsPossible = !fastAsPossible;
        } else if (code === utils.keyCodes.END && evt.ctrlKey) {
            utils.noteEvent('keyboard', 'press', 'end');
            pauseEmu = true;
            this.stop();
        } else if (code === utils.keyCodes.B && evt.ctrlKey) {
            // Ctrl-B turns on the printer, so we open a printer output
            // window in addition to passing the keypress along to the beeb.
            processor.sysvia.keyDown(keyCode(evt), evt.shiftKey);
            evt.preventDefault();
            checkPrinterWindow();*/
    }
    function keyPress(evt) {
        //if (document.activeElement.id === 'paste-text') return;
        //if (running || (!dbgr.enabled() && !pauseEmu)) return;
        //var code = keyCode(evt);
        /*if (dbgr.enabled() && code === 103) { // 103 = lower case g
             dbgr.hide();
            go();
            return;
        }
        if (pauseEmu) {
            if (code === 103 ) {
                pauseEmu = false;
                go();
                return;
            } else if (code === 110) { // lower case n
                stepEmuWhenPaused = true;
                go();
                return;
            }
        }*/
        //var handled = dbgr.keyPress(keyCode(evt));
        //if (handled) evt.preventDefault();
    }
    function keyUp(evt) {
        //if (document.activeElement.id === 'paste-text') return;
        // Always let the key ups come through. That way we don't cause sticky keys in the debugger.
        var code = keyCode(evt);
        if (cpu && cpu.sysvia)
            cpu.sysvia.keyUp(code);
        if (!running) return;
        /*if (evt.altKey) {
            var handler = emuKeyHandlers[code];
            if (handler) {
                handler(false, code);
                evt.preventDefault();
            }
        } else */
        if (code === utils.keyCodes.F12 || code === utils.keyCodes.BREAK) {
            cpu.setReset(false);
        }
        evt.preventDefault();
    }

    // *** END KEYBOARD

    function Emulator(container, state) {
        this.container = container;
        this.hub = container.layoutManager.eventHub;
    }

    Emulator.prototype.init = function() {
        this.root = this.container.getElement().html($('#emulator').html());
        this.canvas = canvasLib.bestCanvas(this.root.find('.screen')[0]);
        this.frames = 0;
        this.frameSkip = 0;
        this.video = new Video.Video(this.canvas.fb32, _.bind(this.paint, this));
        this.canvas.gl.canvas.tabIndex = 1000;
        this.canvas.gl.canvas.addEventListener("keydown", keyDown, false);
        this.canvas.gl.canvas.addEventListener("keypress", keyPress, false);
        this.canvas.gl.canvas.addEventListener("keyup", keyUp, false);

        audioContext = typeof AudioContext !== 'undefined' ? new AudioContext()
            : typeof webkitAudioContext !== 'undefined' ? new webkitAudioContext()
            : null;

        if (audioContext) {
            this.soundChip = new SoundChip.SoundChip(audioContext.sampleRate);
            // NB must be assigned to some kind of object else it seems to get GC'd by
            // Safari...
            this.soundChip.jsAudioNode = audioContext.createScriptProcessor(2048, 0, 1);
            this.soundChip.jsAudioNode.onaudioprocess = _.bind(function pumpAudio(event) {
                var outBuffer = event.outputBuffer;
                var chan = outBuffer.getChannelData(0);
                this.soundChip.render(chan, 0, chan.length);
            }, this);
            this.soundChip.jsAudioNode.connect(audioContext.destination);
            this.ddNoise = new DdNoise.DdNoise(audioContext);
        } else {
            this.soundChip = new SoundChip.FakeSoundChip();
            this.ddNoise = new DdNoise.FakeDdNoise();
        }

        this.dbgr = new Debugger(this.video);
        var model = models.findModel('B');
        var cmos = new Cmos({
            load: function () {
                if (window.localStorage.cmosRam) {
                    return JSON.parse(window.localStorage.cmosRam);
                }
                return null;
            },
            save: function (data) {
                window.localStorage.cmosRam = JSON.stringify(data);
            }
        });
        var config = {};
        cpu = new Cpu6502(model, this.dbgr, this.video, this.soundChip, this.ddNoise, cmos, config);

        this.lastFrameTime = 0;
        this.onAnimFrame = _.bind(this.frameFunc, this);
        this.ready = false;
        Promise.all([cpu.initialise(), this.ddNoise.initialise()]).then(_.bind(function () {
            this.ready = true;
        }, this));

        this.container.on('resize', function () {
            this.resizeScreen();
        }, this);

        this.hub.on('start', this.onStart, this);
        this.hub.on('breakpointsChanged', this.onBreakpointsChanged, this);

        // Start!
        cpu.reset(true);
        this.start();

    }

    Emulator.prototype.stepUntil = function(f) {
        cpu.targetCycles = cpu.currentCycles; // TODO: this prevents the cpu from running any residual cycles. look into a better solution
        while (true) {
            cpu.execute(1);
            if (f()) break;
        }
        this.dbgr.debug(cpu.pc);
    }
    Emulator.prototype.breakIn = function () {
        if (!this.running) {
            this.start();
        } else {
            this.stop();
        }
    };
    Emulator.prototype.stepIn = function () {
        var breakAddr = this.dbgr.nextInstruction(cpu.pc);
        this.dbgr.setTempBreakpoint(breakAddr);
        this.start();
        /*var curpc = cpu.pc;
        this.stepUntil(function () {
            return cpu.pc !== curpc;
        });*/

    };
    Emulator.prototype.stepOver = function () {
        var curpc = cpu.pc;
        if (0x20 === cpu.peekmem(curpc)) { // JSR
            this.stepUntil(function () {
                return cpu.pc === curpc+3;
            });    
        } else {
            this.stepIn();
        }
    };
    Emulator.prototype.stepOut = function () {
        this.dbgr.stepOut();
    }

    Emulator.prototype.start = function () {
        if (this.running) return;
        this.running = true;
        $("#break").text('Break');
        $("#stepIn").prop('disabled', true);
        $("#stepOver").prop('disabled', true);
        $("#stepOut").prop('disabled', true);
        requestAnimationFrame(this.onAnimFrame);
        this.soundChip.unmute();
        this.ddNoise.unmute();
        this.dbgr.hide();
    };
    Emulator.prototype.stop = function () {
        if (!this.running) return;
        this.running = false;
        $("#break").text('Resume');
        $("#stepIn").prop('disabled', false);
        $("#stepOver").prop('disabled', false);
        $("#stepOut").prop('disabled', false);
        cpu.stop();
        this.soundChip.mute();
        this.ddNoise.mute();
        this.dbgr.debug(cpu.pc);
}

    Emulator.prototype.onStart = function (e) {
        if (!this.ready) return;
        cpu.reset(true);
        var image = fdc.discFor(cpu.fdc, false, e.result);
        cpu.fdc.loadDisc(0, image);
        this.start();
        this.sendRawKeyboardToBBC(0,
            // Shift on power-on -> run !Boot from the disc
            utils.BBC.SHIFT,
            1000 // pause in ms
        );
    };

    Emulator.prototype.sendRawKeyboardToBBC = function () {
        var keysToSend = Array.prototype.slice.call(arguments, 0);
        var lastChar;
        var nextKeyMillis = 0;
        cpu.sysvia.disableKeyboard();

        var sendCharHook = cpu.debugInstruction.add(_.bind(function nextCharHook() {
            var millis = cpu.cycleSeconds * 1000 + cpu.currentCycles / (ClocksPerSecond / 1000);
            if (millis < nextKeyMillis) {
                return;
            }

            if (lastChar && lastChar != utils.BBC.SHIFT) {
                cpu.sysvia.keyToggleRaw(lastChar);
            }

            if (keysToSend.length === 0) {
                // Finished
                cpu.sysvia.enableKeyboard();
                sendCharHook.remove();
                return;
            }

            var ch = keysToSend[0];
            var debounce = lastChar === ch;
            lastChar = ch;
            if (debounce) {
                lastChar = undefined;
                nextKeyMillis = millis + 30;
                return;
            }

            var time = 50;
            if (typeof lastChar === "number") {
                time = lastChar;
                lastChar = undefined;
            } else {
                cpu.sysvia.keyToggleRaw(lastChar);
            }

            // remove first character
            keysToSend.shift();

            nextKeyMillis = millis + time;
        }, this));
    };

    Emulator.prototype.frameFunc = function (now) {
        requestAnimationFrame(this.onAnimFrame);
        if (this.running && this.lastFrameTime !== 0) {
            var sinceLast = now - this.lastFrameTime;
            var cycles = (sinceLast * ClocksPerSecond / 1000) | 0;
            cycles = Math.min(cycles, MaxCyclesPerFrame);
            try {
                if (!cpu.execute(cycles)) {
                    this.stop();
                }
            } catch (e) {
                this.stop();
                throw e;
            }
        }
        this.lastFrameTime = now;
    };

    Emulator.prototype.paint = function paint(minx, miny, maxx, maxy) {
        this.frames++;
        if (this.frames < this.frameSkip) return;
        this.frames = 0;
        this.canvas.paint(minx, miny, maxx, maxy);
    };

    Emulator.prototype.resizeScreen = function () {
        var canvasRatio = 696.0 / 900.0;
        var parentWidth = this.container.width;
        var parentHeight = this.container.height - 40;
        var parentRatio = parentHeight / parentWidth;
        var width;
        var height;

        if (parentRatio < canvasRatio) {
            height = parentHeight;
            width = height / canvasRatio;
        } else {
            width = parentWidth;
            height = width * canvasRatio;
        }

        this.canvas.gl.canvas.style.width = width + 'px';
        this.canvas.gl.canvas.style.height = height + 'px';

    }

    Emulator.prototype.onBreakpointsChanged = function() {
        this.dbgr.clearBreakpoints();
        for (var bp of breakpoints) {
            if (bp.addr > 0) {
                this.dbgr.toggleBreakpoint(bp.addr);
            }
        }
    }

    return Emulator;
});