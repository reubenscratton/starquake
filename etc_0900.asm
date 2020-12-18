
; There are 45 glyphs in the font, the character codes start at $41 so
; at least the letters correspond to ASCII.
;
;  Char  Code  |  Char  Code  |  Char  Code  |  Char  Code
;  ----  ----  |  ----  ----  |  ----  ----  |  ----  ----
;   A    $41   |   N    $4E   |  <spc>  $5B  |   7     $68
;   B    $42   |   O    $4F   |   ,,    $5C  |   8     $69
;   C    $43   |   P    $50   |   ·     $5D  |   9     $6A
;   D    $44   |   Q    $51   |   .     $5E  |   :     $6B
;   E    $45   |   R    $52   |  <spc>  $5F  |   /     $6C
;   F    $46   |   S    $53   |   %     $60  |   _     $6D
;   G    $47   |   T    $54   |   0     $61
;   H    $48   |   U    $55   |   1     $62
;   I    $49   |   V    $56   |   2     $63
;   J    $4A   |   W    $57   |   3     $64
;   K    $4B   |   X    $58   |   4     $65
;   L    $4C   |   Y    $59   |   5     $66
;   M    $4D   |   Z    $5A   |   6     $67

.FONT
                    org $0900
                    incbmp bpp:1, width:360, height:8, double_width:0, path:"graphics/", "font.bmp"

                    ; Three tiny graphics for hoverpad stations
                    EQUB $FF, $DD, $DD, $99, $99, $99, $FF, $00
                    EQUB $FF, $99, $DD, $99, $BB, $99, $FF, $00
                    EQUB $FF, $99, $DD, $99, $DD, $99, $FF, $00

                    ;org $0a80
.DRAW_TEXT          stx $8e
                    sty $8f

                    ; Get next character code
.read_char          ldy #$00
                    lda ($8e),y
                    beq L0a95

                    ; If its >0x80 then its a colour code
                    bmi handle_colour

                    ; If it's >0x20 then its a char
                    cmp #$20
                    bcs handle_char

                    ; If it's 0x1f, that's setting the screen position
                    cmp #$1f
                    beq handle_pos

                    ; All other values => just return. $0D is usually used to end the text.
                    rts
                    
.L0a95              lda $87
                    beq L0a9c
                    jmp L0b12
                    
.L0a9c              lda #$01
                    sta $87
                    jmp next_char
                    
.handle_colour      tay
                    lda COLOUR_MASKS_TEXT-$81+1,y
                    sta $89
                    jmp next_char
                    
.handle_pos         iny
                    lda ($8e),y
                    sta $8a
                    asl a
                    adc $8a
                    pha
                    and #$f8
                    sta $8a
                    pla
                    and #$04
                    sta $87

                    ; Get Y-coordinate and add to base of screen memory. One row = one page,
                    ; a much easier calculation.
                    iny
                    lda ($8e),y
                    clc
                    adc #$67
                    sta $8b

                    ; Consume the 3 position bytes and go to next char
                    lda $8e
                    adc #$03
                    sta $8e
                    bcc L0ad0
                    inc $8f
.L0ad0              jmp read_char
                    
.handle_char        sty $8d

                    ; At this point A holds char code. Use it to calculate
                    ; the glyph pixel address in $8c/$8d, i.e. :
                    ; $8c/d = 0x0900 + (char code - 'A') * 8
                    sec
                    sbc #$41  ; 'A'
                    asl a
                    sta $8c
                    asl $8c   ; $8c=charcode*4
                    rol $8d
                    asl $8c   ; $8c=charcode*8
                    rol $8d
                    lda $8d
                    adc #HI(FONT)
                    sta $8d

                    ; At this point $8C/$8D hold address of glyph
                    ldx #$10
                    jsr UNPACK_MONO_GLYPH
                    ldy #$00
                    lda $87
                    bne L0b21

                    ; Apply the color mask ()
.L0af4              lda ($8c),y
                    and $89
                    sta ($8a),y
                    iny
                    cpy #$08
                    bne L0af4

.L0aff              lda ($8a),y
                    and #$33
                    sta $88
                    lda ($8c),y
                    and $89
                    ora $88
                    sta ($8a),y
                    iny
                    cpy #$10
                    bne L0aff
.L0b12              sty $87

                    ; Add 8 to screen address (i.e. 4 pixels right)
                    clc
                    lda $8a
                    adc #$08
                    sta $8a
                    bcc next_char
                    inc $8b
                    bcs next_char
                  
                    ; Renderloop 1
.L0b21              lda ($8c),y
                    lsr a
                    lsr a
                    and #$33  ; // mask off the two rightmost pixels
                    and $89
                    sta $88
                    lda ($8a),y
                    and #$cc
                    ora $88
                    sta ($8a),y
                    iny
                    cpy #$08
                    bne L0b21

                    ; Renderloop 2
.L0b38              lda ($8c),y
                    lsr a
                    lsr a
                    and $89
                    sta $88
                    tya
                    eor #$08
                    tay
                    lda ($8c),y
                    and #$33
                    and $89
                    asl a
                    asl a
                    ora $88
                    sta $88
                    tya
                    eor #$08
                    tay
                    lda $88
                    sta ($8a),y
                    iny
                    cpy #$10
                    bne L0b38

                    ; Advance *8* pixels right
                    clc
                    lda $8a
                    adc #$10
                    sta $8a
                    bcc L0b68
                    inc $8b

                    ; Set fractional X-offset to 0
.L0b68              ldy #$00
                    sty $87

.next_char          inc $8e
                    bne L0b72
                    inc $8f
.L0b72              jmp read_char
                    
.COLOUR_MASKS_TEXT
                    EQUB $00, $0f, $f0, $ff

.UNPACK_MONO_GLYPH  
                    ; On entry ($8C) points to a packed mono glyph in font.bin
                    ; This function unpacks it to scratch memory at $03c0
                    stx $0bf5
                    ldx #$00
                    ldy #$00

                    ; Read mono glyph byte
.unpack_mono_loop   lda ($8c),y

                    ; Mask off low nibble and copy it into high nibble
                    and #$0f
                    sta $0bf6
                    asl a
                    asl a
                    asl a
                    asl a
                    ora $0bf6

                    sta $03c0,x
                    inx

                    ; Mask off high nibble and copy it to low nibble!
                    lda ($8c),y
                    and #$f0
                    sta $0bf6
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    ora $0bf6
                    sta $03c0,x
                    inx
                    
                    ; Next row 
                    iny
                    cpx $0bf5
                    bne unpack_mono_loop

                    ; Update ($8C) to point to the scratch buffer containing the unpacked glyph
                    lda #$03
                    sta $8d
                    lda #$c0
                    sta $8c
                    rts
                    
.L0bb3              stx $8b
                    sty $8a
                    asl a
                    asl a
                    asl a
                    sta $8c
                    asl $8c
                    lda #$00
                    adc #$35
                    pha
                    lda $8c
                    adc #$e0
                    sta $8c
                    pla
                    adc #$00
                    sta $8d
                    ldx #$20
                    jsr UNPACK_MONO_GLYPH
                    ldx #$00
.L0bd5              ldy #$00
.L0bd7              lda $03c0,x
                    and $8b
                    sta $0bf6
                    lda ($8e),y
                    and $8a
                    eor $0bf6
                    sta ($8e),y
                    iny
                    inx
                    cpy #$10
                    bne L0bd7
                    inc $8f
                    cpx #$20
                    bne L0bd5
                    rts
                    
                    EQUB 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00 