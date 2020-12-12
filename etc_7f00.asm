                    org $7f00
L7f00               jmp L7fb9
                    
.L7f03              
                    ; Write EVENTV with $7f6f
                    lda #$6f
                    sta $0220
                    lda #$7f
                    sta $0221

                    lda #$0e
                    ldx #$04
                    jsr $fff4

                    ; Write IRQ2V (unless already written)
                    sei
                    lda $0207 
                    bpl L7f2d  ; i.e. if not handled by ROM 

                    ; Copy original IRQ2V 
                    sta $7ffe
                    lda $0206
                    sta $7ffd
                    lda #$2f
                    sta $0206
                    lda #$7f
                    sta $0207
L7f2d               cli
                    rts
                    
.IRQ2V 
L7f2f               php
                    pha
                    txa
                    pha
                    tya
                    pha
                    lda $fe6d
                    and #$20
                    beq L7f49
                    ldx #$00
L7f3e               lda $110c,x
                    sta $fe21
                    inx
                    cpx #$10
                    bne L7f3e
L7f49               lda #$20
                    sta $fe6e
                    pla
                    tay
                    pla
                    tax
                    pla
                    plp
                    jmp ($7ffd)
                    
L7f57               lda $fe6b
                    and #$df
                    sta $fe6b
                    lda #$a0
                    sta $fe6e
                    lda #$00
                    sta $fe68
                    lda #$0f  ;<-- this is written from 'game_intro' in main
                    sta $fe69
                    rts
                    
L7f6f               php
                    cmp #$04
                    bne L7faf
                    pha
                    txa
                    pha
                    tya
                    pha

                    ; Palette
                    ldx #$00
L7f7b               lda $10fc,x
                    sta $fe21 ; SHEILA &21 
                    inx
                    cpx #$10
                    bne L7f7b

                    jsr L7f57
                    dec $23
                    lda $23
                    bne L7fa9
                    lda #$32
                    sta $23
                    sed
                    clc
                    lda $24
                    adc #$01
                    sta $24
                    cld
                    cmp #$60
                    bcc L7fa9
                    lda #$00
                    sta $24
                    sed
                    adc $25
                    sta $25
L7fa9               cld
                    pla
                    tay
                    pla
                    tax
                    pla
L7faf               plp
                    rts
                    
                    00 20 80 a0 00 10 40 50 
L7fb9               lda #$07
                    sta $8c
                    lda #$10
                    sta $8d
L7fc1               ldy $8c
                    ldx $90,y
                    tya
                    lsr a
                    ldy $8d
                    stx $8e
                    sta $8f
                    tax
                    lda $7fb1,x
                    clc
                    adc $8e
                    eor #$07
                    sta $8e
                    tya
                    asl $8f
                    asl $8f
                    clc
                    adc $8f
                    tay
                    ldx #$00
L7fe3               clc
                    lda $8e
                    adc $7fb5,x
                    sta $10fc,y
                    inx
                    iny
                    cpx #$04
                    bne L7fe3
                    lda $8d
                    eor #$10
                    sta $8d
                    dec $8c
                    bpl L7fc1
                    rts
                    
                    89 de 20 