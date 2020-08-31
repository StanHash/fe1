
FUNC_C04E:
    /* C04E 8A       */ txa
    /* C04F 48       */ pha

    /* C050 A2 0B    */ ldx #11

@lop:
    /* C052 A5 31    */ lda zUnk31
    /* C054 18       */ clc
    /* C055 69 05    */ adc #5
    /* C057 85 31    */ sta zUnk31

    /* C059 A5 32    */ lda zUnk32
    /* C05B 18       */ clc
    /* C05C 69 0D    */ adc #13
    /* C05E 85 32    */ sta zUnk32

    /* C060 CA       */ dex
    /* C061 D0 EF    */ bne @lop

    /* C063 68       */ pla
    /* C064 AA       */ tax

    /* C065 A5 31    */ lda zUnk31

    /* C067 60       */ rts

FUNC_C068:
    /* C068 85 00    */ sta zR00
    /* C06A 20 4E C0 */ jsr FUNC_C04E

    /* C06D 85 01    */ sta zR01
    /* C06F 20 C9 C6 */ jsr Rand_C6C9

    /* C072 A5 01    */ lda zR01
    /* C074 60       */ rts
