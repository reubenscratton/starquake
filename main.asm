MAPCHAR ' ', 0
MAPCHAR '·', $5d
MAPCHAR '.', $5e
MAPCHAR '1', $62
MAPCHAR '2', $63
MAPCHAR '3', $64
MAPCHAR '4', $65
MAPCHAR '5', $66
MAPCHAR '6', $67
MAPCHAR '7', $68
MAPCHAR '8', $69
MAPCHAR '9', $6A
MAPCHAR ':', $6B
MAPCHAR '/', $6C

osword = $fff1

; Zero-page
SCORE0 = $46
SCORE1 = $47
SCORE2 = $48

; Conventions:
;
; .ALLCAPS   - for the start of logical units, e.g. subroutines
; .lowercase - for labels within a logical unit, e.g. local branches 


                    org $e00
.L0e00              jsr S0f11
.L0e03              jsr S6440
                    and #$07
                    cmp #$05
                    bcs L0e03
                    sta $93
.L0e0e              jsr S6440
                    and #$07
                    cmp $93
                    beq L0e0e
                    cmp #$05
                    bcs L0e0e
                    adc #$01
                    sta $95
                    inc $93
                    jsr $7f00
.S0e24              ldx #$14
                    ldy #$10
                    jmp L352b
                    
.S0e2b               ldx #$00
                    ldy $f5
.L0e2f               lda $621d,y
                    sta $0f52,x
                    iny
                    inx
                    cpx #$05
                    bne L0e2f
                    jsr L0e00
                    lda #$24
                    sta $8c
                    lda #$61
                    sta $8d
                    lda #$d0
                    sta $8e
                    lda #$6f
                    sta $8f
                    ldx #$04
                    ldy #$03
                    jsr S6500
                    ldx #$26
                    ldy #$0f
                    jsr $0a80
                    lda #$00
                    sta $86
.L0e60               jsr $ffe0
                    and #$5f
                    cmp #$41
                    bcc L0e60
                    cmp #$5b
                    bcs L0e60
                    ldx $86
                    sta $0f90,x
                    sta $0f95
                    ldx #$95
                    ldy #$0f
                    jsr $0a80
                    ldx #$1e
                    ldy #$0f
                    jsr S353d
                    inc $86
                    lda $86
                    cmp #$05
                    bne L0e60
                    ldy #$08
.L0e8d               ldx #$00
.L0e8f               lda $621d,y
                    cmp $0f90,x
                    bne L0e9f
                    iny
                    inx
                    cpx #$05
                    bne L0e8f
                    beq L0eb2
.L0e9f               tya
                    clc
                    adc #$08
                    and #$f8
                    tay
                    bpl L0e8d
                    jsr S0f17
                    lda $f5
                    pha
                    ldx #$98
                    bne L0ebf
.L0eb2               tya
                    and #$f8
                    pha
                    ldx #$59
                    ldy #$04
                    jsr L352b
                    ldx #$b0
.L0ebf               lda #$d5
                    sta $86
                    stx $7e
.L0ec5               lda $86
                    and #$03
                    ora #$80
                    sta $0fb0
                    sta $0f98
                    ldx $7e
                    ldy #$0f
                    jsr $0a80
                    lda #$13
                    jsr $fff4
                    inc $86
                    bne L0ec5
                    pla
                    tay
                    lda $6224,y
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    sta $8e
                    asl a
                    adc $8e
                    adc #$6e
                    sta $71
                    lda $6224,y
                    lsr a
                    asl a
                    asl a
                    asl a
                    asl a
                    asl a
                    sec
                    sbc #$08
                    sta $70
                    lda #$0b
                    sta $72
                    lda $6223,y
                    sta $7e
                    lda $6224,y
                    and #$01
                    sta $7f
.S0f11              jsr CLEAR_SCREEN
                    jmp FLUSH_BUFFERS
                    
.S0f17              ldx #$c4
                    ldy #$0f
                    jmp L352b

                    EQUB $10, $00, $f1, $00, $01, $00, $01, $00
                    EQUB $81 
                    EQUB $1f, $03, $07 
                    EQUS "YOU  HAVE  ENTERED"
                    EQUB $1f, $13, $09 
                    EQUS "TELEPORT"
                    EQUB $1f, $0a, $0b 
                    EQUS "CODE" 
                    EQUB $5b, $6b $5b 
                    EQUB $83, $28, $43, $29, $4b, $50
                    EQUB $1f, $0c, $0e
                    EQUB $82 
                    EQUS "ENTER[TELEPORTAL" 
                    EQUB $1f, $0c, $10 
                    EQUS "DESTINATION[CODE" 
                    EQUB $1f, $1a, $13 
                    EQUB $83, $6d, $5b, $6d, $5b, $6d, $5b, $6d, $5b, $6d 
                    EQUB $81, $1f, $1a, $13, $0d 
                    EQUB $00, $00, $00, $00, $00, $5b, $5b, $0d, $81
                    EQUB $1f, $05, $15 
                    EQUS "CODE[NOT[RECOGNISED" 
                    EQUB $0d 
                    EQUB $81 
                    EQUB $1f, $0e, $15 
                    EQUS "NOW[TELEPORTING" 
                    EQUB $0d, $04, $01, $0a, $14, $1e, $01, $01, $01, $7e, $00, $00, $82 
                    EQUB $7e, $7e, $11, $00, $04, $00, $c0, $00, $1e, $00, $1f, $0e, $08, $82 
                    EQUS "CHEOPS[PYRAMID" 
                    EQUB $1f, $0e, $0c, $81 
                    EQUS "EXCHANGE[[[FOR" 
                    EQUB $1f, $06, $0e 
                    EQUS "b^[[c^[[d^[[e^[[f^" 
                    EQUB $0d, $04, $01, $f6, $f1, $ec, $04, $04, $04, $7e, $fa, $f3, $dc 
                    EQUB $7e, $5a, $02, $00, $04, $00, $78, $00, $02, $00

.S102a              jsr L0e00
                    ldx #$da
                    ldy #$0f
                    jsr $0a80
.L1034              jsr S6440
                    and #$03
                    tay
                    lda $000f,y
                    beq L1034
                    sty $80
                    sta $89
                    lda #$03
                    sta $8e
.L1047               jsr S6440
                    cmp #$09
                    bcs L1047
                    tay
                    lda $0017,y
                    cmp #$80
                    bcs L1047
                    ldx $8e
                    and #$1f
                    sta $85,x
                    dec $8e
                    bpl L1047
                    ldx #$ff
                    ldy #$00
                    lda #$90
                    sta $8e
                    lda #$72
                    sta $8f
                    lda $89
                    jsr $0bb3
                    lda #$18
                    sta $8e
                    lda #$76
                    sta $8f
                    lda #$00
                    sta $81
.L107d               ldy $81
                    lda $0085,y
                    ldx #$ff
                    ldy #$00
                    jsr $0bb3
                    sec
                    lda $8e
                    sbc #$d0
                    sta $8e
                    lda $8f
                    sbc #$01
                    sta $8f
                    inc $81
                    lda $81
                    cmp #$05
                    bne L107d
                    lda #$0f
                    ldx #$00
                    jsr $fff4
.L10a5               jsr $ffe0
                    sec
                    sbc #$31
                    bcc L10a5
                    cmp #$05
                    bcs L10a5
                    pha
                    tay
                    lda $0085,y
                    ldy $80
                    sta $000f,y
                    sta $87
                    pla
                    asl a
                    asl a
                    asl a
                    asl a
                    sta $86
                    asl a
                    adc $86
                    adc #$18
                    sta $86
                    jsr S0f17
                    lda #$32
                    sta $88
                    lda #$00
                    sta $89
.L10d6               lda #$13
                    jsr $fff4
                    lda $86
                    sta $8e
                    lda #$76
                    sta $8f
                    lda $89
                    eor #$ff
                    sta $89
                    tax
                    ldy #$00
                    lda $87
                    jsr $0bb3
                    dec $88
                    bne L10d6
                    tay
                    sta ($53),y
                    iny
                    sta ($53),y
                    rts
                    
                    EQUB $07, $17, $47, $57, $27, $37, $67, $77 
                    EQUB $87, $97, $c7, $d7, $a7, $b7, $e7, $f7 
                    EQUB $07, $17, $47, $57, $26, $36, $66, $76 
                    EQUB $85, $95, $c5, $d5, $a0, $b0, $e0, $f0 

.S111c              ldy #$09
.L111e              lda $61c3,y
                    and #$fd
                    sta $61c3,y
                    dey
                    dey
                    bpl L111e
                    lda #$80
                    sta $70
                    lda #$77
                    sta $71
                    lda #$00
                    sta SCORE0
                    sta SCORE1
                    sta SCORE2
                    lda #$05
                    sta $49
                    ldy #$00
                    tya
.L1141              sta $0c00,y
                    sta $0d00,y
                    iny
                    bne L1141
.L114a              sta $0380,y
                    iny
                    bpl L114a
                    ldy #$07
.L1152              tya
                    and #$04
                    sta $000f,y
                    dey
                    bpl L1152
                    jsr S20a0
                    lda #$00
                    sta $0b
                    sta $0c
                    sta $88
                    lda #$0c
                    sta $89
.L116a               jsr S6440
                    sta $8e
                    jsr S6440
                    asl a
                    asl a
                    asl a
                    asl a
                    ora $8e
                    sta $8e
                    jsr S6440
                    and #$03
                    sta $8a
                    lsr a
                    ora #$06
                    sta $8f
                    ldy #$00
                    lda ($8e),y
                    bne L116a
                    lda #$01
                    sta ($8e),y
                    lda $8e
                    tax
                    clc
                    adc #$c0
                    sta $8e
                    lda $8f
                    adc #$31
                    sta $8f
                    lda ($8e),y
                    sta $8d
                    and #$3f
                    cmp #$30
                    bcs L116a
                    sta $8c
                    txa
                    sta ($88),y
                    lda $8d
                    and #$c0
                    asl a
                    rol a
                    rol a
                    adc #$01
                    sta $8b
.L11b8               jsr S6440
                    and #$03
                    cmp $8b
                    bcs L11b8
                    adc $8c
                    lsr $8a
                    ror $8a
                    ror $8a
                    ora $8a
                    ldy #$01
                    sta ($88),y
                    inc $88
                    inc $88
                    bne L116a
                    inc $89
                    lda $89
                    cmp #$0e
                    bne L116a
                    lda #$00
                    sta $72
                    sta $22
                    sta $9f
                    lda #$01
                    sta $76
                    sta $7a
                    ldy #$0b
.L11ed               tya
                    sta $000c,y
                    iny
                    cpy #$14
                    bne L11ed
                    lda #$04
                    sta $8e
.L11fa               jsr S6440
                    cmp #$0a
                    bcs L11fa
                    adc #$14
                    ldy #$08
.L1205               cmp $0017,y
                    beq L11fa
                    dey
                    bpl L1205
                    pha
.L120e               jsr S6440
                    cmp #$09
                    bcs L120e
                    tax
                    lda $17,x
                    cmp #$14
                    bcs L120e
                    pla
                    sta $17,x
                    dec $8e
                    bpl L11fa
                    lda #$00
                    sta $8c
                    sta $8d
                    sta $8b
.L122b               jsr S6440
                    and #$02
                    clc
                    adc $8c
                    tay
                    lda $61cd,y
                    ldx $8d
                    sta $0528,x
                    lda $61ce,y
                    pha
                    pha
                    and #$01
                    sta $0529,x
                    pla
                    asl a
                    asl a
                    asl a
                    asl a
                    and #$e0
                    ora #$08
                    ora $0529,x
                    sta $0529,x
                    pla
                    and #$70
                    lsr a
                    lsr a
                    lsr a
                    sta $8e
                    lsr a
                    adc $8e
                    adc #$6e
                    sta $052a,x
                    lda $8b
                    cmp #$0b
                    bcs L1275
                    tay
                    lda $0015,y
                    sta $052b,x
                    jmp L1288
                    
.L1275               jsr S6440
                    lda $9b
                    and #$1f
                    cmp #$13
                    bcs L1275
                    clc
                    adc #$0b
                    ldx $8d
                    sta $052b,x
.L1288               clc
                    lda $8c
                    adc #$04
                    sta $8c
                    lda $8d
                    adc #$04
                    sta $8d
                    inc $8b
                    lda $8b
                    cmp #$01
                    beq L12a1
                    cmp #$03
                    bne L12b2
.L12a1               sec
                    lda $8d
                    sbc #$04
                    sta $8d
                    jsr S6440
                    and #$01
                    beq L1288
.L12af               jmp L122b
                    
.L12b2               lda $8b
                    cmp #$16
                    bne L12af
                    lda #$09
                    sta $052b
                    lda #$0a
                    sta $052f
                    lda #$08
                    sta $7e
                    lda #$00
                    sta $7f
                    sei
                    sta $23
                    inc $23
                    sta $24
                    sta $25
                    cli
                    sta $9e
                    sta $35
                    sta $37
                    sta $39
                    lda #$0f
                    sta $31
                    lda #$10
                    sta $3f
                    lda #$06
                    sta $3d
                    lda #$ff
                    sta $3e
                    jsr S2560
.L12ef               lda $5a
                    sta $70
                    lda $5b
                    sta $71
                    lda $5c
                    sta $72
                    lda $5d
                    sta $76
                    sed
                    sec
                    lda $49
                    sbc #$01
                    sta $49
                    cld
                    bcs L130b
                    rts
                    
.L130b               lda #$10
                    sta $3b
                    lda $3d
                    ora #$01
                    sta $3d
                    lda #$ff
                    sta $3c
                    sta $3a
.L131b               lda #$03
                    sta $29
                    sta $27
.L1321               jsr FLUSH_BUFFERS
                    jsr S2560
                    lda $80
                    pha
                    ldy #$2f
.L132c               lda $0188,y
                    tax
                    lda $0158,y
                    sta $0188,y
                    txa
                    sta $0158,y
                    dey
                    bpl L132c
                    jsr S20a0
                    lda $7f
                    lsr a
                    lda $7e
                    ror a
                    lsr a
                    lsr a
                    tay
                    lda #$00
                    sta $8f
                    lda $7e
                    and #$07
                    tax
                    sec
.L1353               rol $8f
                    dex
                    bpl L1353
                    lda $0380,y
                    and $8f
                    bne L137d
                    lda $0380,y
                    ora $8f
                    sta $0380,y
                    ldy #$02
                    ldx #$50
                    jsr SCORE_ADD
                    clc
                    lda $0b
                    adc #$32
                    sta $0b
                    lda $0c
                    sed
                    adc #$00
                    cld
                    sta $0c
.L137d               ldx $7e
                    ldy $7f
                    jsr S25f0
                    jsr S2571
                    ldx $70
                    ldy $71
                    jsr S252f
                    stx $74
                    sty $75
                    lda #$00
                    sta $73
                    pla
                    sta $80
                    jsr S23d4
                    lda $2e
                    sta $2c
                    lda $2f
                    sta $2d
                    lda $26
                    cmp $7e
                    bne L13bb
                    lda $27
                    cmp $7f
                    bne L13bb
                    lda $2a
                    sta $2e
                    lda $2b
                    sta $2f
                    jmp L1430
                    
.L13bb               jsr S6440
                    ora #$10
                    sta $2e
                    jsr S6440
                    and #$01
                    ora #$02
                    sta $2f
                    ldy #$2f
                    lda #$00
.L13cf               sta $0188,y
                    dey
                    bpl L13cf
                    lda $7f
                    beq L1430
                    lda #$26
                    sta $8e
.L13dd               dec $8e
                    dec $8e
                    bmi L1430
                    ldy $8e
                    lda $6185,y
                    cmp $7e
                    bne L13dd
                    lda $6186,y
                    pha
                    and #$f8
                    sta $2332
                    pla
                    and #$03
                    sta $8e
                    ldy #$00
.L13fc               sty $8f
                    jsr S6440
                    adc #$08
                    sta $2336
                    jsr S6440
                    and #$01
                    tax
                    lda $233e,x
                    sta $2335
                    ldy $8f
                    ldx #$00
.L1416               lda $2332,x
                    sta $0188,y
                    inx
                    iny
                    cpx #$0c
                    bcc L1416
                    lda $2332
                    adc #$1f
                    sta $2332
                    dec $2f
                    dec $8e
                    bpl L13fc
.L1430               lda #$01
                    sta $0d
                    jsr S2eb6
                    jsr S2366
                    ldy #$00
.L143c               lda $0028,y
                    sta $0026,y
                    iny
                    cpy #$08
                    bne L143c
                    lda $7e
                    sta $28
                    lda $7f
                    sta $29
                    lda $7f
                    bne L1461
                    lda $7e
                    cmp #$c7
                    beq L1464
                    cmp #$c6
                    bne L1461
                    lda #$ff
                    sta $2e
.L1461               jmp L15ec
                    
.L1464               lda #$01
                    jsr S2eb6
                    lda #$6d
                    sta $8e
                    lda #$06
                    sta $8f
                    ldx #$06
.L1473               ldy #$05
.L1475               lda #$18
                    sta ($8e),y
                    dey
                    bpl L1475
                    clc
                    lda $8e
                    adc #$20
                    sta $8e
                    bcc L1487
                    inc $8f
.L1487               dex
                    bne L1473
                    jsr S3563
                    lda #$00
                    ldx #$73
                    jsr S3587
                    jsr $7f00
                    lda #$00
                    sta $84
.L149b              ldy $84
                    lda $000f,y
                    ldy #$08
.L14a2              cmp $0017,y
                    beq L14ad
                    dey
                    bpl L14a2
                    jmp L1506
                    
.L14ad              sta $83
                    sty $85
                    sta $81
                    lda #$0f
                    sta $86
                    lda $3575,y
                    sta $209e
.L14bd              lda $86
                    and #$01
                    tax
                    lda $209e,x
                    ldy $85
                    sta $0bf7,y
                    ldy $84
                    lda $81
                    sta $000f,y
                    eor $83
                    sta $81
                    ldx #$34
                    ldy #$60
                    jsr S353d
                    lda #$00
                    ldx #$73
                    jsr S3593
                    jsr S23d4
                    lda #$07
                    jsr S3542
                    dec $86
                    bpl L14bd
                    lda $85
                    tay
                    clc
                    adc #$8b
                    sta $0017,y
                    lda #$ff
                    sta $0bf7,y
                    inc $9f
                    lda $9f
                    cmp #$09
                    bcc L1506
                    rts
                    
.L1506               inc $84
                    lda $84
                    cmp #$04
                    bne L149b
                    ldy #$2f
.L1510               lda $2302,y
                    sta $0188,y
                    dey
                    bpl L1510
                    lda #$08
                    sta $8e
.L151d               jsr S6440
                    lda $9b
                    and #$18
                    sta $8f
                    lsr a
                    adc $8f
                    tay
                    lda $0188,y
                    eor #$08
                    sta $0188,y
                    jsr S6440
                    lda $9b
                    and #$18
                    sta $8f
                    lsr a
                    adc $8f
                    tay
                    lda $0189,y
                    eor #$01
                    sta $0189,y
                    dec $8e
                    bne L151d
                    lda $9f
                    sta $70
                    sec
                    lda #$08
                    sbc $9f
                    lsr a
                    sta $8e
.L1557               dec $8e
                    bmi L157a
.L155b               jsr S6440
                    lda $9b
                    and #$18
                    sta $8f
                    lsr a
                    adc $8f
                    tax
                    lda $0189,x
                    beq L155b
                    lda #$00
                    ldy #$0c
.L1571               sta $0188,x
                    inx
                    dey
                    bne L1571
                    beq L1557
.L157a               lda #$01
                    jsr S2eb6
                    lda #$64
.L1581               pha
.L1582               jsr S6440
                    cmp #$05
                    bcs L1582
                    adc #$02
                    sta $95
                    lda #$02
.L158f               pha
                    lda #$13
                    jsr $fff4
                    lda $603e
                    eor #$f1
                    sta $603e
                    ldx #$3c
                    ldy #$60
                    jsr S353d
                    lda #$00
                    jsr S2eb6
                    pla
                    sec
                    sbc #$01
                    bne L158f
                    jsr $7f00
                    lda #$00
                    ldx #$73
                    jsr S3593
                    lda #$08
                    sta $8e
.L15bd               jsr S6440
                    ldx #$f0
                    and #$01
                    bne L15c8
                    ldx #$0f
.L15c8               ldy $8e
                    txa
                    ldx $17,y
                    bmi L15d2
                    sta $0bf7,y
.L15d2               dec $8e
                    bpl L15bd
                    pla
                    sec
                    sbc #$01
                    beq L15df
                    jmp L1581
                    
.L15df               dec $7e
                    lda #$03
                    sta $73
                    lda #$e8
                    sta $70
                    jmp L1321
                    
.L15ec               jsr S20d9
                    jsr $7f00
                    lda #$00
                    sta $77
                    sta $7b
                    sta $7c
                    sta $7d
                    sta $45
                    lda $0240
                    sta $50
.L1603               lda $76
                    sta $21
                    jsr S2554
                    lda $80
                    sta $81
                    and #$0f
                    beq L1620
                    cmp #$0f
                    beq L1620
                    cmp #$03
                    beq L1620
                    cmp #$0c
                    beq L1620
                    sta $79
.L1620               lda #$00
                    sta $80
                    ldy $0a
                    cpy #$0a
                    bcc L1666
                    lda #$80
                    ldx #$01
                    jsr $fff4
                    ldx #$00
                    cpy #$38
                    bcs L1639
                    ldx #$02
.L1639               cpy #$c8
                    bcc L163f
                    ldx #$01
.L163f               stx $80
                    lda #$80
                    ldx #$02
                    jsr $fff4
                    lda $80
                    cpy #$38
                    bcs L1650
                    ora #$08
.L1650               cpy #$c8
                    bcc L1656
                    ora #$04
.L1656               sta $80
                    lda #$80
                    ldx #$00
                    jsr $fff4
                    txa
                    and #$03
                    beq L16af
                    bne L16a9
.L1666               ldx $00,y
                    jsr S2094
                    bne L1673
                    lda $80
                    ora #$01
                    sta $80
.L1673               ldy $0a
                    ldx $01,y
                    jsr S2094
                    bne L1682
                    lda $80
                    ora #$02
                    sta $80
.L1682               ldy $0a
                    ldx $02,y
                    jsr S2094
                    bne L1691
                    lda $80
                    ora #$04
                    sta $80
.L1691               ldy $0a
                    ldx $03,y
                    jsr S2094
                    bne L16a0
                    lda $80
                    ora #$08
                    sta $80
.L16a0               ldy $0a
                    ldx $04,y
                    jsr S2094
                    bne L16af
.L16a9               lda $80
                    ora #$10
                    sta $80
.L16af               lda #$00
                    sta $f8
                    ldx $70
                    ldy $71
                    jsr S65e0
                    stx $8e
                    sty $8f
                    sty $8d
                    dex
                    stx $8c
                    ldx #$02
                    ldy #$00
                    lda $70
                    and #$07
                    beq L16ce
                    inx
.L16ce               lda $77
                    bne L16d7
                    lda $76
                    bne L16d7
                    inx
.L16d7               lda ($8c),y
                    and #$08
                    bne L16ef
                    clc
                    lda $8c
                    adc #$20
                    sta $8c
                    lda $8d
                    adc #$00
                    sta $8d
                    dex
                    bne L16d7
                    beq L16fb
.L16ef               lda $72
                    and #$03
                    bne L16fb
                    lda $f8
                    ora #$01
                    sta $f8
.L16fb               ldx #$02
                    ldy #$02
                    lda $70
                    and #$07
                    beq L1706
                    inx
.L1706               lda $77
                    bne L170f
                    lda $76
                    bne L170f
                    inx
.L170f               lda ($8e),y
                    and #$08
                    bne L1720
                    clc
                    tya
                    adc #$20
                    tay
                    dex
                    bne L170f
                    jmp L1726
                    
.L1720               lda $f8
                    ora #$02
                    sta $f8
.L1726               lda $2e
                    beq L1731
                    bmi L174c
                    dec $2e
                    jmp L174c
                    
.L1731               lda $2f
                    bmi L174c
                    jsr S6440
                    and #$03
                    bne L174c
                    jsr S2dbd
                    lda $2f
                    bpl L174c
                    jsr S6440
                    and #$07
                    bne L174c
                    dec $2e
.L174c               lda $76
                    beq L176d
                    lda $73
                    beq L1762
                    cmp #$01
                    bne L176d
                    ldx #$54
                    ldy #$60
                    jsr S353d
                    jmp L176d
                    
.L1762               lda $45
                    beq L176d
                    ldx #$d1
                    ldy #$20
                    jsr S353d
.L176d               lda $0240
                    cmp $50
                    beq L176d
                    sta $50
                    jsr S20d9
                    jsr S2571
                    lda $80
                    and #$03
                    cmp #$03
                    beq L17ea
                    lda $f8
                    and #$01
                    bne L17b7
                    lda $80
                    and #$01
                    beq L17b7
                    sta $45
                    lda $77
                    beq L179a
                    lda #$01
                    sta $76
.L179a               dec $72
                    lda $72
                    and #$07
                    sta $72
                    and #$03
                    cmp #$03
                    bne L17b1
                    sec
                    lda $70
                    sbc #$08
                    sta $70
                    dec $74
.L17b1               lda $22
                    and #$fe
                    sta $22
.L17b7               lda $f8
                    and #$02
                    bne L17ea
                    lda $80
                    and #$02
                    beq L17ea
                    sta $45
                    lda $77
                    beq L17cd
                    lda #$01
                    sta $76
.L17cd               clc
                    lda $72
                    and #$07
                    adc #$01
                    ora #$08
                    sta $72
                    and #$03
                    bne L17e4
                    lda $70
                    adc #$08
                    sta $70
                    inc $74
.L17e4               lda $22
                    ora #$01
                    sta $22
.L17ea               lda $76
                    beq L17f1
.L17ee               jmp L18af
                    
.L17f1               lda $80
                    and #$0c
                    cmp #$0c
                    beq L17ee
                    ldx $70
                    ldy $71
                    jsr S252f
                    sec
                    txa
                    sbc #$60
                    sta $8c
                    tya
                    sbc #$00
                    sta $8d
                    ldy #$02
                    lda $72
                    and #$03
                    bne L1814
                    dey
.L1814               lda ($8c),y
                    and #$08
                    bne L1820
                    dey
                    bpl L1814
                    jmp L182c
                    
.L1820               lda $70
                    and #$06
                    bne L182c
                    lda $f8
                    ora #$04
                    sta $f8
.L182c               ldy #$22
                    lda $72
                    and #$03
                    bne L1835
                    dey
.L1835               lda ($8e),y
                    and #$08
                    bne L1843
                    dey
                    cpy #$1f
                    bne L1835
                    jmp L1849
                    
.L1843               lda $f8
                    ora #$08
                    sta $f8
.L1849               lda $f8
                    and #$04
                    bne L1884
                    lda $80
                    and #$04
                    beq L188a
                    lda $f8
                    and #$f7
                    sta $f8
                    sec
                    lda $70
                    and #$07
                    sbc #$02
                    bcs L187d
                    sec
                    lda $70
                    sbc #$fa
                    sta $70
                    bcs L186f
                    dec $71
.L186f               sec
                    lda $74
                    sbc #$20
                    sta $74
                    bcs L187a
                    dec $75
.L187a               jmp L188a
                    
.L187d               dec $70
                    dec $70
                    jmp L188a
                    
.L1884               lda $70
                    and #$f8
                    sta $70
.L188a               lda $f8
                    and #$08
                    bne L18a9
                    lda $80
                    and #$08
                    beq L18af
                    lda #$02
                    jsr S2061
                    clc
                    lda $74
                    adc #$20
                    sta $74
                    bcc L18a6
                    inc $75
.L18a6               jmp L18af
                    
.L18a9               lda $70
                    and #$f8
                    sta $70
.L18af               lda $76
                    beq L18c9
                    lda $9e
                    bne L18c9
                    lda $81
                    and #$08
                    bne L18c9
                    lda $80
                    and #$08
                    beq L18c9
                    lda $71
                    cmp #$6d
                    bpl L18cc
.L18c9               jmp L19af
                    
.L18cc               lda $71
                    cmp #$7d
                    bcs L18c9
                    lda $3d
                    beq L18c9
                    lda $81
                    and #$08
                    bne L18c9
                    lda $80
                    and #$08
                    beq L18c9
                    lda $80
                    and #$03
                    bne L18c9
                    ldx $70
                    ldy $71
                    lda $73
                    beq L18f4
                    iny
                    iny
                    iny
                    iny
.L18f4               dey
                    jsr S65e0
                    ldy #$02
                    lda $72
                    and #$03
                    bne L1901
                    dey
.L1901               lda ($6b),y
                    and #$08
                    bne L1916
                    dey
                    bpl L1901
                    lda $73
                    beq L1926
                    lda $71
                    cmp #$7c
                    bcc L1926
                    bcs L191a
.L1916               lda $73
                    beq L18c9
.L191a               lda $70
                    and #$f8
                    sta $70
                    lda #$00
                    sta $73
                    inc $71
.L1926               ldy #$00
                    jsr S20c2
                    bne L197f
                    lda $70
                    and #$f8
                    sta $8e
                    lda $73
                    bne L1946
                    dec $71
                    sec
                    lda $74
                    sbc #$20
                    sta $74
                    lda $75
                    sbc #$00
                    sta $75
.L1946               ldx $8e
                    clc
                    lda $72
                    and #$02
                    beq L1954
                    txa
                    adc #$08
                    sta $8e
.L1954               lda $71
                    adc #$02
                    sty $6d
                    tay
                    lda $73
                    beq L1960
                    iny
.L1960               ldx $8e
                    jsr S65e0
                    stx $8e
                    sty $8f
                    ldx $6d
                    ldy #$00
                    lda ($8e),y
                    and #$07
                    cmp #$07
                    bne L1982
                    lda $65fe
                    sta $70
                    lda $65ff
                    sta $71
.L197f              jmp L19af
                    
.L1982              lda ($8e),y
                    ora #$08
                    sta ($8e),y
                    iny
                    lda ($8e),y
                    ora #$08
                    sta ($8e),y
                    lda $8f
                    and #$03
                    ora #$e0
                    sta $0401,x
                    lda $8e
                    sta $0400,x
                    sec
                    lda $3c
                    sbc #$40
                    sta $3c
                    bcs L19a8
                    dec $3d
.L19a8              ldx #$5c
                    ldy #$60
                    jsr S353d
.L19af              lda $80
                    and #$10
                    beq L1a04
                    lda $7d
                    bne L1a04
                    lda $3f
                    beq L1a04
                    sec
                    lda $3e
                    sbc #$20
                    sta $3e
                    bcs L19c8
                    dec $3f
.L19c8               lda $76
                    eor #$01
                    sta $78
                    lda $70
                    sta $7c
                    sta $8e
                    lda $71
                    ora #$80
                    tax
                    lda $70
                    and #$04
                    beq L19e0
                    inx
.L19e0               lda $76
                    beq L19e5
                    inx
.L19e5               stx $7d
                    stx $8f
                    ldx $79
                    lda $76
                    beq L19f9
                    ldx #$81
                    lda $72
                    and #$08
                    beq L19f9
                    ldx #$82
.L19f9               stx $7a
                    ldx #$44
                    ldy #$60
                    lda #$07
                    jsr osword
.L1a04               lda $76
                    bne L1a0b
                    jmp L1ab4
                    
.L1a0b               jsr S204e
                    bmi L1a19
                    lda ($74),y
                    and #$04
                    beq L1a19
                    jmp L1ab0
                    
.L1a19               ldy $73
                    lda $20b1,y
                    jsr S2061
                    lda $73
                    cmp #$10
                    bcs L1a29
                    inc $73
.L1a29               jsr S204e
                    bpl L1a31
.L1a2e               jmp L1ab4
                    
.L1a31               lda ($74),y
                    and #$04
                    bne L1a2e
                    lda ($74),y
                    and #$01
                    eor #$01
                    bne L1aaa
                    lda $73
                    cmp #$10
                    bmi L1aaa
                    lda $74
                    sta $8e
                    lda $75
                    sta $8f
                    sta $89
.L1a4f               dec $8e
                    lda ($8e),y
                    and #$01
                    bne L1a4f
                    dey
                    tya
                    clc
                    adc $8e
                    sta $8e
                    sta $88
                    asl $8e
                    rol $8f
                    asl $8e
                    rol $8f
                    asl $8e
                    rol $8f
                    lda $8f
                    ora #$60
                    sta $8f
                    lda #$e0
                    sta $8c
                    lda #$40
                    sta $8d
                    ldx #$04
                    ldy #$01
                    jsr S6500
                    ldy #$00
                    jsr S20c2
                    lda $89
                    and #$03
                    ora #$80
                    sta $0401,y
                    lda $88
                    sta $0400,y
                    ldy #$00
                    jsr S20c2
                    lda $89
                    and #$03
                    ora #$80
                    sta $0401,y
                    lda $88
                    clc
                    adc #$02
                    sta $0400,y
.L1aaa               lda $70
                    and #$f8
                    sta $70
.L1ab0               lda #$00
                    sta $73
.L1ab4               lda #$00
                    sta $77
                    lda $72
                    and #$03
                    bne L1add
                    lda $70
                    and #$f8
                    cmp $64
                    bne L1add
                    lda $71
                    cmp $65
                    bne L1add
                    lda #$01
                    sta $77
                    lda $70
                    and #$f8
                    sta $70
                    lda #$00
                    sta $76
                    jsr S2571
.L1add               lda $76
                    cmp $21
                    beq L1afd
                    lda $64
                    sta $8e
                    lda $65
                    clc
                    adc #$02
                    sta $8f
                    lda #$20
                    sta $8c
                    lda #$41
                    sta $8d
                    ldx #$02
                    ldy #$01
                    jsr S65ad
.L1afd               lda $72
                    and #$03
                    bne L1b63
                    sec
                    lda $74
                    sbc #$61
                    sta $8c
                    lda $75
                    sbc #$00
                    sta $8d
                    ldy #$21
                    lda ($8c),y
                    and #$0c
                    cmp #$04
                    bne L1b63
                    ldy #$22
                    lda ($8c),y
                    and #$0c
                    cmp #$04
                    bne L1b63
                    lda $75
                    cmp #$05
                    beq L1b43
                    lda $70
                    and #$06
                    bne L1b43
                    ldy #$01
                    lda ($8c),y
                    and #$0c
                    cmp #$04
                    bne L1b63
                    iny
                    lda ($8c),y
                    and #$0c
                    cmp #$04
                    bne L1b63
.L1b43               lda $70
                    and #$06
                    sbc #$02
                    bcc L1b55
                    lda $70
                    and #$fe
                    sbc #$02
                    sta $70
                    bcs L1b5f
.L1b55               lda $70
                    and #$f8
                    ora #$06
                    sta $70
                    dec $71
.L1b5f               lda #$01
                    bne L1b65
.L1b63               lda #$00
.L1b65               sta $9e
                    lda $76
                    beq L1b71
                    lda $71
                    cmp #$7d
                    bne L1b95
.L1b71               lda $71
                    cmp #$7c
                    bmi L1b95
                    lda $70
                    and #$07
                    beq L1b95
                    lda #$6d
                    sta $71
                    lda $70
                    and #$f8
                    sta $70
                    clc
                    lda $7e
                    adc #$10
                    sta $7e
                    bcc L1b92
                    inc $7f
.L1b92               jmp L1321
                    
.L1b95               lda $71
                    cmp #$6c
                    bne L1bb9
                    lda #$7c
                    sta $71
                    lda $70
                    and #$f8
                    ora $76
                    sta $70
                    lda #$07
                    sta $75
                    sec
                    lda $7e
                    sbc #$10
                    sta $7e
                    bcs L1bb6
                    dec $7f
.L1bb6               jmp L1321
                    
.L1bb9               lda $72
                    and #$03
                    cmp #$03
                    bne L1be0
                    lda $74
                    and #$1f
                    cmp #$1d
                    bne L1be0
                    lda $70
                    and #$07
                    sta $70
                    lda $72
                    and #$f8
                    ora #$01
                    sta $72
                    inc $7e
                    bne L1bdd
                    inc $7f
.L1bdd               jmp L1321
                    
.L1be0               lda $72
                    and #$03
                    bne L1c0a
                    lda $74
                    and #$1f
                    bne L1c0a
                    lda $70
                    and #$07
                    ora #$e8
                    sta $70
                    lda $72
                    and #$f8
                    ora #$02
                    sta $72
                    sec
                    lda $7e
                    sbc #$01
                    sta $7e
                    bcs L1c07
                    dec $7f
.L1c07               jmp L1321
                    
.L1c0a               jsr S20d9
                    jsr S220f
                    lda #$00
                    jsr S2eb6
                    jsr S2045
                    lda $71
                    cmp $59
                    beq L1c20
                    bcs L1c5c
.L1c20               ldx #$02
                    lda $70
                    and #$07
                    bne L1c29
                    dex
.L1c29               txa
                    clc
                    adc $71
                    cmp $59
                    bcc L1c5c
                    lda $70
                    and #$f8
                    cmp $58
                    beq L1c3b
                    bcs L1c5c
.L1c3b               clc
                    adc #$08
                    cmp $58
                    bcc L1c5c
                    lda $56
                    cmp #$05
                    beq L1c75
                    cmp #$03
                    bcc L1c80
                    beq L1cc8
                    cmp #$04
                    beq L1c8e
                    cmp #$06
                    beq L1c96
                    lda $80
                    and #$04
                    bne L1c5f
.L1c5c               jmp L1cec
                    
.L1c5f               lda $76
                    beq L1c5c
                    ldy #$04
.L1c65               dey
                    bmi L1c5c
                    lda $000f,y
                    cmp #$09
                    bne L1c65
                    jsr S102a
                    jmp L131b
                    
.L1c75               clc
                    sed
                    lda $49
                    adc #$01
                    sta $49
                    cld
                    bne L1cce
.L1c80               tax
.L1c81               lda $1c8b,x
                    clc
                    adc $3b
                    sta $3b
                    bne L1cce
                    bpl L1c98
                    EQUB $06  ; ??? 
.L1c8e               lda $3d
                    adc #$08
                    sta $3d
                    bne L1cce
.L1c96              ldx #$00
.L1c98              ldy #$01
                    jsr SCORE_ADD
                    jsr S6440
                    and #$03
                    clc
                    adc #$06
                    sta $8e
                    ldy #$00
                    ldx #$00
                    lda $49
                    beq L1c75
.L1caf               lda $3b,x
                    cmp $003b,y
                    bcs L1cb8
                    txa
                    tay
.L1cb8               inx
                    inx
                    cpx #$06
                    bne L1caf
                    ldx #$00
                    cpy #$00
                    beq L1c81
                    cpy #$02
                    beq L1c8e
.L1cc8               lda $3f
                    adc #$0b
                    sta $3f
.L1cce               lda $58
                    sta $8e
                    lda $59
                    sta $8f
                    lda $56
                    ldx $55
                    ldy #$ff
                    jsr $0bb3
                    ldy #$00
                    tya
                    sta ($53),y
                    iny
                    sta ($53),y
                    sta $59
                    jsr S0e24
.L1cec               sec
                    lda $3a
                    sbc #$01
                    sta $3a
                    bcs L1cf7
                    dec $3b
.L1cf7               lda $3b
                    bpl L1cff
                    lda #$00
                    sta $3b
.L1cff               jsr S23d4
                    lda $f6
                    cmp $70
                    bne L1d19
                    lda $f7
                    cmp $71
                    bne L1d19
                    lda #$13
                    jsr $fff4
                    jsr S0e2b
                    jmp L1321
                    
.L1d19               lda $72
                    and #$03
                    bne L1d4e
                    lda $70
                    cmp $4c
                    bne L1d4e
                    lda $71
                    cmp $4d
                    bne L1d4e
                    lda $4e
                    sta $70
                    lda $4f
                    sta $71
                    lda $4b
                    sta $7e
                    lda $72
                    and #$fc
                    ora $4a
                    sta $72
                    ldx #$19
                    ldy #$25
                    jsr L352b
                    lda #$0a
                    jsr S3542
                    jmp L1321
                    
.L1d4e               sec
                    lda $70
                    and #$f8
                    sbc #$10
                    cmp $0d
                    beq L1d60
                    clc
                    adc #$20
                    cmp $0d
                    bne L1d90
.L1d60               lda $72
                    and #$03
                    bne L1d90
                    ldy #$04
.L1d68               dey
                    bmi L1d90
                    lda $000f,y
                    cmp #$0a
                    bne L1d68
                    jsr FLUSH_BUFFERS
                    ldx #$fb
                    ldy #$24
                    jsr L352b
                    lda #$11
                    jsr S3542
                    jsr S2366
                    lda $61c4,y
                    ora #$02
                    sta $61c4,y
                    lda #$01
                    sta $0d
.L1d90               lda $76
                    beq L1da6
                    lda $80
                    and #$04
                    beq L1da6
                    lda $81
                    and #$04
                    bne L1da6
                    lda $80
                    and #$03
                    beq L1da9
.L1da6               jmp L1e5d
                    
.L1da9               ldx #$11
                    ldy #$25
                    jsr S353d
                    lda #$00
                    sta $8d
.L1db4               ldx $8d
                    lda $0528,x
                    cmp $7e
                    bne L1e0b
                    lda $0529,x
                    and #$03
                    cmp $7f
                    bne L1e0b
                    lda $0529,x
                    and #$f8
                    sec
                    sbc #$18
                    bcc L1dd4
                    cmp $70
                    bcs L1e0b
.L1dd4               adc #$20
                    bcs L1ddc
                    cmp $70
                    bcc L1e0b
.L1ddc               lda $052a,x
                    sbc #$02
                    cmp $71
                    bcs L1e0b
                    adc #$03
                    cmp $71
                    bcc L1e0b
                    lda $0529,x
                    and #$f8
                    sta $8e
                    lda #$03
                    sta $0529,x
                    lda $052a,x
                    sta $8f
                    lda $052b,x
                    sta $86
                    ldx #$ff
                    ldy #$ff
                    jsr $0bb3
                    jmp L1e1a
                    
.L1e0b               clc
                    lda $8d
                    adc #$04
                    sta $8d
                    cmp #$50
                    bne L1db4
                    lda #$00
                    sta $86
.L1e1a               lda $12
                    beq L1e4e
                    ldy #$fc
.L1e20               iny
                    iny
                    iny
                    iny
                    lda $0529,y
                    and #$02
                    beq L1e20
                    lda $7e
                    sta $0528,y
                    lda $70
                    and #$f8
                    sta $8e
                    ora $7f
                    sta $0529,y
                    lda $71
                    sta $052a,y
                    sta $8f
                    lda $12
                    sta $052b,y
                    ldx #$ff
                    ldy #$ff
                    jsr $0bb3
.L1e4e               ldy #$02
.L1e50               lda $000f,y
                    sta $0010,y
                    dey
                    bpl L1e50
                    lda $86
                    sta $0f
.L1e5d               lda $71
                    cmp $af
                    bne L1ed1
                    lda $72
                    and #$03
                    bne L1ed1
                    lda $70
                    ldy #$02
                    ldx #$09
                    cmp $ac
                    beq L1e85
                    ldy #$00
                    ldx #$03
                    cmp $ae
                    bne L1ed1
                    lda $7f
                    beq L1e85
                    lda $7e
                    cmp #$6a
                    beq L1ed1
.L1e85               sty $86
                    ldy #$04
.L1e89               dey
                    bmi L1ed1
                    lda $000f,y
                    cmp #$09
                    bne L1e89
                    txa
                    pha
                    lda $72
                    jsr S20d9
                    ldx #$50
                    ldy #$23
                    jsr L352b
                    pla
                    tax
                    ldy $86
                    lda $00ac,y
                    sta $70
                    stx $72
                    cpx #$03
                    bne L1eb5
                    sec
                    sbc #$08
                    sta $70
.L1eb5               lda #$06
                    sta $8b
.L1eb9               lda #$03
                    jsr S3542
                    lda $91
                    eor #$07
                    sta $91
                    jsr $7f00
                    dec $8b
                    bne L1eb9
                    jsr FLUSH_BUFFERS
                    jsr S20d9
.L1ed1               jsr S2554
                    ldy #$40
                    sec
                    lda $74
                    sbc #$40
                    sta $8c
                    lda $75
                    sbc #$00
                    sta $8d
                    lda $70
                    and #$07
                    bne L1eeb
                    ldy #$20
.L1eeb               ldx #$01
                    lda $72
                    and #$03
                    beq L1ef4
                    inx
.L1ef4               stx $8e
.L1ef6               tya
                    and #$60
                    ora $8e
                    tay
.L1efc               lda ($8c),y
                    and #$40
                    beq L1f06
                    lda #$01
                    sta $20
.L1f06               dey
                    tya
                    and #$18
                    beq L1efc
                    cpy #$ff
                    bne L1ef6
                    lda $20
                    bne L1f22
                    lda $3b
                    beq L1f1b
                    jmp L1fda
                    
.L1f1b               lda #$01
                    jsr S2eb6
                    lda #$0c
.L1f22               pha
                    jsr FLUSH_BUFFERS
                    jsr S0f17
                    pla
                    asl a
                    asl a
                    sta $86
                    lda #$01
                    sta $7b
                    jsr S220f
.L1f35               lda #$13
                    jsr $fff4
                    jsr S20d9
                    dec $86
                    bpl L1f35
                    lda $20
                    pha
                    beq L1f6c
                    pha
                    lda #$01
                    jsr S2eb6
                    pla
                    cmp #$02
                    beq L1f55
                    cmp #$03
                    bne L1f6c
.L1f55               lda $70
                    sta $8e
                    lda $71
                    sta $8f
                    lda #$00
                    sta $8c
                    lda #$3c
                    sta $8d
                    ldx #$03
                    ldy #$02
                    jsr S6526
.L1f6c               lda $70
                    and #$f8
                    sta $2340
                    lda $71
                    sta $2341
                    lda #$00
                    sta $8e
.L1f7c               jsr S6440
                    and #$03
                    tay
                    lda $234c,y
                    sta $2343
                    jsr S6440
                    and #$07
                    clc
                    adc #$04
                    sta $2344
                    ldy $8e
                    ldx #$00
.L1f97               lda $2340,x
                    sta $0188,y
                    iny
                    inx
                    cpx #$0c
                    bne L1f97
                    sty $8e
                    cpy #$30
                    bne L1f7c
                    lda #$01
                    jsr S2eb6
                    jsr FLUSH_BUFFERS
                    ldx #$43
                    ldy #$04
                    jsr L352b
                    lda #$78
                    sta $69
.L1fbc               lda #$13
                    jsr $fff4
                    lda #$00
                    jsr S2eb6
                    jsr S2045
                    dec $69
                    bne L1fbc
                    pla
                    beq L1fd4
                    cmp #$03
                    bcc L1fd7
.L1fd4               jsr S2560
.L1fd7               jmp L12ef
                    
.L1fda               ldx #$9f
                    jsr S2094
                    bne L1ffb
                    jsr FLUSH_BUFFERS
                    jsr $ffe0
                    and #$5f
                    ldx #$00
                    cmp #$53
                    beq L1ff4
                    inx
                    cmp #$51
                    bne L1ffb
.L1ff4               ldy #$00
                    lda #$d2
                    jsr $fff4
.L1ffb               ldy #$00
.L1ffd               sty $8f
                    ldx $8f
.L2001               lda $0189,x
                    cmp $0189,y
                    bcs L200b
                    stx $8f
.L200b               clc
                    txa
                    adc #$0c
                    tax
                    cpx #$30
                    bmi L2001
                    lda #$0c
                    sta $8c
                    ldx $8f
.L201a               lda $0188,x
                    pha
                    lda $0188,y
                    sta $0188,x
                    pla
                    sta $0188,y
                    iny
                    inx
                    dec $8c
                    bne L201a
                    cpy #$24
                    bcc L1ffd
                    ldx #$fe
                    jsr S2094
                    bne L2040
                    ldx #$8f
                    jsr S2094
                    beq L2043
.L2040               jmp L1603
                    
.L2043               clc
                    rts
                    
.S2045               jsr S2149
                    jsr S6461
                    jmp L62ad
                    
.S204e               ldy #$02
                    lda $72
                    and #$03
                    bne L2057
                    dey
.L2057               lda ($74),y
                    and #$0c
                    bne L2060
                    dey
                    bpl L2057
.L2060               rts
                    
.S2061               sta $8e
                    lda $70
                    and #$07
                    clc
                    adc $8e
                    and #$08
                    beq L2088
                    clc
                    lda $74
                    adc #$20
                    sta $74
                    lda $75
                    adc #$00
                    sta $75
                    clc
                    lda $70
                    adc #$f8
                    sta $70
                    lda $71
                    adc #$00
                    sta $71
.L2088               clc
                    lda $70
                    adc $8e
                    sta $70
                    bcc L2093
                    inc $71
.L2093               rts
                    
.S2094               lda #$81
                    ldy #$ff
                    jsr $fff4
                    cpx #$ff
                    rts
                    
                    EQUB $00, $ff

.S20a0              ldy #$00
.L20a2              lda #$00
                    sta $0580,y
                    sta $0600,y
                    sta $0700,y
                    iny
                    bne L20a2
                    rts
                    
                    EQUB $01, $00, $01, $00, $01, $02, $01, $02 
                    EQUB $01, $02, $02, $03, $02, $03, $03, $04, $04 

.S20c2              lda $0401,y
                    beq L20d0
                    iny
                    iny
                    tya
                    and #$1f
                    bne S20c2
                    lda #$01
.L20d0              rts
                    
                    EQUB $10, $00, $f9, $00, $03, $00, $01, $00

.S20d9              ldx $70
                    stx $8e
                    ldx $71
                    stx $8f
                    lda $72
                    asl a
                    sta $8c
                    lsr a
                    adc $8c
                    adc #$08
                    sta $8c
                    lda #$00
                    sta $8d
                    ldx #$04
.L20f3               asl $8c
                    rol $8d
                    dex
                    bne L20f3
                    lda $8d
                    adc #$3d
                    sta $8d
                    ldx #$03
                    ldy #$02
                    jsr S6300
                    lda $76
                    bne L20d0
                    lda $70
                    and #$07
                    ora $98
                    sta $8e
                    clc
                    lda $71
                    adc #$02
                    sta $8f
                    lda $99
                    tax
                    asl a
                    sta $8c
                    clc
                    txa
                    adc $8c
                    sta $8c
                    lda #$00
                    sta $8d
                    asl $8c
                    rol $8d
                    asl $8c
                    rol $8d
                    asl $8c
                    rol $8d
                    lda $8c
                    adc #$20
                    sta $8c
                    lda $8d
                    adc #$41
                    sta $8d
                    ldx #$03
                    ldy #$01
                    jmp S6526
                    
.S2149               lda #$00
                    sta $87
.L214d               ldy $87
                    lda $0400,y
                    sta $85
                    lda $0401,y
                    sta $86
                    and #$fc
                    beq L21a9
                    sec
                    lda $86
                    sbc #$04
                    sta $86
                    and #$1c
                    cmp #$1c
                    bne L219d
                    lda $86
                    and #$e0
                    lsr a
                    ora #$80
                    sta $8c
                    lda #$40
                    sta $8d
                    jsr S21b4
                    lda $86
                    and #$fc
                    cmp #$1c
                    bne L219d
                    lda $86
                    and #$03
                    ora #$04
                    sta $86
                    ldy #$01
                    lda ($85),y
                    and #$f7
                    sta ($85),y
                    dey
                    lda ($85),y
                    and #$f7
                    sta ($85),y
                    sty $85
                    sty $86
.L219d               ldy $87
                    lda $85
                    sta $0400,y
                    lda $86
                    sta $0401,y
.L21a9               inc $87
                    inc $87
                    lda $87
                    cmp #$20
                    bmi L214d
                    rts
                    
.S21b4               lda $85
                    sta $8e
                    lda $86
                    and #$03
                    sta $8f
                    asl $8e
                    rol $8f
                    asl $8e
                    rol $8f
                    asl $8e
                    rol $8f
                    lda $8f
                    ora #$60
                    sta $8f
                    jmp S65d4
                    
.S21d3               lda $78
                    beq L21ee
                    lda #$3c
                    sta $8d
                    lda $8e
                    and #$10
                    eor #$10
                    sta $8c
                    asl a
                    adc $8c
                    adc #$c0
                    bcc L21f6
                    inc $8d
                    bne L21f6
.L21ee               lda #$41
                    sta $8d
                    lda $8e
                    and #$10
.L21f6               sta $8c
                    lda $8f
                    and #$1f
                    ora #$60
                    sta $8f
                    lda $8e
                    and #$f8
                    sta $8e
                    ldx $78
                    inx
                    txa
                    tay
                    inx
                    jmp S65ad
                    
.S220f               lda $7d
                    bmi L221e
                    beq L222e
                    sta $8f
                    lda $7c
                    sta $8e
                    jsr S21d3
.L221e               lda $7d
                    and #$7f
                    sta $7d
                    lda $7b
                    beq L222f
                    lda #$00
                    sta $7d
                    sta $7b
.L222e               rts
                    
.L222f               lda $7a
                    and #$01
                    beq L223e
                    sec
                    lda $7c
                    sbc #$08
                    sta $7c
                    bcc L22b3
.L223e               lda $7a
                    and #$02
                    beq L224f
                    clc
                    lda $7c
                    adc #$08
                    sta $7c
                    cmp #$f8
                    bcs L22b3
.L224f               lda $7a
                    and #$04
                    beq L225d
                    dec $7d
                    lda $7d
                    cmp #$6d
                    bcc L22ba
.L225d               lda $7a
                    and #$08
                    beq L226b
                    inc $7d
                    lda $7d
                    cmp #$7e
                    bcs L22ba
.L226b               ldx $7c
                    ldy $7d
                    jsr S65e0
                    ldx #$00
                    stx $8e
.L2276               ldy #$00
.L2278               lda ($6b),y
                    and #$08
                    sta $22fe,x
                    beq L2283
                    sta $8e
.L2283               iny
                    inx
                    cpy #$02
                    bne L2278
                    clc
                    lda $6b
                    adc #$20
                    sta $6b
                    bcc L2294
                    inc $6c
.L2294               txa
                    lsr a
                    sbc #$00
                    cmp $78
                    bcc L2276
                    lda $8e
                    bne L22ab
                    lda $7c
                    sta $8e
                    lda $7d
                    sta $8f
                    jmp S21d3
                    
.L22ab               lda $22fe
                    eor $22ff
                    beq L22ba
.L22b3               lda $7a
                    eor #$83
                    jmp L22be
                    
.L22ba               lda $7a
                    eor #$8c
.L22be               sta $7a
                    and #$03
                    beq L22c8
                    eor #$03
                    bne L22d7
.L22c8               jsr S6440
                    and #$03
                    beq L22c8
                    eor #$03
                    beq L22c8
                    eor $7a
                    sta $7a
.L22d7               lda $7a
                    and #$0c
                    beq L22e1
                    eor #$0c
                    bne L22f0
.L22e1               jsr S6440
                    and #$0c
                    beq L22e1
                    eor #$0c
                    beq L22e1
                    eor $7a
                    sta $7a
.L22f0              lda $7a
                    bpl L22f7
                    jmp L222f
                    
.L22f7              lda #$00
                    sta $7c
                    sta $7d
                    rts
                    
                    EQUB $00, $00 
                    EQUB $00, $00, $40, $70, $04, $06, $04, $78, $00, $00, $78, $fa, $00, $00, $a0, $70 
                    EQUB $04, $0c, $04, $78, $00, $00, $78, $fa, $00, $00, $40, $78, $04, $03, $04, $78 
                    EQUB $00, $00, $78, $fa, $00, $00, $a0, $78, $04, $09, $04, $78, $00, $00, $78, $fa 
                    EQUB $00, $00, $00, $7a, $03, $01, $0c, $1e, $00, $01, $1e, $00, $00, $00, $01, $04 
                    EQUB $00, $00, $04, $00, $00, $78, $00, $00, $78, $fa, $00, $00, $03, $06, $09, $0c 
                    EQUB $04, $01, $f5, $eb, $e1, $01, $02, $02, $7e, $00, $00, $82, $82, $82, $11, $00 
                    EQUB $04, $00, $c8, $00, $06, $00 

.S2366              ldy #$00
.L2368              lda $61c3,y
                    cmp $7e
                    bne L23cd
                    lda $61c4,y
                    and #$03
                    cmp $7f
                    bne L23cd
                    tya
                    pha
                    lda $61c4,y
                    and #$f8
                    sta $8e
                    sta $0d
                    pha
                    lda #$76
                    sta $8f
                    pha
                    lda #$ab
                    sta $8c
                    lda #$61
                    sta $8d
                    ldx #$30
                    ldy #$01
                    jsr $0b79
                    ldx #$02
                    ldy #$03
                    jsr S65ad
                    pla
                    tay
                    pla
                    tax
                    jsr S65e0
                    stx $8e
                    sty $8f
                    ldx #$03
                    ldy #$00
.L23ae               lda ($8e),y
                    eor #$18
                    sta ($8e),y
                    iny
                    lda ($8e),y
                    eor #$0c
                    sta ($8e),y
                    dey
                    clc
                    lda $8e
                    adc #$40
                    sta $8e
                    bcc L23c7
                    inc $8f
.L23c7               dex
                    bne L23ae
                    pla
                    tay
                    rts
                    
.L23cd               iny
                    iny
                    cpy #$0a
                    bne L2368
                    rts
                    
.S23d4               ldx #$04
                    ldy #$00
.L23d8               dex
                    bmi L2435
                    lda $30,x
                    cmp SCORE0,x
                    beq L23d8
                    ldx #$00
.L23e3              lda SCORE0,x
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    clc
                    adc #$61
                    sta $24e7,y
                    iny
                    lda SCORE0,x
                    and #$0f
                    adc #$61
                    sta $24e7,y
                    iny
                    inx
                    cpx #$04
                    bne L23e3
                    lda #$0d
                    sta $24ec
                    lda #$18
                    sta $8a
                    lda #$68
                    sta $8b
                    lda #$00
                    sta $87
                    lda #$f0
                    sta $89
                    ldx #$e7
                    ldy #$24
                    jsr $0a80
                    lda #$60
                    sta $8a
                    inc $8b
                    lda #$00
                    sta $87
                    ldx #$ed
                    ldy #$24
                    jsr $0a80

                    ; Copy score somewhere for some reason
                    ldx #$03
.L242e              lda SCORE0,x
                    sta $30,x
                    dex
                    bpl L242e

.L2435              lda #$67
                    sta $8f
                    lda #$88
                    sta $8e
                    lda #$00
                    sta $8a
.L2441              ldx $8a
                    lda $35,x
                    cmp $3b,x
                    beq L2496
                    lda #$f0
                    cpx #$02
                    bne L2451
                    lda #$ff
.L2451               sta $8c
                    lda $3b,x
                    cmp #$11
                    bcc L2461
                    lda #$ff
                    sta $3a,x
                    lda #$10
                    sta $3b,x
.L2461               sta $89
                    lda #$03
                    sta $88
                    ldy #$00
.L2469               lda #$00
                    ldx $89
                    bmi L2478
                    lda #$ff
                    cpx #$04
                    bcs L2478
                    lda $24ef,x
.L2478               and $8c
                    sta $8d
                    ldx #$00
.L247e               lda $24f3,x
                    and $8d
                    sta ($8e),y
                    iny
                    inx
                    cpx #$08
                    bne L247e
                    sec
                    lda $89
                    sbc #$04
                    sta $89
                    dec $88
                    bpl L2469
.L2496               inc $8f
                    inc $8a
                    inc $8a
                    lda $8a
                    cmp #$06
                    bne L2441
                    ldy #$05
.L24a4               lda $003a,y
                    sta $0034,y
                    dey
                    bpl L24a4
                    lda #$b0
                    sta $8e
                    lda #$00
                    sta $87
.L24b5               ldx $87
                    lda $0f,x
                    cmp $13,x
                    beq L24ce
                    ldx #$67
                    stx $8f
                    ldx #$f0
                    ldy #$00
                    cmp #$00
                    bne L24cb
                    lda #$08
.L24cb               jsr $0bb3
.L24ce               clc
                    lda $8e
                    adc #$10
                    sta $8e
                    inc $87
                    cmp #$f0
                    bcc L24b5
                    ldy #$03
.L24dd               lda $000f,y
                    sta $0013,y
                    dey
                    bpl L24dd
                    rts
                    
                    EQUB $00, $00, $00, $00, $00, $00, $00, $0d, 040 
                    EQUB $88, $cc, $ee, $ff, $00, $ee, $ee, $ee, $00, $ff, $00, $04, $01, $fb, $f9, $f6 
                    EQUB $04, $04, $04, $7e, $00, $00, $82, $7e, $7e, $12, $00, $04, $00, $64, $00, $07 
                    EQUB $00, $12, $00, $f6, $00, $32, $00, $01, $00, $04, $01, $00, $00, $00, $00, $00 
                    EQUB $00, $08, $ec, $ec, $ec, $7e, $5a, $10, $00, $04, $00, $04, $00, $04, $00

.S252f               stx $8e
                    sty $8f
                    ldx #$03
.L2535               lsr $8f
                    ror $8e
                    dex
                    bne L2535
                    lda $8f
                    and #$03
                    ora #$04
                    sta $8f
                    clc
                    lda $8e
                    adc #$40
                    sta $8e
                    tax
                    lda $8f
                    adc #$00
                    sta $8f
                    tay
                    rts
                    
.S2554               ldx $70
                    ldy $71
                    jsr S252f
                    stx $74
                    sty $75
                    rts
                    
.S2560               lda $70
                    sta $5a
                    lda $71
                    sta $5b
                    lda $72
                    sta $5c
                    lda $76
                    sta $5d
                    rts
                    
.S2571               lda $70
                    and #$f8
                    sta $98
                    lda $72
                    and #$03
                    sta $99
                    lda #$00
                    sta $45
                    rts
                    
.S2582               ldx $86
                    lda $0400,x
                    and #$3f
                    sta $8f
                    asl a
                    adc $8f
                    asl a
                    sta $69
                    ldy #$00
.L2593               ldx $69
                    lda $5980,x
                    and #$0f
                    tax
                    lda $2db5,x
                    sta ($80),y
                    iny
                    ldx $69
                    lda $5980,x
                    and #$f0
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    tax
                    lda $2db5,x
                    sta ($80),y
                    iny
                    inc $69
                    lda $69
                    and #$01
                    bne L2593
                    tya
                    clc
                    adc #$1c
                    tay
                    cpy #$60
                    bne L2593
                    rts
                    
.S25c5               stx $8e
                    sty $8f
                    stx $8c
                    sty $8d
                    asl $8e
                    rol $8f
                    txa
                    adc $8e
                    sta $80
                    tya
                    adc $8f
                    sta $81
                    asl $80
                    rol $81
                    asl $80
                    rol $81
                    lda $80
                    adc #$80
                    sta $80
                    lda $81
                    adc #$41
                    sta $81
                    rts
                    
.S25f0               stx $89
                    stx $84
                    sty $8a
                    sty $85
                    lda #$13
                    jsr $fff4
                    lda #$00
                    sta $93
                    sta $95
                    sta $97
                    sta $4d
                    sta $59
                    sta $af
                    sta $ad
                    ldy #$57
.L260f               sta $0100,y
                    dey
                    bpl L260f
                    jsr $7f00
                    ldx $89
                    ldy $8a
                    jsr S25c5
                    ldy #$00
                    lda ($80),y
                    pha
                    pha
                    and #$07
                    sta $2dab
                    pla
                    and #$e0
                    asl a
                    rol a
                    rol a
                    rol a
                    sta $95
                    pla
                    and #$18
                    lsr a
                    lsr a
                    lsr a
                    tax
                    lda $2db1,x
                    sta $93
                    iny
                    lda ($80),y
                    pha
                    and #$0f
                    sta $2dac
                    pla
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    sta $2dad
                    ldx #$00
                    ldy #$02
.L2654               lda ($80),y
                    and #$c0
                    asl a
                    rol a
                    rol a
                    sta $8e
                    iny
                    lda ($80),y
                    and #$c0
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    ora $8e
                    sta $2dae,x
                    iny
                    inx
                    cpx #$02
                    bne L2654
                    lda #$00
                    sta $f7
                    lda #$06
                    sta $92
                    lda #$03
                    sta $94
                    lda #$01
                    sta $96
                    lda #$07
                    sta $97
                    ldy #$06
                    ldx #$00
.L2689               lda ($80),y
                    sta $8f
.L268d               lda #$00
                    asl $8f
                    bcc L26af
                    lda $85
                    bne L26a5
                    lda $84
                    cmp #$10
                    bcs L26a5
                    cpy #$08
                    bcs L26a5
                    lda #$d8
                    bne L26af
.L26a5               sty $8e
                    ldy $2dab
                    lda $2d90,y
                    ldy $8e
.L26af               sta $0400,x
                    inx
                    txa
                    and #$07
                    bne L268d
                    iny
                    cpy #$0c
                    bne L2689
                    lda #$02
                    sta $8d
.L26c1               lda $8d
                    cmp #$04
                    bmi L26d1
                    tay
                    lda $2daa,y
                    cmp #$0f
                    bne L270f
                    lda $8d
.L26d1               and #$01
                    tax
                    ldy $2dac,x
                    lda $2d98,y
                    sta $8e
                    ldy $8d
                    lda ($80),y
                    and #$3f
                    cmp #$30
                    bcs L270f
                    tax
                    lda $8d
                    and #$01
                    tay
                    lda $2dac,y
                    cmp #$06
                    bcs L2726
                    cmp #$03
                    beq L2712
                    lda $8e
                    and #$3f
                    cmp #$09
                    bne L270a
                    ldy #$00
                    lda $0400,x
                    beq L2708
                    ldy #$18
.L2708               sty $64
.L270a               lda $8e
                    sta $0400,x
.L270f               jmp L2839
                    
.L2712               ldy $0400,x
                    lda #$cc
                    sta $0400,x
                    cpy #$00
                    beq L270f
                    txa
                    clc
                    adc #$08
                    tax
                    jmp L282a
                    
.L2726               cmp #$0f
                    beq L2755
                    cmp #$0e
                    bne L2731
                    jmp L27a9
                    
.L2731               cmp #$0d
                    beq L2765
                    cmp #$06
                    bne L273c
                    jmp L27f1
                    
.L273c               cmp #$09
                    bne L2743
                    jmp L27fe
                    
.L2743               cmp #$08
                    bne L274a
                    jmp L282a
                    
.L274a               cmp #$0a
                    bne L2751
                    jmp L280c
                    
.L2751               cmp #$07
                    beq L2758
.L2755               jmp L2839
                    
.L2758               lda #$a3
                    sta $0400,x
                    lda #$a4
                    sta $0401,x
                    jmp L2839
                    
.L2765               dec $8e
                    lda #$1a
                    sta $8f
                    lda $0400,x
                    bne L278d
                    lda #$18
                    sta $8f
.L2774               lda $8f
                    clc
                    adc #$01
                    sta $0400,x
                    lda $8e
                    sta $8f
                    txa
                    sbc #$07
                    tax
                    bcc L2755
                    lda $0400,x
                    beq L2774
                    bne L27ee
.L278d               lda $8f
                    clc
                    adc #$01
                    sta $0400,x
                    lda $8e
                    sta $8f
                    txa
                    clc
                    adc #$08
                    tax
                    cpx #$30
                    bcs L2755
                    lda $0400,x
                    beq L278d
                    bne L27ee
.L27a9               lda $95
                    sta $8b
                    lda #$00
                    ldy $0400,x
                    beq L27b6
                    lda #$01
.L27b6               sta $8c
                    lda #$97
                    cpx #$08
                    bpl L27c0
                    lda $8e
.L27c0               sta $8f
.L27c2               lda $8f
                    sta $0400,x
                    lda #$93
                    sta $8f
                    lda $8c
                    eor #$01
                    sta $8c
                    bne L27d9
                    lsr $8b
                    bcc L27d9
                    inc $8f
.L27d9               clc
                    txa
                    adc #$08
                    tax
                    lda #$93
                    cpx #$30
                    bcs L27eb
                    lda $0400,x
                    beq L27c2
                    lda #$94
.L27eb               sta $03f8,x
.L27ee               jmp L2839
                    
.L27f1               lda $8e
                    sta $0400,x
                    clc
                    adc #$01
                    sta $0401,x
                    bne L27ee
.L27fe               lda $0408,x
                    bne L2805
                    inc $8e
.L2805               lda $8e
                    sta $0400,x
                    bne L27ee
.L280c               lda #$e1
                    sta $0410,x
                    sta $0413,x
                    sta $0408,x
                    sta $040b,x
                    lda #$62
                    sta $0400,x
                    sta $0402,x
                    sta $0401,x
                    sta $0403,x
                    bne L2839
.L282a               lda $0400,x
                    beq L2834
                    lda #$97
                    sta $0408,x
.L2834               lda #$d0
                    sta $0400,x
.L2839               inc $8d
                    lda $8d
                    cmp #$06
                    beq L2844
                    jmp L26c1
                    
.L2844               jsr S2cf9
                    ldy #$08
.L2849               lda $6223,y
                    cmp $84
                    bne L2883
                    lda $6224,y
                    and #$01
                    cmp $85
                    bne L2883
                    lda $6224,y
                    lsr a
                    tax
                    lda #$25
                    sta $0400,x
                    lda $6222,y
                    sta $03f8,x
                    sty $f5
                    txa
                    and #$07
                    asl a
                    asl a
                    asl a
                    asl a
                    asl a
                    sta $f6
                    txa
                    lsr a
                    lsr a
                    and #$0e
                    sta $8e
                    lsr a
                    adc $8e
                    adc #$6e
                    sta $f7
.L2883               clc
                    tya
                    adc #$08
                    tay
                    bpl L2849
                    lda #$00
                    sta $8d
.L288e               ldx $8d
                    lda $0400,x
                    and #$3f
                    cmp #$0b
                    beq L289d
                    cmp #$0c
                    bne L28ef
.L289d               and #$01
                    sta $8c
                    ldy #$17
.L28a3               lda $0100,y
                    sta $0108,y
                    dey
                    bpl L28a3
                    txa
                    and #$38
                    lsr a
                    lsr a
                    sta $8b
                    lsr a
                    adc $8b
                    adc $8c
                    adc #$6d
                    sta $0101
                    tay
                    txa
                    and #$07
                    asl a
                    asl a
                    adc #$01
                    asl a
                    asl a
                    asl a
                    sta $0100
                    tax
                    jsr S65e0
                    stx $0102
                    sty $0103
                    jsr S6440
                    lda $9b
                    and #$1f
                    sta $0104
                    lda #$2c
                    sta $0105
                    jsr S6440
                    and #$1c
                    clc
                    adc #$50
                    sta $0106
.L28ef               inc $8d
                    lda $8d
                    cmp #$30
                    bne L288e
                    lda $84
                    cmp #$b0
                    bcc L293b
                    and #$0f
                    cmp #$0b
                    bcc L293b
                    lda $85
                    beq L293b
                    ldy #$00
                    lda #$01
                    sta $8e
.L290d               lda $0400,y
                    beq L291b
                    cmp #$c0
                    bcs L291b
                    lda #$e1
                    sta $0400,y
.L291b               lda $8e
                    eor #$06
                    sta $8e
                    tya
                    clc
                    adc $8e
                    tay
                    cpy #$30
                    bne L290d
                    lda $0404
                    beq L2945
                    ldy #$07
.L2931               lda #$62
                    sta $0400,y
                    dey
                    bpl L2931
                    bmi L2945
.L293b               lda $84
                    cmp #$f0
                    bcc L295b
                    lda $85
                    beq L295b
.L2945               lda $042c
                    beq L295b
                    ldy #$07
.L294c               lda $0428,y
                    cmp #$c9
                    beq L2958
                    lda #$5f
                    sta $0428,y
.L2958               dey
                    bpl L294c
.L295b               ldy #$08
.L295d               lda $03f8,y
                    and #$3f
                    cmp #$17
                    bpl L299a
                    cmp #$13
                    bmi L299a
                    pha
                    lda #$01
                    sta $0118,y
                    lda #$02
                    sta $95
                    pla
                    cmp #$14
                    bne L299a
                    lda $03f7,y
                    beq L2990
                    lda $03f9,y
                    beq L298b
                    lda #$93
                    sta $03f8,y
                    jmp L299a
                    
.L298b               lda #$96
                    sta $03f8,y
.L2990               lda $03f9,y
                    beq L299a
                    lda #$95
                    sta $03f8,y
.L299a               iny
                    cpy #$38
                    bne L295d
                    lda #$07
                    sta $8f
.L29a3               jsr S6440
                    ora #$10
                    ldy $8f
                    sta $0150,y
                    dec $8f
                    bpl L29a3
                    lda $84
                    cmp #$f4
                    bne L29c0
                    lda $85
                    beq L29c0
                    lda #$87
                    sta $0423
.L29c0               lda $85
                    bne L29cf
                    lda $84
                    cmp #$ec
                    bne L29cf
                    lda #$94
                    sta $0425
.L29cf               lda #$a0
                    sta $80
                    lda #$05
                    sta $81
                    lda #$00
                    sta $82
                    sta $65
                    sta $86
                    lda #$6d
                    sta $83
.L29e3               ldy $86
                    lda $0400,y
                    and #$3f
                    sta $8c
                    lda $0400,y
                    and #$c0
                    asl a
                    rol a
                    rol a
                    tax
                    lda $2da7,x
                    sta $8b
                    lda #$00
                    sta $8d
                    lda $8c
                    asl a
                    adc $8c
                    sta $8c
                    asl $8c
                    rol $8d
                    asl $8c
                    rol $8d
                    asl $8c
                    rol $8d
                    asl $8c
                    rol $8d
                    lda $8c
                    adc #$34
                    sta $8c
                    lda $8d
                    adc #$5a
                    sta $8d
                    lda $82
                    sta $8e
                    lda $83
                    sta $8f
                    cpx #$00
                    bne L2a44
                    lda $0400,y
                    bne L2a3a
                    lda #$80
                    sta $8c
                    lda #$6c
                    sta $8d
.L2a3a               ldx #$04
                    ldy #$03
                    jsr S6500
                    jmp L2a88
                    
.L2a44               lda $8d
                    sta L2a58 + 2
                    sta $2a6c
                    lda $8c
                    sta L2a58 + 1
                    sta $2a6b
                    ldx #$00
.L2a56               ldy #$00
.L2a58               lda $7000,x
                    and #$0f
                    sta $8d
                    asl a
                    asl a
                    asl a
                    asl a
                    adc $8d
                    and $8b
                    sta ($8e),y
                    iny
                    lda $7000,x
                    and #$f0
                    sta $8d
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    adc $8d
                    and $8b
                    sta ($8e),y
                    iny
                    inx
                    txa
                    and #$0f
                    bne L2a58
                    inc $8f
                    cpx #$30
                    bmi L2a56
.L2a88               ldy $86
                    lda $0400,y
                    and #$3f
                    cmp #$09
                    beq L2ab3
                    cmp #$23
                    beq L2a9b
                    cmp #$24
                    bne L2ab0
.L2a9b               and #$01
                    eor #$01
                    asl a
                    tay
                    asl a
                    asl a
                    asl a
                    adc $8e
                    sta $00ac,y
                    lda $8f
                    sbc #$01
                    sta $00ad,y
.L2ab0               jmp L2b46
                    
.L2ab3               sec
                    lda $8f
                    sbc #$04
                    sta $8f
                    sbc #$01
                    sta $65
                    lda $8e
                    cmp #$20
                    bcc L2ace
                    lda $64
                    bne L2ace
                    ldy #$eb
                    lda ($8e),y
                    beq L2b28
.L2ace               lda $7e
                    sec
.L2ad1               sbc #$03
                    cmp #$03
                    bcs L2ad1
                    asl a
                    asl a
                    asl a
                    sta $8b
                    ldy $64
.L2ade               ldx $8b
.L2ae0               lda $0a68,x
                    sta ($8e),y
                    iny
                    inx
                    tya
                    and #$07
                    cmp #$07
                    bne L2ae0
                    lda #$11
                    cpy #$07
                    beq L2af6
                    lda #$88
.L2af6               sta ($8e),y
                    sec
                    lda $80
                    sbc #$20
                    sta $8c
                    lda $81
                    sbc #$00
                    sta $8d
                    tya
                    and #$18
                    lsr a
                    lsr a
                    lsr a
                    tay
                    lda #$18
                    sta ($8c),y
                    cpy #$03
                    bne L2b28
                    lda $8e
                    cmp #$20
                    bcc L2b28
                    dec $8f
                    ldy #$f5
                    lda ($8e),y
                    inc $8f
                    ldy #$00
                    cmp #$00
                    bne L2ade
.L2b28               lda $8e
                    clc
                    adc #$08
                    sta $64
                    sta $8e
                    inc $8f
                    lda $76
                    beq L2b46
                    lda #$20
                    sta $8c
                    lda #$41
                    sta $8d
                    ldx #$02
                    ldy #$01
                    jsr S6500
.L2b46               jsr S2582
                    inc $86
                    clc
                    lda $80
                    adc #$04
                    sta $80
                    bcc L2b56
                    inc $81
.L2b56               clc
                    lda $82
                    adc #$20
                    sta $82
                    beq L2b62
.L2b5f               jmp L29e3
                    
.L2b62               clc
                    lda $80
                    adc #$40
                    sta $80
                    bcc L2b6d
                    inc $81
.L2b6d               clc
                    lda $83
                    adc #$03
                    sta $83
                    cmp #$7f
                    bne L2b5f
                    lda #$26
                    sta $86
.L2b7c               ldx $86
                    lda $63d8,x
                    cmp $84
                    bne L2bfd
                    lda $63d9,x
                    and #$01
                    cmp $85
                    bne L2bfd
                    lda $63d9,x
                    lsr a
                    jsr S2ce2
                    txa
                    and #$02
                    asl a
                    asl a
                    adc $8e
                    sta $8e
                    sta $4c
                    lda $8f
                    sta $4d
                    lda #$6c
                    sta $8d
                    lda #$80
                    sta $8c
                    ldx #$03
                    ldy #$02
                    jsr S6500
                    ldx $4c
                    ldy $4d
                    jsr S65e0
                    ldy #$00
.L2bbc               lda #$00
                    sta ($6b),y
                    iny
                    tya
                    and #$03
                    cmp #$03
                    bcc L2bbc
                    tya
                    adc #$1c
                    tay
                    cpy #$40
                    bcc L2bbc
                    lda $4c
                    ora #$08
                    sta $4c
                    lda $86
                    eor #$02
                    tax
                    lda $63d9,x
                    lsr a
                    jsr S2ce2
                    txa
                    and #$02
                    asl a
                    asl a
                    ora $8e
                    sta $4e
                    lda $8f
                    sta $4f
                    lda $63d8,x
                    sta $4b
                    txa
                    and #$02
                    eor #$02
                    ora #$01
                    sta $4a
.L2bfd               dec $86
                    dec $86
                    bmi L2c06
                    jmp L2b7c
                    
.L2c06               lda #$00
                    sta $8d
                    lda #$00
                    sta $8a
                    lda #$0c
                    sta $8b
                    ldx #$02
                    lda $7e
                    bne L2c1c
                    lda $7f
                    beq L2c3a
.L2c1c               ldy $8d
                    lda ($8a),y
                    cmp $84
                    bne L2c2f
                    iny
                    lda ($8a),y
                    and #$80
                    asl a
                    rol a
                    cmp $85
                    beq L2c3c
.L2c2f               inc $8d
                    inc $8d
                    bne L2c1c
                    inc $8b
                    dex
                    bne L2c1c
.L2c3a               beq L2c9c
.L2c3c               stx $8c
                    lda $8d
                    sta $53
                    lda $8b
                    sta $54
                    lda ($8a),y
                    pha
                    and #$3f
                    pha
                    jsr S2ce2
                    clc
                    lda $8e
                    adc #$08
                    sta $8e
                    lsr $8b
                    lda $8d
                    ror a
                    ror a
                    and #$f0
                    sta $8c
                    lda #$53
                    sta $8d
                    pla
                    tax
                    ldy $0400,x
                    beq L2c6d
                    dec $8f
.L2c6d               pla
                    and #$40
                    asl a
                    rol a
                    rol a
                    sta $8b
                    lda $84
                    and #$01
                    asl a
                    ora $8b
                    tax
                    lda $2cde,x
                    sta $8b
                    ldy #$04
.L2c84               lda $008b,y
                    sta $0055,y
                    dey
                    bpl L2c84
                    lda $8c
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    sta $56
                    ldx $8b
                    ldy #$ff
                    jsr $0bb3
.L2c9c               lda #$00
                    sta $88
.L2ca0               ldy $88
                    lda $0528,y
                    cmp $7e
                    bne L2cc8
                    lda $0529,y
                    and #$03
                    cmp $7f
                    bne L2cc8
                    lda $0529,y
                    and #$f8
                    sta $8e
                    lda $052a,y
                    sta $8f
                    lda $052b,y
                    ldx #$ff
                    ldy #$ff
                    jsr $0bb3
.L2cc8               clc
                    lda $88
                    adc #$04
                    sta $88
                    cmp #$50
                    bne L2ca0
                    ldy #$3f
.L2cd5               lda #$00
                    sta $0400,y
                    dey
                    bpl L2cd5
                    rts
                    
                    EQUB $ff, $0f, $f0, $0f 

.S2ce2              pha
                    lsr a
                    lsr a
                    lsr a
                    sta $8e
                    asl a
                    adc $8e
                    adc #$6e
                    sta $8f
                    pla
                    and #$07
                    lsr a
                    ror a
                    ror a
                    ror a
                    sta $8e
                    rts
                    
.S2cf9              lda #$02
                    sta $8d
.L2cfd              ldy $8d
                    lda ($80),y
                    and #$3f
                    cmp #$30
                    bcs L2d18
                    sta $8c
                    lda $8d
                    and #$02
                    beq L2d1b
                    ldy $8d
                    lda $2daa,y
                    cmp #$0f
                    beq L2d24
.L2d18               jmp L2d7d
                    
.L2d1b               ldy $8d
                    lda $2daa,y
                    cmp #$0f
                    beq L2d18
.L2d24               lda #$01
                    sta $8a
                    sta $8b
                    ldx $8c
.L2d2c               lda $0400,x
                    bne L2d3e
                    cpx #$30
                    bcs L2d3e
                    inc $8b
                    txa
                    adc #$08
                    tax
                    jmp L2d2c
                    
.L2d3e               ldx $8c
.L2d40               inx
                    txa
                    and #$07
                    beq L2d55
                    lda $0400,x
                    bne L2d50
                    inc $8a
                    jmp L2d40
                    
.L2d50               lda #$00
                    sta $0400,x
.L2d55               lda $8d
                    and #$01
                    tax
                    ldy $2dae,x
                    lda $2d89,y
                    sta $88
.L2d62               lda $8a
                    sta $89
                    ldx $8c
.L2d68               lda $88
                    sta $0400,x
                    inx
                    dec $89
                    bne L2d68
                    clc
                    lda $8c
                    adc #$08
                    sta $8c
                    dec $8b
                    bne L2d62
.L2d7d              inc $8d
                    lda $8d
                    cmp #$06
                    beq L2d88
                    jmp L2cfd
                    
.L2d88              rts
                    
                    EQUB $d8, $82, $81, $00, $00, $84, $1d 
                    EQUB $41, $42, $43, $44, $45, $46, $1d, $88, $c9, $ca, $cb, $cc, $cd, $e1, $ce, $46 
                    EQUB $d0, $d1, $00, $00, $00, $1d, $93, $00, $0f, $f0, $ff, $00, $00, $00, $00, $00 
                    EQUB $00, $01, $03, $06, $05, $00, $18, $40, $16, $19, $1e, $14, $10 

.S2dbd              lda #$0f
                    sta $8d
                    ldy #$00
.L2dc3              lda $0189,y
                    beq L2dcf
                    clc
                    tya
                    adc #$0c
                    tay
                    bne L2dc3
.L2dcf              sty $86
.L2dd1              dec $8d
                    bne L2dd6
                    rts
                    
.L2dd6              jsr S2e76
                    lda $9b
                    and #$1f
                    cmp #$11
                    bcs L2dd1
                    adc #$6d
                    sta $8f
                    jsr S2e76
                    lda $9b
                    and #$f8
                    cmp #$f8
                    bcs L2dd1
                    sta $8e
                    lda $8f
                    cmp #$6f
                    bcc L2e06
                    cmp #$7c
                    bcs L2e06
                    lda $8e
                    cmp #$18
                    bcc L2e06
                    cmp #$e8
                    bcc L2dd1
.L2e06              ldx $8e
                    ldy $8f
                    jsr S2e89
                    bcs L2dd1
                    lda $8e
                    sta $0188,x
                    lda $8f
                    sta $0189,x
                    lda #$00
                    sta $018a,x
                    sta $018e,x
                    sta $0192,x
                    sta $0193,x
                    lda #$01
                    sta $018f,x
                    sta $0190,x
                    lda #$14
                    sta $0191,x
                    jsr S2e76
                    and #$03
                    tay
                    lda $2e7c,y
                    sta $018b,x
.L2e40               jsr S2e76
                    and #$03
                    beq L2e40
                    tay
                    lda $2e7e,y
                    sta $018c,x
.L2e4e               jsr S2e76
                    and #$07
                    cmp #$05
                    bcs L2e4e
                    tay
                    lda $2e84,y
                    sta $018d,x
                    ldx #$4c
                    ldy #$60
                    jsr S353d
                    dec $2f
                    lda #$c0
                    sta $8c
                    lda #$39
                    sta $8d
                    ldx #$03
                    ldy #$02
                    jmp S65ad
                    
.S2e76               jsr S6440
                    ldx $86
                    rts
                    
                    EQUB $03, $0c, $09, $06, $04, $08, $02, $01, $02, $04, $08, $10, $20 

.S2e89               ldx #$20
                    ldy #$02
.S2e8d               stx $8a
                    sty $8b
                    ldx $8e
                    ldy $8f
                    jsr S65e0
                    ldx $86
.L2e9a               lda $8b
                    ora $8a
                    tay
.L2e9f               lda ($6b),y
                    and #$10
                    bne L2eb4
                    dey
                    cpy $8a
                    bpl L2e9f
                    sec
                    lda $8a
                    sbc #$20
                    sta $8a
                    bcs L2e9a
                    rts
                    
.L2eb4               sec
                    rts
                    
.S2eb6               sta $44
                    lda #$00
                    sta $86
                    sta $20
.L2ebe               ldx $86
                    lda $0189,x
                    sta $41
                    cmp #$6d
                    bcc L2ee9
                    lda $44
                    bne L2eec
                    lda $0188,x
                    sta $40
                    lda $018a,x
                    sta $42
                    lda $0192,x
                    sta $43
                    lda $018f,x
                    sbc #$04
                    sta $018f,x
                    bcc L2eef
                    jmp L309f
                    
.L2ee9               jmp L31a0
                    
.L2eec               jmp L3189
                    
.L2eef               adc $018c,x
                    sta $018f,x
                    lda $0189,x
                    sta $8f
                    lda $0192,x
                    sta $8d
                    lda $0188,x
                    sta $8e
                    lda $018b,x
                    and #$05
                    cmp #$01
                    beq L2f2d
                    cmp #$04
                    bne L2f6a
                    dec $8d
                    bpl L2f3e
                    lda #$03
                    sta $8d
                    sec
                    lda $8e
                    sbc #$08
                    sta $8e
                    bcs L2f3e
.L2f22               lda $018b,x
                    eor #$05
                    sta $018b,x
                    jmp L2f6a
                    
.L2f2d               inc $8d
                    lda $8d
                    and #$03
                    sta $8d
                    bne L2f3e
                    clc
                    lda $8e
                    adc #$08
                    sta $8e
.L2f3e               ldy #$02
                    lda $8d
                    bne L2f45
                    dey
.L2f45               ldx #$20
                    lda $8e
                    and #$07
                    beq L2f4f
                    ldx #$40
.L2f4f               jsr S2e8d
                    ldx $86
                    bcs L2f22
                    lda $8e
                    cmp #$f0
                    bcc L2f60
                    lda $8d
                    bne L2f22
.L2f60               lda $8d
                    sta $0192,x
                    lda $8e
                    sta $0188,x
.L2f6a               lda $0188,x
                    sta $8e
                    lda $0189,x
                    sta $8f
                    lda $018b,x
                    and #$0a
                    cmp #$02
                    beq L2fa2
                    cmp #$08
                    bne L2fe8
                    lda $8e
                    sbc #$02
                    sta $8e
                    and #$06
                    cmp #$06
                    bcc L2fb5
                    lda $8e
                    adc #$07
                    sta $8e
                    dec $8f
                    bne L2fb5
.L2f97               lda $018b,x
                    eor #$0a
                    sta $018b,x
                    jmp L2fe8
                    
.L2fa2               clc
                    lda $8e
                    adc #$02
                    sta $8e
                    and #$07
                    bne L2fb5
                    lda $8e
                    sbc #$07
                    sta $8e
                    inc $8f
.L2fb5               ldy #$01
                    lda $0192,x
                    beq L2fbd
                    iny
.L2fbd               ldx #$20
                    lda $8e
                    and #$07
                    beq L2fc7
                    ldx #$40
.L2fc7               jsr S2e8d
                    ldx $86
                    bcs L2f97
                    lda $8f
                    cmp #$6d
                    bcc L2f97
                    cmp #$7d
                    bcc L2fde
                    lda $8e
                    and #$07
                    bne L2f97
.L2fde               lda $8e
                    sta $0188,x
                    lda $8f
                    sta $0189,x
.L2fe8               lda $0193,x
                    bne L3019
                    lda $0191,x
                    beq L3019
                    dec $0191,x
                    bne L3019
.L2ff7               jsr S2e76
                    cmp #$05
                    bcs L2ff7
                    sta $018e,x
                    cmp #$04
                    bne L300e
                    jsr S2e76
                    and #$02
                    beq L2ff7
                    bne L3013
.L300e               jsr S2e76
                    and #$01
.L3013               clc
                    adc #$01
                    sta $018a,x
.L3019               ldx $86
                    dec $0190,x
                    bne L309f
                    lda $018d,x
                    sta $0190,x
                    lda $018e,x
                    beq L309f
                    cmp #$03
                    bcc L3079
                    bne L3090
.L3031               ldy #$00
                    lda $70
                    and #$f8
                    cmp $0188,x
                    bcc L304f
                    beq L3040
                    bcs L3049
.L3040               jsr S2e76
                    ldy #$00
                    and #$01
                    beq L304f
.L3049               tya
                    ora #$01
                    tay
                    bne L3053
.L304f               tya
                    ora #$04
                    tay
.L3053               lda $71
                    cmp $0189,x
                    bcc L306f
                    beq L305e
                    bcs L3069
.L305e               sty $8f
                    jsr S2e76
                    ldy $8f
                    and #$01
                    beq L306f
.L3069               tya
                    ora #$02
                    tay
                    bne L3073
.L306f               tya
                    ora #$08
                    tay
.L3073               tya
                    sta $018b,x
                    bne L309f
.L3079               tay
                    lda $308d,y
                    sta $8f
                    jsr S2e76
                    and $8f
                    tay
                    lda $2e7c,y
                    sta $018b,x
                    bne L309f
                    07 07 03 
.L3090               jsr S2e76
                    lsr a
                    cmp #$03
                    beq L3031
                    lda #$00
                    bcc L3079
                    sta $018b,x
.L309f               lda $7b
                    bne L30e7
                    lda $018a,x
                    cmp #$04
                    bcs L30e7
                    lda $7c
                    and #$f8
                    sbc #$0f
                    bcs L30b4
                    lda #$00
.L30b4               cmp $0188,x
                    bcs L30e7
                    lda $7c
                    and #$f8
                    adc #$08
                    bcc L30c3
                    lda #$ff
.L30c3               cmp $0188,x
                    bcc L30e7
                    lda $0189,x
                    adc #$01
                    cmp $7d
                    bcc L30e7
                    ldy $76
                    cpy #$01
                    sbc #$03
                    cmp $7d
                    bcs L30e7
                    lda #$04
                    sta $7b
                    sta $018a,x
                    lda #$14
                    sta $0193,x
.L30e7               lda $0193,x
                    beq L311e
                    cmp #$13
                    bne L30f9
                    ldx #$50
                    ldy #$01
                    jsr SCORE_ADD
                    ldx $86
.L30f9               dec $0193,x
                    bne L311e
                    jsr S31af
                    lda $2e
                    bmi L310e
                    inc $2f
                    jsr S2e76
                    ora #$20
                    sta $2e
.L310e               ldx $86
                    ldy #$0c
                    lda #$00
.L3114               sta $0188,x
                    inx
                    dey
                    bne L3114
                    jmp L31a0
                    
.L311e               lda $018a,x
                    beq L316a
                    cmp #$04
                    bcs L316a
                    lda $0188,x
                    and #$f8
                    sta $8e
                    lda $70
                    and #$f8
                    sbc #$0f
                    bcc L313a
                    cmp $8e
                    bcs L316a
.L313a               adc #$18
                    cmp $8e
                    bcc L316a
                    lda $71
                    sbc #$02
                    cmp $0189,x
                    bcs L316a
                    adc #$03
                    cmp $0189,x
                    bcc L316a
                    lda $3a
                    sbc #$2a
                    sta $3a
                    bcs L315a
                    dec $3b
.L315a               lda $018a,x
                    cmp #$03
                    bne L316a
                    lda $018e,x
                    lsr a
                    lsr a
                    ora #$02
                    sta $20
.L316a               lda $0188,x
                    cmp $40
                    bne L3186
                    lda $0189,x
                    cmp $41
                    bne L3186
                    lda $018a,x
                    cmp $42
                    bne L3186
                    lda $0192,x
                    cmp $43
                    beq L31a0
.L3186               jsr S31af
.L3189               ldx $86
                    lda $0188,x
                    sta $8e
                    lda $0189,x
                    sta $8f
                    lda $0192,x
                    tay
                    lda $018a,x
                    tax
                    jsr S31bb
.L31a0               clc
                    lda $86
                    adc #$0c
                    sta $86
                    cmp #$30
                    bcs L31ae
                    jmp L2ebe
                    
.L31ae              rts
                    
.S31af              lda $40
                    sta $8e
                    lda $41
                    sta $8f
                    ldx $42
                    ldy $43
.S31bb              txa
                    asl a
                    asl a
                    sta $8c
                    tya
                    ora $8c
                    asl a
                    sta $8c
                    asl a
                    adc $8c
                    sta $8c
                    lda #$00
                    sta $8d
                    asl $8c
                    rol $8d
                    asl $8c
                    rol $8d
                    asl $8c
                    rol $8d
                    lda $8c
                    adc #$c0
                    sta $8c
                    lda $8d
                    adc #$39
                    sta $8d
                    ldx #$03
                    ldy #$02
                    jmp S6526
                    
.L31ee              php
                    jsr FLUSH_BUFFERS
                    jsr S3563
                    lda $25
                    jsr GET_DIGIT_CODES
                    sty $33f0
                    stx $33f1
                    lda $24
                    jsr GET_DIGIT_CODES
                    sty $33f3
                    stx $33f4
                    ldy #$07
.L320d              lda $350b,y
                    sta $0090,y
                    dey
                    bpl L320d
                    jsr CLEAR_SCREEN
                    jsr $7f00
                    lda #$07
                    sta $fe00
                    lda #$24
                    sta $fe01
                    lda #$0f
                    sta $7f6a
                    plp
                    bcc L3245

                    ; Show the game complete message: "only a thtupid loony" etc
                    ldx LO(GAME_COMPLETE_TEXT)
                    ldy HI(GAME_COMPLETE_TEXT)
                    jsr $0a80
                    lda #$00
                    ldx #$79
                    jsr S3587
                    ldx #$7b
                    ldy #$14
                    lda #$0e
                    jsr PLAY_TUNE

.L3245              lda $9f
                    clc
                    adc #$61
                    sta $33ba
                    lda $0c
                    jsr GET_DIGIT_CODES
                    stx $33df
                    sty $33de

                    ; Write the score directly into the GAME OVER text
                    lda SCORE0
                    jsr GET_DIGIT_CODES
                    sty $33c5
                    stx $33c6
                    lda SCORE1
                    jsr GET_DIGIT_CODES
                    sty $33c7
                    stx $33c8
                    lda SCORE2
                    jsr GET_DIGIT_CODES
                    sty $33c9

                    ; Draw the GAME OVER text
                    jsr CLEAR_SCREEN
                    ldx LO(GAME_OVER_TEXT)
                    ldy HI(GAME_OVER_TEXT)
                    jsr $0a80
                    lda #$40
                    ldx #$79
                    jsr S3587

                    ; Play the 'game over' tune ...
                    ldx #$50
                    ldy #$14
                    lda #$07
                    jsr PLAY_TUNE

                    ; ... and simply fall through back to the menu screen

.MAIN_MENU          
                    ; Clear the screen and draw the menu text
                    jsr CLEAR_SCREEN
                    ldx LO(MENU_TEXT)
                    ldy HI(MENU_TEXT)
                    jsr $0a80

                    ; Play the intro tune
                    ldx #$00
                    ldy #$14
                    lda #$0a
                    jsr PLAY_TUNE

                    ; If user pressed a key during tune play, it'll be in A now
                    bne handle_menu_keypress

.wait_for_menu_key  
                    ; Draw the "KEYBOARD ZX:/" label (and everything after it) again
                    ; cos the colour bytes might have changed
                    ldx LO(keyboard_zx)
                    ldy HI(keyboard_zx)
                    jsr $0a80

                    ; Wait for user to press a key
                    jsr $ffe0

.handle_menu_keypress
                    ; If user pressed '0', start the game!
                    sec
                    sbc #$30
                    beq game_intro

                    ; If user pressed anything othen than '1','2','3' then just 
                    ; jump back to wait for next keypress
                    cmp #$04
                    bcs wait_for_menu_key

                    ; Convert the keypress '1','2', or '3' to the value 0, 5, or 10
                    sbc #$00    ; we know carry is clear so this subtracts 1
                    sta $8f
                    asl a
                    asl a
                    adc $8f

                    ; If it's not changed then go back to waiting for a keypress 
                    cmp $0a
                    beq wait_for_menu_key

                    ; Store the keyboard option (0,5 or 10) in a zero page byte
                    sta $0a

                    ; Y=A*4, i.e. Y is now 0, 20, or 40. This is the offset of the 
                    ; colour byte of the keyboard option label in the menu text 
                    asl a
                    asl a
                    tay

                    ; Set the text color of all the input options back to green (2)
                    lda #$82
                    sta keyboard_zx
                    sta keyboard_ud
                    sta joystick

                    ; Set the selected input option's text colour to white (1)
                    lda #$81
                    sta keyboard_zx,y
                    jsr FLUSH_BUFFERS
                    jsr S0e24
                    jmp wait_for_menu_key
                    
.game_intro         
                    ; Play the game intro tune
                    ldx #$2c
                    ldy #$14
                    lda #$07
                    jsr PLAY_TUNE

                    jsr CLEAR_SCREEN

                    ; Change the vsync position to 30 (normal mode 5 is 34).
                    lda #$07     ; Select R7 in the 6845
                    sta $fe00
                    lda #$1e
                    sta $fe01


                    lda #$1b
                    sta $7f6a
                    jsr S111c
                    jmp L31ee

.MENU_TEXT 
                    EQUB $83
                    EQUB $1f, $0a, $0a 
                    EQUS "S·T·A·R·Q·U·A·K·E" 
                    EQUB $1f, $0f, $14 
                    EQUS "BY  KENTON  PRICE" 
                    EQUB $1f, $0b, $15 
                    EQUS "C.1987  BUBBLE  BUS" 
                    EQUB $82
                    EQUB $1f, $0e, $11 
                    EQUS "0. START[GAME" 
.keyboard_zx
                    EQUB $81
                    EQUB $1f, $0e, $0d 
                    EQUS "1. KEYBOARD[ZX:/"
.keyboard_ud
                    EQUB $82
                    EQUB $1f, $0e, $0e 
                    EQUS "2. KEYBOARD[U.D."
.joystick
                    EQUB $82
                    EQUB $1f, $0e, $0f 
                    EQUS "3. JOYSTICK"
                    EQUB $0d

.GAME_OVER_TEXT
                    EQUB $1f, $18, $07
                    EQUB $83 
                    EQUS "GAME[OVER"
                    EQUB $1f, $12, $12
                    EQUB $82 
                    EQUS "CORE" 
                    EQUB $1f, $0a, $13 
                    EQUS "ELEMENTS"
                    EQUB $1f, $0a, $14 
                    EQUS "REPLACED"
                    EQUB $1f, $16, $16 
.core_digits
                    EQUS "00"
                    EQUB $81
                    EQUB $1f, $14, $0a 
                    EQUS "SCORE["
.score_digits
                    EQUS "00000"
                    EQUB $1f, $04, $0c 
                    EQUS "ADVENTURE  SCORE[00`"
                    EQUB $1f, $0b, $0e 
                    EQUS "TIME  TAKEN["
.time_digits
                    EQUS "00:00" 
                    EQUB $0d

.GAME_COMPLETE_TEXT
                    EQUB $82 
                    EQUB $1f $08 $06 
                    EQUS "THE[CORES[COMPLETE"
                    EQUB $1f $02 $08 
                    EQUS "BUT[HOW[ARE[YOU[GONNA"
                    EQUB $1f $04 $0a 
                    EQUS "GET[HOME[WHEN[ONLY[A"
                    EQUB $1f $06 $0c 
                    EQUS "THTUPID[LOONY[WOULD"
                    EQUB $1f $06 $0e 
                    EQUS "WANDER[THIS[FAR[OUT"
                    EQUB $1f $12 $10 
                    EQUS "IN[THE[GALAXY"
                    EQUB $0d 


.CLEAR_SCREEN
                    ; Clear the screen - $6D00 to $7EFF
                    lda #$00
                    sta $8e
                    lda #$6d
                    sta $8f
.cls_l1             lda #$00
                    tay
.cls_l2             sta ($8e),y
                    iny
                    bne cls_l2
                    inc $8f
                    lda $8f
                    cmp #$7f
                    bne cls_l1
                    rts

.PLAY_TUNE
                    stx $8c
                    sta $8d
                    sty $8f
                    
                    ; ENVELOPE command using block at $046F
                    ldx #$6f
                    ldy #$04
                    lda #$08
                    jsr osword

.tune_loop          ldx $8c
                    lda $047d,x
                    cmp #$ff
                    beq L34fc
                    pha
                    and #$1f
                    asl a
                    asl a
                    adc $8f
                    sta $3507
                    pla
                    and #$e0
                    asl a
                    rol a
                    rol a
                    rol a
                    adc #$01
                    sta $8b

                    ; $8b = $8b * $8d. Think $8b is duration of current note
                    ldx $8d
                    lda #$00
.L34c2              adc $8b
                    dex
                    bne L34c2
                    sta $8b

                    ; SOUND using 8 byte block at SOUND_BLOCK ($3503)
                    ; It calls SOUND 3 times here, presumably there are 3 channels.
                    lda #$11
                    sta SOUND_BLOCK
.L34ce              ldx #$03
                    ldy #$35
                    lda #$07
                    jsr osword
                    inc SOUND_BLOCK
                    inc SOUND_BLOCK+4
                    lda SOUND_BLOCK
                    cmp #$14
                    bne L34ce

                    ; See if key been pressed - this breaks out of tune playing
.key_test           lda #$81   ; INKEY
                    ldx #$00
                    ldy #$00
                    jsr $fff4
                    bcc key_pressed ; X holds ASCII code of pressed key

                    ; *FX 19 - wait for vsync (i.e. delay for 1/50th of a second)
                    lda #$13
                    jsr $fff4

                    ; Decrement note duration counter
                    dec $8b
                    bne key_test

                    ; Increment note index
                    inc $8c
                    bne tune_loop
.key_pressed        txa 
                    pha
                    jsr FLUSH_BUFFERS
                    pla
                    rts
.SOUND_BLOCK                    
                    EQUB $11, $00, $04, $00, $00, $00, $19, $00 
                    EQUB $00, $00, $00, $01, $00, $02, $00, $07

; Given two digits in A (one digit in each nibble, like BCD)
; returns their printable digit codes in X and Y.
.GET_DIGIT_CODES    pha
                    and #$0f
                    clc
                    adc #$61 ; '0'
                    tax
                    pla
                    lsr a
                    lsr a
                    lsr a
                    lsr a
                    clc
                    adc #$61 ; '0'
                    tay
                    rts
                    
; Flush input and other h/w buffers : *FX 15,0
.FLUSH_BUFFERS      lda #$0f
                    ldx #$00
                    jmp $fff4
                    
.L352b              clc
                    ; Add 14 to the address in XY and push it on the stack
                    txa
                    adc #$0e
                    pha
                    tya
                    adc #$00
                    pha
                    ; ENVELOPE 
                    lda #$08
                    jsr osword
                    ; SOUND
                    pla
                    tay
                    pla
                    tax
.S353d              lda #$07
                    jmp osword
                    
.S3542              pha
                    lda #$13
                    jsr $fff4
                    pla
                    sec
                    sbc #$01
                    bne S3542
                    rts
                    
.SCORE_ADD          clc
                    sed ; ooh, BCD arithmetic!
                    txa
                    adc SCORE2
                    sta SCORE2
                    tya
                    adc SCORE1
                    sta SCORE1
                    lda SCORE0
                    adc #$00
                    sta SCORE0
                    cld
                    rts
                    
.S3563              ldy #$08
.L3565              lda #$ff
                    ldx $17,y
                    bmi L356e
                    lda $3575,y
.L356e              sta $0bf7,y
                    dey
                    bpl L3565
                    rts
                    
                    EQUB $f0, $0f, $f0, $0f, $f0, $0f, $f0, $0f, $f0, 
                    EQUB $00, $00 
                    EQUB $00, $00, $00, $00, $00, $00, $00 

.S3587              pha
                    ldy #$08
.L358a              lda #$01
                    sta $357e,y
                    dey
                    bpl L358a
                    pla
.S3593              sta $69
                    stx $89
                    lda #$00
                    sta $87
.L359b              lda #$68
                    sta $88
.L359f              clc
                    lda $88
                    adc $69
                    sta $8e
                    lda $89
                    sta $8f
                    ldy $87
                    lda $0bf7,y
                    cmp $357e,y
                    beq L35bd
                    tax
                    lda $0017,y
                    ldy #$00
                    jsr $0bb3
.L35bd              inc $87
                    clc
                    lda $88
                    adc #$10
                    sta $88
                    cmp #$98
                    bcc L359f
                    inc $89
                    inc $89
                    lda $87
                    cmp #$09
                    bcc L359b
                    ldy #$08
.L35d6              lda $0bf7,y
                    sta $357e,y
                    dey
                    bpl L35d6
                    rts
                    
                    53 b5 bb ba ec f6 f7 fb 50 05 8b 0f a0 0a 1f 0f 
                    73 57 75 13 ec ae ea 8c 62 d6 85 0d 64 b6 1a 0b 
                    56 08 21 22 73 0d c8 cc 62 56 d5 0f ec a6 fa 0f 
                    12 04 26 01 a8 41 09 04 22 22 52 0b cc cc a4 0f 
                    c0 1d 64 90 30 8b 62 90 f4 dd 0f 0b f2 33 0f 0d 
                    21 32 01 11 c8 cc 08 88 11 70 fc 07 88 e0 f3 0e 
                    ac 31 74 43 53 c8 e2 2c 37 74 43 03 ce e2 2c 0c 
                    11 22 44 88 88 cc ee ff 0f 57 45 07 0f 2e 2a 0e 
                    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 c7 ef 00 00 3e 7f ce 8c 99 07 77 bb 11 0e 
                    00 40 66 55 00 00 00 00 54 65 46 00 7f 15 00 00 
                    00 00 00 00 31 13 20 44 00 11 42 ee 88 00 00 31 
                    90 3b 81 2a 90 cd 18 45 44 84 1a 93 22 12 85 9c 
                    c8 8c 40 22 00 00 00 00 11 00 00 c8 00 88 24 77 
                    24 01 10 e4 13 42 28 30 4e 20 10 40 03 42 08 35 
                    08 10 33 77 01 80 cc ee 55 32 01 80 ee cc 08 10 
                    8c 24 41 c0 42 08 80 72 0c 24 01 ca 27 40 80 20 
                    ee 24 11 00 13 00 00 88 00 00 00 00 44 02 31 13 
                    39 a1 48 44 c9 58 21 22 a2 18 b3 09 54 81 dc 09 
                    8c 00 00 11 77 42 88 00 22 04 c8 8c 00 00 00 00 
                    00 30 77 77 00 e0 77 33 77 03 55 05 f3 0e 55 05 
                    00 30 76 66 00 e0 b3 73 76 03 55 05 f3 0e 55 05 
                    00 30 76 77 00 e0 b3 73 77 03 55 05 7f 0e 55 05 
                    10 23 22 07 c0 e6 ee 0f 22 22 44 04 aa aa 59 05 
                    00 31 65 56 00 ec b5 5b 35 10 22 62 e5 40 22 32 
                    00 20 27 00 22 aa af aa 00 00 10 01 02 e4 fe 0f 
                    21 55 55 22 ec ff ff ee 11 10 10 00 c4 c0 c8 08 
                    70 44 77 67 f0 67 ff b7 76 77 77 07 7b 7f 77 0f 
                    00 01 01 21 80 cc 0c 2c 23 22 03 03 ee ee 0e 0e 
                    40 77 14 11 f0 66 0f 88 31 33 33 03 c8 40 04 0c 
                    19 a5 12 5a 5e e3 e4 dc 23 e2 53 1e e3 1e 4c 0b 
                    66 a3 59 52 62 54 c9 1e 64 e4 0e 62 64 19 56 60 
                    23 9a 1e 09 13 e2 1e c9 13 19 e4 e2 e4 14 e1 16 
                    a5 20 1e 19 e4 a1 13 15 9d e2 15 21 0e 09 26 4a 
                    21 e1 16 12 54 27 24 0d 3f 12 e2 e3 20 e2 21 1d 
                    0e 1d 65 0a 21 0d 1b 26 51 e4 e2 12 0b 13 1e 16 
                    27 05 1d 20 14 11 12 91 92 11 3f 4c 24 e2 e3 20 
                    16 27 4c 05 1d a1 e4 1d 21 4a e2 1d d9 e3 0b 0a 
                    14 e1 e1 14 e3 e1 15 54 e1 0e 20 95 20 e0 4b 12 
                    12 1d 0d e1 20 56 22 12 27 1d 64 14 09 14 65 12 
                    12 a5 12 11 e2 1a 64 21 0b 64 e2 e3 e0 11 da 65 
                    27 16 09 10 16 25 60 21 e3 20 27 dc 16 51 9d 0d 
                    1b 16 9d e4 1e 93 25 3f 11 16 15 66 66 5b 14 26 
                    02 13 5a 0d 51 5e 23 25 0c e1 11 21 66 60 04 16 
                    02 e2 16 e2 1b 16 1b 20 12 1d 0c 93 e1 62 e1 01 
                    53 64 a3 5b e2 e3 60 1d e1 19 21 e4 9d 19 58 06 
                    51 16 66 23 62 1b 1d 58 59 5e 5e 58 58 27 4c 11 
                    11 1e e1 d0 27 e2 1f 21 1b 13 98 14 e2 e1 20 26 
                    54 e0 a2 27 e2 27 54 15 1b 14 1d 1b 14 27 0a 1b 
                    27 0a 1d 61 e2 e1 3f 05 51 0c 1c 27 1a 20 20 0d 
                    e3 1d 14 e2 63 66 60 16 e2 ca 1a e2 60 e2 9c 16 
                    1b e0 27 e2 e0 1d 15 9a 1d e4 04 27 15 27 20 42 
                    1c 16 16 0b 12 0c 1b 16 11 21 21 12 e2 e1 e4 e2 
                    27 41 53 26 06 19 a4 1e 16 1d 0a 27 9c 16 1b 19 
                    0b a4 43 e3 e1 14 27 e2 63 1a 19 e1 27 e3 0b 06 
                    e2 16 12 20 20 19 5c 27 20 12 11 16 11 e1 1d 01 
                    27 1a 27 27 16 4b 09 27 27 20 43 19 66 5e e3 3f 
                    12 19 59 4b 06 16 16 20 53 0c 05 15 15 1d 12 1d 
                    09 1a e3 27 27 e1 e2 e1 e0 16 1d 0a e2 12 0d 24 
                    61 65 21 1a 27 1a a0 1a 15 1d 12 1a 20 3f 62 20 
                    27 66 14 ca e1 0d 66 27 e1 27 20 3f 12 21 3f 26 
                    21 3f 27 a5 60 43 3f a4 21 26 26 e3 66 3f ca e1 
                    00 41 00 08 00 00 00 cc 80 00 60 00 34 40 33 33 
                    00 00 00 00 00 00 00 00 cc cc 20 c2 00 60 00 10 
                    33 00 00 00 01 00 28 00 00 00 00 00 00 00 00 00 
                    00 00 00 66 66 66 00 00 80 02 00 30 00 10 02 10 
                    00 00 00 00 00 08 00 80 60 01 24 00 30 00 01 00 
                    00 00 11 11 11 00 00 40 00 00 88 88 88 00 00 00 
                    00 00 20 20 10 02 30 00 cc cc cd 00 08 00 00 00 
                    00 00 00 00 80 00 08 40 20 01 00 10 00 00 00 00 
                    00 00 00 01 00 3b 33 33 00 c0 04 80 40 40 00 00 
                    00 00 00 10 00 00 00 01 14 a0 a0 20 00 80 00 00 
                    00 00 cc cc cc 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 cc dc dc 10 20 02 00 40 00 20 40 40 08 
                    08 0c 06 02 01 01 20 60 01 03 06 04 08 08 40 60 
                    00 00 00 00 00 00 00 00 70 d0 22 54 66 90 f0 50 
                    e0 b0 54 a2 66 90 f0 a0 00 00 00 00 00 00 00 00 
                    00 00 06 07 00 00 10 30 00 00 01 03 0c 0c 20 30 
                    00 00 08 08 00 00 00 00 30 60 51 22 33 60 70 10 
                    f0 d0 22 d1 33 d0 f0 60 00 80 80 00 00 80 80 00 
                    00 00 00 01 03 02 00 10 00 00 00 09 06 06 90 90 
                    00 00 00 08 0c 04 00 80 10 30 20 11 11 20 30 10 
                    f0 60 99 60 99 60 f0 80 80 c0 40 88 88 40 c0 80 
                    00 00 01 01 00 00 00 00 00 00 08 0c 03 03 40 c0 
                    00 00 06 0e 00 00 80 c0 00 10 10 00 00 10 10 00 
                    f0 b0 44 b8 cc 30 f0 60 c0 60 a8 44 cc 20 e0 80 
                    02 15 15 15 0a 0f 0e 04 aa 55 55 f5 a0 00 00 01 
                    00 00 00 00 00 00 00 00 0c 0c 06 0e 0b 07 05 03 
                    01 02 03 07 0f 0e 0a 0c 00 00 00 00 00 00 00 00 
                    01 02 02 02 05 07 07 02 55 aa aa fa 50 08 00 00 
                    00 88 88 88 00 00 00 08 06 06 03 07 05 03 02 01 
                    00 01 01 03 0f 0f 0d 0e 08 00 08 08 08 00 00 00 
                    00 01 01 01 02 03 03 01 2a 55 55 75 28 0c 08 00 
                    88 44 44 c4 80 00 00 08 03 03 01 03 02 01 01 00 
                    00 00 08 09 0f 0f 06 0f 08 0c 0c 08 0c 08 08 00 
                    00 00 00 00 01 01 01 00 15 2a 2a 3a 14 0e 0c 08 
                    44 aa aa ea 40 00 00 04 01 01 00 01 01 00 00 00 
                    08 08 0c 0c 07 0f 0b 07 04 06 06 0c 0e 0c 04 08 
                    11 22 22 00 bb bb bb 00 88 cc cc 00 bb bb bb 00 
                    00 00 00 00 00 00 00 00 22 22 22 22 00 55 00 11 
                    cc cc cc cc 00 ee 00 88 00 00 00 00 00 00 00 00 
                    00 11 11 00 33 33 33 00 cc 66 66 00 bb bb bb 00 
                    00 00 00 00 88 88 88 00 11 11 11 11 00 33 00 00 
                    66 66 66 66 00 dd 00 cc 00 00 00 00 00 00 00 00 
                    00 00 00 00 33 33 33 00 66 bb bb 00 bb bb bb 00 
                    00 00 00 00 88 88 88 00 00 00 00 00 00 11 00 00 
                    bb bb bb bb 00 dd 00 66 00 00 00 00 00 88 00 00 
                    00 00 00 00 11 11 11 00 33 55 55 00 bb bb bb 00 
                    00 88 88 00 aa aa aa 00 00 00 00 00 00 00 00 00 
                    55 55 55 55 00 dd 00 33 88 88 88 88 00 cc 00 00 
                    22 77 22 88 00 22 88 00 00 44 11 00 22 77 22 00 
                    00 00 00 00 00 00 00 00 00 44 00 00 99 00 44 00 
                    88 00 22 88 cc 99 22 00 00 00 00 00 00 00 00 00 
                    00 00 11 00 44 11 44 00 22 88 cc 88 11 33 11 88 
                    00 00 00 00 00 88 00 00 00 22 11 33 11 44 22 00 
                    00 22 00 88 11 00 00 88 00 00 00 88 00 00 88 00 
                    00 00 00 11 00 22 00 00 99 00 88 cc 99 00 00 11 
                    00 00 88 00 00 00 88 cc 00 11 00 00 11 00 00 22 
                    44 00 22 00 00 44 ee 44 88 00 00 00 00 88 00 44 
                    00 00 11 00 00 00 00 00 22 00 11 44 ee 44 00 44 
                    22 00 00 44 00 00 00 22 11 00 00 11 00 00 11 00 
                    11 88 00 22 00 88 dd 88 00 44 ee 44 00 00 00 44 
                    11 00 33 55 22 66 88 cc bb dd 44 aa ee 77 33 77 
                    00 00 00 00 00 00 00 00 ee ff ff 66 66 bb 88 66 
                    ff ff 77 aa cc 22 66 cc 00 00 00 00 00 00 00 00 
                    00 00 11 22 11 33 44 66 dd 66 aa dd 77 33 11 33 
                    88 88 00 00 00 88 88 88 77 77 77 33 33 55 44 33 
                    77 ff bb 55 66 99 33 66 88 88 88 00 00 00 00 00 
                    00 00 00 11 00 11 22 33 33 11 dd 66 bb 99 00 11 
                    44 00 00 88 88 cc cc cc 33 33 33 11 11 00 00 00 
                    bb ff dd aa aa 22 ee 66 cc cc cc 88 88 00 cc 88 
                    00 00 00 00 00 00 11 11 11 00 66 bb 55 cc 00 88 
                    aa 88 88 44 cc ee 66 ee 11 11 11 00 00 00 00 00 
                    dd ff ee dd dd 11 77 33 ee ee ee 44 44 00 66 44 
                    11 00 33 55 22 66 88 cc bb 66 44 aa ee 77 33 77 
                    00 00 00 00 00 00 00 00 ee ff ff 66 66 11 77 22 
                    ff ff 77 aa aa 99 33 66 00 00 00 00 00 00 00 00 
                    00 00 11 22 11 33 44 66 dd 33 aa dd 77 33 11 33 
                    88 00 00 00 00 88 88 88 77 77 77 33 33 00 33 11 
                    77 ff bb 55 55 cc 99 33 88 88 88 00 00 88 88 00 
                    00 00 00 11 00 11 22 33 55 11 dd 66 bb 99 00 11 
                    88 00 00 88 88 cc cc cc 33 33 33 11 11 22 22 11 
                    bb ff dd aa bb dd 33 66 cc cc cc 88 00 00 00 00 
                    00 00 00 00 00 00 11 11 22 00 66 bb 55 cc 00 88 
                    cc 88 88 44 cc ee 66 ee 11 11 11 00 00 11 11 00 
                    dd ff ee dd dd 66 11 bb ee ee ee 44 88 88 88 00 
                    66 22 22 55 77 ee cc ee 88 00 cc aa 44 66 11 33 
                    00 00 00 00 00 00 00 00 ff ff ee 55 33 22 33 11 
                    77 ff ff 66 66 dd 11 aa 00 00 00 00 00 00 00 00 
                    33 11 11 22 33 77 66 77 44 00 66 dd aa 33 00 11 
                    00 00 00 00 00 00 88 88 77 77 77 22 11 11 11 00 
                    bb ff 77 bb bb 66 88 dd 88 88 88 00 00 88 88 00 
                    33 11 00 11 11 33 33 33 66 88 bb 66 dd 99 00 88 
                    00 00 00 88 00 88 44 cc 33 33 33 11 11 22 33 11 
                    dd ff bb 55 55 66 33 99 cc cc cc 88 88 00 88 00 
                    11 00 00 00 00 11 11 11 bb cc 55 bb ee cc 88 cc 
                    00 00 88 44 88 cc 22 66 11 11 11 00 00 11 11 00 
                    ee ff dd aa aa 33 99 cc ee ee ee cc cc 00 cc 88 
                    bb 22 22 55 77 ee cc ee 00 00 cc aa 44 66 11 33 
                    00 00 00 00 00 00 00 00 ff ff ee 55 55 11 dd 55 
                    77 ff ff 66 66 00 cc 88 00 00 00 00 00 00 00 00 
                    55 11 11 22 33 77 66 77 88 00 66 dd aa 33 00 11 
                    00 00 00 00 00 00 88 88 77 77 77 22 22 00 66 22 
                    bb ff 77 bb bb 88 ee cc 88 88 88 00 00 00 00 00 
                    33 22 00 11 11 33 33 33 66 cc bb 66 dd 99 00 88 
                    00 00 00 88 00 88 44 cc 33 33 33 11 00 11 11 00 
                    dd ff bb 55 dd 33 88 dd cc cc cc 88 88 44 44 88 
                    11 11 00 00 00 11 11 11 bb 66 55 bb ee cc 88 cc 
                    00 00 88 44 88 cc 22 66 11 11 11 00 00 00 00 00 
                    ee ff dd aa 66 99 cc 66 ee ee ee cc cc aa 22 cc 
                    00 00 44 00 00 00 88 11 00 00 22 00 00 00 44 00 
                    00 00 00 11 00 00 00 00 00 00 88 00 22 00 00 00 
                    00 88 00 00 44 00 22 00 00 33 00 88 00 88 00 00 
                    00 44 99 00 00 11 00 00 00 00 11 00 00 00 11 88 
                    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 cc dd 11 44 11 aa 11 00 33 bb 88 22 88 55 88 
                    00 cc dd 11 44 11 aa 11 00 33 bb 88 22 88 55 88 
                    22 55 00 00 00 00 00 00 22 55 88 00 00 00 00 00 
                    00 55 22 00 00 00 00 00 88 55 22 00 00 00 00 00 
                    dd 00 55 bb bb dd 55 00 dd 00 aa 55 55 bb aa 00 
                    00 00 00 00 00 00 00 00 55 00 22 55 55 66 22 00 
                    dd 00 dd 66 66 dd dd 00 88 00 00 88 88 88 00 00 
                    11 00 11 22 22 33 11 00 dd 00 66 77 77 66 66 00 
                    cc 00 88 44 44 cc 88 00 11 00 00 11 11 11 00 00 
                    dd 00 bb 77 77 bb bb 00 cc 00 44 22 22 66 44 00 
                    d8 5f 13 3f 55 2f ff fa 9e 80 c0 c0 49 30 3f 3f 
                    11 3f ff 32 60 08 00 c7 41 20 3f 3f 3f 3f ff 4d 
                    00 20 00 ff 51 40 3f 3f 3f 3f ff dd 03 05 33 81 
                    41 1d 3f 3f 3f 3f ff ec c0 b0 c3 81 59 50 3f 3f 
                    15 3f ff 11 06 00 c0 ff 51 4f 12 3f 14 3f ff 9b 
                    3a 00 00 c7 49 30 3f 3f 12 3f ff d1 30 00 0f c1 
                    78 5f 60 3f 2f 11 ff ba 60 00 4c 9c 51 40 3f 3f 
                    12 3f ff 5a 30 08 00 ff 51 40 3f 3f 3f 3f ff 43 
                    00 18 00 81 59 5f 1f 3f 15 3f ff cb 04 01 03 c1 
                    41 1d 3f 3f 10 18 ff f1 a0 c4 c0 ff d8 53 5e 3f 
                    28 3f ff b3 00 00 0f 2f d8 50 7f 3f 14 3f ff a0 
                    0a 00 ff ff 48 40 1a 25 16 3f ff 0f 18 38 f8 fc 
                    c0 f0 2a 07 7f 2c c1 c0 c0 80 80 d0 41 10 3f 3f 
                    3f 3f c7 40 08 00 03 9f 49 36 1c 3f 3f 3f ff 07 
                    03 01 ff ff 41 10 3f 3f 3f 3f 81 81 c3 f1 c1 81 
                    78 5f 40 3f 47 2c 41 80 80 80 c0 f0 41 10 3f 3f 
                    3f 3f ff 07 03 0f 21 81 49 30 3f 3f 3f 3f c7 81 
                    f9 c1 83 bf 49 30 3f 3f 3f 3f c1 c1 e1 c1 83 81 
                    30 4f 51 3f 00 3f 5d 0c 6f 07 03 0f b0 30 6a 3f 
                    40 0d 80 04 c0 80 90 ff c1 10 bf 3f 28 3f 81 81 
                    03 11 01 21 41 10 3f 3f 3f 3f c1 80 88 84 c0 f1 
                    41 10 1b 3f 3f 3f ff 07 01 09 03 ff 78 5f 61 3f 
                    40 08 af 49 01 01 21 07 50 40 1d 3f 3f 3f ff 90 
                    80 83 f0 e1 48 34 25 13 17 06 fc 04 0a 89 3b ff 
                    50 40 3f 3f 3f 3f ff 89 81 81 89 99 b0 3f 43 1c 
                    c0 da 50 80 c0 c0 f8 ff d9 50 bf 3f 28 3f ff 05 
                    03 11 03 23 d9 4f a6 3f 87 2f 80 94 c0 a8 82 90 
                    b0 f0 5c 0f 46 2e fe a5 84 9e 8c 8c 59 53 0c 3f 
                    3f 3f 81 80 3c 00 00 ff 49 30 3f 3f 3f 3f bf 0b 
                    05 01 03 c7 79 50 bf 3f 2c 3f 81 80 fc c0 80 80 
                    d8 3f 40 15 52 1b cf 03 33 1b 07 ff 48 30 dc ff 
                    3f 3f ff c7 c3 87 c1 81 a8 f0 2a 14 7f 07 c1 c0 
                    cc e0 c0 df 70 ff 6a 26 40 07 89 00 00 00 02 c0 
                    41 10 3f 3f 3f 3f ff 16 20 18 f0 ff 28 4f 68 3f 
                    00 3f a7 07 07 0f 07 c3 40 10 2e 3f 3f 3f e1 80 
                    83 81 81 ff 58 22 1d 1b 3f 3f ff 09 c1 eb c1 c1 
                    40 10 3f 3f 3f 3f 99 88 88 c8 88 8f 58 9d d2 de 
                    1c 3f ff 09 01 01 01 81 39 94 8a 0c 98 00 23 01 
                    89 41 03 07 29 f0 aa 2b 96 07 90 80 f8 88 c0 c0 
                    40 4d 5c 1a 46 0f 8e 81 c0 c0 c0 ff 71 3f a4 1c 
                    28 3f ff 98 00 00 0c 00 29 16 bf 3f 28 3f c7 00 
                    24 10 00 00 30 49 5e 3f 00 3f cf 09 39 1d 19 99 
                    40 90 24 1a 3f 3f ff 88 80 c0 ff ff 50 4d 1c 3f 
                    3f 3f 81 08 00 00 c0 ff 58 56 3f 3f 3f 3f ff 09 
                    01 25 01 93 60 ff 6f 1c 42 0f e0 81 80 8c 80 c0 
                    49 30 1b 3f 3f 3f ff 81 0b 19 03 ff d8 ff 5a 14 
                    40 11 43 03 6f 33 03 01 58 04 1a 2c 3f 3f ff c9 
                    c1 c1 c1 c7 48 4d 18 1c 3f 3f c1 81 31 13 91 81 
                    58 93 0a 1e 3f 3f 8f 81 b1 81 81 c1 58 d0 2e 14 
                    3f 3f 81 89 81 a0 81 ff b0 33 5a 15 45 0f 84 f1 
                    81 03 ff ff 40 d3 1e 18 3f 3f ff 96 00 20 83 83 
                    a8 3d 52 3f 1c 3f ff 66 40 0a c0 ff 58 dd 22 3f 
                    3f 3f ff 45 04 00 00 81 40 10 1a 3f 3f 3f ff 9f 
                    0f 1f 07 ff 50 4d 23 3f 3f 3f 99 99 9d c9 81 81 
                    50 0d 1a 1c 3f 3f ff 85 81 85 81 81 40 2d e8 ff 
                    24 3f ff 18 00 20 00 01 40 10 3f 3f 3f 3f 93 01 
                    05 21 01 ff b0 4f 54 3f 47 1d c1 80 ec e6 e0 ff 
                    c9 3f af 3f 28 3f ff 2b 14 00 00 48 50 9d 5c 1e 
                    5a 00 41 8f 01 31 01 ff 50 4d 24 3f 3f 3f cf 82 
                    80 80 a3 e1 40 39 dc ca 1e 3f 81 05 21 01 ff ff 
                    40 20 ac 5d 10 3f c1 81 73 9b 93 97 40 f2 bf 5b 
                    48 25 ff 64 00 98 c6 c1 40 08 12 2c 3f 3f ff 09 
                    21 01 31 f7 48 33 ca ff 1c 3f 83 81 a1 83 89 81 
                    58 20 aa 5d d0 db ff 87 43 aa 80 df 48 4e 3f 3f 
                    3f 3f 81 80 84 20 00 81 40 09 da e8 1c 3f ff 25 
                    01 03 7f ff 48 99 cc de 1a 3f 81 81 89 81 a1 83 
                    40 22 cb cd db dd 81 eb 81 eb 81 83 43 83 4a 12 
                    15 3f 81 80 a6 80 f0 ff 58 5d 1c 3f 3f 3f ff 08 
                    00 00 00 ff d8 56 7f 3f 1a 3f ff 1d 0d 39 01 81 
                    c0 14 51 3f 44 13 8d 81 99 c3 c3 e7 40 14 11 3f 
                    3f 3f ff 88 80 d2 c0 89 58 83 da d4 1e 3f e1 00 
                    08 00 3e ff 58 50 2c 3f 3f 3f ff 19 09 03 07 ff 
                    40 08 14 2a 3f 3f 9f 90 8a c2 ce df 78 ff 6c 1b 
                    51 0d c1 07 61 19 01 8d 40 10 1b 3f 3f 3f ff 80 
                    80 80 94 81 50 45 3f 3f 3f 3f 81 00 00 00 00 81 
                    58 50 1b 3f 3f 3f ff 01 01 39 01 81 40 18 14 3f 
                    3f 3f 81 81 89 c3 89 81 60 42 db d1 5d 1e ff 88 
                    80 ea c3 81 79 3f 80 3f a0 06 c0 00 0c f0 00 00 
                    58 42 cb d1 1d 3f 83 ef 83 fb c3 83 58 20 1a 1d 
                    3f 3f ff 93 83 da c0 ff 58 5d 24 3f 3f 3f ff d1 
                    d1 11 01 81 58 5d e4 ff 1a 3f 81 a1 8d 81 81 81 
                    58 59 1c 3a 3f 3f e7 e7 f7 e7 e7 ef 50 44 21 3f 
                    3f 3f 89 8c 98 80 80 ff 48 3d 3f 3f 3f 3f ff 10 
                    10 10 00 ff 48 dd d2 ff 15 3f ff 01 01 01 01 81 
                    50 dd 22 24 3f 3f ff 81 81 83 83 83 50 40 2d 3f 
                    3f 3f 89 a1 81 89 81 83 50 4d 24 3f 3f 3f 81 80 
                    8c 80 80 81 40 11 3f 3f 3f 3f 81 24 00 42 10 81 
                    40 30 1b 1d 3f 3f 81 01 01 01 15 81 50 09 1e 2c 
                    3f 3f 81 81 fd 81 85 f5 50 3d 1c 1a 3f 3f 81 88 
                    80 80 e0 ff 48 3d 12 1d 3f 3f ff 01 01 01 05 81 
                    40 0d 18 1b 3f 3f c3 81 00 08 80 c1 60 13 5e 3f 
                    12 3f ff 80 28 00 03 ff 60 f3 19 13 7f 1d 81 00 
                    18 06 c0 ff 60 19 5c 3f 12 3f 81 01 31 03 0f ff 
                    48 33 3f 3f 3f 3f ef 8f bf 81 fc fd 58 3d d8 d2 
                    1c 3f ff 00 20 00 20 ff 40 40 1a 1c 3f 3f ff 01 
                    11 71 11 81 48 30 1c 0a ff cd 81 81 a5 bd a5 81 
                    48 30 1b 0a 3f 3f 83 80 a0 a8 a0 81 58 59 1e 3f 
                    3f 3f 87 11 41 05 01 ff 40 1d 3f 3f 3f 3f 81 80 
                    80 80 80 ff 50 83 db dc 14 3f 81 00 00 00 18 81 
                    50 4a 3f 3f 3f 3f 81 01 01 01 01 ff 60 bf 68 7f 
                    20 3f fd 90 80 a4 c0 00 58 5d 5a 3f 5d 68 ff 20 
                    00 06 00 00 b0 f0 5b 28 5c 67 81 01 03 0b 00 40 
                    50 0d 58 5a 60 68 c1 00 00 10 c0 00 38 5a 7f 7f 
                    68 7f ff 18 12 50 00 00 58 59 1e 3f 3f 3f ff 25 
                    01 01 01 81 40 10 29 3f 3f 3f ff 80 80 a7 80 bf 
                    58 56 14 3f 3f 3f fd 20 00 cc 00 83 58 59 3f 3f 
                    3f 3f ff 39 11 01 01 ff 40 13 cb fa 0c 3f 81 81 
                    99 81 81 81 a0 5f 5a 64 64 4d 81 87 81 b1 8d 81 
                    40 11 3f 3f 3f 3f 81 88 80 a0 8c 81 58 83 d2 ff 
                    1d 3f ff 04 20 00 24 81 50 90 1c 1e 3f 3f ff 21 
                    05 0d 25 81 38 ff 4a 0d 5b 1e 81 b6 80 9b 80 ff 
                    b0 4f 51 3f 62 1c ff 25 61 0b 31 81 43 10 1d 3f 
                    3f 3f ff 90 c0 83 80 ff 5b 53 15 3f 3f 3f ff 11 
                    01 c1 1f bf 4b 36 3f 3f bf bf 81 91 85 a1 89 81 
                    43 1d 24 3f ff ff ff 9e 80 a0 80 81 5b 53 da ff 
                    dd 3f ff 25 01 01 25 81 50 48 96 d1 ff e3 81 80 
                    a2 e0 e3 ff 48 03 59 5b ff 3f ff 21 01 09 c1 c1 
                    50 4d 28 3f bf bf 83 80 c0 04 10 01 48 bd 12 7f 
                    ff ff ff 07 07 0f 0f ff 50 d0 6c 5a bf bf 81 a1 
                    85 c1 c1 f7 c3 4f 80 21 a9 07 40 10 04 20 08 20 
                    50 43 14 3f bf bf 81 85 89 a1 89 81 50 80 2a 14 
                    bf bf 81 80 88 80 98 ff 40 3e 11 15 bf 3f 81 01 
                    01 23 0f ff 50 10 1c 1b ff bf ff 80 84 fc 87 81 
                    60 1f 4c 3f 51 1b 81 0c 60 12 c0 ff 5b 5d 1c 3f 
                    ff 3f ff 3b 13 01 21 81 4b 30 3f 3f bf bf bf 81 
                    fd 88 a3 8f 5b 5d 1c 3f bf bf 81 8d 81 21 81 c1 
                    4b 30 0d 3f bf bf 81 83 91 85 a1 81 41 83 ca ff 
                    de ff 81 a0 a0 82 f0 ff 40 dd dc d2 16 3f ff 08 
                    00 00 00 ff 40 03 0b 3f 3f 3f c1 04 10 00 00 ff 
                    50 00 2c 3f 3f 3f 81 01 39 03 07 ff 40 83 14 1c 
                    3f 3f ff a0 80 c0 c8 81 58 30 3f 1e ff da ff 64 
                    44 00 3e ff 58 e0 19 14 3f 3f c1 01 01 31 01 ff 
                    40 70 2a 1c 3f 3f 81 a1 83 80 9e ff 50 1e 93 5d 
                    08 3f ff 41 81 0b 01 f9 40 0d 28 3f 3f 3f ff 84 
                    c0 03 08 01 50 00 3f 3f 3f 3f 81 18 00 81 00 ff 
                    58 0d 14 3f 3f 3f ff 11 11 93 03 c3 5b 33 d4 d2 
                    cc d6 81 c8 aa aa 80 ff 53 0d 1c 2a 3f 3f 8f 09 
                    21 01 01 df 53 d0 2a 18 3f 3f c1 84 20 0a 80 df 
                    43 04 0c 3f 3f 3f 81 10 18 00 00 ff 53 0d 24 3f 
                    3f 3f ff 09 01 01 01 81 50 dd d8 d2 24 3f ff 08 
                    00 00 80 81 40 70 a8 5a 0c 3f ff 06 08 00 7f ff 
                    90 0e 15 3f 3f 3f ff 19 01 03 f3 c3 58 e0 ea 14 
                    3f 3f 81 80 80 e0 c3 df 50 00 3f 3f 3f 3f ff 18 
                    18 00 ff ff 50 00 1c 3f 3f 3f ff 21 05 1d c5 c1 
                    58 90 2d 1e 3f 3f ff 88 80 80 93 87 50 93 19 1c 
                    3f 3f f9 11 01 03 cf ff 50 04 1c 3f 3f 3f 81 80 
                    b0 b0 bf ff 48 0d 1e 1a 3f 3f ff 04 10 30 f0 ff 
                    48 00 3f 3f 3f 3f c3 01 09 01 33 81 5b 00 1a 3f 
                    3f 3f ff 82 80 9c 80 81 53 33 d2 d4 d6 cc ff 49 
                    2a 2a 00 ff 43 00 3f 3f 3f 3f ff c3 c3 c3 c3 ff 
                    5b 07 1c 3f 3f 3f ff 83 82 c0 ff ff 4b 09 da ff 
                    0c 3f 81 81 09 03 a1 81 50 9d 0a 1e 3f 3f 81 a9 
                    81 85 a1 81 80 de 12 18 ff d4 ff 80 00 00 88 83 
                    38 0e 05 3f 3f 3f c7 40 00 10 00 ff 48 3e d6 dc 
                    d1 db ff 10 00 00 18 ff 88 ed 12 0e 3f 3f ff 09 
                    01 09 21 81 50 d0 2d 0a 3f 3f c1 a1 81 81 a1 87 
                    50 0d 1a 3f 3f 3f 87 a5 81 8b 83 83 88 de 49 16 
                    5b 25 ff 80 80 98 86 81 40 e7 9c 59 0e 3f ff 05 
                    02 00 3f ff 40 00 1c 3f 3f 3f ff 03 07 1f c7 c1 
                    48 10 1e 1d ff db 81 81 81 eb c1 81 43 30 2a 15 
                    ff df 81 80 a0 80 8f df 5b 33 d8 da dc de ff 44 
                    00 00 aa ff 53 99 da dc 1e 3f ff 14 00 00 2a ff 
                    7b 00 3f 3f 3f 3f ff 40 08 22 08 81 43 00 3f 3f 
                    3f 3f 81 01 01 01 01 ff 40 00 3f 3f 3f 3f 81 81 
                    81 c1 81 81 80 0e d6 ff 02 3f 83 81 81 81 81 f1 
                    40 de 25 22 3f 3f ff c0 c0 80 80 83 58 ed 1c 22 
                    3f 3f ff 01 01 01 01 c1 80 de 06 0a 3f 3f 81 a9 
                    81 85 a1 81 40 00 3f 3f 3f 3f 87 81 81 83 81 81 
                    40 0d e2 ff 0c 3f 83 a9 81 81 89 81 88 9e 41 1e 
                    4d 13 81 86 98 80 83 ff 58 06 1a 3f 3f 3f ff 21 
                    01 03 ff ff 40 d2 cb dc 0d 3f c1 eb c1 c0 c0 ff 
                    40 d0 2a 0c 3f 3f 81 88 80 00 1c ff 53 03 14 3f 
                    3f 3f ff 21 09 03 0f 87 53 e3 1d 25 3f 3f ff 88 
                    a2 80 90 83 4b 0d e4 ff 22 3f ff 28 00 00 00 81 
                    4b 0d 0c 3f 3f 3f 81 09 01 21 09 81 9b 0e 13 3f 
                    3f 3f ff 84 80 80 84 c1 48 00 1a 3f 3f 3f 81 01 
                    09 19 09 81 90 2e c9 cd 06 3f f1 99 81 9f 80 ff 
                    90 e3 0b 05 3f 3f 83 c3 d3 83 03 ff 90 e4 11 02 
                    ff cd c1 80 80 f0 c0 ff 80 0e 06 3f 3f 3f 81 05 
                    11 41 01 ff 50 00 3f 3f 3f 3f 81 c1 91 85 81 81 
                    50 42 da d1 1d 3f 81 83 83 db c3 81 50 20 1a 1c 
                    3f 3f ff 83 93 b7 93 9f 50 00 3f 3f 3f 3f ff c0 
                    c7 f3 c3 df e8 e3 db d6 dc d1 ff 00 81 81 99 ff 
                    88 0e e1 ff 0e 3f ff 01 fd c1 81 bf 4b 0d 0a 3f 
                    3f 3f 87 e0 c8 c2 e0 ff 8b e0 2a 05 3f 3f 83 03 
                    23 03 0f df 4b 00 3f 3f 3f 3f 81 c1 91 81 85 81 
                    4b 0d 1a 3f 3f 3f 81 e0 80 80 80 ff 3b e3 19 03 
                    3f 3f d1 01 09 03 41 ff 50 d0 2a 0c 3f 3f 81 89 
                    81 81 9c ff 50 d0 2a 16 3f 3f ff c4 d4 84 10 ff 
                    40 30 2a 1e 3f 3f ff 18 08 00 1f ff 40 03 d9 ff 
                    1e 3f ff 24 00 00 c3 ff 40 00 3f 3f 3f 3f ff 07 
                    03 03 c3 c1 48 00 3f 3f 3f 3f 81 83 89 a1 81 81 
                    48 22 db dc ca cd 81 db 81 e7 81 81 48 0d c0 ff 
                    1c 3f 9f 01 21 03 c1 81 e0 e4 21 15 3f 3f df 99 
                    b1 91 80 ff 40 e8 d2 da d4 dc ff d5 c1 81 01 fd 
                    88 0e 01 2c 3f 3f bf a0 80 80 87 ff 58 99 da dc 
                    1e 3f ff 14 00 00 ff ff 58 90 22 1c ff de ff 16 
                    00 00 ff ff 80 0e 0c 1a 3f 3f 81 00 10 30 f3 ff 
                    58 33 d9 da dd de ff 18 00 00 ff ff 58 07 9c 62 
                    0e 3f ff 01 02 00 ff ff 58 99 e2 e3 e4 e5 ff 18 
                    18 00 c3 ff 58 00 3f 3f 3f 3f ff 18 18 00 c3 ff 
                    58 30 1a 1c 3f 3f ff 01 11 31 f9 c1 60 6f 62 1a 
                    15 3f ff 80 86 80 a8 81 78 0f 5a 3f 14 3f c1 01 
                    0b 31 01 ff 40 00 3f 3f 3f 3f 81 c3 91 c3 89 c3 
                    54 00 3f 3f 3f 3f 81 81 91 c5 81 81 5c 03 da ff 
                    0d 3f 81 c1 85 81 a3 81 55 00 3f 3f 3f 3f ff 81 
                    80 bf 81 fd f5 0e 14 3f 3f 3f fd 81 01 f1 e1 ff 
                    55 0d da ff 1c 3f ff a0 80 88 88 81 55 00 1b 3f 
                    3f 3f ff 20 00 1c 00 ff 55 0d d2 ff 16 3f ff 20 
                    02 00 03 ff 55 0d 24 3f 3f 3f ff 39 11 11 81 c1 
                    50 0d 1c 3f 3f 3f ff 88 80 88 98 81 48 0e d4 ff 
                    26 3f ff 20 00 10 01 fd 48 de 0e 1c ff d2 ff 01 
                    01 09 e9 81 4c 0d 22 3f 3f 3f ff e0 c0 88 80 81 
                    44 0d 0a 0d 3f 3f c1 23 21 01 03 ff 4c 00 3f 3f 
                    3f 3f 81 88 c2 90 80 ff 44 03 da ff 1d 3f ff 09 
                    01 01 25 81 4a 09 1c 3f 3f 3f c3 81 91 81 89 c3 
                    4c 00 1b 3f 3f 3f 81 80 c0 8c 80 81 4c 03 15 3f 
                    3f 3f 81 01 21 03 0f ff 55 02 1b 3f 3f 3f fd 81 
                    c1 ef 87 bf 55 3d e8 ff 14 3f ff a0 08 00 08 01 
                    55 00 3f 3f 3f 3f 81 01 01 01 01 ff 4d 03 14 3f 
                    3f 3f ff a0 88 80 88 81 4d 00 1b 3f 3f 3f ff 25 
                    01 0d 09 81 45 0d 0a 3f 3f 3f c1 a9 81 85 a1 81 
                    48 00 3f 3f 3f 3f 81 81 85 81 91 81 68 ed 12 06 
                    3f 3f ff 91 a1 89 a1 81 88 de 06 1a ff cc 83 c9 
                    89 a1 a5 81 5c 00 3f 3f 3f 3f 81 88 82 c0 90 81 
                    54 00 1b 3f 3f 3f ff 20 00 18 00 81 4c 0d d4 ff 
                    22 3f ff 60 08 00 08 81 5c 09 1c 3f 3f 3f 81 01 
                    23 01 09 81 4a 00 3f 3f 3f 3f c3 81 a1 85 91 81 
                    5c 00 3f 3f 3f 3f 81 80 a2 88 80 81 54 06 1c 3f 
                    3f 3f ff 01 21 01 0d 81 ed 0e 13 3f 3f 3f bf 99 
                    c1 81 85 fd 4d 30 2b 1c 3f 3f 81 80 80 80 88 ff 
                    45 00 3f 3f 3f 3f ff 00 00 00 00 ff 4d 0d 0c 2d 
                    3f 3f 81 09 19 01 03 ff 4d 00 1d 3f 3f 3f 81 81 
                    81 8d 99 81 4d 09 ca ff 1c 3f 81 85 a1 81 89 81 
                    40 02 db ff 1c 3f 81 81 81 e7 81 81 20 9e d1 e2 
                    c6 e3 83 81 89 81 81 bf 80 0e d1 ff 06 3f 81 85 
                    81 a1 89 83 54 0d 0c 3f 3f 3f 81 88 80 80 88 81 
                    4c 00 3f 3f 3f 3f 81 00 10 04 20 81 4c 09 3f 3f 
                    3f 3f 81 00 00 00 00 81 4c 0d 24 3f 3f 3f 81 09 
                    01 21 01 81 5a 03 da ff 0d 3f 81 81 85 81 a1 81 
                    4c 0d 1a 1d 3f 3f 81 90 80 a2 e0 ff 4c 00 3f 3f 
                    3f 3f 81 09 41 11 05 81 55 02 db ff 1d 3f f9 81 
                    83 eb 80 ff 55 0d 18 3f 3f 3f ff b8 10 00 00 ff 
                    55 0e da ff 1d 3f ff 10 00 00 00 ff 55 0e 13 3f 
                    3f 3f ff 04 00 08 00 ff 5d 0e 12 2d 3f 3f 81 01 
                    01 01 03 ff 5d 0d e4 ff 22 3f 81 a9 81 83 81 81 
                    50 02 d2 ff 15 3f 81 83 db da c0 ff 90 0e c1 ff 
                    0e 3f bf 81 fd 01 01 ff 98 de ce dc 01 3f 83 91 
                    81 89 e9 c1 4c 03 0c 3f 3f 3f 81 80 88 80 80 ff 
                    4c 0d 14 2a 3f 3f 81 00 08 00 0c df 4c 00 3f 3f 
                    3f 3f 81 00 00 00 00 ff 4c 00 2a 3f 3f 3f 81 01 
                    01 01 0f df 4a 09 da ff 0c 3f 81 81 89 83 a1 81 
                    5c 00 3f 3f 3f 3f ff 80 80 80 90 81 44 09 1c 3f 
                    3f 3f 81 00 00 00 08 ff 45 00 3f 3f 3f 3f ff 00 
                    00 00 00 81 45 0d 1c 3f 3f 3f ff 18 00 00 00 ff 
                    5d dd d4 da 1e 3f ff 62 08 00 08 ff 45 3d 1a 1d 
                    3f 3f ff 18 00 20 24 81 45 00 3f 3f 3f 3f ff 00 
                    20 04 00 ff 4d 30 29 15 3f 3f 81 00 00 00 3e ff 
                    45 0d 1a 3f 3f 3f ff 18 00 20 24 81 45 0e 11 2b 
                    3f 3f ff 08 00 00 00 ff 98 0e d1 ff 06 3f c3 09 
                    01 21 01 cf 4a 3d 1a 1d 3f 3f ff 80 80 a0 a4 81 
                    4a 00 3f 3f 3f 3f ff 01 01 05 21 81 4a 00 3f 3f 
                    3f 3f ff 80 80 80 80 81 4a 00 3f 3f 3f 3f ff 01 
                    01 01 01 81 52 00 3f 3f 3f 3f 81 b1 81 8d 81 81 
                    44 07 1a 3f 3f 3f 81 81 c1 81 b9 e1 54 0d da ff 
                    1c 3f ff a9 81 83 81 81 4d 0d d2 ff 14 3f 81 81 
                    a9 83 a9 81 45 00 3f 3f 3f 3f ff 80 92 80 a4 81 
                    5d 00 1b 3f 3f 3f ff 05 01 31 01 81 83 3e 14 0c 
                    3f 3f 81 80 80 80 80 81 53 e3 1b 23 3f 3f ff 01 
                    01 01 01 81 44 0d e2 ff 24 3f ff a9 81 83 81 81 
                    3d 2e ca d9 cd de 81 81 81 81 81 81 58 0d da ff 
                    24 3f ff 83 83 83 83 c3 58 70 2a 1c 3f 3f cf 85 
                    a5 85 9f ff da ff 4b 15 5a 24 81 99 87 b1 8d 81 
                    5a 00 3f 3f 3f 3f 81 80 80 80 80 ff 5a 00 2d 3f 
                    3f 3f 81 01 01 01 01 ff 5a 00 2b 3f 3f 3f 81 80 
                    a4 80 80 ef 52 06 0c 3f 3f 3f 81 01 0d 21 01 ff 
                    44 5d 12 1d 3f 3f e1 81 a0 80 a4 81 54 02 cb ff 
                    0d 3f 81 eb 01 01 01 ff 5d 02 da ff 1d 3f 81 81 
                    81 db 81 81 5d 6d 0a 0c 3f 3f 81 a1 8d 81 a1 83 
                    5d 09 ca ff 1c 3f 81 83 b1 81 cd 81 8b de 04 1a 
                    3f 3f 81 80 80 a0 fe ff 4b 0e 03 3f 3f 3f 81 01 
                    01 05 01 ff 54 ff 13 15 22 24 81 c1 9f 81 bf 81 
                    75 2e c2 de c5 d9 81 81 81 81 81 81 50 0d 0a 3f 
                    3f 3f c3 a0 a0 80 84 81 42 d0 19 24 3f 3f ff 09 
                    21 61 21 81 ca ff 4a 0d 5e 24 81 b6 80 83 8c 81 
                    4a 30 29 13 3f 3f ff 01 01 01 3f ff 4a 6d 22 1c 
                    3f 3f ff a1 81 83 8d 81 4a 29 da e1 dc ff ff 80 
                    80 80 bf 81 4a 03 d9 ff 1b 3f ff 09 01 01 f1 81 
                    5c 33 e2 cb 1d 3f 81 80 90 80 84 a1 4c 90 68 1a 
                    ff db ff 49 01 03 71 ff 55 22 e1 e3 e4 e6 81 db 
                    81 81 a5 81 55 0d 0a 3f 3f 3f 83 e0 c0 c4 e0 ff 
                    4d d5 0b 0c 3f 3f 81 08 3c 00 00 ff 4c 00 1b 3f 
                    3f 3f ff 42 00 08 00 81 54 03 d9 ff 1e 3f ff 24 
                    00 00 42 ff 5c f0 7f 12 3f 15 81 01 37 01 01 ff 
                    2d 2e c2 d9 c5 de 81 81 81 81 81 bd 40 40 2b 11 
                    3f 3f 81 81 81 c3 ef ff 52 99 ca cb dc dd 81 83 
                    b1 81 cd 81 ca 0f 4a 3f 55 1b 81 b0 86 98 80 ff 
                    82 0e d3 ff 14 3f ff 00 00 00 00 81 5a 0d ca ff 
                    0c 3f 81 29 29 01 01 ff 4a 03 0b 3f 3f 3f 81 81 
                    91 81 81 81 4a 06 ca ff 1c 3f 81 83 b1 81 8d 81 
                    54 00 3f 3f 3f 3f a1 88 a2 88 80 ff 4c 0d e2 ff 
                    24 3f ff 29 01 03 01 81 5d 00 1b 3f 3f 3f 81 80 
                    80 b8 80 81 55 dd da e4 1e 3f ff 3a 00 00 00 81 
                    95 0e 14 3f 3f 3f ff 09 01 01 03 81 4c 99 ca cb 
                    dc dd 81 83 b1 81 cd 81 95 0e 12 3f 3f 3f ff 80 
                    80 80 8c 81 55 03 d9 ff 1e 3f ff 18 00 00 42 c3 
                    5d 00 3f 3f 3f 3f bd 00 00 00 00 81 4d d0 1b 24 
                    3f 3f ff 41 09 39 01 81 52 00 3f 3f 3f 3f 81 81 
                    8f c0 8f 81 4a 0d 1c 3f 3f 3f ff 89 e1 03 e1 81 
                    32 0e c3 ff 04 3f 91 81 81 c1 81 83 4a 9d 1c 1e 
                    3f 3f ff 88 80 c0 83 ff 52 03 1d 3f 3f 3f 81 01 
                    01 01 85 81 42 99 cc cd da db 81 c1 8d 81 b3 81 
                    44 90 2e 1c ff db ff 98 80 c0 fc fd 4c 83 ff ff 
                    d4 dc 81 01 01 01 29 81 5d 99 ca cb dc dd 81 80 
                    b0 80 8c 81 55 00 3f 3f 3f 3f 81 08 40 11 04 81 
                    95 0e 04 3f 3f 3f 89 01 01 83 21 81 4c 00 3f 3f 
                    3f 3f 81 c1 99 83 99 c1 9d e2 c9 c2 d9 ff a1 80 
                    80 80 8c 81 5d 03 db ff 1c 3f c3 42 42 42 5a c3 
                    4d 00 3f 3f 3f 3f 81 00 00 00 00 81 4d 0d ca ff 
                    0c 3f 81 29 01 01 29 81 4a 0d 1a 3f 3f 3f 81 99 
                    81 a1 a5 81 4a 6d 1a 0c 3f 3f 81 80 8c a0 e0 ff 
                    4a e0 e9 c3 ff c4 83 00 00 00 3c ff 4a 07 1c 3f 
                    3f 3f ff 18 10 00 1f ff 52 03 ca ff 0d 3f 81 01 
                    25 01 81 ff 52 05 db ff 0d 3f 81 81 85 81 91 81 
                    54 33 d2 dc 16 3f ff 80 80 a2 88 81 5c 00 28 3f 
                    3f 3f 81 11 01 01 4f ff 4d 90 2d 1b ff de 81 80 
                    80 80 f3 ff 4d 00 3f 3f 3f 3f 81 00 18 00 81 ff 
                    4d 0e 04 3f 3f 3f 89 03 01 01 f1 ff 54 6d 12 0c 
                    3f 3f c1 81 ad 83 b1 81 2d 0e 02 1d 3f 3f 81 80 
                    80 82 f0 81 5d 0d d9 ff 1e 3f c3 42 00 00 00 81 
                    a5 00 7f 3f 1b 3f 81 00 00 14 00 81 45 30 1b 0c 
                    3f 3f 81 01 09 39 01 81 4a 0d dd ff 0a 3f 81 a5 
                    81 81 a1 81 57 0d 12 3f 3f 3f ff 81 a1 85 a1 81 
                    47 06 5a 3f 22 3f ff 80 80 84 a8 81 5f 03 da ff 
                    1d 3f ff 01 01 01 25 81 47 0d 24 3f 3f 3f ff 80 
                    80 a0 80 81 cf 00 3f 3f 3f 3f 81 25 01 11 05 81 
                    56 0d 1c 3f 3f 3f 81 80 c0 88 88 81 4e 3d 1c 1a 
                    3f 3f ff 00 00 00 20 81 46 0d da ff 14 3f ff 00 
                    00 22 20 ff 4e 9d 1a 1d 3f 3f ff 10 00 20 24 81 
                    56 d0 2b 16 3f 3f ff 04 04 20 0e ff 5e 90 2d 0a 
                    ff cd 81 01 25 01 01 ff 5d 6d 0a 0c 3f 3f 81 a0 
                    ac a0 80 ff 5d 0d 1c 3f 3f 3f 81 18 00 40 00 ff 
                    5d 90 2d 0a ff cd 81 00 24 00 00 ff 9d e3 0a 12 
                    3f 3f 81 01 01 03 0f ff 5e f3 dd d2 8a 25 81 81 
                    b1 81 87 81 4f df 52 0c 1e 3f 81 88 b0 83 88 81 
                    47 d0 59 0c 1a 3f 81 09 09 31 01 ff 4e 00 23 3f 
                    3f 3f 81 81 81 a1 ad 81 47 d3 0d 0a 3f 3f 81 a1 
                    85 81 a1 81 47 99 e3 ca e5 cc 81 81 a9 81 81 ff 
                    5e 50 2b 0a ff cd 81 80 a4 80 80 ff 9e e3 5a 0c 
                    3f 3f 81 01 01 03 21 ff 5e 90 2f 1e ff e4 ff 88 
                    88 c0 82 fe 46 00 3f 3f 3f 3f 81 15 41 09 23 81 
                    5e 6d 1a 1c 3f 3f ff 84 80 80 8c 81 56 03 da ff 
                    1d 3f ff 00 00 00 24 81 56 d0 2b 12 3f 3f ff 01 
                    01 01 05 ff 46 00 3f 3f 3f 3f ff 80 84 80 a0 81 
                    46 55 9a 1d a5 22 ff 42 02 00 36 81 56 0d e3 ff 
                    14 3f ff 01 01 41 05 81 5e 3f 9a 12 dd d5 81 81 
                    81 b7 81 81 7f 03 da ff 0d 3f 81 80 84 80 a0 81 
                    90 30 28 21 3f 3f ff 01 01 01 01 ff 5f a9 e1 da 
                    26 3f 81 81 81 81 81 ff b7 60 29 24 3f 3f 81 80 
                    a4 80 80 ff 48 00 3f 3f 3f 3f ff 01 01 01 01 81 
                    46 9d 9a 1d a2 25 ff 80 80 a0 b6 81 46 0a 12 3f 
                    3f 3f ff 00 20 00 00 ff 5e 1e 13 1d 3f 3f ff 61 
                    61 0b 4b fb 56 03 ca ff 0d 3f 81 80 bc 80 80 ff 
                    4e 00 2d 3f 3f 3f 81 05 21 01 01 ff 46 3d 62 0d 
                    3f 3f 81 80 e4 a0 80 81 4e 3d d3 d9 16 3f ff 14 
                    04 00 44 ff 5e 00 bf 3f e3 13 81 00 04 10 14 81 
                    56 99 ca d4 15 3f 81 01 21 0d 01 ff 46 99 d2 d3 
                    d5 d4 81 80 80 bc 80 81 56 00 3f 3f 3f 3f 81 01 
                    01 01 01 81 4f 9d 92 7f dc ff 81 80 a0 8a a0 81 
                    5f 0d 1c 3f 3f 3f ff 01 01 21 01 81 57 90 2e 23 
                    ff e4 ff 82 80 a2 80 fd c0 93 ff db e7 dc ff 00 
                    00 00 18 81 88 93 60 23 ff e5 81 01 01 01 01 ff 
                    46 33 4a 0d 52 15 81 80 b6 80 80 ff 56 35 e1 d9 
                    e6 de ff 10 00 00 00 ff 5e 95 e1 d9 e6 de fb 42 
                    00 00 00 ff 5e 0d 1e 3f 3f 3f ff 1a 08 08 08 ff 
                    5e 6d d1 e4 16 3f ff 40 00 00 00 ff 56 99 e5 e4 
                    e3 e2 81 19 01 01 01 ff 46 90 2e 23 ff e4 ff 82 
                    82 a0 80 fd 56 65 27 23 ff 3f 81 01 01 01 01 ff 
                    5e d0 2e 1d 3f 3f ff 80 80 c0 80 fd 4e 63 0d 24 
                    3f 3f 81 01 25 21 21 ff 56 05 e0 ea 27 3f 81 81 
                    81 81 00 df 50 f9 ca d2 8c 54 81 81 bd 81 81 ff 
                    40 60 2c 22 3f 3f 81 80 80 80 80 f7 88 53 d9 e1 
                    de e6 ff 00 00 00 00 ff 70 0a 12 3f 3f 3f 81 00 
                    20 00 00 ff 58 d0 ff da e9 dc ff 01 01 01 01 ff 
                    00 00 00 00 00 00 11 11 11 11 11 11 11 11 11 11 
                    10 01 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
                    11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
                    11 11 11 11 11 11 71 17 11 11 11 11 11 44 00 00 
                    00 00 01 10 01 10 01 10 00 00 00 00 10 01 11 00 
                    11 00 11 00 00 00 10 11 11 11 00 00 01 00 11 11 
                    11 11 11 11 11 11 00 00 20 02 20 02 00 22 00 22 
                    00 10 65 56 35 53 35 53 65 56 33 33 33 33 65 56 
                    33 53 33 53 65 56 35 33 35 33 11 11 33 33 33 33 
                    11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
                    11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
                    11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
                    11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 
                    11 11 11 11 00 11 00 11 11 11 11 00 11 00 11 11 
                    00 11 00 11 d9 6f aa ba 4c b6 f9 06 6d 6e 76 d5 
                    7d af ba 66 59 55 2b 66 8d 31 46 9d 2b 22 9b cc 
                    45 66 a6 bb dc b9 ce 54 e8 26 e2 dd b7 7e fe dd 
                    39 37 a2 62 c0 3e 02 00 10 c0 00 70 90 5f 00 ef 
                    f0 09 00 88 00 7c 15 6c 8d 80 5f 00 04 11 4c 00 
                    00 7c 02 71 13 00 00 00 5f 00 a7 08 81 00 e8 1b 
                    0c 00 00 00 73 77 8b f6 d9 cd 7b 67 e8 de b3 d0 
                    ff 16 3b ed ff 06 e6 bd 61 ff 6f d9 ee 46 d1 ee 
                    ee c2 ee 8e 3b 61 ee 4f 9d f6 ff 06 ee 2c 77 6f 
                    f6 ff 06 f6 31 13 20 40 a0 18 01 00 01 d8 8c 80 
                    20 77 02 42 ee 04 02 31 01 39 13 80 00 a0 08 00 
                    40 ee 04 18 13 00 00 00 08 98 e4 4e 72 27 20 12 
                    04 00 00 00 30 33 33 00 e0 ee ee 00 11 01 ff ff 
                    ee 6e 66 06 77 77 54 15 88 99 e0 ee 00 cc cc cc 
                    00 ff ff ff 11 01 00 00 ee 0e 77 77 e0 ee ee ee 
                    00 00 00 00 6e 6e 6e 4e 00 00 13 13 13 13 8b 88 
                    00 60 62 62 4d 0d 01 01 9b 9b 9b 9b 88 88 88 9b 
                    62 62 62 62 01 01 00 00 9b 1b 13 00 9b 9b 9b 13 
                    00 00 00 00 a7 88 aa ff af aa ab 7f 4f 4d 45 ff 
                    9e 9b 9d ff 7e 01 00 00 70 1e 10 11 f0 87 80 88 
                    e7 08 00 00 00 00 00 00 11 10 23 55 88 80 cc ee 
                    00 00 00 00 30 73 e7 cc b0 db ed a6 b0 7b f6 dd 
                    80 c8 64 aa ba fc 77 3b 6a ee dd bb ff ff 76 bb 
                    aa 6a c4 8a 34 13 00 00 77 cb 7b 03 dc 7b ca 08 
                    84 08 00 00 ae ee 0a aa 00 00 00 00 00 00 00 00 
                    57 77 05 55 ae aa ba bb fc cc 7c 55 f3 bb 2f 22 
                    57 55 d5 dd fb ee 7f 37 37 cc c3 ff ce 33 3c ff 
                    fd 77 ef ce b7 ea dd 88 60 bf cf 00 60 df 3f 00 
                    de 75 bb 11 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 60 bf ff 9f 00 00 00 00 00 00 00 00 
                    60 df ff 9f 28 ff 2f 98 00 80 00 00 00 10 00 00 
                    41 ff 4f 91 ff bf 6f 00 00 00 00 00 00 00 00 00 
                    ff df 6f 00 60 bf fb 43 00 00 00 00 00 00 00 00 
                    60 bf fb 2c 44 66 33 22 00 00 00 c8 00 00 00 31 
                    22 66 cc 44 11 01 00 00 63 95 98 07 ec fe ff 0e 
                    88 08 00 00 30 55 bf 78 80 c4 a6 ce 00 00 00 00 
                    00 00 00 00 50 85 05 55 80 48 08 88 00 00 00 00 
                    00 00 00 00 55 99 ab d2 08 53 d7 6f 00 00 00 00 
                    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 00 00 10 21 10 70 b7 d5 80 16 88 cc 
                    e0 69 7d a0 22 03 41 0b bd 7b 1e 8e dd cd f1 0e 
                    55 45 44 85 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 00 1e 5d 0d 00 00 00 00 00 00 00 00 
                    00 00 00 00 40 92 99 0a 31 23 45 e0 00 00 e8 02 
                    00 00 d2 19 00 11 22 44 f0 b7 db de f0 ef ad a5 
                    00 88 cc ee aa 99 88 99 bb 77 ff 77 c5 a7 b5 a6 
                    dd bb 77 bb aa cc aa 07 5b 5b 5b 0f c4 84 88 0f 
                    b5 b5 b5 0e 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 00 00 00 00 11 d9 75 37 00 b9 6a c6 
                    00 00 00 00 00 00 00 00 7d 73 d5 19 ef c4 b6 89 
                    00 00 00 00 00 00 00 00 00 00 00 00 11 d9 75 37 
                    00 b9 6a c6 00 00 00 00 00 00 00 00 7d 73 d5 19 
                    ef c4 b6 89 00 00 00 00 00 00 00 00 30 32 01 00 
                    e0 7f ff 00 bb bb bb bb ef bd d9 cd 7f db b9 3b 
                    dd dd dd dd bb bb bb bb ff ff ff ff ff ff ff ff 
                    dd dd dd dd bb bb bb bb ff ff ff ff ff ff ff ff 
                    dd dd dd dd bb bb bb db ef bd d9 cd 7f db b9 3b 
                    dd dd dd bd 55 55 55 55 ff ff ff ff ff ff ff ff 
                    aa aa aa aa 55 55 55 b5 ff ff ff ff ff ff ff ff 
                    aa aa aa da bb bb bb db ef bd d9 cd 7f db b9 3b 
                    dd dd dd dd 55 55 55 55 ff ff ff ff ff ff ff ff 
                    dd dd dd dd 55 55 55 b5 ff ff ff ff ff ff ff ff 
                    dd dd dd dd bb bb bb bb ef bd d9 cd 7f db b9 3b 
                    dd dd dd bd bb bb bb bb ff ff ff ff ff ff ff ff 
                    aa aa aa aa bb bb bb bb ff ff ff ff ff ff ff ff 
                    aa aa aa da ff ff f0 bf ff ff f0 ff ff ff f0 ff 
                    ff ff f0 df 55 55 55 55 ff ff ff ff ff ff ff ff 
                    aa aa aa aa 55 55 55 b5 ff ff ff ff ff ff ff ff 
                    aa aa aa da 00 00 40 00 00 00 00 01 00 00 80 8c 
                    00 00 00 00 00 00 10 00 00 00 00 00 00 00 20 00 
                    00 02 00 00 00 00 20 27 00 20 00 00 00 00 00 00 
                    00 00 00 04 10 40 60 50 30 00 00 01 81 01 03 02 
                    06 0c 09 03 08 60 b0 60 01 0f 2e aa 00 00 00 00 
                    08 08 88 88 01 02 02 02 03 03 01 01 17 0c 08 2a 
                    3f 07 08 07 aa 88 22 bb cf 0c 03 0f 00 88 cc 0c 
                    00 0c 0c 04 01 00 00 00 00 00 00 00 06 08 0d 06 
                    06 03 00 00 0d 07 0e 05 0f 0c 00 00 0c 08 08 08 
                    00 00 00 00 00 00 06 09 0b 0c 0e 07 00 00 01 01 
                    01 01 00 0a 00 0d 0e 0e 0e 0e 0c 00 00 08 0c 0c 
                    0c 04 00 ee 07 03 03 01 00 00 00 00 0d 0d 0d 0e 
                    0f 03 00 01 1d 1d 0c 0c 0a 07 07 07 99 11 15 0e 
                    0e 06 04 00 00 00 00 10 10 10 00 40 01 01 c1 61 
                    c1 00 00 00 02 00 00 00 30 68 18 08 00 00 00 00 
                    00 80 80 00 a0 60 20 00 40 50 70 20 00 60 50 b0 
                    60 01 01 01 08 18 38 38 18 08 00 00 00 80 40 80 
                    80 20 30 f0 03 06 0c 40 e0 50 40 20 09 0c 07 03 
                    00 c0 60 c1 00 08 0f 07 04 0c 18 18 20 0e 0f 08 
                    80 c0 40 40 00 70 c0 a0 c0 10 00 20 01 01 01 01 
                    c1 41 41 80 00 00 00 60 70 40 20 08 20 20 a0 60 
                    20 60 40 00 00 10 fe ff f7 ff ff 87 fe ff ff 1e 
                    00 80 f7 ff ff 1e 2e 01 f7 ff ff 87 fe ff ff 1e 
                    ff 87 47 08 21 1e 2e 01 47 08 48 87 2e 01 21 1e 
                    48 87 47 08 10 00 f1 00 02 00 02 00 11 00 00 00 
                    ff 00 01 00 12 00 01 00 3c 00 02 00 13 00 02 00 
                    14 00 05 00 12 00 03 00 64 00 01 00 10 00 f9 00 
                    02 00 01 00 00 21 40 44 97 73 f0 4f de fe f0 2f 
                    00 48 a0 2a 73 5d 3f 5d 5b 75 aa 1a ad ea 55 85 
                    ec ab cf ab 20 01 00 00 74 03 99 09 f2 0e dd 0d 
                    40 08 00 00 00 c0 de ad 00 10 d3 ad 00 c0 de ad 
                    00 10 d3 2d 6a 55 64 a6 3a 55 b1 2b 5a 45 45 a6 
                    52 15 d9 2b db ed cc 89 d6 3d 99 0c db ed cc 89 
                    d6 3d 99 0c 33 ed ee 40 ff 0f ff 10 cc 7b 56 f0 
                    f0 70 ff 70 88 88 88 88 00 00 00 00 ae ae ae ee 
                    ce 89 ed ff 88 88 88 48 00 00 00 10 ea ee aa ea 
                    f9 8f 8b ff f0 e0 ff e0 33 ed a6 f0 ff 0f ff 80 
                    cc 7b 77 20 b7 91 73 ff 57 57 57 77 00 00 00 00 
                    11 11 11 11 9f ff d1 f1 75 77 55 75 00 00 00 80 
                    11 11 11 21 00 33 66 55 dd ff 88 44 ff 88 77 ff 
                    ff ff 00 10 ff 11 ee ff ff ff 33 d1 00 cc 66 aa 
                    bb ff 11 11 88 88 88 88 88 88 88 88 00 00 00 00 
                    00 00 00 00 e0 a0 e0 a0 e0 a0 e0 e0 bb bb bb ff 
                    dd dd dd dd 88 88 88 88 88 88 88 44 00 00 00 00 
                    00 00 00 10 a0 e0 e0 e0 a0 a0 a0 e0 dd dd dd dd 
                    dd dd dd dd 00 b3 4b 0b 4b 86 4b dc 4b fb 4b fd 
                    4b ff 4b ff 4b de 49 cf 4b 9d 4b ae 4b d2 4b f2 
                    4b f1 4b b1 49 81 8a f8 4b f6 2b 77 33 55 22 ee 
                    cc aa 44 11 32 23 11 88 c4 4c 88 22 55 33 77 44 
                    aa cc ee be 78 fc 88 c4 a9 e6 a9 e2 29 08 4e 28 
                    40 a8 2a b6 46 96 22 c6 46 c8 34 f6 38 b4 4d a6 
                    23 ec 02 de 2a 34 46 10 46 f6 25 f8 23 28 1b 3a 
                    0b 48 2a 6a 40 36 29 16 47 38 22 2a 46 a0 23 60 
                    43 8c 4c 0e 36 0a 33 3c 4f dc 4d e2 2d 54 24 56 
                    2c de 4d 3e 4a 50 4a 52 36 e2 38 c2 42 72 4e 74 
                    40 d2 23 74 33 52 4f 47 41 4c cc 1f 36 56 49 4c 
                    47 41 cc 28 3a 54 41 4d 49 53 cc 42 3a 41 53 4f 
                    47 45 cc 96 3a 44 41 52 41 51 cc a2 3a 51 55 41 
                    52 4b cc d5 3a 53 41 4d 41 4c cc 21 3b 4c 45 58 
                    49 41 cc 57 3b 4b 4f 50 45 58 cc 7c 37 55 52 49 
                    41 48 cc b1 3b 48 41 52 49 41 cc c9 3b 4f 4b 52 
                    49 50 cc cd 3b 41 52 4c 4f 4e cc d6 3b 4d 49 53 
                    45 53 cc f3 47 4f 54 52 55 4e cc fa 4b 00 11 22 
                    44 66 22 22 33 00 88 44 22 66 44 44 cc

.L62ad               lda #$00
                    sta $8b
.L62b1               ldy $8b
                    sec
                    lda $0150,y
                    sbc #$01
                    and #$3f
                    sta $0150,y
                    and #$01
                    bne L62f7
                    lda $0150,y
                    cmp #$0c
                    bpl L62f7
                    asl a
                    asl a
                    sta $8e
                    tya
                    adc $8e
                    tax
                    lda $0120,x
                    beq L62f7
                    lda $0150,y
                    sta $8f
                    lsr a
                    adc $8f
                    adc #$6d
                    sta $8f
                    tya
                    asl a
                    asl a
                    asl a
                    asl a
                    asl a
                    adc #$08
                    sta $8e
                    lda #$9d
                    sta $8c
                    lda #$62
                    sta $8d
                    jsr S65d4
.L62f7               inc $8b
                    lda $8b
                    cmp #$08
                    bne L62b1
                    rts
                    
.S6300               lda $8e
                    and #$07
                    sta $89
                    txa
                    asl a
                    asl a
                    asl a
                    sta $8a
                    sty $8b
                    lda $8e
                    and #$f8
                    tax
                    ldy $8f
                    jsr S65e0
                    ldx #$00
                    ldy #$00
.L631c               lda ($6b),y
                    and #$02
                    sta $01c8,x
                    inx
                    iny
                    tya
                    and #$03
                    cmp #$03
                    bne L631c
                    tya
                    clc
                    adc #$1d
                    tay
                    cpy #$60
                    bmi L631c
                    lda #$00
                    sta $87
.L6339               ldy #$00
                    sec
                    lda $8e
                    and #$07
                    sta $88
                    lda #$08
                    sbc $88
                    sta $88
.L6348               ldx $87
                    lda $01c8,x
                    beq L6353
                    iny
                    jmp L635e
                    
.L6353               lda ($8e),y
                    eor ($8c),y
                    sta ($8e),y
                    iny
                    cpy $88
                    bne L6353
.L635e               inc $87
                    tya
                    clc
                    adc #$07
                    and #$f8
                    tay
                    lda $88
                    adc #$08
                    sta $88
                    cpy $8a
                    bne L6348
                    clc
                    lda $8e
                    adc #$f8
                    sta $8e
                    lda $8f
                    adc #$00
                    sta $8f
                    lda $89
                    beq L63b8
                    ldy #$00
.L6384               sec
                    lda #$08
                    sbc $89
                    sta $88
                    tya
                    ora $88
                    tay
                    ldx $87
                    lda $01c8,x
                    beq L63a0
                    tya
                    clc
                    adc #$08
                    and #$f8
                    tay
                    jmp L63ac
                    
.L63a0               lda ($8e),y
                    eor ($8c),y
                    sta ($8e),y
                    iny
                    tya
                    and #$07
                    bne L63a0
.L63ac               inc $87
                    cpy $8a
                    bne L6384
                    dec $87
                    dec $87
                    dec $87
.L63b8               clc
                    lda $8e
                    adc #$08
                    sta $8e
                    lda $8f
                    adc #$00
                    sta $8f
                    lda $8c
                    adc $8a
                    sta $8c
                    bcc L63cf
                    inc $8d
.L63cf               dec $8b
                    beq L63d6
                    jmp L6339
                    
.L63d6               rts
                    
                                         00 29 2c 2a 22 33 4c 34 42 
                    3d 2c 3e 22 9a 4c 9b 42 9d 48 9e 42 c2 44 c3 46 
                    ec 4c ed 42 f1 4c f2 22 69 2d 6a 3b 79 4c 7a 42 
                    00 00 44 aa 11 00 00 00 00 00 44 aa 11 00 00 00 
                    44 44 aa aa 22 11 11 00 44 44 aa aa 99 00 00 00 
                    00 00 22 55 88 00 00 00 00 00 22 55 88 00 00 00 
                    22 22 55 dd 99 00 00 00 22 22 55 55 44 88 88 00 
                    
.S6440               ldx $9a
                    ldy $9b
                    asl $9a
                    rol $9b
                    txa
                    sta $9d
                    clc
                    adc $9a
                    php
                    clc
                    adc #$03
                    sta $9a
                    tya
                    adc $9b
                    plp
                    adc $9d
                    sta $9b
                    and #$0f
                    sta $9c
                    rts
                    
.S6461               lda #$00
                    sta $88
.L6465               ldx $88
                    lda $0100,x
                    bne L646d
                    rts
                    
.L646d               lda $0104,x
                    sta $89
                    cmp $0105,x
                    bmi L6480
                    and #$03
                    cmp #$03
                    bne L6480
                    jsr S64d9
.L6480               clc
                    ldx $88
                    lda $89
                    adc #$01
                    cmp $0106,x
                    bmi L648e
                    lda #$00
.L648e               sta $0104,x
                    sta $89
                    cmp $0105,x
                    bmi L64cd
                    and #$03
                    bne L649f
                    jsr S64d9
.L649f               ldx $88
                    lda $70
                    and #$f8
                    sec
                    sbc #$10
                    cmp $0100,x
                    bcs L64cd
                    adc #$20
                    cmp $0100,x
                    bcc L64cd
                    bne L64bc
                    lda $72
                    and #$03
                    beq L64cd
.L64bc               lda $0101,x
                    cmp $71
                    bcc L64cd
                    sbc #$03
                    cmp $71
                    bcs L64cd
                    lda #$04
                    sta $20
.L64cd               clc
                    lda $88
                    adc #$08
                    sta $88
                    and #$20
                    beq L6465
                    rts
                    
.S64d9               lda $89
                    and #$0c
                    asl a
                    asl a
                    sta $8c
                    lda #$64
                    sta $8d
                    lda $0100,x
                    sta $8e
                    lda $0101,x
                    sta $8f
                    jmp S65d4
                    
                    dd 99 bb 99 ff 00 ff 99 dd 99 dd 99 ff 00 
.S6500               sty $8b
                    txa
                    asl a
                    asl a
                    asl a
                    sta $8a
.L6508               ldy $8a
                    dey
.L650b               lda ($8c),y
                    sta ($8e),y
                    dey
                    bpl L650b
                    inc $8f
                    clc
                    lda $8c
                    adc $8a
                    sta $8c
                    lda $8d
                    adc #$00
                    sta $8d
                    dec $8b
                    bne L6508
                    rts
                    
.S6526               lda $8e
                    and #$07
                    sta $89
                    txa
                    asl a
                    asl a
                    asl a
                    sta $8a
                    sty $8b
.L6534               ldy #$00
                    sec
                    lda $8e
                    and #$07
                    sta $88
                    lda #$08
                    sbc $88
                    sta $88
.L6543               lda ($8e),y
                    eor ($8c),y
                    sta ($8e),y
                    iny
                    cpy $88
                    bne L6543
                    tya
                    clc
                    adc #$07
                    and #$f8
                    tay
                    lda $88
                    adc #$08
                    sta $88
                    cpy $8a
                    bne L6543
                    clc
                    lda $8e
                    adc #$f8
                    sta $8e
                    lda $8f
                    adc #$00
                    sta $8f
                    lda $89
                    beq L658f
                    ldy #$00
.L6572               sec
                    lda #$08
                    sbc $89
                    sta $88
                    tya
                    ora $88
                    tay
.L657d               lda ($8e),y
                    eor ($8c),y
                    sta ($8e),y
                    iny
                    sty $87
                    tya
                    and #$07
                    bne L657d
                    cpy $8a
                    bne L6572
.L658f               clc
                    lda $8e
                    adc #$08
                    sta $8e
                    lda $8f
                    adc #$00
                    sta $8f
                    lda $8c
                    adc $8a
                    sta $8c
                    lda $8d
                    adc #$00
                    sta $8d
                    dec $8b
                    bne L6534
                    rts
                    
.S65ad               sty $8b
                    txa
                    asl a
                    asl a
                    asl a
                    sta $8a
.L65b5               ldy $8a
                    dey
.L65b8               lda ($8e),y
                    eor ($8c),y
                    sta ($8e),y
                    dey
                    bpl L65b8
                    lda $8c
                    adc $8a
                    sta $8c
                    lda $8d
                    adc #$00
                    sta $8d
                    inc $8f
                    dec $8b
                    bne L65b5
                    rts
                    
.S65d4               ldy #$0f
.L65d6               lda ($8e),y
                    eor ($8c),y
                    sta ($8e),y
                    dey
                    bpl L65d6
                    rts
                    
.S65e0               stx $6b
                    sty $6c
                    lsr $6c
                    ror $6b
                    lsr $6c
                    ror $6b
                    lsr $6c
                    ror $6b
                    lda $6c
                    and #$03
                    ora #$04
                    sta $6c
                    tay
                    ldx $6b
                    rts
                    
                                                        00 00 00 00 
                    10 30 50 d0 e0 e0 f0 f0 f0 80 80 e0 e0 c0 40 70 
                    c0 c0 91 91 91 91 c0 c0 00 00 ff 33 77 ff 00 00 
                    00 00 ff ff ff ff 00 00 00 00 ff ff ff ff 00 00 
                    00 00 ee aa 22 ee 00 00 00 00 ff 99 bb ff 00 00 
                    00 00 ff ff ff ff 00 00 00 00 ff ff ff ff 00 00 
                    00 00 ff ee cc ff 00 00 00 00 bb aa aa bb 00 00 
                    00 00 ff 77 ff ff 00 00 00 00 ff ff ff ff 00 30 
                    00 00 ff ff ff ff 00 40 00 00 ee aa 22 ee 00 00 
                    00 00 ff 99 bb ff 00 00 00 00 ff ff ff ff 00 00 
                    00 00 ff ff ff ff 00 00 00 00 ff ee cc ff 00 00 
                    00 00 bb aa aa bb 00 00 00 00 ff 77 ff ff 00 00 
                    00 00 ff ff ff ff 00 00 00 00 ff ff ff ff 00 00 
                    00 00 ee aa 22 ee 00 00 00 00 ff 99 bb ff 00 00 
                    00 00 ff ff ff ff 00 00 00 00 ff ff ff ff 00 00 
                    00 00 ff ee cc ff 00 00 30 30 98 98 98 98 30 00 
                    f0 10 10 70 70 30 20 e0 80 c0 a0 b0 70 70 f0 f0 
                    b0 b0 a0 a0 80 80 f0 80 80 80 83 83 83 83 83 83 
                    00 07 0f 0f 0f 08 0b 0a 00 0f 0f 0f 0f 00 0f 00 
                    00 0f 0f 0f 0f 00 0f 00 00 0f 0f 0f 0f 00 0f 00 
                    00 0f 0f 0f 0f 00 0f 00 00 0f 0f 0f 0f 00 0f 00 
                    00 0f 0f 0f 0f 00 0f 00 00 0f 0f 0f 0f 00 0f 00 
                    00 0f 0f 0f 0f 00 0e 02 00 0a 0a 0a 0a 0a 0a 0a 
                    00 10 20 10 30 40 60 70 10 d0 f0 60 30 10 30 70 
                    00 00 00 80 80 c0 c0 c0 00 0b 0a 0a 0b 0b 0b 08 
                    00 0e 0a 0e 0a 0a 0e 00 00 00 00 00 00 00 00 00 
                    00 00 00 aa aa ee aa aa 00 00 00 ee 44 44 44 ee 
                    00 00 00 00 00 00 00 00 00 05 05 05 05 05 05 05 
                    00 66 55 66 55 66 00 00 00 55 55 55 55 22 00 00 
                    00 66 55 66 55 66 00 00 00 66 55 66 55 66 00 00 
                    00 44 44 44 44 66 00 00 00 cc 88 cc 88 cc 00 00 
                    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
                    10 10 14 14 14 14 14 14 d0 d0 50 50 10 10 f0 10 
                    80 77 77 55 55 77 77 77 83 03 07 07 07 07 07 07 
                    0a 0a 0a 0a 0a 0a 0a 0a 00 cc aa cc aa cc 00 00 
                    00 aa aa 66 22 cc 00 00 00 55 55 66 55 55 00 00 
                    00 33 22 33 22 22 00 00 00 33 aa 33 22 22 00 00 
                    00 22 aa 22 aa aa 00 00 00 55 99 99 99 55 00 00 
                    02 8a 02 8a 02 8a 02 02 0a 0a 0a 0a 0a 0a 0a 0a 
                    70 70 30 30 50 40 30 00 f0 d0 a0 b0 80 30 70 00 
                    c0 c0 80 00 80 80 00 00 08 0b 0b 08 0a 08 09 08 
                    00 06 06 08 0a 00 04 00 00 00 00 22 33 22 22 22 
                    00 00 00 aa aa aa aa 99 00 00 00 aa bb aa aa 22 
                    00 00 00 88 88 88 88 88 05 05 05 05 05 05 05 05 
                    00 00 00 00 00 00 00 00 33 22 33 22 33 00 00 00 
                    22 aa 22 aa 11 00 00 00 99 aa 99 88 33 00 00 00 
                    88 00 00 88 00 00 00 00 00 11 11 00 00 00 00 00 
                    00 22 55 22 55 22 00 00 00 77 11 11 22 22 00 00 
                    14 04 06 06 06 06 06 06 10 ee ee aa aa ee ee ee 
                    77 77 77 77 55 55 77 77 07 07 07 07 07 07 07 03 
                    0a 0b 08 08 0f 0f 0f 0f 00 0f 00 00 0f 0f 0e 0e 
                    00 0f 00 00 0f 0f 0f 0f 00 0f 00 00 0f 0f 03 02 
                    00 0f 00 00 0f 0f 0f 07 00 0f 00 00 0f 0f 0f 0f 
                    00 0f 00 00 0f 0f 0f 0f 00 0f 00 00 0f 0f 0d 0d 
                    02 0e 00 00 0f 0f 0f 0f 0a 0a 0a 0a 0a 0a 0a 0a 
                    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 00 00 00 00 08 08 09 0b 0a 08 08 08 
                    00 04 04 0e 0a 0a 02 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
                    00 00 00 00 00 00 00 00 05 05 04 04 05 05 05 05 
                    00 0f 00 00 0f 0f 0f 0f 00 0f 00 00 0f 00 07 0f 
                    00 0f 00 00 0f 07 07 07 00 0f 00 00 0f 0f 0f 0f 
                    00 0f 00 00 0f 0f 0f 0f 00 0f 00 00 0f 0e 0e 0e 
                    00 0f 00 00 0f 00 0e 0f 00 0f 00 00 0f 0f 0f 0f 
                    06 06 06 06 0e 0e 0e 0c ee ee ee ee aa aa ee ee 
                    80 80 f0 80 80 a0 a0 b0 83 83 83 83 83 80 80 70 
                    0f 0f 0f 0f 0f 03 01 c0 0e 0e 0e 0f 0f 0f 0f 00 
                    0f 0f 03 0f 0f 0f 0f 00 02 02 02 02 0f 0f 0f 00 
                    04 04 04 04 0f 0f 0f 00 0f 09 09 09 0f 0f 0f 00 
                    0f 0f 03 03 0f 0f 0f 00 0d 0d 01 0f 0f 0f 0f 00 
                    0f 0f 0f 0f 0f 0f 0f 00 0a 0a 0b 08 08 0f 0f 00 
                    00 00 0f 00 00 0f 0f 00 00 00 0f 00 00 0f 0f 00 
                    00 00 0e 00 00 0f 0f 00 08 08 0f 00 00 0f 0f 00 
                    00 00 0f 00 00 0f 0f 00 00 00 0f 00 00 0f 0f 00 
                    00 00 0f 00 00 0f 0f 00 00 00 0f 00 00 0f 0f 00 
                    00 00 0f 00 00 0f 0f 00 05 05 0d 01 01 0f 0f 00 
                    0f 0e 0c 0e 0e 0e 0f 00 07 03 01 03 03 03 0f 00 
                    07 07 07 02 0f 0f 0f 00 0f 0f 0f 09 0f 0f 0f 00 
                    0f 0f 0f 01 0f 0f 0f 00 0e 0e 0e 00 0f 0f 0f 00 
                    0c 0c 0c 08 0c 0e 0f 00 07 07 07 03 07 0c 08 30 
                    1c 1c 1c 1c 1c 10 10 e0 10 10 f0 10 10 50 50 d0 
                    b0 e0 e0 d0 50 30 10 00 40 c0 e0 e0 80 80 f0 00 
                    c0 91 91 91 91 c0 c0 00 00 ff 33 77 ff 00 00 00 
                    00 ff ff ff ff 00 00 00 00 ff ff ff ff 00 00 00 
                    00 ee aa 22 ee 00 00 00 00 ff 99 bb ff 00 00 00 
                    00 ff ff ff ff 00 00 00 00 ff ff ff ff 00 00 00 
                    00 ff ee cc ff 00 00 00 00 bb aa aa bb 00 00 00 
                    00 ff 77 ff ff 00 00 00 00 ff ff ff ff 00 00 00 
                    00 ff ff ff ff 00 00 00 00 ee aa 22 ee 00 00 00 
                    00 ff 99 bb ff 00 00 00 00 ff ff ff ff 00 00 00 
                    00 ff ff ff ff 00 00 00 00 ff ee cc ff 00 00 00 
                    00 bb aa aa bb 00 00 00 00 ff 77 ff ff 00 00 00 
                    00 ff ff ff ff 00 00 00 00 ff ff ff ff 00 00 00 
                    00 ee aa 22 ee 00 00 00 00 ff 99 bb ff 00 00 00 
                    00 ff ff ff ff 00 00 00 00 ff ff ff ff 00 00 00 
                    00 ff ee cc ff 00 00 00 30 98 98 98 98 30 30 00 
                    20 30 70 70 10 10 f0 00 d0 70 70 b0 a0 c0 80 00 
                    