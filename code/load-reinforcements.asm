
    GetMapRowInR04 = $8250
    LOC_8D6D = $8D6D

    DAT_959C = $959C
    DAT_A44E = $A44E

LOC_91D0:
    /* 91D0 AC 74 76 */ ldy sMapNum
    /* 91D3 88       */ dey
    /* 91D4 98       */ tya
    /* 91D5 0A       */ asl A
    /* 91D6 A8       */ tay
    /* 91D7 B9 9C 95 */ lda DAT_959C, Y
    /* 91DA 85 76    */ sta zUnitLoadSrc
    /* 91DC B9 9D 95 */ lda DAT_959C+1, Y
    /* 91DF 85 77    */ sta zUnitLoadSrc+1

@lop:
    /* 91E1 A0 00    */ ldy #0
    /* 91E3 B1 76    */ lda (zUnitLoadSrc), Y
    /* 91E5 D0 03    */ bne +

    /* 91E7 4C 70 92 */ jmp @end

+:
    /* 91EA 85 A3    */ sta zUnkA3
    /* 91EC AC 74 76 */ ldy sMapNum
    /* 91EF 88       */ dey
    /* 91F0 B9 C1 A3 */ lda DAT_A3C1, Y
    /* 91F3 F0 2E    */ beq @LOC_9223

    /* 91F5 18       */ clc
    /* 91F6 69 FF    */ adc #-1
    /* 91F8 0A       */ asl A
    /* 91F9 A8       */ tay
    /* 91FA B9 DA A3 */ lda DAT_A3DA, Y
    /* 91FD 85 02    */ sta zR02
    /* 91FF B9 DB A3 */ lda DAT_A3DA+1, Y
    /* 9202 85 03    */ sta zR02+1

@lop_unk:
    /* 9204 A0 00    */ ldy #0
    /* 9206 B1 02    */ lda (zR02), Y
    /* 9208 F0 19    */ beq @LOC_9223

    /* 920A C5 A3    */ cmp zUnkA3
    /* 920C F0 08    */ beq @LOC_9216

    /* 920E A0 04    */ ldy #4
    /* 9210 20 83 C3 */ jsr IncR02ByY

    /* 9213 4C 04 92 */ jmp @lop_unk

@LOC_9216:
    /* 9216 C8       */ iny
    /* 9217 C8       */ iny
    /* 9218 C8       */ iny
    /* 9219 B1 02    */ lda (zR02), Y
    /* 921B 8D 45 05 */ sta wUnk0545
    /* 921E 20 6D 8D */ jsr LOC_8D6D

    /* 9221 B0 37    */ bcs @continue

@LOC_9223:
    /* 9223 A0 08    */ ldy #EnemyInfo.unk_08
    /* 9225 B1 76    */ lda (zUnitLoadSrc), Y
    /* 9227 0A       */ asl A
    /* 9228 B0 09    */ bcs @multiple_turns

    /* 922A 4A       */ lsr A
    /* 922B CD 75 76 */ cmp sUnk7675
    /* 922E F0 15    */ beq @on_turn

    /* 9230 4C 5A 92 */ jmp @continue

@multiple_turns:
    /* 9233 4A       */ lsr A
    /* 9234 CD 75 76 */ cmp sUnk7675
    /* 9237 B0 21    */ bcs @continue

    /* 9239 AC 74 76 */ ldy sMapNum
    /* 923C 88       */ dey
    /* 923D B9 4E A4 */ lda DAT_A44E, Y
    /* 9240 CD 75 76 */ cmp sUnk7675
    /* 9243 90 15    */ bcc @continue

@on_turn:
    /* 9245 A0 05    */ ldy #EnemyInfo.y
    /* 9247 B1 76    */ lda (zUnitLoadSrc), Y
    /* 9249 85 B3    */ sta zUnkB3
    /* 924B C8       */ iny
    /* 924C B1 76    */ lda (zUnitLoadSrc), Y
    /* 924E 85 B2    */ sta zUnkB2
    /* 9250 20 4A 91 */ jsr LOC_914A

    /* 9253 90 05    */ bcc @continue

    /* 9255 20 44 91 */ jsr LOC_9144

    /* 9258 B0 0E    */ bcs @load_unit

@continue:
    /* 925A A9 0B    */ lda #_sizeof_EnemyInfo
    /* 925C 18       */ clc
    /* 925D 65 76    */ adc zUnitLoadSrc
    /* 925F 85 76    */ sta zUnitLoadSrc
    /* 9261 90 02    */ bcc +

    /* 9263 E6 77    */ inc zUnitLoadSrc+1

+:
    /* 9265 4C E1 91 */ jmp @lop

@load_unit:
    /* 9268 20 71 92 */ jsr LOC_9271

    /* 926B 20 2A 93 */ jsr CopyUnitBufToResult

    /* 926E A9 FF    */ lda #$FF

@end:
    /* 9270 60       */ rts

LOC_9271:
    /* 9271 A0 00    */ ldy #0
    /* 9273 8C 06 77 */ sty sUnitBuf.w+Unit.unk_12 ; ????
    /* 9276 B1 76    */ lda (zUnitLoadSrc), Y
    /* 9278 8D F4 76 */ sta sUnitBuf+Unit.pid
    /* 927B C8       */ iny
    /* 927C B1 76    */ lda (zUnitLoadSrc), Y
    /* 927E 8D F5 76 */ sta sUnitBuf+Unit.jid
    /* 9281 C8       */ iny
    /* 9282 B1 76    */ lda (zUnitLoadSrc), Y
    /* 9284 8D F6 76 */ sta sUnitBuf+Unit.level
    /* 9287 38       */ sec
    /* 9288 E9 01    */ sbc #1
    /* 928A 4A       */ lsr A
    /* 928B 85 0B    */ sta zR0B
    /* 928D C8       */ iny
    /* 928E B1 76    */ lda (zUnitLoadSrc), Y
    /* 9290 8D 07 77 */ sta sUnitBuf+Unit.item+0
    /* 9293 C8       */ iny
    /* 9294 B1 76    */ lda (zUnitLoadSrc), Y
    /* 9296 8D 08 77 */ sta sUnitBuf+Unit.item+1
    /* 9299 C8       */ iny
    /* 929A B1 76    */ lda (zUnitLoadSrc), Y
    /* 929C 8D 04 77 */ sta sUnitBuf+Unit.y
    /* 929F C8       */ iny
    /* 92A0 B1 76    */ lda (zUnitLoadSrc), Y
    /* 92A2 8D 05 77 */ sta sUnitBuf+Unit.x
    /* 92A5 C8       */ iny
    /* 92A6 B1 76    */ lda (zUnitLoadSrc), Y
    /* 92A8 8D 0B 77 */ sta sUnitBuf+Unit.uses+0
    /* 92AB C8       */ iny
    /* 92AC B1 76    */ lda (zUnitLoadSrc), Y
    /* 92AE 8D 0C 77 */ sta sUnitBuf+Unit.uses+1
    /* 92B1 C8       */ iny
    /* 92B2 B1 76    */ lda (zUnitLoadSrc), Y
    /* 92B4 8D 0D 77 */ sta sUnitBuf+Unit.uses+2
    /* 92B7 C8       */ iny
    /* 92B8 B1 76    */ lda (zUnitLoadSrc), Y
    /* 92BA 8D 0E 77 */ sta sUnitBuf+Unit.uses+3
    /* 92BD AD F5 76 */ lda sUnitBuf+Unit.jid
    /* 92C0 38       */ sec
    /* 92C1 E9 01    */ sbc #1
    /* 92C3 0A       */ asl A
    /* 92C4 A8       */ tay
    /* 92C5 B9 04 EC */ lda JobStats, Y
    /* 92C8 85 02    */ sta zR02
    /* 92CA B9 05 EC */ lda JobStats+1, Y
    /* 92CD 85 03    */ sta zR02+1
    /* 92CF A0 00    */ ldy #0

@lop_stats:
    /* 92D1 B1 02    */ lda (zR02), Y
    /* 92D3 C0 04    */ cpy #(Unit.lck - Unit.str)
    /* 92D5 F0 03    */ beq @skip_lck

    /* 92D7 18       */ clc
    /* 92D8 65 0B    */ adc zR0B

@skip_lck:
    /* 92DA 99 FB 76 */ sta sUnitBuf+Unit.str, Y
    /* 92DD C8       */ iny
    /* 92DE C0 06    */ cpy #(Unit.mov - Unit.str)
    /* 92E0 90 EF    */ bcc @lop_stats

    /* 92E2 B1 02    */ lda (zR02), Y
    /* 92E4 99 FB 76 */ sta sUnitBuf+Unit.str, Y
    /* 92E7 C8       */ iny
    /* 92E8 A5 0B    */ lda zR0B
    /* 92EA 0A       */ asl A
    /* 92EB 18       */ clc
    /* 92EC 65 0B    */ adc zR0B
    /* 92EE 71 02    */ adc (zR02), Y
    /* 92F0 8D F7 76 */ sta sUnitBuf+Unit.hp_cur
    /* 92F3 8D F8 76 */ sta sUnitBuf+Unit.hp_max
    /* 92F6 C8       */ iny
    /* 92F7 84 12    */ sty zUnk12
    /* 92F9 AC F6 76 */ ldy sUnitBuf+Unit.level
    /* 92FC A9 00    */ lda #0
    /* 92FE 85 0A    */ sta zR0A

@lop_unk:
    /* 9300 A9 01    */ lda #1
    /* 9302 18       */ clc
    /* 9303 65 0A    */ adc zR0A
    /* 9305 85 0A    */ sta zR0A
    /* 9307 88       */ dey
    /* 9308 D0 F6    */ bne @lop_unk

    /* 930A A4 12    */ ldy zUnk12
    /* 930C B1 02    */ lda (zR02), Y
    /* 930E 18       */ clc
    /* 930F 65 0A    */ adc zR0A
    /* 9311 69 FF    */ adc #-1
    /* 9313 8D F9 76 */ sta sUnitBuf+Unit.exp
    /* 9316 AE 04 77 */ ldx sUnitBuf+Unit.y
    /* 9319 AC 05 77 */ ldy sUnitBuf+Unit.x
    /* 931C 20 50 82 */ jsr GetMapRowInR04
    /* 931F B1 04    */ lda (zR04), Y
    /* 9321 8D FA 76 */ sta sUnitBuf+Unit.terrain
    /* 9324 A9 00    */ lda #0
    /* 9326 8D 03 77 */ sta sUnitBuf+Unit.res
    /* 9329 60       */ rts

CopyUnitBufToResult:
    /* 932A 8A       */ txa
    /* 932B 48       */ pha
    /* 932C 98       */ tya
    /* 932D 48       */ pha
    /* 932E A9 F4    */ lda #<sUnitBuf
    /* 9330 85 02    */ sta zR02
    /* 9332 A9 76    */ lda #>sUnitBuf
    /* 9334 85 03    */ sta zR02+1
    /* 9336 A0 00    */ ldy #0

@lop:
    /* 9338 B1 02    */ lda (zR02), Y
    /* 933A 91 9D    */ sta (zUnitPtr9D), Y
    /* 933C C8       */ iny
    /* 933D C0 1B    */ cpy #_sizeof_Unit
    /* 933F D0 F7    */ bne @lop

    /* 9341 68       */ pla
    /* 9342 A8       */ tay
    /* 9343 68       */ pla
    /* 9344 AA       */ tax
    /* 9345 60       */ rts
