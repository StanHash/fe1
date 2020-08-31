
FUNC_E3CE:
    /* E3CE AD 7A 04 */ lda wUnk047A
    /* E3D1 F0 14    */ beq @end

    /* E3D3 A9 87    */ lda #$87 ; 135
    /* E3D5 8D 00 02 */ sta wOamBuf
    /* E3D8 A9 F7    */ lda #$F7 ; does it matter?
    /* E3DA 8D 01 02 */ sta wOamBuf+1
    /* E3DD A9 23    */ lda #$23 ; pal 3, behind background
    /* E3DF 8D 02 02 */ sta wOamBuf+2
    /* E3E2 A9 E0    */ lda #$E0 ; 224
    /* E3E4 8D 03 02 */ sta wOamBuf+3

@end:
    /* E3E7 60       */ rts

FUNC_E3E8:
    /* E3E8 A2 02    */ ldx #2

@lop:
    /* E3EA BD A7 03 */ lda wUnk03A7, X
    /* E3ED F0 2E    */ beq @continue

    /* E3EF E0 01    */ cpx #1
    /* E3F1 D0 05    */ bne @LOC_E3F8

    /* E3F3 AD 5A 03 */ lda wUnk035A
    /* E3F6 D0 25    */ bne @continue

@LOC_E3F8:
    /* E3F8 BD AA 03 */ lda wUnk03AA, X
    /* E3FB F0 03    */ beq @LOC_E400

    /* E3FD 4C B7 E4 */ jmp CODE_E4B7

@LOC_E400:
    /* E400 20 26 E4 */ jsr SelectBank_E426

    /* E403 20 7B E4 */ jsr FUNC_E47B

    /* E406 BD 98 03 */ lda wUnk0398, X
    /* E409 85 36    */ sta zSpriteNum

    /* E40B 20 1D CA */ jsr PutSprite

    /* E40E 20 42 E4 */ jsr FUNC_E442

    /* E411 BD 84 04 */ lda wUnk0484, X
    /* E414 8D 00 B0 */ sta MMC4CHRLO1

    /* E417 AD DC 03 */ lda wUnk03DC
    /* E41A 9D 87 04 */ sta wUnk0487, X

@continue:
    /* E41D CA       */ dex
    /* E41E 10 CA    */ bpl @lop

    /* E420 A9 05    */ lda #$05
    /* E422 8D 00 A0 */ sta MMC4BANK

    /* E425 60       */ rts

SelectBank_E426:
    /* E426 BD 87 04 */ lda wUnk0487, X
    /* E429 8D DC 03 */ sta wUnk03DC

    /* E42C C9 0C    */ cmp #$0C
    /* E42E 90 0C    */ bcc @bank_1 ; blo

    /* E430 BD 87 04 */ lda wUnk0487, X
    /* E433 E9 0C    */ sbc #$0C
    /* E435 9D 87 04 */ sta wUnk0487, X

    /* E438 A9 00    */ lda #0

    /* E43A F0 02    */ beq +

@bank_1:
    /* E43C A9 01    */ lda #1

+:
    /* E43E 8D 00 A0 */ sta MMC4BANK
    /* E441 60       */ rts

FUNC_E442:
    /* E442 E0 02    */ cpx #2
    /* E444 F0 30    */ beq @end

    /* E446 8E 73 03 */ stx wUnk0373_2

    /* E449 8A       */ txa
    /* E44A 0A       */ asl A
    /* E44B AA       */ tax

    /* E44C BD 77 E4 */ lda DAT_E477.w, X
    /* E44F 85 00    */ sta zR00
    /* E451 BD 78 E4 */ lda DAT_E477.w+1, X
    /* E454 85 01    */ sta zR00+1

    /* E456 A0 00    */ ldy #0

    /* E458 A9 04    */ lda #4
    /* E45A 85 02    */ sta zR02

    /* E45C AE 73 03 */ ldx wUnk0373_2

@lop:
    /* E45F B1 00    */ lda (zR00), Y
    /* E461 30 0E    */ bmi @continue

    /* E463 85 36    */ sta zSpriteNum

    /* E465 8C 74 03 */ sty wUnk0374_2

    /* E468 20 7B E4 */ jsr FUNC_E47B
    /* E46B 20 1D CA */ jsr PutSprite

    /* E46E AC 74 03 */ ldy wUnk0374_2

@continue:
    /* E471 C8       */ iny
    /* E472 C6 02    */ dec zR02
    /* E474 D0 E9    */ bne @lop

@end:
    /* E476 60       */ rts

DAT_E477:
    .dw wUnk03D2
    .dw wUnk03D6

FUNC_E47B:
    /* E47B BD 87 04 */ lda wUnk0487, X
    /* E47E 85 3C    */ sta zSpriteGroup

    /* E480 BD 9B 03 */ lda wUnk039B, X
    /* E483 85 35    */ sta zSpriteX

    /* E485 BC 9E 03 */ ldy wUnk039E, X
    /* E488 88       */ dey
    /* E489 84 34    */ sty zSpriteY

    /* E48B BD A4 03 */ lda wUnk03A4, X
    /* E48E 85 38    */ sta zUnk38

    /* E490 BD A1 03 */ lda wUnk03A1, X

    /* E493 E0 01    */ cpx #1
    /* E495 D0 02    */ bne +

    /* E497 49 01    */ eor #1

+:
    /* E499 85 3B    */ sta zUnk3B

    /* E49B E0 02    */ cpx #2
    /* E49D D0 0B    */ bne +

    /* E49F A9 03    */ lda #$3
    /* E4A1 85 3A    */ sta zUnk3A

    /* E4A3 AD C2 03 */ lda wUnk03C2
    /* E4A6 85 39    */ sta zUnk39

    /* E4A8 10 0C    */ bpl @end

+:
    /* E4AA E0 01    */ cpx #1
    /* E4AC D0 08    */ bne @end

    /* E4AE A9 03    */ lda #$3
    /* E4B0 85 3A    */ sta zUnk3A

    /* E4B2 A9 01    */ lda #$1
    /* E4B4 85 39    */ sta zUnk39

@end:
    /* E4B6 60       */ rts

CODE_E4B7:
    /* E4B7 A5 21    */ lda zTransferEnable
    /* E4B9 D0 06    */ bne @LOC_E4C1

    /* E4BB A5 22    */ lda zUnk22
    /* E4BD D0 02    */ bne @LOC_E4C1

    /* E4BF F0 03    */ beq @LOC_E4C4

@LOC_E4C1:
    /* E4C1 4C 1D E4 */ jmp FUNC_E3E8@continue

@LOC_E4C4:
    /* E4C4 20 26 E4 */ jsr SelectBank_E426

    /* E4C7 BD 9B 03 */ lda wUnk039B, X
    /* E4CA 20 9B C3 */ jsr Lsr3
    /* E4CD 85 03    */ sta zR03 ; zR03 = X/8

    /* E4CF BD 9E 03 */ lda wUnk039E, X
    /* E4D2 20 9B C3 */ jsr Lsr3
    /* E4D5 85 02    */ sta zR02 ; zR02 = Y/8

    /* E4D7 20 95 C7 */ jsr FUNC_C795

    /* E4DA AD FA BF */ lda EVERYBANK_BFFA
    /* E4DD 85 08    */ sta zR08
    /* E4DF AD FB BF */ lda EVERYBANK_BFFA+1
    /* E4E2 85 09    */ sta zR08+1

    /* E4E4 8A       */ txa
    /* E4E5 0A       */ asl A
    /* E4E6 A8       */ tay

    /* E4E7 B9 FC BF */ lda EVERYBANK_BFFC, Y
    /* E4EA 85 0A    */ sta zR0A
    /* E4EC B9 FD BF */ lda EVERYBANK_BFFC+1, Y
    /* E4EF 85 0B    */ sta zR0A+1

    /* E4F1 BD 87 04 */ lda wUnk0487, X
    /* E4F4 0A       */ asl A
    /* E4F5 A8       */ tay

    /* E4F6 B1 0A    */ lda (zR0A), Y
    /* E4F8 85 02    */ sta zR02
    /* E4FA C8       */ iny
    /* E4FB B1 0A    */ lda (zR0A), Y
    /* E4FD 85 03    */ sta zR02+1

    /* E4FF BC 98 03 */ ldy wUnk0398, X
    /* E502 B1 02    */ lda (zR02), Y

    /* E504 0A       */ asl A
    /* E505 90 09    */ bcc +

    /* E507 48       */ pha

    /* E508 A5 09    */ lda zR08+1
    /* E50A 18       */ clc
    /* E50B 69 01    */ adc #1
    /* E50D 85 09    */ sta zR08+1

    /* E50F 68       */ pla

+:
    /* E510 A8       */ tay

    /* E511 B1 08    */ lda (zR08), Y
    /* E513 85 00    */ sta zR00
    /* E515 C8       */ iny
    /* E516 B1 08    */ lda (zR08), Y
    /* E518 85 01    */ sta zR00+1

    ; zR03 = total length of data
    /* E51A A0 00    */ ldy #0
    /* E51C B1 00    */ lda (zR00), Y
    /* E51E 85 03    */ sta zR03

    /* E520 E6 00    */ inc zR00
    /* E522 D0 02    */ bne +

    /* E524 E6 01    */ inc zR00+1

+:
@lop
    ; put lo ppu addr
    /* E526 B1 00    */ lda (zR00), Y
    /* E528 18       */ clc
    /* E529 65 04    */ adc zR04
    /* E52B 99 82 07 */ sta wTransferScr+1, Y

    /* E52E C8       */ iny
    /* E52F C6 03    */ dec zR03

    ; put hi ppu addr
    /* E531 B1 00    */ lda (zR00), Y
    /* E533 65 05    */ adc zR05
    /* E535 99 80 07 */ sta wTransferScr-1, Y

    /* E538 C8       */ iny
    /* E539 C6 03    */ dec zR03

    ; put transfer attributes
    /* E53B B1 00    */ lda (zR00), Y
    /* E53D 99 81 07 */ sta wTransferScr, Y

    ; zR02 = length of data
    /* E540 29 3F    */ and #$3F
    /* E542 85 02    */ sta zR02

    /* E544 C8       */ iny
    /* E545 C6 03    */ dec zR03

@lop_inner:
    /* E547 B1 00    */ lda (zR00), Y
    /* E549 99 81 07 */ sta wTransferScr, Y

    /* E54C C8       */ iny
    /* E54D C6 03    */ dec zR03

    /* E54F F0 06    */ beq @finish

    /* E551 C6 02    */ dec zR02
    /* E553 D0 F2    */ bne @lop_inner

    /* E555 F0 CF    */ beq @lop

@finish:
    /* E557 A9 00    */ lda #0
    /* E559 99 81 07 */ sta wTransferScr, Y

    /* E55C 9D A7 03 */ sta wUnk03A7, X

    /* E55F A9 01    */ lda #1
    /* E561 85 21    */ sta zTransferEnable

    /* E563 AD DC 03 */ lda wUnk03DC
    /* E566 9D 87 04 */ sta wUnk0487, X

    /* E569 4C 1D E4 */ jmp FUNC_E3E8@continue

FUNC_E56C:
    /* E56C 48       */ pha
    /* E56D 8A       */ txa
    /* E56E 48       */ pha
    /* E56F 98       */ tya
    /* E570 48       */ pha

    /* E571 A9 FF    */ lda #$FF
    /* E573 A0 3B    */ ldy #$3B

-:
    /* E575 99 E1 03 */ sta wUnk03E1, Y
    /* E578 88       */ dey
    /* E579 10 FA    */ bpl -

    /* E57B A2 00    */ ldx #0
    /* E57D A0 00    */ ldy #0

@lop:
    /* E57F B1 00    */ lda (zR00), Y

    /* E581 C9 EF    */ cmp #$EF
    /* E583 F0 16    */ beq @LOC_E59B

    /* E585 C9 1F    */ cmp #$1F
    /* E587 F0 04    */ beq @LOC_E58D

    /* E589 C9 0F    */ cmp #$0F
    /* E58B D0 07    */ bne @LOC_E594

@LOC_E58D:
    /* E58D CA       */ dex
    /* E58E 9D FF 03 */ sta wUnk03E1+30, X
    /* E591 E8       */ inx

    /* E592 10 04    */ bpl @continue

@LOC_E594:
    /* E594 9D E1 03 */ sta wUnk03E1, X
    /* E597 E8       */ inx

@continue:
    /* E598 C8       */ iny
    /* E599 10 E4    */ bpl @lop

@LOC_E59B:
    /* E59B A2 00    */ ldx #0

    /* E59D A9 03    */ lda #>wUnk03E1
    /* E59F 85 07    */ sta zR06+1
    /* E5A1 A9 E1    */ lda #<wUnk03E1
    /* E5A3 85 06    */ sta zR06

    /* E5A5 20 CF E5 */ jsr FUNC_E5CF

    /* E5A8 A9 03    */ lda #>(wUnk03E1+30)
    /* E5AA 85 07    */ sta zR06+1
    /* E5AC A9 FF    */ lda #<(wUnk03E1+30)
    /* E5AE 85 06    */ sta zR06

    /* E5B0 38       */ sec
    /* E5B1 A5 02    */ lda zR02
    /* E5B3 E9 20    */ sbc #<$0020
    /* E5B5 85 02    */ sta zR02
    /* E5B7 A5 03    */ lda zR02+1
    /* E5B9 E9 00    */ sbc #>$0020
    /* E5BB 85 03    */ sta zR02+1

    /* E5BD 20 CF E5 */ jsr FUNC_E5CF

    /* E5C0 A9 00    */ lda #0
    /* E5C2 9D 81 07 */ sta wTransferScr, X

    /* E5C5 A9 01    */ lda #1
    /* E5C7 85 21    */ sta zTransferEnable

    /* E5C9 68       */ pla
    /* E5CA A8       */ tay
    /* E5CB 68       */ pla
    /* E5CC AA       */ tax
    /* E5CD 68       */ pla

    /* E5CE 60       */ rts

FUNC_E5CF:
    ; put hi ppu addr
    /* E5CF A5 03    */ lda zR02+1
    /* E5D1 9D 81 07 */ sta wTransferScr, X

    /* E5D4 E8       */ inx

    ; put lo ppu addr
    /* E5D5 A5 02    */ lda zR02
    /* E5D7 9D 81 07 */ sta wTransferScr, X

    /* E5DA E8       */ inx

    ; put transfer attributes
    /* E5DB A5 04    */ lda zR04
    /* E5DD 9D 81 07 */ sta wTransferScr, X
    /* E5E0 85 05    */ sta zR05

    /* E5E2 E8       */ inx

    /* E5E3 A0 00    */ ldy #0

@lop:
    /* E5E5 B1 06    */ lda (zR06), Y
    /* E5E7 9D 81 07 */ sta wTransferScr, X

    /* E5EA C8       */ iny
    /* E5EB E8       */ inx

    /* E5EC C6 05    */ dec zR05
    /* E5EE D0 F5    */ bne @lop

    /* E5F0 60       */ rts
