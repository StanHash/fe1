
    ; TODO: 

    PlayerUnits = $8490
    DAT_8790 = $8790
    EnemyUnits = $8AA3

FN0_BA7A:
    /* BA7A AC 74 76 */ ldy sMapNum
    /* BA7D 88       */ dey
    /* BA7E 98       */ tya
    /* BA7F 0A       */ asl A
    /* BA80 A8       */ tay
    /* BA81 B9 90 87 */ lda DAT_8790, Y
    /* BA84 85 72    */ sta zUnitPtr72
    /* BA86 B9 91 87 */ lda DAT_8790+1, Y
    /* BA89 85 73    */ sta zUnitPtr72+1
    /* BA8B A0 00    */ ldy #0
    /* BA8D B1 72    */ lda (zUnitPtr72), Y
    /* BA8F 8D EA 05 */ sta wUnk05EA
    /* BA92 60       */ rts

FN1_BA93:
    /* BA93 A0 00    */ ldy #0
    /* BA95 B1 72    */ lda (zUnitPtr72), Y
    /* BA97 A0 10    */ ldy #Unit.y
    /* BA99 91 74    */ sta (zUnitLoadDst), Y
    /* BA9B 85 04    */ sta zR04
    /* BA9D A0 01    */ ldy #1
    /* BA9F B1 72    */ lda (zUnitPtr72), Y
    /* BAA1 A0 11    */ ldy #Unit.x
    /* BAA3 91 74    */ sta (zUnitLoadDst), Y
    /* BAA5 85 05    */ sta zR05
    /* BAA7 60       */ rts

LoadMapPlayerUnits:
    /* BAA8 A9 F4    */ lda #<sUnitBuf
    /* BAAA 85 00    */ sta zR00
    /* BAAC A9 76    */ lda #>sUnitBuf
    /* BAAE 85 01    */ sta zR00+1
    /* BAB0 A9 1B    */ lda #<_sizeof_Unit ; TODO: sizeof sUnitBuf
    /* BAB2 85 02    */ sta zR02
    /* BAB4 A9 00    */ lda #>_sizeof_Unit ; TODO: sizeof sUnitBuf
    /* BAB6 85 03    */ sta zR02+1

    /* BAB8 20 25 C2 */ jsr MemFill

    /* BABB AC 74 76 */ ldy sMapNum
    /* BABE 88       */ dey
    /* BABF 98       */ tya
    /* BAC0 0A       */ asl A
    /* BAC1 A8       */ tay

    /* BAC2 B9 90 84 */ lda PlayerUnits, Y
    /* BAC5 85 76    */ sta zUnitLoadSrc
    /* BAC7 B9 91 84 */ lda PlayerUnits+1, Y
    /* BACA 85 77    */ sta zUnitLoadSrc+1

    /* BACC A9 90    */ lda #<sBlueUnits
    /* BACE 85 74    */ sta zUnitLoadDst
    /* BAD0 A9 6A    */ lda #>sBlueUnits
    /* BAD2 85 75    */ sta zUnitLoadDst+1

    /* BAD4 D0 33    */ bne @begin

@lop:
    /* BAD6 B1 76    */ lda (zUnitLoadSrc), Y
    /* BAD8 99 F4 76 */ sta sUnitBuf, Y
    /* BADB C8       */ iny
    /* BADC C0 1B    */ cpy #$1B
    /* BADE D0 F6    */ bne @lop

    /* BAE0 A2 17    */ ldx #Unit.uses
    /* BAE2 A0 13    */ ldy #Unit.item

@lop_items:
    /* BAE4 B9 F4 76 */ lda sUnitBuf, Y
    /* BAE7 84 12    */ sty zUnk12
    /* BAE9 F0 08    */ beq @not_item

    /* BAEB A8       */ tay
    /* BAEC 88       */ dey
    /* BAED B9 7F D8 */ lda ItemInfo.uses, Y
    /* BAF0 9D F4 76 */ sta sUnitBuf, X

@not_item:
    /* BAF3 A4 12    */ ldy zUnk12
    /* BAF5 E8       */ inx
    /* BAF6 C8       */ iny
    /* BAF7 C0 17    */ cpy #Unit.item+UNIT_ITEM_COUNT
    /* BAF9 D0 E9    */ bne @lop_items

    /* BAFB 20 10 BB */ jsr LoadUnit

    /* BAFE A9 1B    */ lda #_sizeof_Unit
    /* BB00 18       */ clc
    /* BB01 65 76    */ adc zUnitLoadSrc
    /* BB03 85 76    */ sta zUnitLoadSrc
    /* BB05 90 02    */ bcc +

    /* BB07 E6 77    */ inc zUnitLoadSrc+1
+:
@begin:
    /* BB09 A0 00    */ ldy #$00
    /* BB0B B1 76    */ lda (zUnitLoadSrc), Y
    /* BB0D D0 C7    */ bne @lop

    /* BB0F 60       */ rts

LoadUnit:
    /* BB10 8A       */ txa
    /* BB11 48       */ pha
    /* BB12 98       */ tya
    /* BB13 48       */ pha

    /* BB14 A5 74    */ lda zUnitLoadDst
    /* BB16 85 00    */ sta zR00
    /* BB18 A5 75    */ lda zUnitLoadDst+1
    /* BB1A 85 01    */ sta zR00+1

    /* BB1C A2 00    */ ldx #0
    /* BB1E F0 0A    */ beq @begin_find_slot

@lop_slots:
    /* BB20 E8       */ inx
    /* BB21 E0 36    */ cpx #$36 ; TODO: what is this?
    /* BB23 B0 5B    */ bcs @end

    /* BB25 A9 1B    */ lda #_sizeof_Unit
    /* BB27 20 79 C3 */ jsr IncR00ByA

@begin_find_slot:
    /* BB2A A0 12    */ ldy #Unit.unk_12
    /* BB2C B1 00    */ lda (zR00), Y
    /* BB2E C9 FF    */ cmp #$FF ; TODO: what is this?
    /* BB30 F0 EE    */ beq @lop_slots

    /* BB32 C9 F0    */ cmp #$F0 ; TODO: what is this?
    /* BB34 F0 EA    */ beq @lop_slots

    /* BB36 A0 00    */ ldy #0
    /* BB38 B1 00    */ lda (zR00), Y
    /* BB3A D0 E4    */ bne @lop_slots

    /* BB3C A5 00    */ lda zR00
    /* BB3E 85 74    */ sta zUnitLoadDst
    /* BB40 A5 01    */ lda zR00+1
    /* BB42 85 75    */ sta zUnitLoadDst+1

    /* BB44 A0 00    */ ldy #0

@lop_copy:
    /* BB46 B9 F4 76 */ lda sUnitBuf, Y
    /* BB49 91 74    */ sta (zUnitLoadDst), Y
    /* BB4B C8       */ iny
    /* BB4C C0 1B    */ cpy #_sizeof_Unit
    /* BB4E D0 F6    */ bne @lop_copy

    /* BB50 A0 11    */ ldy #Unit.x
    /* BB52 B1 74    */ lda (zUnitLoadDst), Y
    /* BB54 85 05    */ sta zR05
    /* BB56 A0 10    */ ldy #Unit.y
    /* BB58 B1 74    */ lda (zUnitLoadDst), Y
    /* BB5A 0A       */ asl A
    /* BB5B A8       */ tay
    /* BB5C B9 3D ED */ lda MapCellRows, Y
    /* BB5F 85 00    */ sta zR00
    /* BB61 B9 3E ED */ lda MapCellRows+1, Y
    /* BB64 85 01    */ sta zR00+1
    /* BB66 A5 05    */ lda zR05
    /* BB68 20 79 C3 */ jsr IncR00ByA

    /* BB6B A0 00    */ ldy #0
    /* BB6D B1 00    */ lda (zR00), Y
    /* BB6F A0 06    */ ldy #Unit.cell
    /* BB71 91 74    */ sta (zUnitLoadDst), Y
    /* BB73 A0 01    */ ldy #Unit.jid
    /* BB75 B1 74    */ lda (zUnitLoadDst), Y
    /* BB77 0A       */ asl A
    /* BB78 0D ED 76 */ ora sUnk76ED
    /* BB7B A0 00    */ ldy #0
    /* BB7D 91 00    */ sta (zR00), Y
    /* BB7F 18       */ clc

@end:
    /* BB80 68       */ pla
    /* BB81 A8       */ tay
    /* BB82 68       */ pla
    /* BB83 AA       */ tax
    /* BB84 60       */ rts

LoadMapEnemyUnits:
    /* BB85 A9 78    */ lda #<sRedUnits
    /* BB87 85 00    */ sta zR00
    /* BB89 A9 70    */ lda #>sRedUnits
    /* BB8B 85 01    */ sta zR00+1
    /* BB8D A9 37    */ lda #$37 ; TODO: <sizeof sRedUnits
    /* BB8F 85 02    */ sta zR02
    /* BB91 A9 02    */ lda #$02 ; TODO: >sizeof sRedUnits
    /* BB93 85 03    */ sta zR02+1
    /* BB95 A9 00    */ lda #0
    /* BB97 8D 06 77 */ sta sUnitBuf+Unit.unk_12

    /* BB9A 20 25 C2 */ jsr MemFill

    /* BB9D A9 F4    */ lda #<sUnitBuf
    /* BB9F 85 00    */ sta zR00
    /* BBA1 A9 76    */ lda #>sUnitBuf
    /* BBA3 85 01    */ sta zR00+1
    /* BBA5 A9 1B    */ lda #<_sizeof_Unit ; TODO: sizeof sUnitBuf
    /* BBA7 85 02    */ sta zR02
    /* BBA9 A9 00    */ lda #>_sizeof_Unit ; TODO: sizeof sUnitBuf
    /* BBAB 85 03    */ sta zR02+1

    /* BBAD 20 25 C2 */ jsr MemFill

    /* BBB0 AC 74 76 */ ldy sMapNum
    /* BBB3 88       */ dey
    /* BBB4 98       */ tya
    /* BBB5 0A       */ asl A
    /* BBB6 A8       */ tay
    /* BBB7 B9 A3 8A */ lda EnemyUnits, Y
    /* BBBA 85 76    */ sta zUnitLoadSrc
    /* BBBC B9 A4 8A */ lda EnemyUnits+1, Y
    /* BBBF 85 77    */ sta zUnitLoadSrc+1
    /* BBC1 A9 78    */ lda #<sRedUnits
    /* BBC3 85 74    */ sta zUnitLoadDst
    /* BBC5 A9 70    */ lda #>sRedUnits
    /* BBC7 85 75    */ sta zUnitLoadDst+1

    /* BBC9 D0 17    */ bne @begin

    /* BBCB A9 F4    */ lda #$F4
    /* BBCD 85 00    */ sta zR00
    /* BBCF A9 76    */ lda #$76

@lop:
    /* BBD1 20 F4 BB */ jsr EnemyInfoToUnit

    /* BBD4 20 10 BB */ jsr LoadUnit

    /* BBD7 A9 0B    */ lda #_sizeof_EnemyInfo
    /* BBD9 18       */ clc
    /* BBDA 65 76    */ adc zUnitLoadSrc
    /* BBDC 85 76    */ sta zUnitLoadSrc
    /* BBDE 90 02    */ bcc +

    /* BBE0 E6 77    */ inc zUnitLoadSrc+1

+:
@begin:
    /* BBE2 A0 00    */ ldy #0
    /* BBE4 B1 76    */ lda (zUnitLoadSrc), Y
    /* BBE6 D0 E9    */ bne @lop

    /* BBE8 A0 05    */ ldy #Unit.exp
    /* BBEA B9 78 70 */ lda sRedUnits, Y
    /* BBED 18       */ clc
    /* BBEE 69 0A    */ adc #10
    /* BBF0 99 78 70 */ sta sRedUnits, Y
    /* BBF3 60       */ rts

EnemyInfoToUnit:
    /* BBF4 B1 76    */ lda (zUnitLoadSrc), Y
    /* BBF6 8D F4 76 */ sta sUnitBuf+Unit.pid
    /* BBF9 C8       */ iny
    /* BBFA B1 76    */ lda (zUnitLoadSrc), Y
    /* BBFC 8D F5 76 */ sta sUnitBuf+Unit.jid
    /* BBFF C8       */ iny
    /* BC00 B1 76    */ lda (zUnitLoadSrc), Y
    /* BC02 8D F6 76 */ sta sUnitBuf+Unit.level
    /* BC05 38       */ sec
    /* BC06 E9 01    */ sbc #1
    /* BC08 4A       */ lsr A
    /* BC09 85 0B    */ sta zR0B
    /* BC0B C8       */ iny
    /* BC0C B1 76    */ lda (zUnitLoadSrc), Y
    /* BC0E 8D 07 77 */ sta sUnitBuf+Unit.item+0
    /* BC11 C8       */ iny
    /* BC12 B1 76    */ lda (zUnitLoadSrc), Y
    /* BC14 8D 08 77 */ sta sUnitBuf+Unit.item+1
    /* BC17 C8       */ iny
    /* BC18 B1 76    */ lda (zUnitLoadSrc), Y
    /* BC1A 8D 04 77 */ sta sUnitBuf+Unit.y
    /* BC1D C8       */ iny
    /* BC1E B1 76    */ lda (zUnitLoadSrc), Y
    /* BC20 8D 05 77 */ sta sUnitBuf+Unit.x
    /* BC23 C8       */ iny
    /* BC24 B1 76    */ lda (zUnitLoadSrc), Y
    /* BC26 8D 0B 77 */ sta sUnitBuf+Unit.uses+0
    /* BC29 C8       */ iny
    /* BC2A B1 76    */ lda (zUnitLoadSrc), Y
    /* BC2C 8D 0C 77 */ sta sUnitBuf+Unit.uses+1
    /* BC2F C8       */ iny
    /* BC30 B1 76    */ lda (zUnitLoadSrc), Y
    /* BC32 8D 0D 77 */ sta sUnitBuf+Unit.uses+2
    /* BC35 C8       */ iny
    /* BC36 B1 76    */ lda (zUnitLoadSrc), Y
    /* BC38 8D 0E 77 */ sta sUnitBuf+Unit.uses+3
    /* BC3B AD F5 76 */ lda sUnitBuf+Unit.jid
    /* BC3E 38       */ sec
    /* BC3F E9 01    */ sbc #1
    /* BC41 0A       */ asl A
    /* BC42 A8       */ tay
    /* BC43 B9 04 EC */ lda JobStats, Y
    /* BC46 85 00    */ sta zR00
    /* BC48 B9 05 EC */ lda JobStats+1, Y
    /* BC4B 85 01    */ sta zR00+1
    /* BC4D A0 00    */ ldy #0

@lop_stats:
    /* BC4F B1 00    */ lda (zR00), Y
    /* BC51 C0 04    */ cpy #(Unit.lck - Unit.str)
    /* BC53 F0 03    */ beq @skip_luck

    /* BC55 18       */ clc
    /* BC56 65 0B    */ adc zR0B

@skip_luck:
    /* BC58 99 FB 76 */ sta sUnitBuf+Unit.str, Y
    /* BC5B C8       */ iny
    /* BC5C C0 06    */ cpy #(Unit.mov - Unit.str)
    /* BC5E 90 EF    */ bcc @lop_stats

    /* BC60 B1 00    */ lda (zR00), Y
    /* BC62 8D 01 77 */ sta sUnitBuf+Unit.mov
    /* BC65 C8       */ iny
    /* BC66 A5 0B    */ lda zR0B
    /* BC68 0A       */ asl A
    /* BC69 18       */ clc
    /* BC6A 65 0B    */ adc zR0B
    /* BC6C 71 00    */ adc (zR00), Y
    /* BC6E 8D F7 76 */ sta sUnitBuf+Unit.hp_cur
    /* BC71 8D F8 76 */ sta sUnitBuf+Unit.hp_max
    /* BC74 C8       */ iny
    /* BC75 B1 00    */ lda (zR00), Y
    /* BC77 18       */ clc
    /* BC78 6D F6 76 */ adc sUnitBuf+Unit.level
    /* BC7B 69 FF    */ adc #$FF
    /* BC7D 8D F9 76 */ sta sUnitBuf+Unit.exp
    /* BC80 60       */ rts
