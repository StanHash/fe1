
LOC_9144:
    /* 9144 20 67 82 */ jsr GetPlayerUnitsIn9F

    /* 9147 4C 86 91 */ jmp LOC_9186

LOC_914A:
    /* 914A 20 DB 8F */ jsr LOC_8FDB

    /* 914D 4C 50 91 */ jmp LOC_9150

LOC_9150:
    /* 9150 98       */ tya
    /* 9151 48       */ pha
    /* 9152 8A       */ txa
    /* 9153 48       */ pha
    /* 9154 A2 00    */ ldx #0
    /* 9156 F0 06    */ beq @begin

@lop:
    /* 9158 E8       */ inx
    /* 9159 A0 1B    */ ldy #_sizeof_Unit
    /* 915B 20 83 C3 */ jsr IncR02ByY

@begin:
    /* 915E A0 00    */ ldy #Unit.pid
    /* 9160 B1 02    */ lda (zR02), Y
    /* 9162 C9 00    */ cmp #0
    /* 9164 F0 1B    */ beq @end

    /* 9166 A0 12    */ ldy #Unit.unk_12
    /* 9168 B1 02    */ lda (zR02), Y
    /* 916A C9 FF    */ cmp #$FF
    /* 916C F0 EA    */ beq @lop

    /* 916E A0 10    */ ldy #Unit.y
    /* 9170 B1 02    */ lda (zR02), Y
    /* 9172 C5 B3    */ cmp zUnkB3
    /* 9174 D0 E2    */ bne @lop

    /* 9176 A0 11    */ ldy #Unit.x
    /* 9178 B1 02    */ lda (zR02), Y
    /* 917A C5 B2    */ cmp zUnkB2
    /* 917C D0 DA    */ bne @lop

    /* 917E 18       */ clc
    /* 917F 86 AE    */ stx zUnkAE

@end:
    /* 9181 68       */ pla
    /* 9182 AA       */ tax
    /* 9183 68       */ pla
    /* 9184 A8       */ tay
    /* 9185 60       */ rts

LOC_9186:
    /* 9186 98       */ tya
    /* 9187 48       */ pha
    /* 9188 8A       */ txa
    /* 9189 48       */ pha
    /* 918A A2 00    */ ldx #0
    /* 918C F0 06    */ beq @begin

@lop:
    /* 918E E8       */ inx
    /* 918F A9 1B    */ lda #_sizeof_Unit
    /* 9191 20 BC 91 */ jsr @add_to_9F

@begin:
    /* 9194 A0 00    */ ldy #Unit.pid
    /* 9196 B1 9F    */ lda (zUnk9F), Y
    /* 9198 C9 00    */ cmp #0
    /* 919A F0 19    */ beq @end

    /* 919C A0 12    */ ldy #Unit.unk_12
    /* 919E B1 9F    */ lda (zUnk9F), Y
    /* 91A0 C9 FF    */ cmp #$FF
    /* 91A2 F0 EA    */ beq @lop

    /* 91A4 A0 10    */ ldy #Unit.y
    /* 91A6 B1 9F    */ lda (zUnk9F), Y
    /* 91A8 C5 B3    */ cmp zUnkB3
    /* 91AA D0 E2    */ bne @lop

    /* 91AC A0 11    */ ldy #Unit.x
    /* 91AE B1 9F    */ lda (zUnk9F), Y
    /* 91B0 C5 B2    */ cmp zUnkB2
    /* 91B2 D0 DA    */ bne @lop

    /* 91B4 18       */ clc

@end:
    /* 91B5 86 AE    */ stx zUnkAE
    /* 91B7 68       */ pla
    /* 91B8 AA       */ tax
    /* 91B9 68       */ pla
    /* 91BA A8       */ tay
    /* 91BB 60       */ rts

@add_to_9F:
    /* 91BC 18       */ clc
    /* 91BD 65 9F    */ adc zUnk9F
    /* 91BF 85 9F    */ sta zUnk9F
    /* 91C1 90 02    */ bcc +

    /* 91C3 E6 A0    */ inc zUnk9F+1

+:
    /* 91C5 60       */ rts
