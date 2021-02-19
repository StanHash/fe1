
    .include "include/global.inc"
    .include "include/variables.inc"

    .proc FUNC_E6F5

    /* E6F5 20 3A E7 */ jsr FUNC_E73A

    /* E6F8 A9 FE    */ lda #$FE
    /* E6FA 9D 81 07 */ sta wTransferScr, X

    /* E6FD E8       */ inx

    /* E6FE A9 00    */ lda #0
    /* E700 9D 81 07 */ sta wTransferScr, X

    /* E703 E8       */ inx

    /* E704 8E 80 07 */ stx wTransferCnt

    /* E707 A9 01    */ lda #1
    /* E709 85 21    */ sta zTransferEnable

    /* E70B 60       */ rts

    .endproc ; FUNC_E6F5

    .proc FUNC_E70C

    /* E70C 20 3A E7 */ jsr FUNC_E73A

    /* E70F A5 63    */ lda zUnk63
    /* E711 20 A0 D4 */ jsr GetMapRowIn6A
    /* E714 A4 64    */ ldy zUnk64
    /* E716 B1 6A    */ lda (zUnk6A), Y

    /* E718 20 84 D4 */ jsr FUNC_D484

    /* E71B A9 06    */ lda #$6
    /* E71D 8D 00 A0 */ sta MMC4BANK

    /* E720 A0 00    */ ldy #0
    /* E722 B1 02    */ lda (zR02), Y

    /* E724 9D 81 07 */ sta wTransferScr, X

    /* E727 E8       */ inx

    /* E728 98       */ tya
    /* E729 9D 81 07 */ sta wTransferScr, X

    /* E72C E8       */ inx

    /* E72D 8E 80 07 */ stx wTransferCnt

    /* E730 A9 01    */ lda #1
    /* E732 85 21    */ sta zTransferEnable

    /* E734 A5 29    */ lda zBank29
    /* E736 8D 00 A0 */ sta MMC4BANK

    /* E739 60       */ rts

    .endproc ; FUNC_E70C

    .proc FUNC_E73A

    /* E73A A9 01    */ lda #1
    /* E73C 85 00    */ sta zR00 ; y = 1
    /* E73E 85 01    */ sta zR01 ; x = 1

    /* E740 20 17 C5 */ jsr GetScreenTilePPUAddr

    /* E743 AE 80 07 */ ldx wTransferCnt

    /* E746 A5 05    */ lda zR05
    /* E748 9D 81 07 */ sta wTransferScr, X

    /* E74B E8       */ inx

    /* E74C A5 04    */ lda zR04
    /* E74E 9D 81 07 */ sta wTransferScr, X

    /* E751 E8       */ inx

    /* E752 A9 01    */ lda #1
    /* E754 9D 81 07 */ sta wTransferScr, X

    /* E757 E8       */ inx

    /* E758 60       */ rts

    .endproc ; FUNC_E73A

    .proc PutFarSprite

    /* E759 85 42    */ sta zUnk42

    /* E75B AD C6 05 */ lda wUnk05C6
    /* E75E 30 0B    */ bmi no_force_bank

    /* E760 A5 29    */ lda zBank29
    /* E762 8D C7 05 */ sta wUnk05C7

    /* E765 AD C6 05 */ lda wUnk05C6
    /* E768 20 A6 C9 */ jsr SwapBank

no_force_bank:
    /* E76B AD C8 05 */ lda wUnk05C8
    /* E76E 0A       */ asl A
    /* E76F A8       */ tay

    /* E770 B9 D1 BF */ lda FarSpriteGroups+1, Y
    /* E773 85 43    */ sta zUnk42+1

    /* E775 A5 42    */ lda zUnk42
    /* E777 0A       */ asl A
    /* E778 90 02    */ bcc :+

    /* E77A E6 43    */ inc zUnk42+1

:
    /* E77C 18       */ clc
    /* E77D 79 D0 BF */ adc FarSpriteGroups, Y
    /* E780 85 42    */ sta zUnk42
    /* E782 90 02    */ bcc :+

    /* E784 E6 43    */ inc zUnk42+1

:
    /* E786 A0 00    */ ldy #0

    /* E788 B1 42    */ lda (zUnk42), Y
    /* E78A 85 06    */ sta zR06

    /* E78C C8       */ iny

    /* E78D B1 42    */ lda (zUnk42), Y
    /* E78F 85 07    */ sta zR06+1

    /* E791 88       */ dey

    /* E792 B1 06    */ lda (zR06), Y
    /* E794 85 42    */ sta zUnk42

    /* E796 C8       */ iny

    /* E797 B1 06    */ lda (zR06), Y
    /* E799 85 43    */ sta zUnk42+1

    /* E79B C8       */ iny

    /* E79C 84 13    */ sty zUnk13

    /* E79E A0 00    */ ldy #0

    /* E7A0 F0 5C    */ beq begin

lop:
    /* E7A2 B1 42    */ lda (zUnk42), Y
    /* E7A4 85 08    */ sta zR08

    /* E7A6 A5 3B    */ lda zUnk3B
    /* E7A8 F0 10    */ beq no_hflip

    ; flip sprite horizontally

    /* E7AA A5 08    */ lda zR08
    /* E7AC 48       */ pha

    /* E7AD 29 40    */ and #%01000000
    /* E7AF 49 40    */ eor #%01000000
    /* E7B1 85 08    */ sta zR08

    /* E7B3 68       */ pla
    /* E7B4 29 BF    */ and #%10111111
    /* E7B6 05 08    */ ora zR08
    /* E7B8 85 08    */ sta zR08

no_hflip:
    /* E7BA A5 08    */ lda zR08
    /* E7BC 05 39    */ ora zUnk39
    /* E7BE 05 38    */ ora zUnk38
    /* E7C0 9D 02 02 */ sta wOamBuf+2, X

    /* E7C3 C8       */ iny

    /* E7C4 B1 42    */ lda (zUnk42), Y

    /* E7C6 C8       */ iny

    /* E7C7 18       */ clc
    /* E7C8 65 34    */ adc zSpriteY
    /* E7CA 38       */ sec
    /* E7CB E9 01    */ sbc #1
    /* E7CD 9D 00 02 */ sta wOamBuf, X

    /* E7D0 84 12    */ sty zUnk12

    /* E7D2 A4 13    */ ldy zUnk13

    /* E7D4 B1 06    */ lda (zR06), Y
    /* E7D6 9D 01 02 */ sta wOamBuf+1, X

    /* E7D9 E6 13    */ inc zUnk13

    /* E7DB A4 12    */ ldy zUnk12

    /* E7DD B1 42    */ lda (zUnk42), Y

    /* E7DF C8       */ iny

    /* E7E0 48       */ pha

    /* E7E1 A5 3B    */ lda zUnk3B
    /* E7E3 F0 0A    */ beq no_x_hflip

    /* E7E5 68       */ pla

    /* E7E6 20 BA C5 */ jsr Neg
    /* E7E9 38       */ sec
    /* E7EA E9 08    */ sbc #8
    /* E7EC 4C F0 E7 */ jmp :+

no_x_hflip:
    /* E7EF 68       */ pla

:
    /* E7F0 18       */ clc
    /* E7F1 65 35    */ adc zSpriteX
    /* E7F3 9D 03 02 */ sta wOamBuf+3, X

    /* E7F6 A6 37    */ ldx zSpriteIt
    /* E7F8 E8       */ inx
    /* E7F9 E8       */ inx
    /* E7FA E8       */ inx
    /* E7FB E8       */ inx
    /* E7FC 86 37    */ stx zSpriteIt

begin:
    /* E7FE A6 37    */ ldx zSpriteIt

    /* E800 E0 FC    */ cpx #$FC
    /* E802 B0 08    */ bcs break ; bhs

    /* E804 B1 42    */ lda (zUnk42), Y
    /* E806 29 F0    */ and #$F0
    /* E808 C9 F0    */ cmp #$F0
    /* E80A D0 96    */ bne lop

break:
    /* E80C AD C6 05 */ lda wUnk05C6
    /* E80F 30 0B    */ bmi no_restore_bank

    /* E811 AD C7 05 */ lda wUnk05C7
    /* E814 20 A6 C9 */ jsr SwapBank

    /* E817 A9 FF    */ lda #$FF
    /* E819 8D C6 05 */ sta wUnk05C6

no_restore_bank:
    /* E81C A9 00    */ lda #0
    /* E81E 85 3B    */ sta zUnk3B
    /* E820 85 39    */ sta zUnk39
    /* E822 85 38    */ sta zUnk38
    /* E824 8D C8 05 */ sta wUnk05C8

    /* E827 60       */ rts

    .endproc ; PutFarSprite
