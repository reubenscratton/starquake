; *** Assemble everything at it's eventual execution address

        org $0440
        INCBIN "etc_0440.bin" 
        org $0900
        INCLUDE "etc_0900.asm" 
        org $0e00
        INCLUDE "main.asm"
        org $7f00
        INCBIN "etc_7F00.bin"


; *** Entry point of $.QUAKE2
        ORG $74E8
.RELOC_START

; *TAPE - select 1200 baud
        LDA     #$8C
        LDX     #$0C
        JSR     &FFF4

; *FX 200 - clear memory on BREAK, disable ESCAPE key
        LDA     #$C8
        LDX     #$03
        LDY     #$00
        JSR     &FFF4

; *FX 4,1 - disable cursor editing
        LDA     #$04
        LDX     #$01
        LDY     #$00
        JSR     &FFF4

; *FX 11,1 - disable keyboard autorepeat
        LDA     #$0B
        LDX     #$00
        LDY     #$00
        JSR     &FFF4

; Relocate the bulk of the game ... move 0x1200-0x7000 down to 0x0E00-0x6C00

        LDY     #$00
        STY     &008E
        STY     &008C
        LDA     #$12
        STA     &008F
        LDA     #$0E
        STA     &008D
.L7518
        LDA     (&008E),Y
        STA     (&008C),Y
        INY
        BNE     L7518
        INC     &008D
        INC     &008F
        LDA     &008F
        CMP     #$70
        BNE     L7518

; Relocate 0x7000-0x72FF to 0x0900-0x0BFF
.L752C
        LDA     &7000,Y
        STA     &0900,Y
        LDA     &7100,Y
        STA     &0A00,Y
        LDA     &7200,Y
        STA     &0B00,Y
        INY
        BNE     L752C

; Relocate page to the very top of video memory ?!?
.L754A
        LDA     &7300,Y
        STA     &7F00,Y
        INY
        BNE     L754A

; Clear 0x0400-0x7FF and 0x6C00-0x6CFF (possibly the strip between status area and game display?)
        TYA
.L7557
        STA     &0400,Y
        STA     &0500,Y
        STA     &0600,Y
        STA     &0700,Y
        STA     &6C00,Y
        INY
        BNE     L7557

; Relocate 0x7400-0x74E7 to 0x0440-0x0527
.L7569
        LDA     &7400,Y
        STA     &0440,Y
        INY
        CPY     #$E8
        BNE     L7569

; Zero 0x000A-0x00AF
        LDY     #$0A
.L7579
        LDA     #$00
        STA     &0000,Y
        INY
        CPY     #$B0
        BNE     L7579


; Copy 0x75DA-0x75E2 to 0x0090-0x0097
        LDY     #$07
.L7585
        LDA     L75DA,Y
        STA     &0090,Y
        DEY
        BPL     L7585

; TODO
        LDA     &0000
        STA     &009A
        LDA     &0001
        STA     &009B
.L7595
        LDA     #$9E
        STA     &0000
        LDA     #$BD
        STA     &0001
        LDA     #$B7
        STA     &0002
        LDA     #$97
        STA     &0003
        LDA     #$B6
        STA     &0004
        LDA     &0007
        LDX     &0008
        STA     &0008
        STX     &0007

; Set up 6845 video controller
        INY
.L75B3
        LDA     VIDEO_CTRL_BLOCK,Y
        STA     &FE00
        INY
        LDA     VIDEO_CTRL_BLOCK,Y
        STA     &FE01
        INY
        CPY     #$0E
        BNE     L75B3

; *FX 154,100 : Write ULA control reg: set 1MHz, 20 columns
        LDA     #$9A
        LDX     #$64
        JSR     &FFF4

; TODO: this is in the decoded code
        JSR     &7F03
        JSR     &7F00

; *FX 15 - flush buffers (?)
        LDA     #$0F
        JSR     &FFF4

; Jump into the game!
        JMP     MAIN_MENU ;&3290


; These get copied to 0x0090-0x0097
.L75DA
        EQUB 0,0
        EQUB 0,1
        EQUB 0,2
        EQUB 0,7

; Video controller block (a series of reg/val pairs written to 0xFE00)
.VIDEO_CTRL_BLOCK

; Screen size 32x25
        EQUB 1, 32      ; R1 = 32 chars horizontally
        EQUB 6, 25      ; R6 = 25 chars vertically

; Screen base address = $6600 (set R12/13 to $0CC0, i.e. $6600/8)
        EQUB 12, $0C
        EQUB 13, $C0

; Vertical sync position = 36, i.e. two more rows than normal mode 5
        EQUB 7, 36

; Horizontal sync = 46
        EQUB 2, 46

; Horizontal total = 63 (i.e. 64 characters across). Standard mode 5 
        EQUB 0, 63

; 16 bytes of god knows what
        EQUB &AE, &34, &14, &BB, &D2, &D2, &A6, &F9 
        EQUB &0D, &BB, &F2, &A7, &93, &C9, &A0, &C0 
        

; Block of 256 bytes all 0xE5... why?? 
.L7600 
FOR n, 0, 255
        EQUB &E5
NEXT

.L7700
        EQUB &A4, &0C, &FF, &FD 

FOR n, 0, 79
        EQUB &FF
NEXT

; 2.1KB of zeros

; Last bytes of the file
        EQUB &FC,&14,0,0

.RELOC_END

; 0x1200-0x6FFF  =>  0x0E00-0x6BFF
; 0x7000-0x72FF  =>  0x0900-0x0BFF
; 0x7300-0x73FF  =>  0x7F00-0x7FFF
; 0x7400-0x74E7  =>  0x0440-0x0527

;COPYBLOCK start, end, dest
COPYBLOCK $0900, $0C00, $7000-$400
COPYBLOCK $7F00, $8000, $7300-$400
COPYBLOCK $0440, $0528, $7400-$400
COPYBLOCK RELOC_START, RELOC_END, RELOC_START-$400

; SAVE "filename", start, end [, exec [, reload] ]
SAVE "quake", $0E00, RELOC_END-$400, $74E8, $1200


