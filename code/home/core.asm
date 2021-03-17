
    .proc MemCopy

    /* C209 A0 00    */ ldy #0
    /* C20B A6 04    */ ldx zR04
    /* C20D F0 02    */ beq lop

    /* C20F E6 05    */ inc zR04+1

lop:
    /* C211 B1 00    */ lda (zR00), Y
    /* C213 91 02    */ sta (zR02), Y
    /* C215 C8       */ iny
    /* C216 D0 04    */ bne :+

    /* C218 E6 01    */ inc zR00+1
    /* C21A E6 03    */ inc zR02+1

:
    /* C21C C6 04    */ dec zR04
    /* C21E D0 F1    */ bne lop

    /* C220 C6 05    */ dec zR04+1
    /* C222 D0 ED    */ bne lop

    /* C224 60       */ rts

    .endproc ; MemCopy

    .proc MemFill

    /* C225 A0 00    */ ldy #0
    /* C227 A6 02    */ ldx zR02
    /* C229 F0 02    */ beq lop

    /* C22B E6 03    */ inc zR02+1

lop:
    /* C22D 91 00    */ sta (zR00), Y
    /* C22F C8       */ iny
    /* C230 D0 02    */ bne :+

    /* C232 E6 01    */ inc zR00+1

:
    /* C234 C6 02    */ dec zR02
    /* C236 D0 F5    */ bne lop

    /* C238 C6 03    */ dec zR02+1
    /* C23A D0 F1    */ bne lop

    /* C23C 60       */ rts

    .endproc ; MemFill

    .proc ClearNameTables

    ; always clears nt 0
    ; if zUnk23 != 0 and zUnk25 = 0x1D; also clears nt 2
    ; else; clears nt 1

    /* C23D 20 52 C2 */ jsr clear_nt_0

    /* C240 A5 23    */ lda zUnk23
    /* C242 F0 06    */ beq clear_nt_1

    /* C244 A5 25    */ lda zUnk25
    /* C246 C9 1D    */ cmp #$1D
    /* C248 F0 04    */ beq clear_nt_2

clear_nt_1:
    /* C24A A9 02    */ lda #2
    /* C24C D0 06    */ bne clear_nt

clear_nt_2:
    /* C24E A9 03    */ lda #3
    /* C250 D0 02    */ bne clear_nt

clear_nt_0:
    /* C252 A9 01    */ lda #1

clear_nt:
    /* C254 85 01    */ sta zR01
    /* C256 A9 FF    */ lda #$FF
    /* C258 85 00    */ sta zR00
    /* C25A AE 02 20 */ ldx PPUSTATUS
    /* C25D A5 CD    */ lda zPPUCTRL
    /* C25F 29 FB    */ and #$FB
    /* C261 85 CD    */ sta zPPUCTRL
    /* C263 8D 00 20 */ sta PPUCTRL
    /* C266 A6 01    */ ldx zR01
    /* C268 CA       */ dex
    /* C269 BD 84 C2 */ lda ppu_nt_hiaddr_lut, X
    /* C26C 8D 06 20 */ sta PPUADDR
    /* C26F A9 00    */ lda #0
    /* C271 8D 06 20 */ sta PPUADDR
    /* C274 A2 04    */ ldx #$04
    /* C276 A0 00    */ ldy #$00
    /* C278 A5 00    */ lda zR00

lop:
    /* C27A 8D 07 20 */ sta PPUDATA
    /* C27D 88       */ dey
    /* C27E D0 FA    */ bne lop

    /* C280 CA       */ dex
    /* C281 D0 F7    */ bne lop

    /* C283 60       */ rts

ppu_nt_hiaddr_lut:
    .byte >PPU_NT0
    .byte >PPU_NT1
    .byte >PPU_NT2
    .byte >PPU_NT3

    .endproc ; ClearNameTables

    .proc ClearOamBuf

    /* C288 A0 00    */ ldy #0
    /* C28A A9 F4    */ lda #$F4

lop:
    /* C28C 99 00 02 */ sta wOamBuf, Y
    /* C28F C8       */ iny
    /* C290 C8       */ iny
    /* C291 C8       */ iny
    /* C292 C8       */ iny
    /* C293 D0 F7    */ bne lop

end:
    /* C295 60       */ rts

    .endproc ; ClearOamBuf

    .proc RunQueuedPPUTransfer

    ; do not call this function directly, it is called on VBlank
    ; instead, set zUnk22 to the id of the transfer, and wait for VBlank
    ; zUnk22 = 0      | no transfer
    ; zUnk22 positive | transfer from ROM script indexed in array at (EVERYBANK_BFC0)
    ; zUnk22 negative | transfer from script at wUnk04D8
    ; zUnk22 is set to 0 at the end of this function

    /* C296 A4 22    */ ldy zUnk22
    /* C298 F0 FB    */ beq ClearOamBuf::end

    /* C29A 30 30    */ bmi from_04D8

    /* C29C 88       */ dey
    /* C29D 98       */ tya
    /* C29E 0A       */ asl A
    /* C29F A8       */ tay
    /* C2A0 AD C0 BF */ lda EVERYBANK_BFC0
    /* C2A3 85 00    */ sta zR00
    /* C2A5 AD C1 BF */ lda EVERYBANK_BFC0+1
    /* C2A8 85 01    */ sta zR00+1
    /* C2AA B1 00    */ lda (zR00), Y
    /* C2AC AA       */ tax
    /* C2AD C8       */ iny
    /* C2AE B1 00    */ lda (zR00), Y
    /* C2B0 A8       */ tay

do_transfer:
    /* C2B1 A9 00    */ lda #0
    /* C2B3 85 22    */ sta zUnk22

    /* C2B5 20 D2 C2 */ jsr begin_transfer

    ; reset PPUADDR flip-flop
    /* C2B8 AD 02 20 */ lda PPUSTATUS

    ; set PPUADDR to $3F00 (background color)
    /* C2BB A9 3F    */ lda #$3F
    /* C2BD 8D 06 20 */ sta PPUADDR
    /* C2C0 A9 00    */ lda #$00
    /* C2C2 8D 06 20 */ sta PPUADDR

    ; don't do anything with it?

    ; set PPUADDR to $0000
    /* C2C5 8D 06 20 */ sta PPUADDR
    /* C2C8 8D 06 20 */ sta PPUADDR

    /* C2CB 60       */ rts

from_04D8:
    /* C2CC A2 D8    */ ldx #<wUnk04D8
    /* C2CE A0 04    */ ldy #>wUnk04D8

    /* C2D0 D0 DF    */ bne do_transfer

begin_transfer:
    /* C2D2 86 00    */ stx zR00
    /* C2D4 84 01    */ sty zR00+1
    /* C2D6 4C E7 C3 */ jmp BatchPPUTransfer

    .endproc ; RunQueuedPPUTransfer

    .proc UpdateInput

    /* C2D9 A0 01    */ ldy #1
    /* C2DB 8C 16 40 */ sty INPUT1
    /* C2DE 88       */ dey
    /* C2DF 8C 16 40 */ sty INPUT1
    /* C2E2 A0 08    */ ldy #8

lop:
    /* C2E4 48       */ pha
    /* C2E5 AD 16 40 */ lda INPUT1
    /* C2E8 85 1C    */ sta zUnk1C
    /* C2EA 4A       */ lsr A
    /* C2EB 05 1C    */ ora zUnk1C
    /* C2ED 4A       */ lsr A
    /* C2EE 68       */ pla
    /* C2EF 2A       */ rol A
    /* C2F0 88       */ dey
    /* C2F1 D0 F1    */ bne lop

    /* C2F3 CD F2 05 */ cmp wInputRaw
    /* C2F6 F0 08    */ beq no_fast_change

    /* C2F8 8D F2 05 */ sta wInputRaw
    /* C2FB A9 04    */ lda #4
    /* C2FD 8D F1 05 */ sta wInputDelayCnt

no_fast_change:
    /* C300 CE F1 05 */ dec wInputDelayCnt
    /* C303 D0 2A    */ bne no_new_input

    /* C305 A0 04    */ ldy #4
    /* C307 8C F1 05 */ sty wInputDelayCnt
    /* C30A A4 16    */ ldy zInputHeld
    /* C30C 84 1C    */ sty zUnk1C
    /* C30E 85 16    */ sta zInputHeld
    /* C310 45 1C    */ eor zUnk1C
    /* C312 F0 06    */ beq :+

    /* C314 25 16    */ and zInputHeld
    /* C316 85 14    */ sta zInputNew
    /* C318 85 18    */ sta zInputRepeat

:
    /* C31A A0 04    */ ldy #4
    /* C31C A5 16    */ lda zInputHeld
    /* C31E C5 1C    */ cmp zUnk1C
    /* C320 D0 0A    */ bne reset_repeat

    /* C322 C6 1A    */ dec zInputRepeatCnt
    /* C324 D0 08    */ bne end

    /* C326 A5 16    */ lda zInputHeld
    /* C328 85 18    */ sta zInputRepeat
    /* C32A A0 01    */ ldy #1

reset_repeat:
    /* C32C 84 1A    */ sty zInputRepeatCnt

end:
    /* C32E 60       */ rts

no_new_input:
    /* C32F A9 00    */ lda #0
    /* C331 85 14    */ sta zInputNew
    /* C333 85 18    */ sta zInputRepeat
    /* C335 60       */ rts

    .endproc ; UpdateInput

    .proc FUNC_C336

    /* C336 A2 01    */ ldx #1
    /* C338 C6 2C    */ dec zUnk2C
    /* C33A 10 06    */ bpl :+

    /* C33C A9 09    */ lda #9
    /* C33E 85 2C    */ sta zUnk2C
    /* C340 A2 02    */ ldx #2

:
lop:
    /* C342 B5 2D    */ lda zUnk2D, X
    /* C344 F0 02    */ beq :+

    /* C346 D6 2D    */ dec zUnk2D, X

:
    /* C348 CA       */ dex
    /* C349 10 F7    */ bpl lop

    /* C34B 60       */ rts

    .endproc ; FUNC_C336

    .proc Switch

    /* C34C 0A       */ asl A
    /* C34D 84 0F    */ sty zSwitchY
    /* C34F 86 0E    */ stx zSwitchX
    /* C351 A8       */ tay
    /* C352 C8       */ iny
    /* C353 68       */ pla
    /* C354 85 0C    */ sta zSwitchPtr
    /* C356 68       */ pla
    /* C357 85 0D    */ sta zSwitchPtr+1
    /* C359 B1 0C    */ lda (zSwitchPtr), Y
    /* C35B AA       */ tax
    /* C35C C8       */ iny
    /* C35D B1 0C    */ lda (zSwitchPtr), Y
    /* C35F 85 0D    */ sta zSwitchPtr+1
    /* C361 86 0C    */ stx zSwitchPtr
    /* C363 A6 0E    */ ldx zSwitchX
    /* C365 A4 0F    */ ldy zSwitchY
    /* C367 6C 0C 00 */ jmp (zSwitchPtr)

    .endproc ; Switch

    .proc ApplyPPUScroll

    /* C36A AD 02 20 */ lda PPUSTATUS
    /* C36D A5 CB    */ lda zPPUSCROLLH
    /* C36F 8D 05 20 */ sta PPUSCROLL
    /* C372 A5 CA    */ lda zPPUSCROLLV
    /* C374 8D 05 20 */ sta PPUSCROLL
    /* C377 60       */ rts

    .endproc ; ApplyPPUScroll

    .scope IncR00

by_y:
    /* C378 98       */ tya

by_a:
    /* C379 18       */ clc
    /* C37A 65 00    */ adc zR00
    /* C37C 85 00    */ sta zR00
    /* C37E 90 02    */ bcc :+

    /* C380 E6 01    */ inc zR00+1

:
    /* C382 60       */ rts

    .endscope ; IncR00

    IncR00ByY := IncR00::by_y
    IncR00ByA := IncR00::by_a

    .scope IncR02

by_y:
    /* C383 98       */ tya

by_a:
    /* C384 18       */ clc
    /* C385 65 02    */ adc zR02
    /* C387 85 02    */ sta zR02
    /* C389 90 02    */ bcc end

    /* C38B E6 03    */ inc zR02+1

end:
    /* C38D 60       */ rts

    .endscope ; IncR02

    IncR02ByY := IncR02::by_y
    IncR02ByA := IncR02::by_a

    .scope IncR04

by_y:
    /* C38E 98       */ tya

by_a:
    /* C38F 18       */ clc
    /* C390 65 04    */ adc zR04
    /* C392 85 04    */ sta zR04
    /* C394 90 F7    */ bcc IncR02::end

    /* C396 E6 05    */ inc zR04+1

    /* C398 60       */ rts

    .endscope

    IncR04ByY := IncR04::by_y
    IncR04ByA := IncR04::by_a

    .scope LsrLadder

lsr_5:
    /* C399 4A       */ lsr A

lsr_4:
    /* C39A 4A       */ lsr A

lsr_3:
    /* C39B 4A       */ lsr A
    /* C39C 4A       */ lsr A
    /* C39D 4A       */ lsr A

    /* C39E 60       */ rts

    .endscope ; LsrLadder

    Lsr5 := LsrLadder::lsr_5
    Lsr4 := LsrLadder::lsr_4
    Lsr3 := LsrLadder::lsr_3

    .scope AslLadder

asl_5:
    /* C39F 0A       */ asl A

asl_4:
    /* C3A0 0A       */ asl A

asl_3:
    /* C3A1 0A       */ asl A
    /* C3A2 0A       */ asl A
    /* C3A3 0A       */ asl A
    /* C3A4 60       */ rts

    .endscope ; AslLadder

    Asl5 := AslLadder::asl_5
    Asl4 := AslLadder::asl_4
    Asl3 := AslLadder::asl_3

    .proc RunPPUTransfer

    ; do not run this directly, it is called on VBlank
    ; runs the transfer script at wTransferScr if zTransferEnable is set
    ; clears the script when done

    /* C3A5 A5 21    */ lda zTransferEnable
    /* C3A7 F0 15    */ beq end

    /* C3A9 A9 81    */ lda #<wTransferScr
    /* C3AB 85 00    */ sta zR00
    /* C3AD A9 07    */ lda #>wTransferScr
    /* C3AF 85 01    */ sta zR00+1
    /* C3B1 20 E7 C3 */ jsr BatchPPUTransfer

    /* C3B4 A9 00    */ lda #0
    /* C3B6 8D 80 07 */ sta wTransferCnt
    /* C3B9 8D 81 07 */ sta wTransferScr
    /* C3BC 85 21    */ sta zTransferEnable

end:
    /* C3BE 60       */ rts

    .endproc ; RunPPUTransfer

    .scope BatchPPUTransfer

    ; batch ppu transfer:
    ; in zR00: ppu transfer scr addr

    ; script format:
    ; either:
    ;   [+00] : ppu addr (16bit, big endian!, msb not 0)
    ;   [+02] : config (bit 7 : H or V, bit 6 : fill or copy, bits 0-5: length)
    ;   [+xx] : data (only one byte if fill, else <length> bytes)
    ; or:
    ;   [+00] : 0 (terminator)
    ; repeated

lop:
    /* C3BF 8D 06 20 */ sta PPUADDR
    /* C3C2 C8       */ iny

    /* C3C3 B1 00    */ lda (zR00), Y
    /* C3C5 8D 06 20 */ sta PPUADDR

    /* C3C8 C8       */ iny

    /* C3C9 B1 00    */ lda (zR00), Y

    /* C3CB 0A       */ asl A
    /* C3CC 20 F3 C3 */ jsr SetTransferMode

    /* C3CF 0A       */ asl A

    /* C3D0 B1 00    */ lda (zR00), Y
    /* C3D2 29 3F    */ and #$3F
    /* C3D4 AA       */ tax

    /* C3D5 90 01    */ bcc lop_write

    /* C3D7 C8       */ iny

lop_write:
    /* C3D8 B0 01    */ bcs :+

    /* C3DA C8       */ iny

:
    /* C3DB B1 00    */ lda (zR00), Y
    /* C3DD 8D 07 20 */ sta PPUDATA
    /* C3E0 CA       */ dex
    /* C3E1 D0 F5    */ bne lop_write

    /* C3E3 C8       */ iny
    /* C3E4 20 78 C3 */ jsr IncR00ByY

entry:
    /* C3E7 AE 02 20 */ ldx PPUSTATUS
    /* C3EA A0 00    */ ldy #0
    /* C3EC B1 00    */ lda (zR00), Y
    /* C3EE D0 CF    */ bne lop

    /* C3F0 4C 6A C3 */ jmp ApplyPPUScroll

    .proc SetTransferMode

    /* C3F3 48       */ pha
    /* C3F4 A5 CD    */ lda zPPUCTRL
    /* C3F6 09 04    */ ora #$04
    /* C3F8 B0 02    */ bcs :+

    /* C3FA 29 FB    */ and #$FB

:
    /* C3FC 8D 00 20 */ sta PPUCTRL
    /* C3FF 85 CD    */ sta zPPUCTRL
    /* C401 68       */ pla
    /* C402 60       */ rts

    .endproc ; SetTransferMode

    .endscope ; BatchPPUTransfer

    BatchPPUTransfer := BatchPPUTransfer::entry

    ; UNUSED?
    /* C403 ...      */ .byte $FC, $F3, $CF, $3F

    /* C407 A5 04    */ lda zR04
    /* C409 4A       */ lsr A
    /* C40A 4A       */ lsr A
    /* C40B 29 07    */ and #$07
    /* C40D 85 00    */ sta zR00
    /* C40F A5 04    */ lda zR04
    /* C411 29 80    */ and #$80
    /* C413 20 9A C3 */ jsr Lsr4
    /* C416 85 01    */ sta zR01
    /* C418 C8       */ iny
    /* C419 A5 05    */ lda zR05
    /* C41B 29 03    */ and #$03
    /* C41D 20 A0 C3 */ jsr Asl4
    /* C420 05 00    */ ora zR00
    /* C422 05 01    */ ora zR01
    /* C424 09 C0    */ ora #$C0
    /* C426 85 72    */ sta zUnitPtr72
    /* C428 A5 05    */ lda zR05
    /* C42A 09 03    */ ora #$03
    /* C42C 85 73    */ sta zUnitPtr72+1
    /* C42E 60       */ rts

    .scope TransferCode

put_transfer_wtsa:
    /* C42F 86 00    */ stx zR00
    /* C431 84 01    */ sty zR00+1
    /* C433 A9 00    */ lda #<wUnk0700
    /* C435 85 02    */ sta zR02
    /* C437 A9 07    */ lda #>wUnk0700
    /* C439 85 03    */ sta zR02+1
    /* C43B A0 01    */ ldy #1
    /* C43D 84 21    */ sty zTransferEnable
    /* C43F 88       */ dey
    /* C440 B1 02    */ lda (zR02), Y
    /* C442 29 1F    */ and #$1F
    /* C444 85 05    */ sta zR05
    /* C446 B1 02    */ lda (zR02), Y
    /* C448 20 99 C3 */ jsr Lsr5
    /* C44B 85 04    */ sta zR04
    /* C44D AE 80 07 */ ldx wTransferCnt
    /* C450 4C 74 C4 */ jmp put_transfer_rect_core

put_transfer_rtsa:
    /* C453 86 00    */ stx zR00
    /* C455 84 01    */ sty zR00+1
    /* C457 A9 00    */ lda #<wUnk0700
    /* C459 85 02    */ sta zR02
    /* C45B A9 07    */ lda #>wUnk0700
    /* C45D 85 03    */ sta zR02+1
    /* C45F A0 01    */ ldy #1
    /* C461 84 21    */ sty zTransferEnable
    /* C463 88       */ dey
    /* C464 B1 02    */ lda (zR02), Y
    /* C466 29 0F    */ and #$0F
    /* C468 85 05    */ sta $05
    /* C46A B1 02    */ lda (zR02), Y
    /* C46C 20 9A C3 */ jsr Lsr4
    /* C46F 85 04    */ sta zR04
    /* C471 AE 80 07 */ ldx wTransferCnt

put_transfer_rect_core:
lop_y:
    /* C474 A5 01    */ lda zR00+1
    /* C476 20 A2 C4 */ jsr put_transfer_byte

    /* C479 A5 00    */ lda zR00
    /* C47B 20 A2 C4 */ jsr put_transfer_byte

    /* C47E A5 05    */ lda zR05
    /* C480 85 06    */ sta zR06
    /* C482 20 A2 C4 */ jsr put_transfer_byte

lop_x:
    /* C485 C8       */ iny
    /* C486 B1 02    */ lda (zR02), Y
    /* C488 20 A2 C4 */ jsr put_transfer_byte

    /* C48B C6 06    */ dec zR06
    /* C48D D0 F6    */ bne lop_x

    /* C48F 8E 80 07 */ stx wTransferCnt
    /* C492 84 06    */ sty zR06
    /* C494 A0 20    */ ldy #$20
    /* C496 20 78 C3 */ jsr IncR00ByY

    /* C499 A4 06    */ ldy zR06
    /* C49B C6 04    */ dec zR04
    /* C49D D0 D5    */ bne lop_y

    /* C49F 20 AD C4 */ jsr end_transfer

put_transfer_byte:
    /* C4A2 9D 81 07 */ sta wTransferScr, X

inc_transfer_cnt:
    /* C4A5 E8       */ inx
    /* C4A6 E0 5F    */ cpx #$5F
    /* C4A8 90 0A    */ bcc end

    /* C4AA AE 80 07 */ ldx wTransferCnt

end_transfer:
    /* C4AD A9 00    */ lda #0
    /* C4AF 9D 81 07 */ sta wTransferScr, X
    /* C4B2 68       */ pla
    /* C4B3 68       */ pla

end:
    /* C4B4 60       */ rts

    /* C4B5 86 00    */ stx zR00
    /* C4B7 84 01    */ sty zR00+1
    /* C4B9 A2 00    */ ldx #<wUnk0700
    /* C4BB 86 02    */ stx zR02
    /* C4BD A2 07    */ ldx #>wUnk0700
    /* C4BF 86 03    */ stx zR02+1
    /* C4C1 A0 01    */ ldy #1
    /* C4C3 84 21    */ sty zTransferEnable

    /* C4C5 88       */ dey ; ldy #0
    /* C4C6 F0 37    */ beq LOC_C4FF

LOC_C4C8:
    /* C4C8 85 04    */ sta zR04
    /* C4CA A5 01    */ lda zR01
    /* C4CC 20 A2 C4 */ jsr put_transfer_byte

    /* C4CF A5 00    */ lda zR00
    /* C4D1 20 A2 C4 */ jsr put_transfer_byte

    /* C4D4 A5 04    */ lda zR04
    /* C4D6 20 09 C5 */ jsr FUNC_C509

    /* C4D9 24 04    */ bit zR04
    /* C4DB 50 01    */ bvc LOC_C4DE

    /* C4DD C8       */ iny

LOC_C4DE:
    /* C4DE 24 04    */ bit zR04
    /* C4E0 70 01    */ bvs :+

    /* C4E2 C8       */ iny

:
    /* C4E3 B1 02    */ lda (zR02), Y
    /* C4E5 20 A2 C4 */ jsr put_transfer_byte

    /* C4E8 84 06    */ sty zR06
    /* C4EA A0 01    */ ldy #$01
    /* C4EC 24 04    */ bit zR04
    /* C4EE 10 02    */ bpl :+

    /* C4F0 A0 20    */ ldy #$20

:
    /* C4F2 20 78 C3 */ jsr IncR00ByY

    /* C4F5 A4 06    */ ldy zR06
    /* C4F7 C6 05    */ dec zR05
    /* C4F9 D0 E3    */ bne LOC_C4DE

    /* C4FB 8E 80 07 */ stx wTransferCnt
    /* C4FE C8       */ iny

LOC_C4FF:
    /* C4FF AE 80 07 */ ldx wTransferCnt
    /* C502 B1 02    */ lda (zR02), Y
    /* C504 D0 C2    */ bne LOC_C4C8

    /* C506 20 AD C4 */ jsr end_transfer

func_C509:
    /* C509 85 04    */ sta zR04

    /* C50B 29 BF    */ and #%10111111
    /* C50D 9D 81 07 */ sta wTransferScr, X

    /* C510 29 3F    */ and #%00111111
    /* C512 85 05    */ sta zR05

    /* C514 4C A5 C4 */ jmp inc_transfer_cnt

    .endscope ; TransferCode

    PutTransferWTsa := TransferCode::put_transfer_wtsa
    PutTransferRTsa := TransferCode::put_transfer_rtsa
    PutTransferByte := TransferCode::put_transfer_byte
    EndTransfer     := TransferCode::end_transfer
    FUNC_C509 := TransferCode::func_C509

    .proc GetScreenTilePPUAddr

    ; Input:
    ; - zR00 = Y tile offset
    ; - zR01 = X tile offset
    ; Output:
    ; - zR04 = ppu addr

    /* C517 8A       */ txa
    /* C518 48       */ pha
    /* C519 98       */ tya
    /* C51A 48       */ pha

    /* C51B A5 CD    */ lda zPPUCTRL
    /* C51D 4A       */ lsr A
    /* C51E 66 06    */ ror zR06
    /* C520 4A       */ lsr A
    /* C521 66 06    */ ror zR06

    /* C523 A5 CB    */ lda zPPUSCROLLH
    /* C525 18       */ clc
    /* C526 65 01    */ adc zR01

    /* C528 66 06    */ ror zR06
    /* C52A 20 9B C3 */ jsr Lsr3 ; /8
    /* C52D 85 04    */ sta zR04 ; zR04 = (HSCROLL+zR01)/8

    /* C52F 06 06    */ asl zR06
    /* C531 6A       */ ror A
    /* C532 6A       */ ror A
    /* C533 45 06    */ eor zR06
    /* C535 85 07    */ sta zR07

    /* C537 A0 20    */ ldy #>PPU_NT0

    /* C539 24 07    */ bit zR07
    /* C53B 50 02    */ bvc :+

    /* C53D A0 24    */ ldy #>PPU_NT1

:
    /* C53F 84 05    */ sty zR04+1

    /* C541 A5 CA    */ lda zPPUSCROLLV
    /* C543 18       */ clc
    /* C544 65 00    */ adc zR00
    /* C546 B0 02    */ bcs :+

    /* C548 C9 F0    */ cmp #240

:
    /* C54A 08       */ php
    /* C54B 66 06    */ ror zR06
    /* C54D 28       */ plp
    /* C54E 90 03    */ bcc :+

    /* C550 18       */ clc
    /* C551 69 10    */ adc #$10

:
    /* C553 20 9B C3 */ jsr Lsr3
    /* C556 AA       */ tax
    /* C557 06 06    */ asl zR06
    /* C559 6A       */ ror A
    /* C55A 45 06    */ eor zR06
    /* C55C 10 07    */ bpl :+

    ; NT0/NT1 -> NT2/NT3
    /* C55E A5 05    */ lda zR04+1
    /* C560 18       */ clc
    /* C561 69 08    */ adc #>$0800
    /* C563 85 05    */ sta zR04+1

:
    /* C565 8A       */ txa
    /* C566 F0 10    */ beq end

lop:
    ; zR04 += $0020
    /* C568 A5 04    */ lda zR04
    /* C56A 18       */ clc
    /* C56B 69 20    */ adc #<$0020
    /* C56D 85 04    */ sta zR04
    /* C56F A5 05    */ lda zR04+1
    /* C571 69 00    */ adc #>$0020
    /* C573 85 05    */ sta zR04+1

    /* C575 CA       */ dex
    /* C576 D0 F0    */ bne lop

end:
    /* C578 68       */ pla
    /* C579 A8       */ tay
    /* C57A 68       */ pla
    /* C57B AA       */ tax

    /* C57C 60       */ rts

    .endproc ; GetScreenTilePPUAddr

    .proc FUNC_C57D

    /* C57D AE 80 07 */ ldx wTransferCnt

    /* C580 A0 01    */ ldy #1
    /* C582 84 21    */ sty zTransferEnable

    /* C584 D0 29    */ bne LOC_C5AF

LOC_C586:
    /* C586 20 A2 C4 */ jsr PutTransferByte

    /* C589 C8       */ iny
    /* C58A B1 00    */ lda (zR00), Y
    /* C58C 20 A2 C4 */ jsr PutTransferByte

    /* C58F C8       */ iny
    /* C590 B1 00    */ lda (zR00), Y
    /* C592 20 09 C5 */ jsr FUNC_C509

    /* C595 24 04    */ bit zR04
    /* C597 50 01    */ bvc LOC_C59A

    /* C599 C8       */ iny

LOC_C59A:
    /* C59A 24 04    */ bit zR04
    /* C59C 70 01    */ bvs LOC_C59F

    /* C59E C8       */ iny

LOC_C59F:
    /* C59F B1 00    */ lda (zR00), Y
    /* C5A1 20 A2 C4 */ jsr PutTransferByte

    /* C5A4 C6 05    */ dec zR05
    /* C5A6 D0 F2    */ bne LOC_C59A

    /* C5A8 8E 80 07 */ stx wTransferCnt
    /* C5AB C8       */ iny
    /* C5AC 20 78 C3 */ jsr IncR00ByY

LOC_C5AF:
    /* C5AF A0 00    */ ldy #0
    /* C5B1 B1 00    */ lda (zR00), Y
    /* C5B3 D0 D1    */ bne LOC_C586

    /* C5B5 20 AD C4 */ jsr EndTransfer

    /* C5B8 10 05    */ bpl Neg_end

    .endproc ; FUNC_C57D

    ; we can't open new scope here as the `Neg_end` label needs to not be in a scope
    ; this is because is it referenced above in the FUNC_C57D function
    ; and ca65 doesn't like forward referencing scoped labels

    ; .proc Neg

Neg:
    /* C5BA 49 FF    */ eor #$FF
    /* C5BC 18       */ clc
    /* C5BD 69 01    */ adc #1

Neg_end:
    /* C5BF 60       */ rts

    ; .endproc ; Neg

    .proc SplitNibbles

    /* C5C0 48       */ pha

    ; Y = lo nibble
    /* C5C1 29 0F    */ and #$F
    /* C5C3 A8       */ tay

    /* C5C4 68       */ pla

    ; A = hi nibble
    /* C5C5 4C 9A C3 */ jmp Lsr4

    .endproc ; SplitNibbles

    .proc SplitByteDecDigits

    /* C5C8 A0 FF    */ ldy #<-1

:
    /* C5CA C8       */ iny
    /* C5CB 38       */ sec
    /* C5CC E9 64    */ sbc #100
    /* C5CE B0 FA    */ bcs :-

    /* C5D0 69 64    */ adc #100

    ; Y = A / 100
    ; A = A % 100

    /* C5D2 AA       */ tax
    /* C5D3 98       */ tya
    /* C5D4 48       */ pha
    /* C5D5 8A       */ txa

    /* C5D6 A2 FF    */ ldx #<-1

:
    /* C5D8 E8       */ inx
    /* C5D9 38       */ sec
    /* C5DA E9 0A    */ sbc #10
    /* C5DC B0 FA    */ bcs :-

    /* C5DE 69 0A    */ adc #10

    ; X = A / 10
    ; A = A % 10

    /* C5E0 A8       */ tay
    /* C5E1 68       */ pla

    ; A = A / 100 ; 3rd decimal digit
    ; X = A / 10  ; 2nd decimal digit
    ; Y = A % 10  ; 1st decimal digit

    /* C5E2 60       */ rts

    .endproc ; SplitByteDecDigits

    .proc SplitLongDecDigits

    ; Input:
    ; - R00:R02:R04 : 24bit number
    ; Output:
    ; - R00:R01:R02:R03:R04 : decimal digits

    /* C5E3 A2 FF    */ ldx #<-1

:
    /* C5E5 E8       */ inx

    /* C5E6 A5 00    */ lda zR00
    /* C5E8 85 01    */ sta zR01

    /* C5EA A5 02    */ lda zR02
    /* C5EC 85 03    */ sta zR03

    /* C5EE A5 04    */ lda zR04
    /* C5F0 85 05    */ sta zR05

    /* C5F2 A5 00    */ lda zR00
    /* C5F4 38       */ sec
    /* C5F5 E9 10    */ sbc #<10000
    /* C5F7 85 00    */ sta zR00
    /* C5F9 A5 02    */ lda zR02
    /* C5FB E9 27    */ sbc #>10000
    /* C5FD 85 02    */ sta zR02

    /* C5FF B0 E4    */ bcs :-

    /* C601 A5 04    */ lda zR04
    /* C603 E9 00    */ sbc #0
    /* C605 85 04    */ sta zR04

    /* C607 B0 DC    */ bcs :-

    /* C609 8A       */ txa
    /* C60A 48       */ pha

    /* C60B A5 01    */ lda zR01
    /* C60D 85 00    */ sta zR00

    /* C60F A5 03    */ lda zR03
    /* C611 85 02    */ sta zR02

    /* C613 A2 FF    */ ldx #<-1

:
    /* C615 E8       */ inx

    /* C616 A5 00    */ lda zR00
    /* C618 85 01    */ sta zR01

    /* C61A A5 02    */ lda zR02
    /* C61C 85 03    */ sta zR03

    /* C61E A5 00    */ lda zR00
    /* C620 38       */ sec
    /* C621 E9 E8    */ sbc #<1000
    /* C623 85 00    */ sta zR00
    /* C625 A5 02    */ lda zR02
    /* C627 E9 03    */ sbc #>1000
    /* C629 85 02    */ sta zR02

    /* C62B B0 E8    */ bcs :-

    /* C62D 8A       */ txa
    /* C62E 48       */ pha

    /* C62F A5 01    */ lda zR01
    /* C631 85 00    */ sta zR00
    /* C633 A5 03    */ lda zR03
    /* C635 85 02    */ sta zR02

    /* C637 A2 FF    */ ldx #$FF

:
    /* C639 E8       */ inx
    /* C63A A5 00    */ lda zR00
    /* C63C 85 01    */ sta zR01
    /* C63E A5 02    */ lda zR02
    /* C640 85 03    */ sta zR03

    /* C642 A5 00    */ lda zR00
    /* C644 38       */ sec
    /* C645 E9 64    */ sbc #<100
    /* C647 85 00    */ sta zR00
    /* C649 A5 02    */ lda zR02
    /* C64B E9 00    */ sbc #>100
    /* C64D 85 02    */ sta zR02

    /* C64F B0 E8    */ bcs :-

    /* C651 8A       */ txa
    /* C652 48       */ pha

    /* C653 A5 01    */ lda zR01
    /* C655 85 00    */ sta zR00

    /* C657 A2 FF    */ ldx #<-1

:
    /* C659 E8       */ inx

    /* C65A A5 00    */ lda zR00
    /* C65C 85 01    */ sta zR01

    /* C65E A5 00    */ lda zR00
    /* C660 38       */ sec
    /* C661 E9 0A    */ sbc #10
    /* C663 85 00    */ sta zR00

    /* C665 B0 F2    */ bcs :-

    /* C667 A5 01    */ lda zR01
    /* C669 85 00    */ sta zR00

    /* C66B 86 01    */ stx zR01
    /* C66D 68       */ pla
    /* C66E 85 02    */ sta zR02
    /* C670 68       */ pla
    /* C671 85 03    */ sta zR03
    /* C673 68       */ pla
    /* C674 85 04    */ sta zR04

    /* C676 60       */ rts

    .endproc ; SplitLongDecDigits

    .proc FUNC_C677

    /* C677 20 BA C6 */ jsr FUNC_C6BA

    /* C67A 65 01    */ adc zR01
    /* C67C C9 0A    */ cmp #10
    /* C67E 90 02    */ bcc LOC_C682

    /* C680 69 05    */ adc #5

LOC_C682:
    /* C682 18       */ clc
    /* C683 65 02    */ adc zR02
    /* C685 85 02    */ sta zR02
    /* C687 A5 03    */ lda zR03
    /* C689 29 F0    */ and #$F0
    /* C68B 65 02    */ adc zR02
    /* C68D 90 04    */ bcc LOC_C693

LOC_C68F:
    /* C68F 69 5F    */ adc #$5F
    /* C691 38       */ sec
    /* C692 60       */ rts

LOC_C693:
    /* C693 C9 A0    */ cmp #$A0
    /* C695 B0 F8    */ bcs LOC_C68F

    /* C697 60       */ rts

    .endproc ; FUNC_C677

    .proc FUNC_C698

    /* C698 20 BA C6 */ jsr FUNC_C6BA

    /* C69B E5 01    */ sbc zR01
    /* C69D 85 01    */ sta zR01
    /* C69F B0 0A    */ bcs LOC_C6AB

    /* C6A1 69 0A    */ adc #$0A
    /* C6A3 85 01    */ sta zR01
    /* C6A5 A5 02    */ lda zR02
    /* C6A7 69 0F    */ adc #$0F
    /* C6A9 85 02    */ sta zR02

LOC_C6AB:
    /* C6AB A5 03    */ lda zR03
    /* C6AD 29 F0    */ and #$F0
    /* C6AF 38       */ sec
    /* C6B0 E5 02    */ sbc zR02
    /* C6B2 B0 03    */ bcs LOC_C6B7

    /* C6B4 69 A0    */ adc #$A0
    /* C6B6 18       */ clc

LOC_C6B7:
    /* C6B7 05 01    */ ora zR01
    /* C6B9 60       */ rts

    .endproc ; FUNC_C698

    .proc FUNC_C6BA

    /* C6BA 48       */ pha

    /* C6BB 29 0F    */ and #$0F
    /* C6BD 85 01    */ sta zR01

    /* C6BF 68       */ pla

    /* C6C0 29 F0    */ and #$F0
    /* C6C2 85 02    */ sta zR02

    /* C6C4 A5 03    */ lda zR03
    /* C6C6 29 0F    */ and #$0F

    /* C6C8 60       */ rts

    .endproc ; FUNC_C6BA

    .proc Mul

    ; Input: R00: left operand, R01: right operand
    ; Output: R00:R01: result (16bit)
    ; Clobbers: R02

    /* C6C9 8A       */ txa
    /* C6CA 48       */ pha
    /* C6CB 98       */ tya
    /* C6CC 48       */ pha

    /* C6CD A9 00    */ lda #0
    /* C6CF 85 02    */ sta zR02

    /* C6D1 A2 08    */ ldx #8

lop:
    /* C6D3 46 00    */ lsr zR00
    /* C6D5 90 03    */ bcc LOC_C6DA

    /* C6D7 18       */ clc
    /* C6D8 65 01    */ adc zR01

LOC_C6DA:
    /* C6DA 6A       */ ror A
    /* C6DB 66 02    */ ror zR02

    /* C6DD CA       */ dex
    /* C6DE D0 F3    */ bne lop

    /* C6E0 85 01    */ sta zR01
    /* C6E2 A5 02    */ lda zR02
    /* C6E4 85 00    */ sta zR00

    /* C6E6 68       */ pla
    /* C6E7 A8       */ tay
    /* C6E8 68       */ pla
    /* C6E9 AA       */ tax

    /* C6EA 60       */ rts

    .endproc ; Mul

    .proc Div

    ; Input: zDivLeft:zDivLeft+1: left operand (16bit), zDivRight: right operand
    ; Output: zDivResult: result

    /* C6EB 8A       */ txa
    /* C6EC 48       */ pha

    /* C6ED A9 00    */ lda #0
    /* C6EF 85 4B    */ sta zDivResult

    /* C6F1 A2 10    */ ldx #16

    /* C6F3 26 48    */ rol zDivLeft
    /* C6F5 26 49    */ rol zDivLeft+1

lop:
    /* C6F7 26 4B    */ rol zDivResult

    /* C6F9 A5 4B    */ lda zDivResult

    /* C6FB C5 4A    */ cmp zDivRight
    /* C6FD 90 04    */ bcc LOC_C703

    /* C6FF E5 4A    */ sbc zDivRight
    /* C701 85 4B    */ sta zDivResult

LOC_C703:
    /* C703 26 48    */ rol zDivLeft
    /* C705 26 49    */ rol zDivLeft+1

    /* C707 CA       */ dex
    /* C708 D0 ED    */ bne lop

    /* C70A 68       */ pla
    /* C70B AA       */ tax

    /* C70C 60       */ rts

    .endproc ; Div

    .proc WaitFrame

    /* C70D 20 15 C7 */ jsr BeginWaitFrame

lop:
    /* C710 A5 20    */ lda zFrameEnded
    /* C712 F0 FC    */ beq lop

    /* C714 60       */ rts

    .endproc ; WaitFrame

    .proc BeginWaitFrame

    /* C715 A9 00    */ lda #0
    /* C717 85 20    */ sta zFrameEnded
    /* C719 60       */ rts

    .endproc ; BeginWaitFrame

    .proc WaitForTransfer

    /* C71A A5 21    */ lda zTransferEnable
    /* C71C D0 EF    */ bne WaitFrame

    /* C71E 60       */ rts

    .endproc ; WaitForTransfer

    .proc SetApplyDisableDisplay

    /* C71F A5 CC    */ lda zPPUMASK
    /* C721 29 E7    */ and #$E7

    ; jmp SetApplyPPUMask ; fallthrough

    .endproc ; SetApplyDisableDisplay

    .proc SetApplyPPUMask

    /* C723 85 CC    */ sta zPPUMASK
    /* C725 20 15 C7 */ jsr BeginWaitFrame

lop:
    /* C728 A5 20    */ lda zFrameEnded
    /* C72A F0 FC    */ beq lop

    /* C72C 60       */ rts

    .endproc ; SetApplyPPUMask

    .proc SetApplyEnableDisplay

    /* C72D A5 CC    */ lda zPPUMASK
    /* C72F 09 1E    */ ora #$1E
    /* C731 D0 F0    */ bne SetApplyPPUMask

    .endproc ; SetApplyEnableDisplay

    .proc ApplyPPUControls

    /* C733 A5 CD    */ lda zPPUCTRL
    /* C735 8D 00 20 */ sta PPUCTRL
    /* C738 A5 CC    */ lda zPPUMASK
    /* C73A 8D 01 20 */ sta PPUMASK

end:
    /* C73D 60       */ rts

    .endproc ; ApplyPPUControls

    ; why is this here I have no idea
    CaseRet := ApplyPPUControls::end

    .proc ClearDisableDisplay

    /* C73E 20 1F C7 */ jsr SetApplyDisableDisplay

    /* C741 20 3D C2 */ jsr ClearNameTables

    /* C744 A0 00    */ ldy #0
    /* C746 84 CA    */ sty zPPUSCROLLV
    /* C748 84 CB    */ sty zPPUSCROLLH

    /* C74A A5 CD    */ lda zPPUCTRL
    /* C74C 29 FC    */ and #$FC
    /* C74E 85 CD    */ sta zPPUCTRL

    /* C750 4C 88 C2 */ jmp ClearOamBuf

    .endproc ; ClearDisableDisplay

    .proc FUNC_C753

    /* C753 A5 CC    */ lda zPPUMASK
    /* C755 29 E7    */ and #$E7
    /* C757 20 23 C7 */ jsr SetApplyPPUMask

    /* C75A A5 CD    */ lda zPPUCTRL
    /* C75C 29 7F    */ and #$7F
    /* C75E 85 CD    */ sta zPPUCTRL
    /* C760 8D 00 20 */ sta PPUCTRL

    /* C763 60       */ rts

    .endproc ; FUNC_C753

    .proc FUNC_C764

    /* C764 A5 CD    */ lda zPPUCTRL
    /* C766 09 80    */ ora #$80
    /* C768 85 CD    */ sta zPPUCTRL
    /* C76A 8D 00 20 */ sta PPUCTRL

    /* C76D A5 CC    */ lda zPPUMASK
    /* C76F 09 1E    */ ora #$1E
    /* C771 D0 B0    */ bne SetApplyPPUMask

    .endproc ; FUNC_C764

    .proc SetApplyDisableNmi

    /* C773 A5 CD    */ lda zPPUCTRL
    /* C775 29 7B    */ and #$7B

    ; jmp SetApplyPPUControl ; fallthrough

    .endproc ; SetApplyDisableNmi

    .proc SetApplyPPUControl

    /* C777 8D 00 20 */ sta PPUCTRL
    /* C77A 85 CD    */ sta zPPUCTRL
    /* C77C 60       */ rts

    .endproc ; SetApplyPPUControl

    .proc SetApplyEnableNmi

lop:
    /* C77D AD 02 20 */ lda PPUSTATUS
    /* C780 29 80    */ and #$80 ; vblank flag
    /* C782 D0 F9    */ bne lop

    /* C784 A5 CD    */ lda zPPUCTRL
    /* C786 09 80    */ ora #$80
    /* C788 D0 ED    */ bne SetApplyPPUControl

    .endproc ; SetApplyEnableNmi

    .proc FUNC_C78A

lop:
    /* C78A 48       */ pha
    /* C78B 20 0D C7 */ jsr WaitFrame

    /* C78E 68       */ pla
    /* C78F 38       */ sec
    /* C790 E9 01    */ sbc #1
    /* C792 D0 F6    */ bne lop

    /* C794 60       */ rts

    .endproc ; FUNC_C78A

    .proc FUNC_C795

    /* C795 8A       */ txa
    /* C796 48       */ pha
    /* C797 98       */ tya
    /* C798 48       */ pha

    /* C799 A6 03    */ ldx zR03 ; X = X position?
    /* C79B A4 02    */ ldy zR02 ; Y = Y position? (wow!)

    /* C79D 84 00    */ sty zR00

    /* C79F A9 20    */ lda #$20
    /* C7A1 85 01    */ sta zR01

    /* C7A3 20 C9 C6 */ jsr Mul

    ; zR00:zR01 = Y position * $20

    /* C7A6 86 03    */ stx zR03

    /* C7A8 A5 00    */ lda zR00
    /* C7AA 18       */ clc
    /* C7AB 65 03    */ adc zR03
    /* C7AD 85 04    */ sta zR04

    /* C7AF A5 01    */ lda zR00+1
    /* C7B1 69 20    */ adc #$20
    /* C7B3 85 05    */ sta zR04+1

    /* C7B5 68       */ pla
    /* C7B6 A8       */ tay
    /* C7B7 68       */ pla
    /* C7B8 AA       */ tax

    /* C7B9 60       */ rts

    .endproc ; FUNC_C795

    .proc FUNC_C7BA

    /* C7BA 98       */ tya
    /* C7BB 48       */ pha

    /* C7BC A5 00    */ lda zR00
    /* C7BE 85 48    */ sta zDivLeft
    /* C7C0 A5 01    */ lda zR00+1
    /* C7C2 85 49    */ sta zDivLeft+1

    /* C7C4 A9 0A    */ lda #10
    /* C7C6 85 4A    */ sta zDivRight

    /* C7C8 A0 04    */ ldy #4

LOC_C7CA:
    /* C7CA 20 EB C6 */ jsr Div

    /* C7CD A5 4B    */ lda zDivResult
    /* C7CF 09 60    */ ora #$60
    /* C7D1 91 08    */ sta (zR08), Y
    /* C7D3 88       */ dey
    /* C7D4 10 F4    */ bpl LOC_C7CA

    /* C7D6 A0 00    */ ldy #0

LOC_C7D8:
    /* C7D8 B1 08    */ lda (zR08), Y
    /* C7DA C9 60    */ cmp #$60
    /* C7DC D0 09    */ bne end

    /* C7DE A9 FF    */ lda #$FF
    /* C7E0 91 08    */ sta (zR08), Y
    /* C7E2 C8       */ iny
    /* C7E3 C0 04    */ cpy #4
    /* C7E5 D0 F1    */ bne LOC_C7D8

end:
    /* C7E7 68       */ pla
    /* C7E8 A8       */ tay

    /* C7E9 60       */ rts

    .endproc ; FUNC_C7BA

    .proc FUNC_C7EA

    /* C7EA 98       */ tya
    /* C7EB 48       */ pha

    /* C7EC A5 00    */ lda zR00
    /* C7EE 85 48    */ sta zDivLeft
    /* C7F0 A9 00    */ lda #0
    /* C7F2 85 49    */ sta zDivLeft+1
    /* C7F4 C6 01    */ dec zR01
    /* C7F6 A9 0A    */ lda #$0A
    /* C7F8 85 4A    */ sta zDivRight
    /* C7FA A4 01    */ ldy zR01

LOC_C7FC:
    /* C7FC 20 EB C6 */ jsr Div

    /* C7FF A5 4B    */ lda zDivResult
    /* C801 09 60    */ ora #$60
    /* C803 91 08    */ sta (zR08), Y
    /* C805 88       */ dey
    /* C806 10 F4    */ bpl LOC_C7FC

    /* C808 A0 00    */ ldy #0

LOC_C80A:
    /* C80A B1 08    */ lda (zR08), Y
    /* C80C C9 60    */ cmp #$60
    /* C80E D0 09    */ bne end

    /* C810 A9 FF    */ lda #$FF
    /* C812 91 08    */ sta (zR08), Y
    /* C814 C8       */ iny
    /* C815 C4 01    */ cpy zR01
    /* C817 D0 F1    */ bne LOC_C80A

end:
    /* C819 68       */ pla
    /* C81A A8       */ tay

    /* C81B 60       */ rts

    .endproc ; FUNC_C7EA

    .proc FUNC_C81C

    /* C81C A5 00    */ lda zR00
    /* C81E 18       */ clc
    /* C81F 69 20    */ adc #<$0020
    /* C821 85 00    */ sta zR00
    /* C823 A5 01    */ lda zR01
    /* C825 69 00    */ adc #>$0020
    /* C827 85 01    */ sta zR01

    /* C829 C9 23    */ cmp #$23
    /* C82B F0 04    */ beq LOC_C831

    /* C82D C9 27    */ cmp #$27
    /* C82F D0 10    */ bne end

LOC_C831:
    /* C831 A5 00    */ lda zR00
    /* C833 C9 C0    */ cmp #$C0
    /* C835 90 0A    */ bcc end

    /* C837 29 1F    */ and #<%1111110000011111
    /* C839 85 00    */ sta zR00
    /* C83B A5 01    */ lda zR01
    /* C83D 29 FC    */ and #>%1111110000011111
    /* C83F 85 01    */ sta zR01

end:
    /* C841 60       */ rts

    .endproc ; FUNC_C81C

    .proc FUNC_C842

    /* C842 A9 10    */ lda #<wUnk0310
    /* C844 85 02    */ sta zR02
    /* C846 A9 03    */ lda #>wUnk0310
    /* C848 85 03    */ sta zR02+1
    /* C84A 86 00    */ stx zR00
    /* C84C 84 01    */ sty zR01
    /* C84E A0 00    */ ldy #0
    /* C850 B1 02    */ lda (zR02), Y
    /* C852 29 1F    */ and #$1F
    /* C854 85 05    */ sta zR05
    /* C856 B1 02    */ lda (zR02), Y
    /* C858 20 99 C3 */ jsr Lsr5
    /* C85B 85 04    */ sta zR04

    /* C85D AE 80 07 */ ldx wTransferCnt

LOC_C860:
    /* C860 A9 00    */ lda #$00
    /* C862 85 08    */ sta zR08
    /* C864 A5 00    */ lda zR00
    /* C866 29 1F    */ and #$1F
    /* C868 85 06    */ sta zR06
    /* C86A A9 20    */ lda #$20
    /* C86C 38       */ sec
    /* C86D E5 06    */ sbc zR06
    /* C86F 85 07    */ sta zR07
    /* C871 A5 05    */ lda zR05
    /* C873 C5 07    */ cmp zR07
    /* C875 F0 06    */ beq LOC_C87D

    /* C877 90 04    */ bcc LOC_C87D

    /* C879 A5 07    */ lda zR07
    /* C87B E6 08    */ inc zR08

LOC_C87D:
    /* C87D 85 06    */ sta zR06
    /* C87F A5 01    */ lda zR00+1
    /* C881 20 A2 C4 */ jsr PutTransferByte

    /* C884 A5 00    */ lda zR00
    /* C886 20 A2 C4 */ jsr PutTransferByte

    /* C889 A5 06    */ lda zR06
    /* C88B 20 A2 C4 */ jsr PutTransferByte

LOC_C88E:
    /* C88E C8       */ iny
    /* C88F B1 02    */ lda (zR02), Y
    /* C891 20 A2 C4 */ jsr PutTransferByte

    /* C894 C6 06    */ dec zR06
    /* C896 D0 F6    */ bne LOC_C88E

    /* C898 A5 08    */ lda zR08
    /* C89A F0 1D    */ beq LOC_C8B9

    /* C89C C6 08    */ dec zR08
    /* C89E A5 01    */ lda zR00+1
    /* C8A0 49 04    */ eor #$04
    /* C8A2 20 A2 C4 */ jsr PutTransferByte

    /* C8A5 A5 00    */ lda zR00
    /* C8A7 29 E0    */ and #$E0
    /* C8A9 20 A2 C4 */ jsr PutTransferByte

    /* C8AC A5 05    */ lda zR05
    /* C8AE 38       */ sec
    /* C8AF E5 07    */ sbc zR07
    /* C8B1 85 06    */ sta zR06
    /* C8B3 20 A2 C4 */ jsr PutTransferByte

    /* C8B6 4C 8E C8 */ jmp LOC_C88E

LOC_C8B9:
    /* C8B9 8E 80 07 */ stx wTransferCnt
    /* C8BC 20 1C C8 */ jsr FUNC_C81C

    /* C8BF C6 04    */ dec zR04
    /* C8C1 D0 9D    */ bne LOC_C860

    /* C8C3 A9 00    */ lda #0
    /* C8C5 9D 81 07 */ sta wTransferScr, X

    /* C8C8 A0 01    */ ldy #1
    /* C8CA 84 21    */ sty zTransferEnable

    /* C8CC 60       */ rts

    .endproc ; FUNC_C842

    .proc FUNC_C8CD

    /* C8CD A9 00    */ lda #<wUnk0700
    /* C8CF 85 02    */ sta zR02
    /* C8D1 A9 07    */ lda #>wUnk0700
    /* C8D3 85 03    */ sta zR02+1
    /* C8D5 86 00    */ stx zR00
    /* C8D7 84 01    */ sty zR01
    /* C8D9 A0 00    */ ldy #0
    /* C8DB B1 02    */ lda (zR02), Y
    /* C8DD 29 1F    */ and #$1F
    /* C8DF 85 05    */ sta zR05
    /* C8E1 B1 02    */ lda (zR02), Y
    /* C8E3 20 99 C3 */ jsr Lsr5
    /* C8E6 85 04    */ sta zR04

    /* C8E8 AE 80 07 */ ldx wTransferCnt

LOC_C8EB:
    /* C8EB A9 00    */ lda #0
    /* C8ED 85 08    */ sta zR08
    /* C8EF A5 00    */ lda zR00
    /* C8F1 29 07    */ and #$07
    /* C8F3 85 06    */ sta zR06
    /* C8F5 A9 08    */ lda #$08
    /* C8F7 38       */ sec
    /* C8F8 E5 06    */ sbc zR06
    /* C8FA 85 07    */ sta zR07
    /* C8FC A5 05    */ lda zR05
    /* C8FE C5 07    */ cmp zR07
    /* C900 F0 06    */ beq LOC_C908

    /* C902 90 04    */ bcc LOC_C908

    /* C904 A5 07    */ lda zR07
    /* C906 E6 08    */ inc zR08

LOC_C908:
    /* C908 85 06    */ sta zR06
    /* C90A A5 01    */ lda zR01
    /* C90C 20 A2 C4 */ jsr PutTransferByte

    /* C90F A5 00    */ lda zR00
    /* C911 20 A2 C4 */ jsr PutTransferByte

    /* C914 A5 06    */ lda zR06
    /* C916 20 A2 C4 */ jsr PutTransferByte

LOC_C919:
    /* C919 C8       */ iny
    /* C91A B1 02    */ lda (zR02), Y
    /* C91C 20 A2 C4 */ jsr PutTransferByte

    /* C91F C6 06    */ dec zR06
    /* C921 D0 F6    */ bne LOC_C919

    /* C923 A5 08    */ lda zR08
    /* C925 F0 1D    */ beq LOC_C944

    /* C927 C6 08    */ dec zR08
    /* C929 A5 01    */ lda zR01
    /* C92B 49 04    */ eor #$04
    /* C92D 20 A2 C4 */ jsr PutTransferByte

    /* C930 A5 00    */ lda zR00
    /* C932 29 F8    */ and #$F8
    /* C934 20 A2 C4 */ jsr PutTransferByte

    /* C937 A5 05    */ lda zR05
    /* C939 38       */ sec
    /* C93A E5 07    */ sbc zR07
    /* C93C 85 06    */ sta zR06
    /* C93E 20 A2 C4 */ jsr PutTransferByte

    /* C941 4C 19 C9 */ jmp LOC_C919

LOC_C944:
    /* C944 8E 80 07 */ stx wTransferCnt
    /* C947 A9 08    */ lda #$08
    /* C949 18       */ clc
    /* C94A 65 00    */ adc zR00
    /* C94C 09 C0    */ ora #$C0
    /* C94E 85 00    */ sta zR00
    /* C950 C6 04    */ dec zR04
    /* C952 D0 97    */ bne LOC_C8EB

    /* C954 A9 00    */ lda #$00
    /* C956 9D 81 07 */ sta wTransferScr, X
    /* C959 A0 01    */ ldy #$01
    /* C95B 84 21    */ sty zTransferEnable

    /* C95D 60       */ rts

    .endproc ; FUNC_C8CD

    .proc GetMapSquare

    /* C95E 8A       */ txa
    /* C95F 48       */ pha
    /* C960 A2 02    */ ldx #$02
    /* C962 AD 74 76 */ lda sMapNum
    /* C965 C9 0E    */ cmp #$0E
    /* C967 90 04    */ bcc :+

    /* C969 E9 0D    */ sbc #$0D
    /* C96B A2 09    */ ldx #$09

:
    /* C96D A8       */ tay
    /* C96E 8A       */ txa
    /* C96F 20 A6 C9 */ jsr SwapBank

    /* C972 88       */ dey
    /* C973 98       */ tya
    /* C974 0A       */ asl A
    /* C975 AA       */ tax
    /* C976 BD 00 80 */ lda $8000, X
    /* C979 85 02    */ sta zR02
    /* C97B BD 01 80 */ lda $8000+1, X
    /* C97E 85 03    */ sta zR02+1
    /* C980 18       */ clc
    /* C981 A9 04    */ lda #4
    /* C983 65 02    */ adc zR02
    /* C985 85 02    */ sta zR02
    /* C987 90 02    */ bcc :+

    /* C989 E6 03    */ inc zR02+1

:
    /* C98B 18       */ clc
    /* C98C A5 02    */ lda zR02
    /* C98E 65 00    */ adc zR00
    /* C990 85 02    */ sta zR02
    /* C992 A5 03    */ lda zR02+1
    /* C994 65 01    */ adc zR00+1
    /* C996 85 03    */ sta zR02+1
    /* C998 A0 00    */ ldy #0
    /* C99A B1 02    */ lda (zR02), Y
    /* C99C A8       */ tay
    /* C99D A9 0B    */ lda #$0B
    /* C99F 8D 00 A0 */ sta MMC4BANK
    /* C9A2 68       */ pla
    /* C9A3 AA       */ tax
    /* C9A4 98       */ tya
    /* C9A5 60       */ rts

    .endproc ; GetMapSquare

    .proc SwapBank

    /* C9A6 85 29    */ sta zBank29
    /* C9A8 85 51    */ sta zBank51
    /* C9AA 8D 00 A0 */ sta MMC4BANK
    /* C9AD 60       */ rts

    .endproc ; SwapBank

    .proc SwapLoChrBankA

    /* C9AE 85 59    */ sta zChr59
    /* C9B0 05 52    */ ora zChr52
    /* C9B2 8D 00 B0 */ sta MMC4CHRLO1
    /* C9B5 60       */ rts

    .endproc ; SwapLoChrBankA

    .proc SwapLoChrBankB

    /* C9B6 85 5A    */ sta zChr5A
    /* C9B8 05 52    */ ora zChr52
    /* C9BA 8D 00 C0 */ sta MMC4CHRLO2
    /* C9BD 60       */ rts

    .endproc ; SwapLoChrBankB

    .proc SwapHiChrBankA

    /* C9BE 85 5B    */ sta zChr5B
    /* C9C0 05 52    */ ora zChr52
    /* C9C2 8D 00 D0 */ sta MMC4CHRHI1
    /* C9C5 60       */ rts

    .endproc ; SwapHiChrBankA

    .proc SwapHiChrBankB

    /* C9C6 85 5C    */ sta zChr5C
    /* C9C8 05 52    */ ora zChr52
    /* C9CA 8D 00 E0 */ sta MMC4CHRHI2
    /* C9CD 60       */ rts

    .endproc ; SwapHiChrBankB

    .proc SetMirrorH

    /* C9CE A9 01    */ lda #1
    /* C9D0 85 C8    */ sta zMirrorC8
    /* C9D2 8D 00 F0 */ sta MMC4MIRROR
    /* C9D5 60       */ rts

    .endproc ; SetMirrorH

    .proc SetMirrorV

    /* C9D6 A9 00    */ lda #0
    /* C9D8 85 C8    */ sta zMirrorC8
    /* C9DA 8D 00 F0 */ sta MMC4MIRROR
    /* C9DD 60       */ rts

    .endproc ; SetMirrorV

    .proc FUNC_C9DE

    /* C9DE A9 10    */ lda #$10
    /* C9E0 D0 02    */ bne :+

    /* C9E2 A9 00    */ lda #0

:
    /* C9E4 85 52    */ sta zChr52

    /* C9E6 A5 59    */ lda zChr59
    /* C9E8 20 AE C9 */ jsr SwapLoChrBankA

    /* C9EB A5 5A    */ lda zChr5A
    /* C9ED 20 B6 C9 */ jsr SwapLoChrBankB

    /* C9F0 A5 5B    */ lda zChr5B
    /* C9F2 20 BE C9 */ jsr SwapHiChrBankA

    /* C9F5 A5 5C    */ lda zChr5C
    /* C9F7 4C C6 C9 */ jmp SwapHiChrBankB

    .endproc ; FUNC_C9DE

    .proc CallFarFunc

    /* C9FA AA       */ tax
    /* C9FB A5 29    */ lda zBank29
    /* C9FD 48       */ pha
    /* C9FE 8A       */ txa
    /* C9FF 20 A6 C9 */ jsr SwapBank

    /* CA02 A9 CA    */ lda #>(ret-1)
    /* CA04 48       */ pha
    /* CA05 A9 18    */ lda #<(ret-1)
    /* CA07 48       */ pha

    /* CA08 A5 44    */ lda zFarFuncNum
    /* CA0A 0A       */ asl A
    /* CA0B AA       */ tax

    /* CA0C BD A0 BF */ lda FarFuncs, X
    /* CA0F 85 45    */ sta zFarFuncPtr
    /* CA11 BD A1 BF */ lda FarFuncs+1, X
    /* CA14 85 46    */ sta zFarFuncPtr+1

    /* CA16 6C 45 00 */ jmp (zFarFuncPtr)

ret:
    /* CA19 68       */ pla
    /* CA1A 4C A6 C9 */ jmp SwapBank

    .endproc ; CallFarFunc

    .proc PutSprite

    ; Input:
    ; - zSpriteY = Y Offset
    ; - zSpriteX = X Offset
    ; - zSpriteNum = Sprite number
    ; - zSpriteIt = Last OAM write offset
    ; - zSpriteGroup = Group number

    /* CA1D 48       */ pha
    /* CA1E 98       */ tya
    /* CA1F 48       */ pha
    /* CA20 8A       */ txa
    /* CA21 48       */ pha

    /* CA22 A5 3C    */ lda zSpriteGroup
    /* CA24 0A       */ asl A
    /* CA25 A8       */ tay

    /* CA26 B9 D0 BF */ lda FarSpriteGroups, Y
    /* CA29 85 40    */ sta zUnk40
    /* CA2B B9 D1 BF */ lda FarSpriteGroups+1, Y
    /* CA2E 85 41    */ sta zUnk40+1

    /* CA30 A5 36    */ lda zSpriteNum
    /* CA32 0A       */ asl A
    /* CA33 A8       */ tay

    /* CA34 B1 40    */ lda (zUnk40), Y
    /* CA36 85 3E    */ sta zUnk3E
    /* CA38 C8       */ iny
    /* CA39 B1 40    */ lda (zUnk40), Y
    /* CA3B 85 3F    */ sta zUnk3E+1

    ; X = last oam write offset
    /* CA3D A6 37    */ ldx zSpriteIt

    /* CA3F A0 00    */ ldy #0
    /* CA41 B1 3E    */ lda (zUnk3E), Y
    /* CA43 85 3D    */ sta zUnk3D

lop:
    /* CA45 C8       */ iny
    /* CA46 E8       */ inx

    ; Write OAM+00 : Y Coord

    /* CA47 B1 3E    */ lda (zUnk3E), Y
    /* CA49 18       */ clc
    /* CA4A 65 34    */ adc zSpriteY
    /* CA4C 9D 00 02 */ sta wOamBuf, X

    /* CA4F C8       */ iny
    /* CA50 E8       */ inx

    ; Write OAM+01 : Tile number

    /* CA51 B1 3E    */ lda (zUnk3E), Y
    /* CA53 9D 00 02 */ sta wOamBuf, X

    /* CA56 C8       */ iny
    /* CA57 E8       */ inx

    ; Write OAM+02 : Attributes

    /* CA58 B1 3E    */ lda (zUnk3E), Y
    /* CA5A 05 38    */ ora zUnk38
    /* CA5C 85 43    */ sta zUnk43

    /* CA5E A5 3A    */ lda zUnk3A
    /* CA60 49 FF    */ eor #$FF ; not
    /* CA62 25 43    */ and zUnk43
    /* CA64 05 39    */ ora zUnk39

    /* CA66 84 42    */ sty zUnk42

    /* CA68 A4 3B    */ ldy zUnk3B
    /* CA6A F0 0C    */ beq LOC_CA78

    /* CA6C A8       */ tay
    /* CA6D 29 40    */ and #%01000000 ; get hflip bit
    /* CA6F 49 40    */ eor #%01000000 ; not hflip bit
    /* CA71 85 43    */ sta zUnk43
    /* CA73 98       */ tya
    /* CA74 29 BF    */ and #%10111111
    /* CA76 05 43    */ ora zUnk43

LOC_CA78:
    /* CA78 9D 00 02 */ sta wOamBuf, X

    /* CA7B A4 42    */ ldy zUnk42

    /* CA7D C8       */ iny
    /* CA7E E8       */ inx

    ; Write OAM+03 : X Coord

    /* CA7F B1 3E    */ lda (zUnk3E), Y

    /* CA81 48       */ pha

    /* CA82 A5 3B    */ lda zUnk3B
    /* CA84 F0 09    */ beq LOC_CA8F

    /* CA86 68       */ pla

    /* CA87 38       */ sec
    /* CA88 49 FF    */ eor #$FF ; not
    /* CA8A 69 08    */ adc #8

    ; A = 8-A

    /* CA8C 4C 90 CA */ jmp LOC_CA90

LOC_CA8F:
    /* CA8F 68       */ pla

LOC_CA90:
    /* CA90 18       */ clc
    /* CA91 65 35    */ adc zSpriteX
    /* CA93 9D 00 02 */ sta wOamBuf, X

    /* CA96 C6 3D    */ dec zUnk3D
    /* CA98 D0 AB    */ bne lop

    /* CA9A 86 37    */ stx zSpriteIt

    /* CA9C A9 00    */ lda #0
    /* CA9E 85 39    */ sta zUnk39
    /* CAA0 85 3A    */ sta zUnk3A
    /* CAA2 85 3B    */ sta zUnk3B

    /* CAA4 68       */ pla
    /* CAA5 AA       */ tax
    /* CAA6 68       */ pla
    /* CAA7 A8       */ tay
    /* CAA8 68       */ pla

    /* CAA9 60       */ rts

    .endproc ; PutSprite
