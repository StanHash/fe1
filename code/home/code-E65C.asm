
    .include "include/global.inc"
    .include "include/variables.inc"

    .proc FUNC_E65C

    /* E65C AD CC 05 */ lda wUnk05CC
    /* E65F F0 0C    */ beq end

    /* E661 A9 01    */ lda #1
    /* E663 85 97    */ sta zUnk97

    ; discard return location
    /* E665 68       */ pla
    /* E666 68       */ pla

    /* E667 AD CC 05 */ lda wUnk05CC
    /* E66A 4C 84 E6 */ jmp FUNC_E684

end:
    /* E66D 60       */ rts

    .endproc ; FUNC_E65C

    .proc FUNC_E66E

    /* E66E AD CE 05 */ lda wUnk05CE
    /* E671 F0 10    */ beq end

    /* E673 8D CD 05 */ sta wUnk05CD
    /* E676 8D D3 05 */ sta wUnk05D3

    /* E679 A9 00    */ lda #0
    /* E67B 8D D4 05 */ sta wUnk05D4

    /* E67E A9 03    */ lda #3
    /* E680 8D CC 05 */ sta wUnk05CC

end:
    /* E683 60       */ rts

    .endproc ; FUNC_E66E

    .proc FUNC_E684

    /* E684 8D DE 05 */ sta wUnk05DE

    /* E687 A9 00    */ lda #$0
    /* E689 85 44    */ sta zFarFuncNum
    /* E68B A9 0B    */ lda #$B
    /* E68D 4C FA C9 */ jmp CallFarFunc

    .endproc ; FUNC_E684

    .proc FUNC_E690

    /* E690 8D E8 05 */ sta wUnk05E8
    /* E693 A9 01    */ lda #$1
    /* E695 85 44    */ sta zFarFuncNum
    /* E697 A9 0B    */ lda #$B
    /* E699 4C FA C9 */ jmp CallFarFunc

    .endproc ; FUNC_E690

    .proc FUNC_E69C

    /* E69C AD F2 77 */ lda sUnk77F2
    /* E69F F0 03    */ beq :+

    /* E6A1 8D 00 A0 */ sta MMC4BANK

:
    /* E6A4 B1 76    */ lda (zUnitLoadSrc), Y
    /* E6A6 8D 34 79 */ sta sUnk7934

    /* E6A9 A9 0A    */ lda #$A
    /* E6AB 8D 00 A0 */ sta MMC4BANK

    /* E6AE AD 34 79 */ lda sUnk7934
    /* E6B1 60       */ rts

    .endproc ; FUNC_E69C

    .proc FUNC_E6B2

    /* E6B2 AD F2 77 */ lda sUnk77F2
    /* E6B5 F0 06    */ beq :+

    /* E6B7 AD F2 77 */ lda sUnk77F2
    /* E6BA 8D 00 A0 */ sta MMC4BANK

:
    /* E6BD AD F4 77 */ lda sUnk77F4
    /* E6C0 29 0F    */ and #$F
    /* E6C2 0A       */ asl A
    /* E6C3 A8       */ tay

    /* E6C4 B9 E0 BF */ lda EVERYBANK_BFE0, Y
    /* E6C7 85 04    */ sta zR04
    /* E6C9 B9 E1 BF */ lda EVERYBANK_BFE0+1, Y
    /* E6CC 85 05    */ sta zR04+1

    /* E6CE AD F1 77 */ lda sUnk77F1
    /* E6D1 0A       */ asl A
    /* E6D2 90 02    */ bcc :+

    /* E6D4 E6 05    */ inc zR04+1

:
    /* E6D6 18       */ clc
    /* E6D7 65 04    */ adc zR04
    /* E6D9 85 04    */ sta zR04
    /* E6DB 90 02    */ bcc :+

    /* E6DD E6 05    */ inc zR04+1

:
    /* E6DF A0 00    */ ldy #0
    /* E6E1 B1 04    */ lda (zR04), Y

    /* E6E3 AE F0 77 */ ldx sUnk77F0

    /* E6E6 9D 12 78 */ sta sUnk7812, X

    /* E6E9 C8       */ iny

    /* E6EA B1 04    */ lda (zR04), Y
    /* E6EC 9D 14 78 */ sta sUnk7814, X

    /* E6EF A9 0A    */ lda #$A
    /* E6F1 8D 00 A0 */ sta MMC4BANK

    /* E6F4 60       */ rts

    .endproc ; FUNC_E6B2
