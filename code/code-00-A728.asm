
FUNC_00_A728:
    /* A728 AD 25 04 */ lda wUnk0425
    /* A72B F0 4F    */ beq @end

    /* A72D A2 05    */ ldx #5

@lop:
    /* A72F DE 26 04 */ dec wUnk0426, X
    /* A732 D0 45    */ bne @continue

@LOC_A734:
    /* A734 BD 2C 04 */ lda wUnk042C, X
    /* A737 30 40    */ bmi @continue

    /* A739 0A       */ asl A
    /* A73A A8       */ tay

    /* A73B B9 7D A7 */ lda DATA_00_A77D.w, Y
    /* A73E 85 00    */ sta zR00
    /* A740 B9 7E A7 */ lda DATA_00_A77D.w+1, Y
    /* A743 85 01    */ sta zR00+1

    /* A745 B9 C3 A7 */ lda DATA_00_A7C3.w, Y
    /* A748 85 02    */ sta zR02
    /* A74A B9 C4 A7 */ lda DATA_00_A7C3.w+1, Y
    /* A74D 85 03    */ sta zR02+1

    /* A74F BC 32 04 */ ldy wUnk0432, X
    /* A752 B1 02    */ lda (zR02), Y

    /* A754 C9 FF    */ cmp #$FF
    /* A756 D0 08    */ bne +

    /* A758 9D 2C 04 */ sta wUnk042C, X
    /* A75B 9D 38 04 */ sta wUnk0438, X

    /* A75E F0 19    */ beq @continue

+:
    /* A760 C9 FE    */ cmp #$FE
    /* A762 D0 07    */ bne +

    /* A764 A9 00    */ lda #0
    /* A766 9D 32 04 */ sta wUnk0432, X

    /* A769 F0 C9    */ beq @LOC_A734

+:
    /* A76B 9D 26 04 */ sta wUnk0426, X
    /* A76E BC 32 04 */ ldy wUnk0432, X
    /* A771 B1 00    */ lda (zR00), Y
    /* A773 9D 38 04 */ sta wUnk0438, X
    /* A776 FE 32 04 */ inc wUnk0432, X

@continue:
    /* A779 CA       */ dex
    /* A77A 10 B3    */ bpl @lop

@end:
    /* A77C 60       */ rts

DATA_00_A77D:
    /* A77D ...      */ .db $09
    /* A77E ...      */ .db $A8, $22, $A8, $2A, $A8, $4E, $A8, $5B
    /* A786 ...      */ .db $A8, $6A, $A8, $83, $A8, $CC, $A8, $D5
    /* A78E ...      */ .db $A8, $06, $A9, $2A, $A9, $3D, $A9, $61
    /* A796 ...      */ .db $A9, $70, $A9, $A2, $A9, $70, $A9, $C3
    /* A79E ...      */ .db $A9, $04, $AA, $09, $AA, $1F, $AA, $26
    /* A7A6 ...      */ .db $AA, $8B, $AA, $9B, $AA, $A4, $AA, $92
    /* A7AE ...      */ .db $AA, $B5, $AA, $C6, $AA, $EF, $AA, $EF
    /* A7B6 ...      */ .db $AA, $18, $AB, $23, $AB, $2C, $AB, $99
    /* A7BE ...      */ .db $AB, $AC, $AB, $C3, $AB

DATA_00_A7C3:
    /* A7C3 ...      */ .db $15
    /* A7C4 ...      */ .db $A8, $37, $A8, $40, $A8, $54, $A8, $62
    /* A7CC ...      */ .db $A8, $76, $A8, $A7, $A8, $D0, $A8, $ED
    /* A7D4 ...      */ .db $A8, $A7, $A8, $33, $A9, $A7, $A8, $68
    /* A7DC ...      */ .db $A9, $80, $A9, $B2, $A9, $91, $A9, $E3
    /* A7E4 ...      */ .db $A9, $11, $AA, $16, $AA, $22, $AA, $58
    /* A7EC ...      */ .db $AA, $8E, $AA, $9F, $AA, $AC, $AA, $96
    /* A7F4 ...      */ .db $AA, $BD, $AA, $DA, $AA, $EF, $AA, $03
    /* A7FC ...      */ .db $AB, $1D, $AB, $27, $AB, $62, $AB, $A2
    /* A804 ...      */ .db $AB, $B7, $AB, $C5, $AB

    /* A809 ...      */ .db $08, $09, $0A
    /* A80C ...      */ .db $08, $09, $0A, $08, $09, $0A, $08, $09
    /* A814 ...      */ .db $0A, $05, $05, $05, $05, $05, $05, $05
    /* A81C ...      */ .db $05, $05, $05, $05, $05, $FF, $0B, $0C
    /* A824 ...      */ .db $0D, $0E, $0F, $10, $11, $1A, $0B, $0C
    /* A82C ...      */ .db $0D, $0E, $0F, $10, $11, $12, $13, $14
    /* A834 ...      */ .db $15, $16, $1A, $03, $03, $03, $03, $03
    /* A83C ...      */ .db $03, $03, $10, $FF, $03, $03, $03, $03
    /* A844 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* A84C ...      */ .db $10, $FF, $19, $18, $17, $0D, $0C, $0B
    /* A854 ...      */ .db $03, $03, $03, $03, $03, $03, $FF, $11
    /* A85C ...      */ .db $10, $0F, $0E, $0D, $0C, $0B, $03, $03
    /* A864 ...      */ .db $03, $03, $03, $03, $03, $FF, $16, $15
    /* A86C ...      */ .db $14, $13, $12, $11, $10, $0F, $0E, $0D
    /* A874 ...      */ .db $0C, $0B, $03, $03, $03, $03, $03, $03
    /* A87C ...      */ .db $03, $03, $03, $03, $03, $03, $FF, $1B
    /* A884 ...      */ .db $1C, $1D, $1B, $1C, $1D, $1B, $1C, $1D
    /* A88C ...      */ .db $1B, $1C, $1D, $1B, $1C, $1D, $1B, $1C
    /* A894 ...      */ .db $1D, $1B, $1C, $1D, $1B, $1C, $1D, $1B
    /* A89C ...      */ .db $1C, $1D, $1B, $1C, $1D, $1B, $1C, $1D
    /* A8A4 ...      */ .db $1B, $1C, $1D, $03, $03, $03, $03, $03
    /* A8AC ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* A8B4 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* A8BC ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* A8C4 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $FF
    /* A8CC ...      */ .db $1E, $1F, $20, $21, $06, $06, $06, $F8
    /* A8D4 ...      */ .db $FF, $22, $23, $24, $25, $26, $27, $28
    /* A8DC ...      */ .db $29, $2A, $2B, $2C, $2D, $22, $23, $24
    /* A8E4 ...      */ .db $25, $26, $27, $28, $29, $2A, $2B, $2C
    /* A8EC ...      */ .db $2D, $02, $01, $01, $02, $01, $01, $02
    /* A8F4 ...      */ .db $01, $01, $02, $01, $01, $02, $01, $01
    /* A8FC ...      */ .db $02, $01, $01, $02, $01, $01, $02, $01
    /* A904 ...      */ .db $01, $FF, $2E, $2F, $37, $2E, $2F, $37
    /* A90C ...      */ .db $2E, $2F, $37, $2E, $2F, $37, $2E, $2F
    /* A914 ...      */ .db $37, $2E, $2F, $37, $2E, $2F, $37, $2E
    /* A91C ...      */ .db $2F, $37, $2E, $2F, $37, $2E, $2F, $37
    /* A924 ...      */ .db $2E, $2F, $37, $2E, $2F, $37, $1A, $30
    /* A92C ...      */ .db $31, $32, $33, $34, $35, $36, $33, $40
    /* A934 ...      */ .db $07, $06, $06, $10, $03, $03, $03, $80
    /* A93C ...      */ .db $FF, $38, $39, $3A, $3B, $38, $39, $3A
    /* A944 ...      */ .db $3B, $38, $39, $3A, $3B, $38, $39, $3A
    /* A94C ...      */ .db $3B, $38, $39, $3A, $3B, $38, $39, $3A
    /* A954 ...      */ .db $3B, $38, $39, $3A, $3B, $38, $39, $3A
    /* A95C ...      */ .db $3B, $38, $39, $3A, $3B, $3C, $1A, $3D
    /* A964 ...      */ .db $3E, $3F, $40, $41, $01, $10, $01, $01
    /* A96C ...      */ .db $03, $02, $02, $FF, $42, $43, $44, $45
    /* A974 ...      */ .db $46, $47, $48, $49, $49, $48, $47, $46
    /* A97C ...      */ .db $45, $44, $43, $42, $01, $01, $01, $01
    /* A984 ...      */ .db $01, $01, $01, $10, $01, $01, $01, $01
    /* A98C ...      */ .db $01, $01, $01, $01, $FF, $01, $01, $01
    /* A994 ...      */ .db $01, $01, $01, $01, $0A, $01, $01, $01
    /* A99C ...      */ .db $01, $01, $01, $01, $01, $FF, $4A, $4B
    /* A9A4 ...      */ .db $4C, $4D, $4E, $4F, $1A, $50, $51, $52
    /* A9AC ...      */ .db $53, $1A, $54, $55, $56, $57, $01, $01
    /* A9B4 ...      */ .db $01, $01, $01, $01, $0A, $01, $01, $01
    /* A9BC ...      */ .db $01, $0A, $01, $01, $01, $01, $FF, $58
    /* A9C4 ...      */ .db $59, $58, $59, $5A, $5B, $5C, $5B, $5B
    /* A9CC ...      */ .db $5D, $5E, $5F, $60, $5F, $60
    /* A9D2 ...      */ .db $61, $58, $59, $5F, $60, $5F, $60
    /* A9D9 ...      */ .db $62, $63, $64, $63, $64, $65, $66, $67
    /* A9E1 ...      */ .db $66, $67, $02, $02, $02, $02, $04, $02
    /* A9E9 ...      */ .db $02, $02, $02, $04, $02, $02, $02, $02
    /* A9F1 ...      */ .db $02, $04, $02, $02, $02, $02, $02, $02
    /* A9F9 ...      */ .db $02, $01, $01, $01, $01, $02, $02, $02
    /* AA01 ...      */ .db $02, $02, $FE, $71, $1A, $71, $72, $73
    /* AA09 ...      */ .db $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
    /* AA11 ...      */ .db $04, $04, $05, $05, $05, $05, $05, $05
    /* AA19 ...      */ .db $05, $25, $05, $05, $05, $FF, $00, $01
    /* AA21 ...      */ .db $02, $03, $03, $03, $FE, $03, $04, $05
    /* AA29 ...      */ .db $06, $07, $06, $07, $06, $07, $06, $06
    /* AA31 ...      */ .db $07, $06, $07, $06, $07, $06, $08, $09
    /* AA39 ...      */ .db $0A, $0B, $0C, $0B, $0C, $0B, $0C, $0B
    /* AA41 ...      */ .db $0C, $0B, $0C, $0B, $0C, $0B, $0C, $0B
    /* AA49 ...      */ .db $0C, $0B, $0C, $0B, $0C, $0B, $0C, $0B
    /* AA51 ...      */ .db $0C, $0B, $0C, $0B, $0C, $0B, $0C, $08
    /* AA59 ...      */ .db $08, $03, $03, $03, $03, $03, $03, $03
    /* AA61 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* AA69 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* AA71 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* AA79 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* AA81 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* AA89 ...      */ .db $03, $FF, $0D, $0E, $0F, $05, $02, $05
    /* AA91 ...      */ .db $FE, $1B, $1C, $1D, $1E, $0D, $09, $07
    /* AA99 ...      */ .db $06, $FF, $10, $11, $12, $13, $07, $05
    /* AAA1 ...      */ .db $04, $0A, $FF, $14, $15, $16, $17, $18
    /* AAA9 ...      */ .db $19, $18, $1A, $05, $03, $07, $05, $05
    /* AAB1 ...      */ .db $05, $05, $05, $FE, $25, $26, $1F, $20
    /* AAB9 ...      */ .db $21, $22, $23, $24, $02, $02, $01, $01
    /* AAC1 ...      */ .db $01, $01, $02, $02, $FE, $27, $28, $29
    /* AAC9 ...      */ .db $2A, $2B, $2C, $2B, $2C, $2B, $2C, $2B
    /* AAD1 ...      */ .db $2C, $2B, $2C, $2B, $2C, $2B, $2C, $2B
    /* AAD9 ...      */ .db $2C, $03, $03, $03, $05, $02, $03, $03
    /* AAE1 ...      */ .db $03, $03, $03, $03, $03, $03, $03, $03
    /* AAE9 ...      */ .db $03, $03, $03, $03, $03, $FE, $36, $37
    /* AAF1 ...      */ .db $38, $39, $3A, $3B, $3C, $3A, $39, $3A
    /* AAF9 ...      */ .db $3D, $3E, $3F, $40, $3F, $40
    /* AAFF ...      */ .db $41, $38, $37, $36, $10, $08, $05, $40
    /* AB07 ...      */ .db $20, $0B, $0A, $06, $04, $50, $04, $06
    /* AB0F ...      */ .db $0A, $03, $02, $08, $10, $04, $05, $07
    /* AB17 ...      */ .db $FF, $42, $43, $44, $45, $46, $04, $04
    /* AB1F ...      */ .db $04, $04, $04, $FE, $47, $48, $49, $4A
    /* AB27 ...      */ .db $04, $04, $04, $04, $FE, $2D, $35, $2E
    /* AB2F ...      */ .db $35, $2D, $35, $2E, $35, $2D, $35, $2E
    /* AB37 ...      */ .db $35, $2D, $2E, $2D, $2E, $2D, $2E, $2D
    /* AB3F ...      */ .db $2E, $2D, $2E, $2D, $2E, $2D, $2E, $2D
    /* AB47 ...      */ .db $2E, $2D, $2E, $2D, $2E, $2D, $2E, $2D
    /* AB4F ...      */ .db $2E, $2D, $2E, $2D, $2E, $2D, $2E, $2D
    /* AB57 ...      */ .db $2E, $2D, $2E, $2D, $2E, $2F, $30, $31
    /* AB5F ...      */ .db $32, $33, $34, $04, $04, $04, $04, $04
    /* AB67 ...      */ .db $04, $04, $04, $04, $04, $04, $04, $04
    /* AB6F ...      */ .db $04, $04, $04, $04, $04, $04, $04, $04
    /* AB77 ...      */ .db $04, $04, $04, $04, $04, $04, $04, $04
    /* AB7F ...      */ .db $04, $04, $04, $04, $04, $04, $04, $04
    /* AB87 ...      */ .db $04, $04, $04, $04, $04, $04, $04, $04
    /* AB8F ...      */ .db $04, $04, $04, $07, $07, $07, $07, $07
    /* AB97 ...      */ .db $07, $FF, $4B, $4C, $4D, $4E, $53, $54
    /* AB9F ...      */ .db $55, $56, $35, $01, $03, $03, $01, $01
    /* ABA7 ...      */ .db $02, $03, $02, $04, $FE, $4B, $4C, $4F
    /* ABAF ...      */ .db $50, $51, $52, $4F, $50, $4C, $4D, $4E
    /* ABB7 ...      */ .db $01, $01, $01, $02, $02, $02, $02, $01
    /* ABBF ...      */ .db $01, $01, $01, $FE, $57, $58, $05, $05
    /* ABC7 ...      */ .db $FE
