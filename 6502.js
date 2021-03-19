define(function () {
    return {
        defaultToken: 'invalid',
        brackets: [
            ['{', '}', 'delimiter.curly'],
            ['[', ']', 'delimiter.square'],
            ['(', ')', 'delimiter.parenthesis'],
        ],
        opcodes: [
            'LDA', 'LDX', 'LDY',
            'STA', 'STX', 'STY',
            'TAX', 'TAY', 'TXA', 'TYA', 'TSX',
            'ADC', 'SBC', 'SEC', 'CLC',
            'INC', 'DEC',
            'INY', 'DEY',
            'INX', 'DEX',
            'CLI', 'SEI',
            'CLD', 'SED',
            'CMP', 'CPX', 'CPY',
            'AND', 'ORA', 'EOR',
            'BPL', 'BMI', 'BEQ', 'BNE', 'BRA', 'BCC', 'BCS', 'BVS', 'BVC',
            'JMP', 'BRK', 'JSR', 'RTS',
            'ROL', 'ROR', 'ASL', 'LSR',
            'PHA', 'PHP', 'PLA', 'PLP',
            'BIT'
        ],
        directives: [
            'ORG',
            'CPU',
            'SKIP',
            'SKIPTO',
            'ALIGN',
            'COPYBLOCK',
            'INCLUDE',
            'INCBIN', 'INCBMP',
            'EQUB',
            'EQUW',
            'EQUD',
            'EQUS',
            'MAPCHAR',
            'GUARD',
            'CLEAR',
            'SAVE',
            'PRINT',
            'ERROR',
            'FOR', 'NEXT',
            'IF', 'ELIF', 'ELSE', 'ENDIF',
            'PUTFILE',
            'PUTBASIC',
            'MACRO',
            'ENDMACRO'
        ],
        intrinsics: [
            'LO', 'HI',
            'SIN', 'COS', 'TAN', 'ATN', 'ABS', 'SQR',
            'PI', 'FALSE', 'TRUE'
        ],
        operators: [
            '#', // immediate
            '+', '-', '*', '/', '<<', '>>', '^', '=', '==', '<>', '!=', '<', '>', '<=', '>=',
            '{', '}', ':'
        ],
        symbols: /[-+#=><!*\/{}:]+/,
        
        // C# style strings
        escapes: /\\(?:[abfnrtv\\"']|x[0-9A-Fa-f]{1,4}|u[0-9A-Fa-f]{4}|U[0-9A-Fa-f]{8})/,

        ignoreCase: true,
        tokenizer: {
            root: [
                [/\#\$[0-9a-fA-F]+/, 'number.lit'],
                [/\$[0-9a-fA-F]+/, 'number.addr'],
                [/&[0-9a-fA-F]+/, 'number.addr'],

                // identifiers and keywords
                [/[a-zA-Z_$][\w$]*/, {
                    cases: {
                        '@directives': 'keyword',
                        '@opcodes': 'keyword',
                        '@intrinsics': 'keyword',
                        '@default': 'identifier'
                    }
                }],
                [/,\s*[XY]/, 'keyword'],
                // whitespace
                {include: '@whitespace'},
                // labels
                [/\.[a-zA-Z_$][\w$]*/, 'type.identifier'],
                // immediate
                [/@symbols/, { cases: {'@operators' : 'operator', '@default': ''}}],
                // numbers
                [/\d*\.\d+([eE][\-+]?\d+)?/, 'number.float'],
                [/\d+/, 'number'],
                [/[{}()\[\]]/, '@brackets'],
                // strings
                [/"([^"\\]|\\.)*$/, 'string.invalid' ],  // non-teminated string
                [/"/,  { token: 'string.quote', bracket: '@open', next: '@string' } ],

                // characters
                [/'[^\\']'/, 'string'],
                [/(')(@escapes)(')/, ['string','string.escape','string']],
                [/'/, 'string.invalid']
            ],
            string: [
                [/[^\\"]+/,  'string'],
                [/@escapes/, 'string.escape'],
                [/\\./,      'string.escape.invalid'],
                [/"/,        { token: 'string.quote', bracket: '@close', next: '@pop' } ]
              ],

              whitespace: [
                [/[ \t\r\n]+/, 'white'],
                [/[;\\\\].*/, 'comment']
            ]
        }
    };
});