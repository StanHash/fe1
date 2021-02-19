
    .include "include/variables.inc"
    .include "include/global.inc"

    .proc FUNC_D358

    /* D358 A5 00    */ lda zR00

    /* D35A 38       */ sec
    /* D35B E9 20    */ sbc #$20

    /* D35D 85 00    */ sta zR00
    /* D35F B0 02    */ bcs LOC_D363

    /* D361 C6 01    */ dec zR00+1

LOC_D363:
    /* D363 A5 01    */ lda zR00+1

    /* D365 C9 20    */ cmp #$20
    /* D367 90 0E    */ bcc LOC_D377

    /* D369 C9 24    */ cmp #$24
    /* D36B B0 17    */ bcs LOC_D384

    /* D36D C9 23    */ cmp #$23
    /* D36F 90 13    */ bcc LOC_D384

    /* D371 A5 00    */ lda zR00
    /* D373 C9 C0    */ cmp #$C0
    /* D375 90 0D    */ bcc LOC_D384

LOC_D377:
    /* D377 18       */ clc
    /* D378 A5 00    */ lda zR00
    /* D37A 69 C0    */ adc #$C0
    /* D37C 85 00    */ sta zR00
    /* D37E A5 01    */ lda zR00+1
    /* D380 69 03    */ adc #$03
    /* D382 85 01    */ sta zR00+1

LOC_D384:
    /* D384 60       */ rts

    .endproc ; FUNC_D358

    .proc UnpackMap

    .assert DATA_02_8000 = DATA_09_8000, error, "DATA_02_8000 and DATA_09_8000 must be mapped to the same address"

    /* D385 A5 51    */ lda zBank51
    /* D387 85 08    */ sta zR08

    /* D389 A0 02    */ ldy #2
    /* D38B AD 74 76 */ lda sMapNum
    /* D38E C9 0E    */ cmp #$0E
    /* D390 90 04    */ bcc :+

    /* D392 E9 0D    */ sbc #$0D
    /* D394 A0 09    */ ldy #9

:
    /* D396 84 01    */ sty zR01 ; map bank
    /* D398 85 00    */ sta zR00 ; map number

    /* D39A A5 01    */ lda zR01
    /* D39C 20 A6 C9 */ jsr SwapBank

    /* D39F A4 00    */ ldy zR00
    /* D3A1 88       */ dey
    /* D3A2 98       */ tya
    /* D3A3 0A       */ asl A
    /* D3A4 A8       */ tay

    /* D3A5 B9 00 80 */ lda DATA_02_8000, Y
    /* D3A8 85 68    */ sta zUnk68
    /* D3AA B9 01 80 */ lda DATA_02_8000+1, Y
    /* D3AD 85 69    */ sta zUnk68+1

    /* D3AF A9 AF    */ lda #<sMapCell
    /* D3B1 85 6A    */ sta zUnk6A
    /* D3B3 A9 72    */ lda #>sMapCell
    /* D3B5 85 6B    */ sta zUnk6A+1

    /* D3B7 A0 00    */ ldy #0
    /* D3B9 B1 68    */ lda (zUnk68), Y

    /* D3BB 8D 76 76 */ sta sMapHeight
    /* D3BE 85 7B    */ sta zUnk7B
    /* D3C0 E6 7B    */ inc zUnk7B

    /* D3C2 C8       */ iny

    /* D3C3 B1 68    */ lda (zUnk68), Y
    /* D3C5 8D 77 76 */ sta sMapWidth

    /* D3C8 C8       */ iny

    /* D3C9 B1 68    */ lda (zUnk68), Y
    /* D3CB 85 63    */ sta zUnk63

    /* D3CD C8       */ iny

    /* D3CE B1 68    */ lda (zUnk68), Y
    /* D3D0 85 64    */ sta zUnk64

    /* D3D2 C8       */ iny

    /* D3D3 20 F5 D3 */ jsr inc_scr_ptr

lop_y:
    /* D3D6 A0 00    */ ldy #0

lop_x:
    /* D3D8 B1 68    */ lda (zUnk68), Y
    /* D3DA 91 6A    */ sta (zUnk6A), Y
    /* D3DC C8       */ iny
    /* D3DD CC 77 76 */ cpy sMapWidth
    /* D3E0 90 F6    */ bcc lop_x

    /* D3E2 F0 F4    */ beq lop_x

    /* D3E4 20 F5 D3 */ jsr inc_scr_ptr

    /* D3E7 A0 20    */ ldy #$20
    /* D3E9 20 00 D4 */ jsr inc_dst_ptr

    /* D3EC C6 7B    */ dec zUnk7B
    /* D3EE D0 E6    */ bne lop_y

    /* D3F0 A5 08    */ lda zR08
    /* D3F2 4C A6 C9 */ jmp SwapBank

inc_scr_ptr:
    /* D3F5 98       */ tya
    /* D3F6 18       */ clc
    /* D3F7 65 68    */ adc zUnk68
    /* D3F9 85 68    */ sta zUnk68
    /* D3FB 90 02    */ bcc :+

    /* D3FD E6 69    */ inc zUnk68+1

:
    /* D3FF 60       */ rts

inc_dst_ptr:
    /* D400 98       */ tya
    /* D401 18       */ clc
    /* D402 65 6A    */ adc zUnk6A
    /* D404 85 6A    */ sta zUnk6A
    /* D406 90 02    */ bcc :+

    /* D408 E6 6B    */ inc zUnk6A+1

:
    /* D40A 60       */ rts

    /* D40B 84 0A    */ sty zR0A
    /* D40D 38       */ sec
    /* D40E A5 68    */ lda zUnk68
    /* D410 E5 0A    */ sbc zR0A
    /* D412 85 68    */ sta zUnk68
    /* D414 B0 02    */ bcs :+

    /* D416 C6 69    */ dec zUnk68+1

:
    /* D418 60       */ rts

    .endproc ; UnpackMap

    .proc FUNC_D419

    ; Input: A = Row number, zR04 = nt0 ppu address?

    /* D419 20 A0 D4 */ jsr GetMapRowIn6A

    /* D41C A9 00    */ lda #0
    /* D41E 85 12    */ sta zUnk12
    /* D420 8D 01 03 */ sta wUnk0301_2

    ; nametable 0 : cells 0-15

    /* D423 20 44 D4 */ jsr FUNC_D444

    /* D426 20 57 D4 */ jsr FUNC_D457

    /* D429 A5 05    */ lda zR05
    /* D42B 09 04    */ ora #%00000100
    /* D42D 85 05    */ sta zR05

    ; nametable 1 : cells 16-31

    /* D42F 20 44 D4 */ jsr FUNC_D444

    /* D432 20 57 D4 */ jsr FUNC_D457

    /* D435 A5 05    */ lda zR05
    /* D437 29 FB    */ and #%11111011
    /* D439 85 05    */ sta zR05

    ; terminate with 0?

    /* D43B AE 01 03 */ ldx wUnk0301_2

    /* D43E A9 00    */ lda #0
    /* D440 9D 02 03 */ sta wUnk0302_2, X

    /* D443 60       */ rts

    .endproc ; FUNC_D419

    .proc FUNC_D444

    /* D444 AE 01 03 */ ldx wUnk0301_2

    /* D447 A5 05    */ lda zR05
    /* D449 9D 02 03 */ sta wUnk0302_2, X

    /* D44C E8       */ inx

    /* D44D A5 04    */ lda zR04
    /* D44F 9D 02 03 */ sta wUnk0302_2, X

    /* D452 E8       */ inx

    /* D453 8E 01 03 */ stx wUnk0301_2

    /* D456 60       */ rts

    .endproc ; FUNC_D444

    .proc FUNC_D457

    /* D457 A9 10    */ lda #16
    /* D459 85 11    */ sta zUnk11

lop_cells:
    /* D45B A4 12    */ ldy zUnk12
    /* D45D B1 6A    */ lda (zUnk6A), Y

    /* D45F 20 69 D4 */ jsr FUNC_D469

    /* D462 E6 12    */ inc zUnk12

    /* D464 C6 11    */ dec zUnk11
    /* D466 D0 F3    */ bne lop_cells

    /* D468 60       */ rts

    .endproc ; FUNC_D457

    .proc FUNC_D469

    ; Input: A = Map Cell Value

    /* D469 20 84 D4 */ jsr FUNC_D484

    /* D46C AE 01 03 */ ldx wUnk0301_2

    /* D46F A5 13    */ lda zUnk13
    /* D471 0A       */ asl A
    /* D472 A8       */ tay

    /* D473 B1 02    */ lda (zR02), Y
    /* D475 9D 02 03 */ sta wUnk0302_2, X

    /* D478 C8       */ iny
    /* D479 E8       */ inx

    /* D47A B1 02    */ lda (zR02), Y
    /* D47C 9D 02 03 */ sta wUnk0302_2, X

    /* D47F E8       */ inx

    /* D480 8E 01 03 */ stx wUnk0301_2

    /* D483 60       */ rts

    .endproc ; FUNC_D469

    .proc FUNC_D484

    ; Input: A = Map Cell Value
    ; Output: zR02 = DATA_06_8000 + A*4

    ; zR02 = A*4
    /* D484 85 02    */ sta zR02
    /* D486 A9 00    */ lda #0
    /* D488 85 03    */ sta zR02+1
    /* D48A 06 02    */ asl zR02
    /* D48C 26 03    */ rol zR02+1
    /* D48E 06 02    */ asl zR02
    /* D490 26 03    */ rol zR02+1

    ; zR02 = DATA_06_8000 + A*4
    /* D492 18       */ clc
    /* D493 A9 00    */ lda #<DATA_06_8000
    /* D495 65 02    */ adc zR02
    /* D497 85 02    */ sta zR02
    /* D499 A9 80    */ lda #>DATA_06_8000
    /* D49B 65 03    */ adc zR02+1
    /* D49D 85 03    */ sta zR02+1

    /* D49F 60       */ rts

    .endproc ; FUNC_D484

    .proc GetMapRowIn6A

    ; Input: A = Row number
    ; Output: zUnk6A = Row pointer

    /* D4A0 0A       */ asl A
    /* D4A1 A8       */ tay

    /* D4A2 B9 3D ED */ lda MapCellRows, Y
    /* D4A5 85 6A    */ sta zUnk6A
    /* D4A7 B9 3E ED */ lda MapCellRows+1, Y
    /* D4AA 85 6B    */ sta zUnk6A+1

    /* D4AC 60       */ rts

    .endproc ; GetMapRowIn6A

    .proc FUNC_D4AD

    /* D4AD A5 89    */ lda zUnk89
    /* D4AF D0 05    */ bne LOC_D4B6

    /* D4B1 A5 8A    */ lda zUnk8A
    /* D4B3 D0 19    */ bne LOC_D4CE

    /* D4B5 60       */ rts

LOC_D4B6:
    /* D4B6 A9 02    */ lda #<wUnk0302_2
    /* D4B8 85 1C    */ sta zUnk1C
    /* D4BA A9 03    */ lda #>wUnk0302_2
    /* D4BC 85 1D    */ sta zUnk1C+1

    /* D4BE C6 89    */ dec zUnk89

    /* D4C0 A4 89    */ ldy zUnk89
    /* D4C2 B9 CC D4 */ lda DAT_D4CC, Y

    /* D4C5 A8       */ tay

    /* D4C6 A2 20    */ ldx #$20
    /* D4C8 4C E7 D4 */ jmp FUNC_D4E7

    /* D4CB 60       */ rts

DAT_D4CC:
    /* D4CC ...      */ .byte $20+2, $00

LOC_D4CE:
    /* D4CE A9 02    */ lda #<wUnk0302_2
    /* D4D0 85 1C    */ sta zUnk1C
    /* D4D2 A9 03    */ lda #>wUnk0302_2
    /* D4D4 85 1D    */ sta zUnk1C+1

    /* D4D6 A0 00    */ ldy #0

    /* D4D8 A2 08    */ ldx #8
    /* D4DA 20 E7 D4 */ jsr FUNC_D4E7

    /* D4DD A2 08    */ ldx #8
    /* D4DF 20 E7 D4 */ jsr FUNC_D4E7

    /* D4E2 A9 00    */ lda #0
    /* D4E4 85 8A    */ sta zUnk8A

    /* D4E6 60       */ rts

    .endproc ; FUNC_D4AD

    .proc FUNC_D4E7

    /* D4E7 AD 02 20 */ lda PPUSTATUS

    /* D4EA B1 1C    */ lda (zUnk1C), Y
    /* D4EC 8D 06 20 */ sta PPUADDR

    /* D4EF C8       */ iny

    /* D4F0 B1 1C    */ lda (zUnk1C), Y
    /* D4F2 8D 06 20 */ sta PPUADDR

    /* D4F5 C8       */ iny

    ; set ppu write increment to 1
    /* D4F6 A5 CD    */ lda zPPUCTRL
    /* D4F8 29 FB    */ and #$FB
    /* D4FA 8D 00 20 */ sta PPUCTRL
    /* D4FD 85 CD    */ sta zPPUCTRL

lop:
    /* D4FF B1 1C    */ lda (zUnk1C), Y
    /* D501 8D 07 20 */ sta PPUDATA

    /* D504 C8       */ iny

    /* D505 CA       */ dex
    /* D506 D0 F7    */ bne lop

    /* D508 4C 6A C3 */ jmp ApplyPPUScroll

    .endproc ; FUNC_D4E7

    .proc FUNC_D50B

    /* D50B 20 A0 D4 */ jsr GetMapRowIn6A

    /* D50E A9 00    */ lda #0
    /* D510 8D 01 03 */ sta wUnk0301_2
    /* D513 85 12    */ sta zUnk12

    /* D515 A9 20    */ lda #$20
    /* D517 85 13    */ sta zUnk13

    /* D519 20 58 D5 */ jsr FUNC_D558

    /* D51C 20 3A D5 */ jsr FUNC_D53A

    /* D51F A5 05    */ lda zR05
    /* D521 09 04    */ ora #%00000100
    /* D523 85 05    */ sta zR05

    /* D525 20 58 D5 */ jsr FUNC_D558

    /* D528 20 3A D5 */ jsr FUNC_D53A

    /* D52B A5 05    */ lda zR05
    /* D52D 29 FB    */ and #%11111011
    /* D52F 85 05    */ sta zR05

    /* D531 AC 01 03 */ ldy wUnk0301_2
    /* D534 A9 00    */ lda #0
    /* D536 99 02 03 */ sta wUnk0302_2, Y

    /* D539 60       */ rts

    .endproc ; FUNC_D50B

    .proc FUNC_D53A

    /* D53A A2 08    */ ldx #8

lop:
    /* D53C 20 6B D5 */ jsr FUNC_D56B

    /* D53F 20 6B D5 */ jsr FUNC_D56B

    /* D542 20 73 D5 */ jsr FUNC_D573

    /* D545 20 73 D5 */ jsr FUNC_D573

    /* D548 AC 01 03 */ ldy wUnk0301_2
    /* D54B A5 02    */ lda zR02
    /* D54D 99 02 03 */ sta wUnk0302_2, Y

    /* D550 C8       */ iny

    /* D551 8C 01 03 */ sty wUnk0301_2

    /* D554 CA       */ dex
    /* D555 D0 E5    */ bne lop

    /* D557 60       */ rts

    .endproc ; FUNC_D53A

    .proc FUNC_D558

    /* D558 AC 01 03 */ ldy wUnk0301_2

    /* D55B A5 05    */ lda zR05
    /* D55D 99 02 03 */ sta wUnk0302_2, Y

    /* D560 C8       */ iny

    /* D561 A5 04    */ lda zR04
    /* D563 99 02 03 */ sta wUnk0302_2, Y

    /* D566 C8       */ iny

    /* D567 8C 01 03 */ sty wUnk0301_2

    /* D56A 60       */ rts

    .endproc ; FUNC_D558

    .proc FUNC_D56B

    /* D56B A4 12    */ ldy zUnk12
    /* D56D 20 48 D6 */ jsr FUNC_D648

    /* D570 E6 12    */ inc zUnk12
    /* D572 60       */ rts

    .endproc ; FUNC_D56B

    .proc FUNC_D573

    /* D573 A4 13    */ ldy zUnk13
    /* D575 20 48 D6 */ jsr FUNC_D648

    /* D578 E6 13    */ inc zUnk13
    /* D57A 60       */ rts

    .endproc ; FUNC_D573

    .scope CODE_D57B

entry_D57B:
    /* D57B AD 00 03 */ lda wUnk0300_2
    /* D57E 20 A0 D4 */ jsr GetMapRowIn6A

    /* D581 A5 6A    */ lda zUnk6A
    /* D583 85 06    */ sta zR06
    /* D585 A5 6B    */ lda zUnk6A+1
    /* D587 85 07    */ sta zR06+1

    /* D589 AD 00 03 */ lda wUnk0300_2
    /* D58C 18       */ clc
    /* D58D 69 0E    */ adc #14
    /* D58F 20 A0 D4 */ jsr GetMapRowIn6A

    /* D592 4C E3 D5 */ jmp common

entry_D595:
    /* D595 AD 00 03 */ lda wUnk0300_2
    /* D598 18       */ clc
    /* D599 69 0E    */ adc #14
    /* D59B 20 A0 D4 */ jsr GetMapRowIn6A

    /* D59E A5 6A    */ lda zUnk6A
    /* D5A0 85 06    */ sta zR06
    /* D5A2 A5 6B    */ lda zUnk6A+1
    /* D5A4 85 07    */ sta zR06+1

    /* D5A6 AD 00 03 */ lda wUnk0300_2
    /* D5A9 18       */ clc
    /* D5AA 69 0D    */ adc #13
    /* D5AC 20 A0 D4 */ jsr GetMapRowIn6A

    /* D5AF 4C E3 D5 */ jmp common

entry_D5B2:
    /* D5B2 AD 00 03 */ lda wUnk0300_2
    /* D5B5 18       */ clc
    /* D5B6 69 01    */ adc #1
    /* D5B8 20 A0 D4 */ jsr GetMapRowIn6A

    /* D5BB A5 6A    */ lda zUnk6A
    /* D5BD 85 06    */ sta zR06
    /* D5BF A5 6B    */ lda zUnk6A+1
    /* D5C1 85 07    */ sta zR06+1

    /* D5C3 AD 00 03 */ lda wUnk0300_2
    /* D5C6 20 A0 D4 */ jsr GetMapRowIn6A

    /* D5C9 4C E3 D5 */ jmp common

entry_D5CC:
    /* D5CC AD 00 03 */ lda wUnk0300_2
    /* D5CF 20 A0 D4 */ jsr GetMapRowIn6A

    /* D5D2 A5 6A    */ lda zUnk6A
    /* D5D4 85 06    */ sta zR06
    /* D5D6 A5 6B    */ lda zUnk6A+1
    /* D5D8 85 07    */ sta zR06+1

    /* D5DA AD 00 03 */ lda wUnk0300_2
    /* D5DD 38       */ sec
    /* D5DE E9 01    */ sbc #1
    /* D5E0 20 A0 D4 */ jsr GetMapRowIn6A

common:
    /* D5E3 A0 00    */ ldy #0
    /* D5E5 8C 01 03 */ sty wUnk0301_2
    /* D5E8 84 12    */ sty zUnk12

    /* D5EA 20 35 D6 */ jsr FUNC_D635

    /* D5ED 20 03 D6 */ jsr FUNC_D603

    /* D5F0 A5 05    */ lda zR05
    /* D5F2 09 04    */ ora #$04
    /* D5F4 85 05    */ sta zR05

    /* D5F6 20 35 D6 */ jsr FUNC_D635

    /* D5F9 20 03 D6 */ jsr FUNC_D603

    /* D5FC A5 05    */ lda zR05
    /* D5FE 29 FB    */ and #$FB
    /* D600 85 05    */ sta zR05

    /* D602 60       */ rts

    .endscope ; CODE_D57B

    FUNC_D57B := CODE_D57B::entry_D57B
    FUNC_D595 := CODE_D57B::entry_D595
    FUNC_D5B2 := CODE_D57B::entry_D5B2
    FUNC_D5CC := CODE_D57B::entry_D5CC

    .proc FUNC_D603

    /* D603 A2 08    */ ldx #8

lop:
    /* D605 A4 12    */ ldy zUnk12
    /* D607 20 48 D6 */ jsr FUNC_D648

    /* D60A A4 12    */ ldy zUnk12
    /* D60C C8       */ iny
    /* D60D 20 48 D6 */ jsr FUNC_D648

    /* D610 A4 12    */ ldy zUnk12
    /* D612 B1 06    */ lda (zR06), Y
    /* D614 20 4A D6 */ jsr FUNC_D64A

    /* D617 A4 12    */ ldy zUnk12
    /* D619 C8       */ iny
    /* D61A B1 06    */ lda (zR06), Y
    /* D61C 20 4A D6 */ jsr FUNC_D64A

    /* D61F A4 12    */ ldy zUnk12
    /* D621 C8       */ iny
    /* D622 C8       */ iny
    /* D623 84 12    */ sty zUnk12

    /* D625 AC 01 03 */ ldy wUnk0301_2

    /* D628 A5 02    */ lda zR02
    /* D62A 99 02 03 */ sta wUnk0302_2, Y

    /* D62D C8       */ iny

    /* D62E 8C 01 03 */ sty wUnk0301_2

    /* D631 CA       */ dex
    /* D632 D0 D1    */ bne lop

    /* D634 60       */ rts

    .endproc ; FUNC_D603

    .proc FUNC_D635

    /* D635 AC 01 03 */ ldy wUnk0301_2

    /* D638 A5 05    */ lda zR05
    /* D63A 99 02 03 */ sta wUnk0302_2, Y

    /* D63D C8       */ iny

    /* D63E A5 04    */ lda zR04
    /* D640 99 02 03 */ sta wUnk0302_2, Y

    /* D643 C8       */ iny

    /* D644 8C 01 03 */ sty wUnk0301_2

    /* D647 60       */ rts

    .endproc ; FUNC_D635

    .scope CODE_D648

entry_D648:
    /* D648 B1 6A    */ lda (zUnk6A), Y

entry_D64A:
    /* D64A A8       */ tay
    /* D64B B9 BF F1 */ lda DAT_F1BF, Y

    /* D64E 29 03    */ and #$3

    /* D650 6A       */ ror A
    /* D651 66 02    */ ror zR02
    /* D653 6A       */ ror A
    /* D654 66 02    */ ror zR02

    /* D656 60       */ rts

    .endscope ; CODE_D648

    FUNC_D648 := CODE_D648::entry_D648
    FUNC_D64A := CODE_D648::entry_D64A
