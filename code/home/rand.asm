
    .include "include/variables.inc"
    .include "include/global.inc"

    .proc Rand

    /* C04E 8A       */ txa
    /* C04F 48       */ pha

    /* C050 A2 0B    */ ldx #11

lop:
    /* C052 A5 31    */ lda zRngA
    /* C054 18       */ clc
    /* C055 69 05    */ adc #5
    /* C057 85 31    */ sta zRngA

    /* C059 A5 32    */ lda zRngB
    /* C05B 18       */ clc
    /* C05C 69 0D    */ adc #13
    /* C05E 85 32    */ sta zRngB

    /* C060 CA       */ dex
    /* C061 D0 EF    */ bne lop

    /* C063 68       */ pla
    /* C064 AA       */ tax

    /* C065 A5 31    */ lda zRngA

    /* C067 60       */ rts

    .endproc ; Rand

    .proc RandBounded

    ; Input: A = upper bound
    ; Output: A = random number from 0 to upper bound

    /* C068 85 00    */ sta zR00

    /* C06A 20 4E C0 */ jsr Rand
    /* C06D 85 01    */ sta zR01

    /* C06F 20 C9 C6 */ jsr Mul

    /* C072 A5 01    */ lda zR01

    ; A = (Input * Rand8) / 256

    /* C074 60       */ rts

    .endproc ; RandBounded
