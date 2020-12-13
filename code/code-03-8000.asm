
    LOC_99E6 = $99E6
    LOC_9A81 = $9A81
    LOC_9E5D = $9E5D
    LOC_9EA0 = $9EA0
    LOC_9EEE = $9EEE

    MapReinforcements = $959C
    DAT_A3C1 = $A3C1
    DAT_A3DA = $A3DA
    DAT_A438 = $A438
    MapFirstReinforcementTurn = $A44E

CODE_03_8000:
    /* 8000 4C 0C 80 */ jmp FUNC_03_800C

CODE_03_8003:
    /* 8003 4C BD 82 */ jmp FUNC_03_82BD

CODE_03_8006:
    /* 8006 4C E6 99 */ jmp LOC_99E6

CODE_03_8009:
    /* 8009 4C EE 9E */ jmp LOC_9EEE

FUNC_03_800C:
    /* 800C AD 3F 05 */ lda wUnk053F
    /* 800F 20 4C C3 */ jsr Switch

    .dw FUNC_03_8022
    .dw HealEnemyUnitsFromTerrain
    .dw FUNC_03_8026
    .dw FUNC_03_8270
    .dw HealPlayerUnitsFromTerrain
    .dw FUNC_03_93EE
    .dw FUNC_03_802D
    .dw CaseRet

FUNC_03_8022:
    /* 8022 EE 3F 05 */ inc wUnk053F
    /* 8025 60       */ rts

FUNC_03_8026:
    /* 8026 20 6F 80 */ jsr PerhapsInitDangerMap

    /* 8029 EE 3F 05 */ inc wUnk053F
    /* 802C 60       */ rts

FUNC_03_802D:
    /* 802D A9 20    */ lda #$20
    /* 802F 85 84    */ sta zUnk84

    /* 8031 A9 00    */ lda #0
    /* 8033 8D 3F 05 */ sta wUnk053F

    /* 8036 60       */ rts

ClearMovementMap:
    /* 8037 AE 76 76 */ ldx sMapHeight
    /* 803A E8       */ inx
    /* 803B 86 0A    */ stx zR0A

    /* 803D AE 77 76 */ ldx sMapWidth
    /* 8040 E8       */ inx
    /* 8041 86 0B    */ stx zR0B

    /* 8043 A2 00    */ ldx #0

@lop_y:
    /* 8045 20 22 82 */ jsr GetMapMovementRow

    /* 8048 A0 00    */ ldy #0

@lop_x:
    /* 804A C0 00    */ cpy #0
    /* 804C F0 12    */ beq @edge

    /* 804E CC 77 76 */ cpy sMapWidth
    /* 8051 F0 0D    */ beq @edge

    /* 8053 E0 00    */ cpx #0
    /* 8055 F0 09    */ beq @edge

    /* 8057 EC 76 76 */ cpx sMapHeight
    /* 805A F0 04    */ beq @edge

    /* 805C A9 00    */ lda #0
    /* 805E F0 02    */ beq +

@edge:
    /* 8060 A9 FF    */ lda #$FF

+:
    /* 8062 91 6C    */ sta (zMapMovementRow), Y
    /* 8064 C8       */ iny
    /* 8065 C4 0B    */ cpy zR0B
    /* 8067 D0 E1    */ bne @lop_x

    /* 8069 E8       */ inx
    /* 806A E4 0A    */ cpx zR0A
    /* 806C 90 D7    */ bcc @lop_y

    /* 806E 60       */ rts

PerhapsInitDangerMap:
    /* 806F 20 A8 80 */ jsr ClearMap2

    /* 8072 20 67 82 */ jsr GetBlueUnits

    /* 8075 A2 00    */ ldx #0
    /* 8077 86 AD    */ stx zUnkAD

@lop:
    /* 8079 A0 00    */ ldy #Unit.pid
    /* 807B B1 9F    */ lda (zUnitPtrBlue), Y
    /* 807D F0 28    */ beq @end

    /* 807F A0 12    */ ldy #Unit.unk_12
    /* 8081 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 8083 C9 FF    */ cmp #$FF
    /* 8085 F0 13    */ beq @continue

    /* 8087 A0 10    */ ldy #Unit.y
    /* 8089 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 808B 8D 39 05 */ sta wUnk0539

    /* 808E C8       */ iny ; Unit.x
    /* 808F B1 9F    */ lda (zUnitPtrBlue), Y
    /* 8091 8D 38 05 */ sta wUnk0538

    /* 8094 20 CA 80 */ jsr FUNC_03_80CA

    /* 8097 20 2B 81 */ jsr FUNC_03_812B

@continue:
    /* 809A A6 AD    */ ldx zUnkAD
    /* 809C E8       */ inx
    /* 809D 86 AD    */ stx zUnkAD

    /* 809F A9 1B    */ lda #_sizeof_Unit
    /* 80A1 20 BC 91 */ jsr AddToBlueUnitPtr

    /* 80A4 4C 79 80 */ jmp @lop

@end:
    /* 80A7 60       */ rts

ClearMap2:
    /* 80A8 AE 76 76 */ ldx sMapHeight
    /* 80AB E8       */ inx
    /* 80AC 86 0A    */ stx zR0A

    /* 80AE AE 77 76 */ ldx sMapWidth
    /* 80B1 E8       */ inx
    /* 80B2 86 0B    */ stx zR0B

    /* 80B4 A2 00    */ ldx #0

@lop_y:
    /* 80B6 20 39 82 */ jsr GetMapRow2In9B

    /* 80B9 A0 00    */ ldy #0
    /* 80BB A9 00    */ lda #0

@lop_x:
    /* 80BD 91 9B    */ sta (zUnk9B), Y

    /* 80BF C8       */ iny
    /* 80C0 C4 0B    */ cpy zR0B
    /* 80C2 D0 F9    */ bne @lop_x

    /* 80C4 E8       */ inx
    /* 80C5 E4 0A    */ cpx zR0A
    /* 80C7 90 ED    */ bcc @lop_y

    /* 80C9 60       */ rts

FUNC_03_80CA:
    /* 80CA AC 38 05 */ ldy wUnk0538 ; x map position
    /* 80CD AE 39 05 */ ldx wUnk0539 ; y map position

    /* 80D0 88       */ dey

    ; { -1,  0 }

    /* 80D1 20 17 81 */ jsr FUNC_03_8117

    /* 80D4 E8       */ inx

    ; { -1, +1 }

    /* 80D5 20 21 81 */ jsr FUNC_03_8121

    /* 80D8 CA       */ dex
    /* 80D9 88       */ dey

    /* 80DA 30 03    */ bmi +

    ; { -2,  0 }

    /* 80DC 20 21 81 */ jsr FUNC_03_8121

+:
    /* 80DF C8       */ iny
    /* 80E0 C8       */ iny
    /* 80E1 C8       */ iny

    ; { +1,  0 }

    /* 80E2 20 17 81 */ jsr FUNC_03_8117

    /* 80E5 CA       */ dex

    ; { +1, -1 }

    /* 80E6 20 21 81 */ jsr FUNC_03_8121

    /* 80E9 E8       */ inx
    /* 80EA C8       */ iny

    /* 80EB C0 1F    */ cpy #MAP_ROW_MAX_LENGTH-1
    /* 80ED 10 03    */ bpl +

    ; { +2,  0 }

    /* 80EF 20 21 81 */ jsr FUNC_03_8121

+:
    /* 80F2 88       */ dey
    /* 80F3 88       */ dey
    /* 80F4 CA       */ dex

    ; {  0, -1 }

    /* 80F5 20 17 81 */ jsr FUNC_03_8117

    /* 80F8 88       */ dey

    ; { -1, -1 }

    /* 80F9 20 21 81 */ jsr FUNC_03_8121

    /* 80FC C8       */ iny
    /* 80FD CA       */ dex

    /* 80FE 30 03    */ bmi +

    ; {  0, -2 }

    /* 8100 20 21 81 */ jsr FUNC_03_8121

+:
    /* 8103 E8       */ inx
    /* 8104 E8       */ inx
    /* 8105 E8       */ inx

    ; {  0, +1 }

    /* 8106 20 17 81 */ jsr FUNC_03_8117

    /* 8109 C8       */ iny

    ; { +1, +1 }

    /* 810A 20 21 81 */ jsr FUNC_03_8121

    /* 810D 88       */ dey
    /* 810E E8       */ inx

    /* 810F E0 1D    */ cpx #MAP_ROW_COUNT-1
    /* 8111 10 03    */ bpl +

    ; {  0, +2 }

    /* 8113 20 21 81 */ jsr FUNC_03_8121

+:
    /* 8116 60       */ rts

FUNC_03_8117:
    ; 1 cell away

    /* 8117 20 39 82 */ jsr GetMapRow2In9B

    /* 811A B1 9B    */ lda (zUnk9B), Y
    /* 811C 09 20    */ ora #$20
    /* 811E 91 9B    */ sta (zUnk9B), Y
    /* 8120 60       */ rts

FUNC_03_8121:
    ; 2 cells away

    /* 8121 20 39 82 */ jsr GetMapRow2In9B

    /* 8124 B1 9B    */ lda (zUnk9B), Y
    /* 8126 09 40    */ ora #$40
    /* 8128 91 9B    */ sta (zUnk9B), Y
    /* 812A 60       */ rts

FUNC_03_812B:
    /* 812B 20 0D C7 */ jsr WaitFrame

    /* 812E A0 07    */ ldy #Unit.str
    /* 8130 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 8132 85 B5    */ sta zUnkB5

    /* 8134 A0 13    */ ldy #Unit.item
    /* 8136 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 8138 A8       */ tay
    /* 8139 88       */ dey

    /* 813A B9 C3 D9 */ lda ItemInfo.Unk_D9C3, Y
    /* 813D 29 06    */ and #%00000110
    /* 813F 4A       */ lsr A
    /* 8140 85 AF    */ sta zUnkAF

    /* 8142 B9 57 D6 */ lda ItemInfo.might, Y
    /* 8145 18       */ clc
    /* 8146 65 B5    */ adc zUnkB5
    /* 8148 85 B5    */ sta zUnkB5

    /* 814A C9 1F    */ cmp #$1F
    /* 814C 30 02    */ bmi +

    /* 814E A9 1F    */ lda #$1F

+:
    /* 8150 85 A7    */ sta zUnkA7

    /* 8152 A0 0D    */ ldy #Unit.mov
    /* 8154 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 8156 85 BF    */ sta zMapFloodRingCount

    /* 8158 AD 38 05 */ lda wUnk0538
    /* 815B 8D 00 05 */ sta wUnk0500

    /* 815E AD 39 05 */ lda wUnk0539
    /* 8161 8D 01 05 */ sta wUnk0501

    /* 8164 A9 01    */ lda #1
    /* 8166 85 B8    */ sta zMapFloodAction

    /* 8168 20 37 80 */ jsr ClearMovementMap
    /* 816B 20 E4 8F */ jsr FloodMovementMap

    /* 816E 60       */ rts

FUNC_03_816F:
    /* 816F 8A       */ txa
    /* 8170 48       */ pha
    /* 8171 98       */ tya
    /* 8172 48       */ pha

    /* 8173 E8       */ inx

    /* 8174 A5 AF    */ lda zUnkAF

    /* 8176 29 01    */ and #$01
    /* 8178 F0 03    */ beq +

    /* 817A 20 0E 82 */ jsr FUNC_03_820E

+:
    /* 817D A5 AF    */ lda zUnkAF

    /* 817F 29 02    */ and #$02
    /* 8181 F0 16    */ beq @LOC_8199

    /* 8183 C8       */ iny
    /* 8184 20 0E 82 */ jsr FUNC_03_820E

    /* 8187 88       */ dey
    /* 8188 A5 C1    */ lda zUnkC1
    /* 818A 18       */ clc
    /* 818B 69 02    */ adc #2
    /* 818D CD 76 76 */ cmp sMapHeight
    /* 8190 90 03    */ bcc +

    /* 8192 AD 76 76 */ lda sMapHeight

+:
    /* 8195 AA       */ tax
    /* 8196 20 0E 82 */ jsr FUNC_03_820E

@LOC_8199:
    /* 8199 A6 C1    */ ldx zUnkC1
    /* 819B C8       */ iny
    /* 819C A5 AF    */ lda zUnkAF
    /* 819E 29 01    */ and #$01
    /* 81A0 F0 03    */ beq +

    /* 81A2 20 0E 82 */ jsr FUNC_03_820E

+:
    /* 81A5 A5 AF    */ lda zUnkAF
    /* 81A7 29 02    */ and #$02
    /* 81A9 F0 16    */ beq @LOC_81C1

    /* 81AB CA       */ dex
    /* 81AC 20 0E 82 */ jsr FUNC_03_820E

    /* 81AF E8       */ inx
    /* 81B0 A5 C0    */ lda zUnkC0
    /* 81B2 18       */ clc
    /* 81B3 69 02    */ adc #$02
    /* 81B5 CD 77 76 */ cmp sMapWidth
    /* 81B8 90 03    */ bcc +

    /* 81BA AD 77 76 */ lda sMapWidth

+:
    /* 81BD A8       */ tay
    /* 81BE 20 0E 82 */ jsr FUNC_03_820E

@LOC_81C1:
    /* 81C1 A4 C0    */ ldy zUnkC0
    /* 81C3 CA       */ dex
    /* 81C4 A5 AF    */ lda zUnkAF
    /* 81C6 29 01    */ and #$01
    /* 81C8 F0 03    */ beq +

    /* 81CA 20 0E 82 */ jsr FUNC_03_820E

+:
    /* 81CD A5 AF    */ lda zUnkAF
    /* 81CF 29 02    */ and #$02
    /* 81D1 F0 12    */ beq @LOC_81E5

    /* 81D3 88       */ dey
    /* 81D4 20 0E 82 */ jsr FUNC_03_820E

    /* 81D7 C8       */ iny
    /* 81D8 A5 C1    */ lda zUnkC1
    /* 81DA 38       */ sec
    /* 81DB E9 02    */ sbc #$02
    /* 81DD B0 02    */ bcs +

    /* 81DF A9 00    */ lda #$00

+:
    /* 81E1 AA       */ tax
    /* 81E2 20 0E 82 */ jsr FUNC_03_820E

@LOC_81E5:
    /* 81E5 A6 C1    */ ldx zUnkC1
    /* 81E7 88       */ dey
    /* 81E8 A5 AF    */ lda zUnkAF
    /* 81EA 29 01    */ and #$01
    /* 81EC F0 03    */ beq +

    /* 81EE 20 0E 82 */ jsr FUNC_03_820E

+:
    /* 81F1 A5 AF    */ lda zUnkAF
    /* 81F3 29 02    */ and #$02
    /* 81F5 F0 12    */ beq @LOC_8209

    /* 81F7 E8       */ inx
    /* 81F8 20 0E 82 */ jsr FUNC_03_820E

    /* 81FB CA       */ dex
    /* 81FC A5 C0    */ lda zUnkC0
    /* 81FE 38       */ sec
    /* 81FF E9 02    */ sbc #$02
    /* 8201 B0 02    */ bcs +

    /* 8203 A9 00    */ lda #$00

+:
    /* 8205 A8       */ tay
    /* 8206 20 0E 82 */ jsr FUNC_03_820E

@LOC_8209:
    /* 8209 68       */ pla
    /* 820A A8       */ tay
    /* 820B 68       */ pla
    /* 820C AA       */ tax

    /* 820D 60       */ rts

FUNC_03_820E:
    /* 820E 20 39 82 */ jsr GetMapRow2In9B

    /* 8211 B1 9B    */ lda (zUnk9B), Y
    /* 8213 29 1F    */ and #$1F
    /* 8215 C5 A7    */ cmp zUnkA7
    /* 8217 B0 08    */ bcs + ; bhs

    /* 8219 B1 9B    */ lda (zUnk9B), Y
    /* 821B 29 E0    */ and #$E0
    /* 821D 05 A7    */ ora zUnkA7
    /* 821F 91 9B    */ sta (zUnk9B), Y

+:
    /* 8221 60       */ rts

GetMapMovementRow:
    /* 8222 8A       */ txa
    /* 8223 48       */ pha

    /* 8224 C9 1E    */ cmp #MAP_ROW_COUNT
    /* 8226 30 02    */ bmi +

    /* 8228 A9 00    */ lda #0

+:
    /* 822A 0A       */ asl A
    /* 822B AA       */ tax

    /* 822C BD 01 ED */ lda MapMovementRows.w, X
    /* 822F 85 6C    */ sta zMapMovementRow
    /* 8231 BD 02 ED */ lda MapMovementRows.w+1, X
    /* 8234 85 6D    */ sta zMapMovementRow+1

    /* 8236 68       */ pla
    /* 8237 AA       */ tax

    /* 8238 60       */ rts

GetMapRow2In9B:
    /* 8239 8A       */ txa
    /* 823A 48       */ pha

    /* 823B C9 1E    */ cmp #MAP_ROW_COUNT
    /* 823D 30 02    */ bmi +

    /* 823F A9 00    */ lda #0

+:
    /* 8241 0A       */ asl A
    /* 8242 AA       */ tax

    /* 8243 BD 79 ED */ lda MapRows2.w, X
    /* 8246 85 9B    */ sta zUnk9B
    /* 8248 BD 7A ED */ lda MapRows2.w+1, X
    /* 824B 85 9C    */ sta zUnk9B+1

    /* 824D 68       */ pla
    /* 824E AA       */ tax

    /* 824F 60       */ rts

GetMapCellRowInR04:
    /* 8250 8A       */ txa
    /* 8251 48       */ pha

    /* 8252 C9 1E    */ cmp #MAP_ROW_COUNT
    /* 8254 30 02    */ bmi +

    /* 8256 A9 00    */ lda #0

+:
    /* 8258 0A       */ asl A
    /* 8259 AA       */ tax

    /* 825A BD 3D ED */ lda MapCellRows.w, X
    /* 825D 85 04    */ sta zR04
    /* 825F BD 3E ED */ lda MapCellRows.w+1, X
    /* 8262 85 05    */ sta zR04+1

    /* 8264 68       */ pla
    /* 8265 AA       */ tax

    /* 8266 60       */ rts

GetBlueUnits:
    /* 8267 A9 90    */ lda #<sBlueUnits
    /* 8269 85 9F    */ sta zUnitPtrBlue
    /* 826B A9 6A    */ lda #>sBlueUnits
    /* 826D 85 A0    */ sta zUnitPtrBlue+1

    /* 826F 60       */ rts

FUNC_03_8270:
    /* 8270 AD 42 05 */ lda wUnk0542
    /* 8273 F0 03    */ beq +

    /* 8275 4C 17 83 */ jmp CODE_03_8317

+:
    /* 8278 20 34 83 */ jsr FUNC_03_8334

    /* 827B 20 D2 8F */ jsr GetRedUnits

    /* 827E A2 00    */ ldx #0
    /* 8280 86 AD    */ stx zUnkAD

CODE_03_8282:
    /* 8282 A0 00    */ ldy #Unit.pid
    /* 8284 B1 9D    */ lda (zUnitPtrRed), Y

    /* 8286 D0 03    */ bne +

    /* 8288 4C 2C 83 */ jmp CODE_03_832C

+:
    /* 828B A0 12    */ ldy #Unit.unk_12
    /* 828D B1 9D    */ lda (zUnitPtrRed), Y

    /* 828F C9 FF    */ cmp #$FF
    /* 8291 D0 03    */ bne +

    /* 8293 4C 1F 83 */ jmp CODE_03_831F

+:
    /* 8296 A0 10    */ ldy #Unit.y
    /* 8298 B1 9D    */ lda (zUnitPtrRed), Y
    /* 829A 8D 39 05 */ sta wUnk0539

    /* 829D C8       */ iny ; Unit.x
    /* 829E B1 9D    */ lda (zUnitPtrRed), Y
    /* 82A0 8D 38 05 */ sta wUnk0538

    /* 82A3 A0 17    */ ldy #Unit.uses
    /* 82A5 B1 9D    */ lda (zUnitPtrRed), Y
    /* 82A7 85 AC    */ sta zUnkAC

    /* 82A9 8E C3 05 */ stx wUnk05C3

    /* 82AC 20 00 84 */ jsr FUNC_03_8400

    /* 82AF 20 A4 85 */ jsr FUNC_03_85A4

    /* 82B2 A0 12    */ ldy #Unit.unk_12
    /* 82B4 B1 9D    */ lda (zUnitPtrRed), Y

    /* 82B6 C9 FF    */ cmp #$FF
    /* 82B8 F0 03    */ beq FUNC_03_82BD

    /* 82BA 4C 98 83 */ jmp FUNC_03_8398

FUNC_03_82BD:
    /* 82BD A0 12    */ ldy #Unit.unk_12
    /* 82BF B1 9D    */ lda (zUnitPtrRed), Y

    /* 82C1 C9 FF    */ cmp #$FF
    /* 82C3 F0 52    */ beq CODE_03_8317

    /* 82C5 A0 01    */ ldy #Unit.jid
    /* 82C7 B1 9D    */ lda (zUnitPtrRed), Y

    /* 82C9 C9 09    */ cmp #JID_THIEF
    /* 82CB D0 4A    */ bne CODE_03_8317

    /* 82CD A0 06    */ ldy #Unit.cell
    /* 82CF B1 9D    */ lda (zUnitPtrRed), Y

    /* 82D1 48       */ pha

    /* 82D2 C9 A5    */ cmp #CELL_VILLAGE_OPENED
    /* 82D4 D0 2B    */ bne @not_village

    /* 82D6 A9 A9    */ lda #CELL_VILLAGE_DESTROYED
    /* 82D8 91 9D    */ sta (zUnitPtrRed), Y

    /* 82DA A0 10    */ ldy #Unit.y
    /* 82DC B1 9D    */ lda (zUnitPtrRed), Y
    /* 82DE AA       */ tax
    /* 82DF CA       */ dex
    /* 82E0 20 50 82 */ jsr GetMapCellRowInR04
    /* 82E3 C8       */ iny ; Unit.x
    /* 82E4 B1 9D    */ lda (zUnitPtrRed), Y
    /* 82E6 A8       */ tay
    /* 82E7 A9 AD    */ lda #CELL_HOUSE_DESTROYED
    /* 82E9 91 04    */ sta (zR04), Y
    /* 82EB 86 04    */ stx zR04
    /* 82ED 84 05    */ sty zR05
    /* 82EF 85 0B    */ sta zR0B

    /* 82F1 A9 0D    */ lda #$0D
    /* 82F3 85 44    */ sta zFarFuncNum
    /* 82F5 A9 06    */ lda #$06
    /* 82F7 20 FA C9 */ jsr CallFarFunc

    /* 82FA A9 80    */ lda #$80
    /* 82FC 8D F0 06 */ sta wUnk06F0

    /* 82FF D0 15    */ bne @LOC_8316

@not_village:
    /* 8301 68       */ pla

    /* 8302 C9 AB    */ cmp #CELL_CHEST_CLOSED
    /* 8304 D0 11    */ bne CODE_03_8317

    /* 8306 A9 AC    */ lda #CELL_CHEST_OPENED
    /* 8308 91 9D    */ sta (zUnitPtrRed), Y
    /* 830A A9 80    */ lda #$80
    /* 830C 8D F0 06 */ sta wUnk06F0
    /* 830F A9 01    */ lda #1
    /* 8311 8D 48 05 */ sta wUnk0548

    /* 8314 D0 01    */ bne CODE_03_8317

@LOC_8316:
    /* 8316 68       */ pla

CODE_03_8317:
    /* 8317 20 CE 8C */ jsr FUNC_03_8CCE

    /* 831A AD 42 05 */ lda wUnk0542
    /* 831D D0 10    */ bne CODE_03_832F

CODE_03_831F:
    /* 831F A6 AD    */ ldx zUnkAD
    /* 8321 E8       */ inx
    /* 8322 86 AD    */ stx zUnkAD

    /* 8324 A9 1B    */ lda #_sizeof_Unit
    /* 8326 20 C6 91 */ jsr AddToRedUnitPtr

    /* 8329 4C 82 82 */ jmp CODE_03_8282

CODE_03_832C:
    /* 832C EE 3F 05 */ inc wUnk053F

CODE_03_832F:
    /* 832F A9 27    */ lda #$27
    /* 8331 85 84    */ sta zUnk84

    /* 8333 60       */ rts

FUNC_03_8334:
    /* 8334 20 D2 8F */ jsr GetRedUnits

    /* 8337 A2 00    */ ldx #0
    /* 8339 86 AD    */ stx zUnkAD

    /* 833B F0 49    */ beq @continue

@lop:
    /* 833D A0 12    */ ldy #Unit.unk_12
    /* 833F B1 9D    */ lda (zUnitPtrRed), Y

    /* 8341 C9 FF    */ cmp #$FF
    /* 8343 F0 06    */ beq +

    /* 8345 A0 00    */ ldy #Unit.pid
    /* 8347 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8349 D0 3B    */ bne @continue

+:
    /* 834B 20 D0 91 */ jsr SpawnEnemyReinforcement

    /* 834E C9 00    */ cmp #0
    /* 8350 F0 34    */ beq @continue

    /* 8352 A0 17    */ ldy #Unit.uses
    /* 8354 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8356 29 03    */ and #$03
    /* 8358 85 A3    */ sta zUnkA3
    /* 835A B1 9D    */ lda (zUnitPtrRed), Y
    /* 835C 29 1C    */ and #$1C
    /* 835E 0A       */ asl A
    /* 835F 0A       */ asl A
    /* 8360 05 A3    */ ora zUnkA3
    /* 8362 A0 16    */ ldy #Unit.item+3
    /* 8364 91 9D    */ sta (zUnitPtrRed), Y

    /* 8366 A0 00    */ ldy #0

    /* 8368 A0 11    */ ldy #Unit.x
    /* 836A B1 9D    */ lda (zUnitPtrRed), Y
    /* 836C 8D 00 05 */ sta wUnk0500
    /* 836F 88       */ dey ; Unit.y
    /* 8370 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8372 8D 01 05 */ sta wUnk0501

    /* 8375 A9 F4    */ lda #<sUnitBuf
    /* 8377 85 74    */ sta zUnitLoadDst
    /* 8379 A9 76    */ lda #>sUnitBuf
    /* 837B 85 75    */ sta zUnitLoadDst+1

    /* 837D A9 0C    */ lda #$0C
    /* 837F 85 44    */ sta zFarFuncNum
    /* 8381 A9 06    */ lda #$06
    /* 8383 20 FA C9 */ jsr CallFarFunc

@continue:
    /* 8386 A6 AD    */ ldx zUnkAD
    /* 8388 E8       */ inx

    /* 8389 E0 14    */ cpx #20
    /* 838B B0 0A    */ bcs @end

    /* 838D 86 AD    */ stx zUnkAD
    /* 838F A9 1B    */ lda #_sizeof_Unit
    /* 8391 20 C6 91 */ jsr AddToRedUnitPtr

    /* 8394 4C 3D 83 */ jmp @lop

@end:
    /* 8397 60       */ rts

FUNC_03_8398:
    /* 8398 AC 38 05 */ ldy wUnk0538
    /* 839B AE 39 05 */ ldx wUnk0539

    /* 839E EC C0 05 */ cpx wUnk05C0
    /* 83A1 D0 33    */ bne @LOC_83D6

    /* 83A3 CC C1 05 */ cpy wUnk05C1
    /* 83A6 D0 2E    */ bne @LOC_83D6

    /* 83A8 AD C2 05 */ lda wUnk05C2
    /* 83AB C9 FF    */ cmp #-1
    /* 83AD D0 4C    */ bne @LOC_83FB

    /* 83AF A0 00    */ ldy #Unit.pid
    /* 83B1 B1 9D    */ lda (zUnitPtrRed), Y

    /* 83B3 C9 A5    */ cmp #PID_A5
    /* 83B5 F0 44    */ beq @LOC_83FB

    /* 83B7 C9 B0    */ cmp #PID_B0
    /* 83B9 F0 40    */ beq @LOC_83FB

    /* 83BB C9 B1    */ cmp #PID_B1
    /* 83BD F0 3C    */ beq @LOC_83FB

    /* 83BF C9 B2    */ cmp #PID_B2
    /* 83C1 F0 38    */ beq @LOC_83FB

    /* 83C3 C9 B6    */ cmp #PID_B6
    /* 83C5 F0 34    */ beq @LOC_83FB

    /* 83C7 C9 AE    */ cmp #PID_AE
    /* 83C9 F0 30    */ beq @LOC_83FB

    /* 83CB C9 AD    */ cmp #PID_AD
    /* 83CD F0 2C    */ beq @LOC_83FB

    /* 83CF C9 9C    */ cmp #PID_9C
    /* 83D1 F0 28    */ beq @LOC_83FB

@LOC_83D3:
    /* 83D3 4C BD 82 */ jmp FUNC_03_82BD

@LOC_83D6:
    /* 83D6 AE C0 05 */ ldx wUnk05C0
    /* 83D9 86 B3    */ stx zUnkB3
    /* 83DB AC C1 05 */ ldy wUnk05C1
    /* 83DE 84 B2    */ sty zUnkB2

    /* 83E0 20 50 82 */ jsr GetMapCellRowInR04

    /* 83E3 B1 04    */ lda (zR04), Y
    /* 83E5 A8       */ tay
    /* 83E6 B9 F8 E8 */ lda Cell2TerrainRed, Y

    /* 83E9 C9 0E    */ cmp #TERRAIN_ALLY
    /* 83EB F0 E6    */ beq @LOC_83D3

    /* 83ED C9 1F    */ cmp #TERRAIN_ENEMY
    /* 83EF F0 E2    */ beq @LOC_83D3

    /* 83F1 20 4A 91 */ jsr FindEnemyUnitAtToR02

    /* 83F4 90 DD    */ bcc @LOC_83D3

    /* 83F6 20 44 91 */ jsr FindPlayerUnitAtTo9F

    /* 83F9 90 D8    */ bcc @LOC_83D3

@LOC_83FB:
    /* 83FB A9 28    */ lda #$28
    /* 83FD 85 84    */ sta zUnk84

    /* 83FF 60       */ rts

FUNC_03_8400:
    /* 8400 A0 16    */ ldy #Unit.item+3
    /* 8402 B1 9D    */ lda (zUnitPtrRed), Y

    /* 8404 29 0C    */ and #%00001100
    /* 8406 4A       */ lsr A
    /* 8407 4A       */ lsr A
    /* 8408 85 A9    */ sta zUnkA9

    /* 840A 20 4C C3 */ jsr Switch

    .dw @CODE_03_8415
    .dw @CODE_03_8524
    .dw @CODE_03_8547
    .dw @CODE_03_8548

@CODE_03_8415:
    /* 8415 A5 AC    */ lda zUnkAC
    /* 8417 29 60    */ and #$60
    /* 8419 F0 2B    */ beq @CODE_03_8446

    /* 841B 29 40    */ and #$40
    /* 841D 85 A3    */ sta zUnkA3

    /* 841F 20 33 84 */ jsr @CODE_03_8433

    /* 8422 B0 22    */ bcs @CODE_03_8446

    ; fallthrough

@CODE_03_8424:
    /* 8424 A9 00    */ lda #0
    /* 8426 85 AB    */ sta zUnkAB
    /* 8428 A9 00    */ lda #0
    /* 842A 85 AA    */ sta zUnkAA
    /* 842C A9 01    */ lda #1
    /* 842E 85 A9    */ sta zUnkA9

    /* 8430 4C 15 85 */ jmp @CODE_03_8515

@CODE_03_8433:
    /* 8433 A0 04    */ ldy #Unit.hp_max
    /* 8435 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8437 85 B0    */ sta zUnkB0
    /* 8439 88       */ dey ; Unit.hp_cur
    /* 843A B1 9D    */ lda (zUnitPtrRed), Y
    /* 843C 0A       */ asl A

    /* 843D A6 A3    */ ldx zUnkA3
    /* 843F D0 01    */ bne +

    /* 8441 0A       */ asl A

+:
    /* 8442 C8       */ iny
    /* 8443 C5 B0    */ cmp zUnkB0
    /* 8445 60       */ rts

@CODE_03_8446:
    /* 8446 A5 AD    */ lda zUnkAD
    /* 8448 F0 08    */ beq @LOC_8452

    /* 844A A0 01    */ ldy #Unit.jid
    /* 844C B1 9D    */ lda (zUnitPtrRed), Y

    /* 844E C9 13    */ cmp #JID_PRIEST
    /* 8450 D0 03    */ bne @LOC_8455

@LOC_8452:
    /* 8452 4C 23 85 */ jmp @CODE_03_8523

@LOC_8455:
    /* 8455 A5 AC    */ lda zUnkAC
    /* 8457 29 80    */ and #$80
    /* 8459 F0 18    */ beq @LOC_8473

    /* 845B A0 18    */ ldy #Unit.uses+1
    /* 845D B1 9D    */ lda (zUnitPtrRed), Y

    /* 845F CD 75 76 */ cmp sTurnNumber
    /* 8462 B0 0F    */ bcs @LOC_8473

    /* 8464 A9 03    */ lda #3
    /* 8466 85 A9    */ sta zUnkA9
    /* 8468 A9 00    */ lda #0
    /* 846A 85 AA    */ sta zUnkAA
    /* 846C A9 07    */ lda #7
    /* 846E 85 AB    */ sta zUnkAB

    /* 8470 4C 15 85 */ jmp @CODE_03_8515

@LOC_8473:
    /* 8473 A5 AC    */ lda zUnkAC
    /* 8475 29 1C    */ and #$1C
    /* 8477 4A       */ lsr A
    /* 8478 4A       */ lsr A
    /* 8479 85 AB    */ sta zUnkAB

    /* 847B C9 01    */ cmp #$01
    /* 847D D0 03    */ bne @LOC_8482

    /* 847F 4C 23 85 */ jmp @CODE_03_8523

@LOC_8482:
    /* 8482 C9 02    */ cmp #$02
    /* 8484 D0 32    */ bne @CODE_03_84B8

    /* 8486 20 67 82 */ jsr GetBlueUnits

    /* 8489 A2 00    */ ldx #0

@CODE_03_848B:
    /* 848B A0 00    */ ldy #Unit.pid
    /* 848D B1 9F    */ lda (zUnitPtrBlue), Y
    /* 848F D0 03    */ bne @CODE_03_8494

    /* 8491 4C 09 85 */ jmp @CODE_03_8509

@CODE_03_8494:
    /* 8494 A0 12    */ ldy #Unit.unk_12
    /* 8496 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 8498 C9 FF    */ cmp #-1
    /* 849A F0 10    */ beq @CODE_03_84AC

    /* 849C A0 01    */ ldy #Unit.jid
    /* 849E B1 9F    */ lda (zUnitPtrBlue), Y

    /* 84A0 C9 13    */ cmp #JID_PRIEST
    /* 84A2 F0 11    */ beq @CODE_03_84B5

    /* 84A4 C9 10    */ cmp #JID_COMMANDO
    /* 84A6 F0 0D    */ beq @CODE_03_84B5

    /* 84A8 C9 09    */ cmp #JID_THIEF
    /* 84AA F0 09    */ beq @CODE_03_84B5

@CODE_03_84AC:
    /* 84AC E8       */ inx

    /* 84AD A9 1B    */ lda #_sizeof_Unit
    /* 84AF 20 BC 91 */ jsr AddToBlueUnitPtr

    /* 84B2 4C 8B 84 */ jmp @CODE_03_848B

@CODE_03_84B5:
    /* 84B5 4C 23 85 */ jmp @CODE_03_8523

@CODE_03_84B8:
    /* 84B8 C9 04    */ cmp #$04
    /* 84BA D0 28    */ bne @CODE_03_84E4

    /* 84BC 20 DB 8F */ jsr GetRedUnitsInR02

    /* 84BF A2 00    */ ldx #0

@CODE_03_84C1:
    /* 84C1 E4 AD    */ cpx zUnkAD
    /* 84C3 F0 16    */ beq @CODE_03_84DB

    /* 84C5 A0 00    */ ldy #Unit.pid
    /* 84C7 B1 02    */ lda (zR02), Y
    /* 84C9 F0 3E    */ beq @CODE_03_8509

    /* 84CB A0 12    */ ldy #Unit.unk_12
    /* 84CD B1 02    */ lda (zR02), Y
    /* 84CF C9 FF    */ cmp #-1
    /* 84D1 F0 08    */ beq @CODE_03_84DB

    /* 84D3 A0 01    */ ldy #Unit.jid
    /* 84D5 B1 02    */ lda (zR02), Y

    /* 84D7 C9 13    */ cmp #JID_PRIEST
    /* 84D9 F0 09    */ beq @CODE_03_84E4

@CODE_03_84DB:
    /* 84DB E8       */ inx
    /* 84DC A0 1B    */ ldy #_sizeof_Unit
    /* 84DE 20 83 C3 */ jsr IncR02ByY

    /* 84E1 4C C1 84 */ jmp @CODE_03_84C1

@CODE_03_84E4:
    /* 84E4 20 DB 8F */ jsr GetRedUnitsInR02

    /* 84E7 A2 00    */ ldx #0
    /* 84E9 86 A3    */ stx zUnkA3

@CODE_03_84EB:
    /* 84EB A0 00    */ ldy #Unit.pid
    /* 84ED B1 02    */ lda (zR02), Y
    /* 84EF F0 18    */ beq @CODE_03_8509

    /* 84F1 A0 12    */ ldy #Unit.unk_12
    /* 84F3 B1 02    */ lda (zR02), Y
    /* 84F5 C9 FF    */ cmp #-1
    /* 84F7 F0 08    */ beq @CODE_03_8501

    /* 84F9 E6 A3    */ inc zUnkA3
    /* 84FB A5 A3    */ lda zUnkA3
    /* 84FD C9 05    */ cmp #5
    /* 84FF B0 22    */ bcs @CODE_03_8523

@CODE_03_8501:
    /* 8501 A0 1B    */ ldy #_sizeof_Unit
    /* 8503 20 83 C3 */ jsr IncR02ByY

    /* 8506 4C EB 84 */ jmp @CODE_03_84EB

@CODE_03_8509:
    /* 8509 A9 01    */ lda #1
    /* 850B 85 AA    */ sta zUnkAA
    /* 850D A9 02    */ lda #2
    /* 850F 85 A9    */ sta zUnkA9
    /* 8511 A9 01    */ lda #1
    /* 8513 85 AB    */ sta zUnkAB

@CODE_03_8515:
    /* 8515 A5 AB    */ lda zUnkAB
    /* 8517 0A       */ asl A
    /* 8518 0A       */ asl A
    /* 8519 05 A9    */ ora zUnkA9
    /* 851B 0A       */ asl A
    /* 851C 0A       */ asl A
    /* 851D 05 AA    */ ora zUnkAA
    /* 851F A0 16    */ ldy #Unit.item+3
    /* 8521 91 9D    */ sta (zUnitPtrRed), Y

@CODE_03_8523:
    /* 8523 60       */ rts

@CODE_03_8524:
    /* 8524 A5 AC    */ lda zUnkAC
    /* 8526 29 40    */ and #$40
    /* 8528 85 A3    */ sta zUnkA3

    /* 852A 20 33 84 */ jsr @CODE_03_8433

    /* 852D B0 03    */ bcs @CODE_03_8532

    /* 852F 4C 24 84 */ jmp @CODE_03_8424

@CODE_03_8532:
    /* 8532 A9 00    */ lda #0
    /* 8534 85 A9    */ sta zUnkA9

    /* 8536 A5 AC    */ lda zUnkAC
    /* 8538 29 03    */ and #$03
    /* 853A 85 AA    */ sta zUnkAA

    /* 853C A5 AC    */ lda zUnkAC
    /* 853E 29 1C    */ and #$1C
    /* 8540 4A       */ lsr A
    /* 8541 4A       */ lsr A
    /* 8542 85 AB    */ sta zUnkAB

    /* 8544 4C 15 85 */ jmp @CODE_03_8515

@CODE_03_8547:
    /* 8547 60       */ rts

@CODE_03_8548:
    /* 8548 A0 00    */ ldy #Unit.pid
    /* 854A B1 9D    */ lda (zUnitPtrRed), Y

    /* 854C C9 9C    */ cmp #PID_9C
    /* 854E F0 53    */ beq FUNC_03_8550@CODE_03_85A3

FUNC_03_8550:
    /* 8550 A0 19    */ ldy #Unit.uses+2
    /* 8552 B1 9D    */ lda (zUnitPtrRed), Y

    /* 8554 CD 39 05 */ cmp wUnk0539
    /* 8557 D0 4A    */ bne @CODE_03_85A3

    /* 8559 C8       */ iny ; Unit.uses+3
    /* 855A B1 9D    */ lda (zUnitPtrRed), Y

    /* 855C CD 38 05 */ cmp wUnk0538
    /* 855F D0 42    */ bne @CODE_03_85A3

    /* 8561 AE 39 05 */ ldx wUnk0539
    /* 8564 20 50 82 */ jsr GetMapCellRowInR04

    /* 8567 A0 06    */ ldy #Unit.cell
    /* 8569 B1 9D    */ lda (zUnitPtrRed), Y

    /* 856B AC 38 05 */ ldy wUnk0538
    /* 856E 91 04    */ sta (zR04), Y

    /* 8570 85 0B    */ sta zR0B
    /* 8572 84 05    */ sty zR05
    /* 8574 86 04    */ stx zR04

    /* 8576 A9 0D    */ lda #$0D
    /* 8578 85 44    */ sta zFarFuncNum
    /* 857A A9 06    */ lda #$06
    /* 857C 20 FA C9 */ jsr CallFarFunc

    /* 857F AE 39 05 */ ldx wUnk0539
    /* 8582 20 50 82 */ jsr GetMapCellRowInR04

    /* 8585 A0 06    */ ldy #Unit.cell
    /* 8587 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8589 AC 38 05 */ ldy wUnk0538
    /* 858C 85 0B    */ sta zR0B
    /* 858E 84 05    */ sty zR05
    /* 8590 86 04    */ stx zR04

    /* 8592 A9 07    */ lda #$07
    /* 8594 85 44    */ sta zFarFuncNum
    /* 8596 A9 06    */ lda #$06
    /* 8598 20 FA C9 */ jsr CallFarFunc

    /* 859B A9 FF    */ lda #-1
    /* 859D A0 12    */ ldy #Unit.unk_12
    /* 859F 91 9D    */ sta (zUnitPtrRed), Y

    /* 85A1 A9 00    */ lda #0

@CODE_03_85A3:
    /* 85A3 60       */ rts

FUNC_03_85A4:
    /* 85A4 A0 16    */ ldy #Unit.item+3
    /* 85A6 B1 9D    */ lda (zUnitPtrRed), Y
    /* 85A8 85 AC    */ sta zUnkAC

    /* 85AA 20 B4 85 */ jsr FUNC_03_85B4

    /* 85AD 20 CC 8B */ jsr FUNC_03_8BCC

    /* 85B0 20 54 8F */ jsr FUNC_03_8F54

    /* 85B3 60       */ rts

FUNC_03_85B4:
    /* 85B4 29 01    */ and #$1
    /* 85B6 F0 0B    */ beq @CODE_03_85C3

    /* 85B8 A0 01    */ ldy #Unit.jid
    /* 85BA B1 9D    */ lda (zUnitPtrRed), Y

    /* 85BC C9 13    */ cmp #JID_PRIEST
    /* 85BE F0 03    */ beq @CODE_03_85C3

    /* 85C0 4C C6 85 */ jmp @CODE_03_85C6

@CODE_03_85C3:
    /* 85C3 4C 90 88 */ jmp FUNC_03_8890

@CODE_03_85C6:
    /* 85C6 A9 00    */ lda #0
    /* 85C8 85 BC    */ sta zUnkBC

    /* 85CA A0 0C    */ ldy #Unit.def
    /* 85CC B1 9D    */ lda (zUnitPtrRed), Y
    /* 85CE 85 B1    */ sta zUnkB1

    /* 85D0 A0 07    */ ldy #Unit.str
    /* 85D2 B1 9D    */ lda (zUnitPtrRed), Y
    /* 85D4 85 B5    */ sta zUnkB5

    /* 85D6 A0 13    */ ldy #Unit.item+0
    /* 85D8 B1 9D    */ lda (zUnitPtrRed), Y

    /* 85DA A8       */ tay
    /* 85DB 88       */ dey

    /* 85DC B9 C3 D9 */ lda ItemInfo.Unk_D9C3, Y
    /* 85DF 29 06    */ and #%00000110
    /* 85E1 4A       */ lsr A
    /* 85E2 85 AF    */ sta zUnkAF

    /* 85E4 B9 57 D6 */ lda ItemInfo.might, Y
    /* 85E7 18       */ clc
    /* 85E8 65 B5    */ adc zUnkB5
    /* 85EA 85 B5    */ sta zUnkB5

    /* 85EC C9 20    */ cmp #32
    /* 85EE 30 02    */ bmi +

    /* 85F0 A9 20    */ lda #32

+:
    /* 85F2 85 A8    */ sta zUnkA8

    /* 85F4 AD 38 05 */ lda wUnk0538
    /* 85F7 8D 00 05 */ sta wUnk0500

    /* 85FA AD 39 05 */ lda wUnk0539
    /* 85FD 8D 01 05 */ sta wUnk0501

    /* 8600 A5 AD    */ lda zUnkAD
    /* 8602 F0 04    */ beq @LOC_8608

    /* 8604 A0 0D    */ ldy #Unit.mov
    /* 8606 B1 9D    */ lda (zUnitPtrRed), Y

@LOC_8608:
    /* 8608 85 BF    */ sta zMapFloodRingCount

    /* 860A A9 02    */ lda #2
    /* 860C 85 B8    */ sta zMapFloodAction

    /* 860E 20 37 80 */ jsr ClearMovementMap

    /* 8611 20 E4 8F */ jsr FloodMovementMap

    /* 8614 A5 BC    */ lda zUnkBC
    /* 8616 F0 0A    */ beq @LOC_8622

    /* 8618 A5 AC    */ lda zUnkAC
    /* 861A 29 02    */ and #$2
    /* 861C F0 07    */ beq @end

    /* 861E A5 B9    */ lda zUnkB9
    /* 8620 F0 03    */ beq @end

@LOC_8622:
    /* 8622 4C 90 88 */ jmp FUNC_03_8890

@end:
    /* 8625 60       */ rts

FUNC_03_8626:
    /* 8626 8A       */ txa
    /* 8627 48       */ pha
    /* 8628 98       */ tya
    /* 8629 48       */ pha

    /* 862A A5 BE    */ lda zMapFloodRingNum
    /* 862C F0 11    */ beq @LOC_863F

    /* 862E A6 C1    */ ldx zUnkC1
    /* 8630 20 50 82 */ jsr GetMapCellRowInR04
    /* 8633 A4 C0    */ ldy zUnkC0
    /* 8635 B1 04    */ lda (zR04), Y

    /* 8637 A8       */ tay
    /* 8638 B9 F8 E8 */ lda Cell2TerrainRed.w, Y

    /* 863B C9 1F    */ cmp #TERRAIN_ENEMY
    /* 863D F0 2B    */ beq @end

@LOC_863F:
    /* 863F 20 39 82 */ jsr GetMapRow2In9B

    /* 8642 A4 C0    */ ldy zUnkC0
    /* 8644 B1 9B    */ lda (zUnk9B), Y
    /* 8646 85 A5    */ sta zUnkA5

    /* 8648 29 60    */ and #%01100000
    /* 864A 4A       */ lsr A
    /* 864B 4A       */ lsr A
    /* 864C 4A       */ lsr A
    /* 864D 4A       */ lsr A
    /* 864E 4A       */ lsr A
    /* 864F 25 AF    */ and zUnkAF
    /* 8651 85 A6    */ sta zUnkA6
    /* 8653 F0 15    */ beq @end

    /* 8655 A5 A5    */ lda zUnkA5
    /* 8657 29 1F    */ and #%00011111
    /* 8659 85 A7    */ sta zUnkA7

    /* 865B AE 76 76 */ ldx sMapHeight
    /* 865E E8       */ inx
    /* 865F 86 0A    */ stx zR0A

    /* 8661 AE 77 76 */ ldx sMapWidth
    /* 8664 E8       */ inx
    /* 8665 86 0B    */ stx zR0B

    /* 8667 20 6F 86 */ jsr FUNC_03_866F

@end:
    /* 866A 68       */ pla
    /* 866B A8       */ tay
    /* 866C 68       */ pla
    /* 866D AA       */ tax

    /* 866E 60       */ rts

FUNC_03_866F:
    /* 866F A4 C0    */ ldy zUnkC0
    /* 8671 A6 C1    */ ldx zUnkC1
    /* 8673 E8       */ inx

    /* 8674 A9 01    */ lda #1
    /* 8676 85 A5    */ sta zUnkA5

    /* 8678 25 A6    */ and zUnkA6
    /* 867A F0 03    */ beq +

    /* 867C 20 1E 87 */ jsr FUNC_03_871E

+:
    /* 867F A9 02    */ lda #2
    /* 8681 85 A5    */ sta zUnkA5

    /* 8683 25 A6    */ and zUnkA6
    /* 8685 F0 15    */ beq @LOC_869C

    /* 8687 C8       */ iny

    /* 8688 20 1E 87 */ jsr FUNC_03_871E

    /* 868B 88       */ dey
    /* 868C A5 C1    */ lda zUnkC1
    /* 868E 18       */ clc
    /* 868F 69 02    */ adc #2

    /* 8691 CD 76 76 */ cmp sMapHeight
    /* 8694 B0 06    */ bcs @LOC_869C ; bhs

    /* 8696 A4 C0    */ ldy zUnkC0
    /* 8698 AA       */ tax

    /* 8699 20 1E 87 */ jsr FUNC_03_871E

@LOC_869C:
    /* 869C A6 C1    */ ldx zUnkC1
    /* 869E A4 C0    */ ldy zUnkC0
    /* 86A0 C8       */ iny

    /* 86A1 A9 01    */ lda #1
    /* 86A3 85 A5    */ sta zUnkA5

    /* 86A5 25 A6    */ and zUnkA6
    /* 86A7 F0 03    */ beq +

    /* 86A9 20 1E 87 */ jsr FUNC_03_871E

+:
    /* 86AC A9 02    */ lda #2
    /* 86AE 85 A5    */ sta zUnkA5

    /* 86B0 25 A6    */ and zUnkA6
    /* 86B2 F0 15    */ beq @LOC_86C9

    /* 86B4 CA       */ dex

    /* 86B5 20 1E 87 */ jsr FUNC_03_871E

    /* 86B8 E8       */ inx
    /* 86B9 A5 C0    */ lda zUnkC0
    /* 86BB 18       */ clc
    /* 86BC 69 02    */ adc #2

    /* 86BE CD 77 76 */ cmp sMapWidth
    /* 86C1 B0 06    */ bcs @LOC_86C9

    /* 86C3 A6 C1    */ ldx zUnkC1
    /* 86C5 A8       */ tay

    /* 86C6 20 1E 87 */ jsr FUNC_03_871E

@LOC_86C9:
    /* 86C9 A4 C0    */ ldy zUnkC0
    /* 86CB A6 C1    */ ldx zUnkC1
    /* 86CD CA       */ dex

    /* 86CE A9 01    */ lda #1
    /* 86D0 85 A5    */ sta zUnkA5

    /* 86D2 25 A6    */ and zUnkA6
    /* 86D4 F0 03    */ beq @LOC_86D9

    /* 86D6 20 1E 87 */ jsr FUNC_03_871E

@LOC_86D9:
    /* 86D9 A9 02    */ lda #2
    /* 86DB 85 A5    */ sta zUnkA5

    /* 86DD 25 A6    */ and zUnkA6
    /* 86DF F0 12    */ beq @LOC_86F3

    /* 86E1 88       */ dey
    /* 86E2 20 1E 87 */ jsr FUNC_03_871E

    /* 86E5 C8       */ iny

    /* 86E6 A5 C1    */ lda zUnkC1
    /* 86E8 38       */ sec
    /* 86E9 E9 02    */ sbc #2

    /* 86EB 90 06    */ bcc @LOC_86F3 ; blo

    /* 86ED A4 C0    */ ldy zUnkC0
    /* 86EF AA       */ tax

    /* 86F0 20 1E 87 */ jsr FUNC_03_871E

@LOC_86F3:
    /* 86F3 A6 C1    */ ldx zUnkC1
    /* 86F5 A4 C0    */ ldy zUnkC0
    /* 86F7 88       */ dey

    /* 86F8 A9 01    */ lda #1
    /* 86FA 85 A5    */ sta zUnkA5

    /* 86FC 25 A6    */ and zUnkA6
    /* 86FE F0 03    */ beq @LOC_8703

    /* 8700 20 1E 87 */ jsr FUNC_03_871E

@LOC_8703:
    /* 8703 A9 02    */ lda #2
    /* 8705 85 A5    */ sta zUnkA5

    /* 8707 25 A6    */ and zUnkA6
    /* 8709 F0 12    */ beq @LOC_871D

    /* 870B E8       */ inx
    /* 870C 20 1E 87 */ jsr FUNC_03_871E

    /* 870F CA       */ dex
    /* 8710 A5 C0    */ lda zUnkC0
    /* 8712 38       */ sec
    /* 8713 E9 02    */ sbc #2

    /* 8715 90 06    */ bcc @LOC_871D ; blo

    /* 8717 A6 C1    */ ldx zUnkC1
    /* 8719 A8       */ tay

    /* 871A 20 1E 87 */ jsr FUNC_03_871E

@LOC_871D:
    /* 871D 60       */ rts

FUNC_03_871E:
    ; Input:
    ; - X = X map position
    ; - Y = Y map position

    /* 871E 8A       */ txa
    /* 871F 48       */ pha
    /* 8720 98       */ tya
    /* 8721 48       */ pha

    /* 8722 86 B3    */ stx zUnkB3
    /* 8724 84 B2    */ sty zUnkB2

    /* 8726 8A       */ txa
    /* 8727 0A       */ asl A
    /* 8728 AA       */ tax

    /* 8729 BD 3D ED */ lda MapCellRows.w, X
    /* 872C 85 04    */ sta zR04
    /* 872E BD 3E ED */ lda MapCellRows.w+1, X
    /* 8731 85 05    */ sta zR04+1

    /* 8733 B1 04    */ lda (zR04), Y
    /* 8735 A8       */ tay
    /* 8736 B9 F8 E8 */ lda Cell2TerrainRed.w, Y

    /* 8739 C9 0E    */ cmp #TERRAIN_ALLY
    /* 873B D0 05    */ bne @LOC_8742

    /* 873D 20 44 91 */ jsr FindPlayerUnitAtTo9F

    /* 8740 90 03    */ bcc @LOC_8745

@LOC_8742:
    /* 8742 4C C5 87 */ jmp @LOC_87C5

@LOC_8745:
    /* 8745 A0 01    */ ldy #Unit.jid
    /* 8747 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 8749 85 A3    */ sta zUnkA3

    /* 874B A0 13    */ ldy #Unit.item+0
    /* 874D B1 9D    */ lda (zUnitPtrRed), Y

    /* 874F A8       */ tay
    /* 8750 88       */ dey
    /* 8751 84 A4    */ sty zUnkA4

    /* 8753 B9 DB D8 */ lda ItemInfo.effectiveness, Y
    /* 8756 F0 32    */ beq @not_effective

    /* 8758 0A       */ asl A
    /* 8759 A8       */ tay

    /* 875A B9 37 D9 */ lda EffectivenessInfo, Y
    /* 875D 85 00    */ sta zR00
    /* 875F B9 38 D9 */ lda EffectivenessInfo+1, Y
    /* 8762 85 01    */ sta zR00+1

    /* 8764 A0 00    */ ldy #0

@lop_effectiveness:
    /* 8766 B1 00    */ lda (zR00), Y

    /* 8768 C9 FF    */ cmp #$FF
    /* 876A F0 1E    */ beq @not_effective

    /* 876C C5 A3    */ cmp zUnkA3
    /* 876E F0 04    */ beq @is_effective

    /* 8770 C8       */ iny
    /* 8771 4C 66 87 */ jmp @lop_effectiveness

@is_effective:
    /* 8774 A4 A4    */ ldy zUnkA4
    /* 8776 B9 57 D6 */ lda ItemInfo.might, Y

    /* 8779 85 A3    */ sta zUnkA3

    /* 877B 0A       */ asl A
    /* 877C 18       */ clc
    /* 877D 65 A3    */ adc zUnkA3
    /* 877F 85 A3    */ sta zUnkA3

    /* 8781 A0 07    */ ldy #Unit.str
    /* 8783 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8785 18       */ clc
    /* 8786 65 A3    */ adc zUnkA3
    /* 8788 85 A8    */ sta zUnkA8

@not_effective:
    /* 878A A0 01    */ ldy #Unit.jid
    /* 878C B1 9D    */ lda (zUnitPtrRed), Y

    /* 878E C9 12    */ cmp #JID_MAGE
    /* 8790 F0 0C    */ beq @magic

    /* 8792 C9 14    */ cmp #JID_BISHOP
    /* 8794 F0 08    */ beq @magic

    /* 8796 A0 13    */ ldy #Unit.item+0
    /* 8798 B1 9D    */ lda (zUnitPtrRed), Y

    /* 879A C9 09    */ cmp #IID_LEVINSWORD+1
    /* 879C D0 09    */ bne @not_magic

@magic:
    /* 879E A0 0F    */ ldy #Unit.res
    /* 87A0 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 87A2 85 A3    */ sta zUnkA3

    /* 87A4 4C BC 87 */ jmp @LOC_87BC

@not_magic:
    /* 87A7 A0 0C    */ ldy #Unit.def
    /* 87A9 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 87AB 85 A3    */ sta zUnkA3

    /* 87AD A0 01    */ ldy #Unit.jid
    /* 87AF B1 9F    */ lda (zUnitPtrBlue), Y

    /* 87B1 C9 11    */ cmp #JID_MANAKETE
    /* 87B3 D0 07    */ bne @LOC_87BC

    ; manaketes have a 13 def bonus?
    /* 87B5 A5 A3    */ lda zUnkA3
    /* 87B7 18       */ clc
    /* 87B8 69 0D    */ adc #13
    /* 87BA 85 A3    */ sta zUnkA3

@LOC_87BC:
    /* 87BC A5 A8    */ lda zUnkA8
    /* 87BE 38       */ sec
    /* 87BF E5 A3    */ sbc zUnkA3
    /* 87C1 85 BB    */ sta zUnkBB

    /* 87C3 B0 03    */ bcs @LOC_87C8 ; bhs

@LOC_87C5:
    /* 87C5 4C 8B 88 */ jmp @LOC_888B

@LOC_87C8:
    /* 87C8 A0 01    */ ldy #Unit.jid
    /* 87CA B1 9F    */ lda (zUnitPtrBlue), Y

    /* 87CC C9 15    */ cmp #JID_LORD
    /* 87CE D0 04    */ bne @LOC_87D4

    /* 87D0 A9 46    */ lda #70
    /* 87D2 D0 1A    */ bne @LOC_87EE

@LOC_87D4:
    /* 87D4 C9 13    */ cmp #JID_PRIEST
    /* 87D6 D0 04    */ bne @LOC_87DC

    /* 87D8 A9 2D    */ lda #45
    /* 87DA D0 12    */ bne @LOC_87EE

@LOC_87DC:
    /* 87DC C9 10    */ cmp #JID_COMMANDO
    /* 87DE D0 04    */ bne @LOC_87E4

    /* 87E0 A9 1E    */ lda #30
    /* 87E2 D0 0A    */ bne @LOC_87EE

@LOC_87E4:
    /* 87E4 C9 09    */ cmp #JID_THIEF
    /* 87E6 D0 04    */ bne @LOC_87EC

    /* 87E8 A9 19    */ lda #25
    /* 87EA D0 02    */ bne @LOC_87EE

@LOC_87EC:
    /* 87EC A9 00    */ lda #0

@LOC_87EE:
    /* 87EE 85 BD    */ sta zUnkBD

    /* 87F0 A5 BE    */ lda zMapFloodRingNum
    /* 87F2 D0 07    */ bne @LOC_87FB

    /* 87F4 A0 06    */ ldy #Unit.cell
    /* 87F6 B1 9D    */ lda (zUnitPtrRed), Y

    /* 87F8 4C 04 88 */ jmp @LOC_8804

@LOC_87FB:
    /* 87FB A6 C1    */ ldx zUnkC1
    /* 87FD 20 50 82 */ jsr GetMapCellRowInR04
    /* 8800 A4 C0    */ ldy zUnkC0
    /* 8802 B1 04    */ lda (zR04), Y

@LOC_8804:
    /* 8804 A8       */ tay
    /* 8805 B9 F8 E8 */ lda Cell2TerrainRed, Y

    /* 8808 A8       */ tay
    /* 8809 B9 D8 EB */ lda DAT_EBD8, Y

    /* 880C 18       */ clc
    /* 880D 65 BD    */ adc zUnkBD
    /* 880F 85 BD    */ sta zUnkBD

    /* 8811 A0 03    */ ldy #Unit.hp_cur
    /* 8813 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 8815 85 A3    */ sta zUnkA3

    /* 8817 A9 0A    */ lda #10
    /* 8819 38       */ sec
    /* 881A E5 A3    */ sbc zUnkA3

    /* 881C 90 08    */ bcc @LOC_8826 ; blo

    /* 881E 69 06    */ adc #6
    /* 8820 0A       */ asl A
    /* 8821 18       */ clc
    /* 8822 65 BD    */ adc zUnkBD
    /* 8824 85 BD    */ sta zUnkBD

@LOC_8826:
    /* 8826 A0 13    */ ldy #Unit.item+0
    /* 8828 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 882A A8       */ tay
    /* 882B 88       */ dey

    /* 882C B9 C3 D9 */ lda ItemInfo.Unk_D9C3, Y
    /* 882F 29 06    */ and #%00000110
    /* 8831 4A       */ lsr A

    /* 8832 48       */ pha

    /* 8833 A5 AF    */ lda zUnkAF
    /* 8835 C9 03    */ cmp #$03
    /* 8837 D0 07    */ bne @LOC_8840

    /* 8839 68       */ pla

    /* 883A 25 A5    */ and zUnkA5

    /* 883C D0 0D    */ bne @LOC_884B
    /* 883E F0 05    */ beq @LOC_8845

@LOC_8840:
    /* 8840 68       */ pla

    /* 8841 25 AF    */ and zUnkAF

    /* 8843 D0 06    */ bne @LOC_884B

@LOC_8845:
    /* 8845 A9 32    */ lda #50
    /* 8847 65 BD    */ adc zUnkBD
    /* 8849 85 BD    */ sta zUnkBD

@LOC_884B:
    /* 884B A5 A7    */ lda zUnkA7
    /* 884D 38       */ sec
    /* 884E E5 B1    */ sbc zUnkB1

    /* 8850 B0 08    */ bcs @LOC_885A ; bhs

    /* 8852 A9 32    */ lda #50
    /* 8854 65 BD    */ adc zUnkBD
    /* 8856 85 BD    */ sta zUnkBD

    /* 8858 A9 00    */ lda #0

@LOC_885A:
    /* 885A 85 BA    */ sta zUnkBA

    ; A = zUnkBD + 32 + zUnkBB*3 - zUnkBA

    /* 885C A5 BB    */ lda zUnkBB
    /* 885E 0A       */ asl A
    /* 885F 65 BB    */ adc zUnkBB

    /* 8861 38       */ sec
    /* 8862 E5 BA    */ sbc zUnkBA

    /* 8864 18       */ clc
    /* 8865 69 20    */ adc #$20

    /* 8867 18       */ clc
    /* 8868 65 BD    */ adc zUnkBD

    ; if carry is set here, it means we overflowed and went past 255
    /* 886A 90 04    */ bcc @LOC_8870

    /* 886C A9 FF    */ lda #255
    /* 886E D0 06    */ bne @LOC_8876

@LOC_8870:
    /* 8870 C5 BC    */ cmp zUnkBC

    /* 8872 90 17    */ bcc @LOC_888B ; blo
    /* 8874 F0 15    */ beq @LOC_888B

@LOC_8876:
    /* 8876 85 BC    */ sta zUnkBC

    /* 8878 A5 C1    */ lda zUnkC1
    /* 887A 8D C0 05 */ sta wUnk05C0

    /* 887D A5 C0    */ lda zUnkC0
    /* 887F 8D C1 05 */ sta wUnk05C1

    /* 8882 A5 AE    */ lda zUnkAE
    /* 8884 8D C2 05 */ sta wUnk05C2

    /* 8887 A5 BA    */ lda zUnkBA
    /* 8889 85 B9    */ sta zUnkB9

@LOC_888B:
    /* 888B 68       */ pla
    /* 888C A8       */ tay
    /* 888D 68       */ pla
    /* 888E AA       */ tax

    /* 888F 60       */ rts

FUNC_03_8890:
    /* 8890 A5 AC    */ lda zUnkAC
    /* 8892 29 70    */ and #%01110000
    /* 8894 4A       */ lsr A
    /* 8895 4A       */ lsr A
    /* 8896 4A       */ lsr A
    /* 8897 4A       */ lsr A
    /* 8898 85 AB    */ sta zUnkAB

    /* 889A AD 38 05 */ lda wUnk0538
    /* 889D 8D 00 05 */ sta wUnk0500

    /* 88A0 AD 39 05 */ lda wUnk0539
    /* 88A3 8D 01 05 */ sta wUnk0501

    /* 88A6 A0 19    */ ldy #Unit.uses+2
    /* 88A8 B1 9D    */ lda (zUnitPtrRed), Y
    /* 88AA 85 C3    */ sta zUnkC3

    /* 88AC C8       */ iny ; Unit.uses+3
    /* 88AD B1 9D    */ lda (zUnitPtrRed), Y
    /* 88AF 85 C2    */ sta zUnkC2

    /* 88B1 A5 AB    */ lda zUnkAB
    /* 88B3 C9 07    */ cmp #$07
    /* 88B5 D0 22    */ bne @LOC_88D9

    /* 88B7 A5 C2    */ lda zUnkC2
    /* 88B9 CD 38 05 */ cmp wUnk0538
    /* 88BC D0 1B    */ bne @LOC_88D9

    /* 88BE A5 C3    */ lda zUnkC3
    /* 88C0 CD 39 05 */ cmp wUnk0539
    /* 88C3 D0 14    */ bne @LOC_88D9

    /* 88C5 A9 FF    */ lda #255
    /* 88C7 8D C2 05 */ sta wUnk05C2

    /* 88CA AD 38 05 */ lda wUnk0538
    /* 88CD 8D C1 05 */ sta wUnk05C1

    /* 88D0 AD 39 05 */ lda wUnk0539
    /* 88D3 8D C0 05 */ sta wUnk05C0

    /* 88D6 4C 1C 89 */ jmp @LOC_891C

@LOC_88D9:
    /* 88D9 A9 3C    */ lda #$3C
    /* 88DB 85 BF    */ sta zMapFloodRingCount

    /* 88DD A9 00    */ lda #0
    /* 88DF 85 B8    */ sta zMapFloodAction

    /* 88E1 AD 3A 05 */ lda wUnk053A
    /* 88E4 F0 06    */ beq @LOC_88EC

    /* 88E6 20 83 8C */ jsr FUNC_03_8C83

    /* 88E9 4C EF 88 */ jmp @LOC_88EF

@LOC_88EC:
    /* 88EC 20 37 80 */ jsr ClearMovementMap

@LOC_88EF:
    /* 88EF 20 E4 8F */ jsr FloodMovementMap

    /* 88F2 A5 BE    */ lda zMapFloodRingNum
    /* 88F4 F0 04    */ beq @LOC_88FA

    /* 88F6 A5 B8    */ lda zMapFloodAction
    /* 88F8 D0 14    */ bne @LOC_890E

@LOC_88FA:
    /* 88FA AD 38 05 */ lda wUnk0538
    /* 88FD 8D C1 05 */ sta wUnk05C1

    /* 8900 AD 39 05 */ lda wUnk0539
    /* 8903 8D C0 05 */ sta wUnk05C0

    /* 8906 A9 FF    */ lda #255
    /* 8908 8D C2 05 */ sta wUnk05C2

    /* 890B 4C 1C 89 */ jmp @LOC_891C

@LOC_890E:
    /* 890E 20 82 8A */ jsr FUNC_03_8A82

    /* 8911 20 E8 8A */ jsr FUNC_03_8AE8

    /* 8914 AD 3A 05 */ lda wUnk053A
    /* 8917 F0 03    */ beq @LOC_891C

    /* 8919 4C 90 88 */ jmp FUNC_03_8890

@LOC_891C:
    /* 891C 60       */ rts

FUNC_03_891D:
    /* 891D 8A       */ txa
    /* 891E 48       */ pha
    /* 891F 98       */ tya
    /* 8920 48       */ pha

    /* 8921 A5 AB    */ lda zUnkAB

    /* 8923 C9 07    */ cmp #$07
    /* 8925 D0 0E    */ bne @LOC_8935

    /* 8927 C4 C2    */ cpy zUnkC2
    /* 8929 D0 07    */ bne @LOC_8932

    /* 892B E4 C3    */ cpx zUnkC3
    /* 892D D0 03    */ bne @LOC_8932

    /* 892F 4C 79 8A */ jmp FUNC_03_89BB@LOC_8A79

@LOC_8932:
    /* 8932 4C 7D 8A */ jmp FUNC_03_89BB@LOC_8A7D

@LOC_8935:
    /* 8935 86 0A    */ stx zR0A
    /* 8937 84 0B    */ sty zR0B

    /* 8939 A9 00    */ lda #0
    /* 893B 85 B7    */ sta zUnkB7

    ; { +0, +0 }

    /* 893D 20 6B 89 */ jsr FUNC_03_896B

    /* 8940 E6 B7    */ inc zUnkB7

    ; { +1, +0 }

    /* 8942 A6 0A    */ ldx zR0A
    /* 8944 A4 0B    */ ldy zR0B
    /* 8946 E8       */ inx

    /* 8947 20 6B 89 */ jsr FUNC_03_896B

    /* 894A E6 B7    */ inc zUnkB7

    ; { -1, +0 }

    /* 894C A6 0A    */ ldx zR0A
    /* 894E A4 0B    */ ldy zR0B
    /* 8950 CA       */ dex

    /* 8951 20 6B 89 */ jsr FUNC_03_896B

    /* 8954 E6 B7    */ inc zUnkB7

    ; { +0, -1 }

    /* 8956 A6 0A    */ ldx zR0A
    /* 8958 A4 0B    */ ldy zR0B
    /* 895A 88       */ dey

    /* 895B 20 6B 89 */ jsr FUNC_03_896B

    /* 895E E6 B7    */ inc zUnkB7

    ; { +0, +1 }

    /* 8960 A6 0A    */ ldx zR0A
    /* 8962 A4 0B    */ ldy zR0B
    /* 8964 C8       */ iny

    /* 8965 20 6B 89 */ jsr FUNC_03_896B

    /* 8968 4C BB 89 */ jmp FUNC_03_89BB

FUNC_03_896B:
    /* 896B 84 B2    */ sty zUnkB2
    /* 896D 86 B3    */ stx zUnkB3

    /* 896F 20 50 82 */ jsr GetMapCellRowInR04
    /* 8972 B1 04    */ lda (zR04), Y

    /* 8974 A8       */ tay
    /* 8975 B9 F8 E8 */ lda Cell2TerrainRed, Y

    /* 8978 A6 B7    */ ldx zUnkB7
    /* 897A 9D 2E 05 */ sta wUnk052E, X

    /* 897D C9 0E    */ cmp #TERRAIN_ALLY
    /* 897F D0 18    */ bne @LOC_8999

    /* 8981 20 44 91 */ jsr FindPlayerUnitAtTo9F

    /* 8984 A0 01    */ ldy #Unit.jid
    /* 8986 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 8988 9D 33 05 */ sta wUnk0533, X

    /* 898B A0 06    */ ldy #Unit.cell
    /* 898D B1 9F    */ lda (zUnitPtrBlue), Y

    /* 898F A8       */ tay
    /* 8990 B9 F8 E8 */ lda Cell2TerrainRed, Y

    /* 8993 9D 2E 05 */ sta wUnk052E, X

    /* 8996 4C BA 89 */ jmp @LOC_89BA

@LOC_8999:
    /* 8999 C9 1F    */ cmp #TERRAIN_ENEMY
    /* 899B D0 18    */ bne @LOC_89B5

    /* 899D E0 00    */ cpx #0
    /* 899F D0 14    */ bne @LOC_89B5

    /* 89A1 8D 33 05 */ sta wUnk0533

    /* 89A4 20 4A 91 */ jsr FindEnemyUnitAtToR02

    /* 89A7 A0 06    */ ldy #Unit.cell
    /* 89A9 B1 02    */ lda (zR02), Y

    /* 89AB A8       */ tay

    /* 89AC B9 F8 E8 */ lda Cell2TerrainRed, Y
    /* 89AF 9D 2E 05 */ sta wUnk052E, X

    /* 89B2 4C BA 89 */ jmp @LOC_89BA

@LOC_89B5:
    /* 89B5 A9 80    */ lda #JID_UNK_128
    /* 89B7 9D 33 05 */ sta wUnk0533, X

@LOC_89BA:
    /* 89BA 60       */ rts

FUNC_03_89BB:
    /* 89BB A5 AB    */ lda zUnkAB
    /* 89BD 20 4C C3 */ jsr Switch

    .dw @case_0 ; 0
    .dw @case_1 ; 1
    .dw @case_2 ; 2
    .dw @case_3 ; 3
    .dw @case_4 ; 4
    .dw @case_5 ; 5
    .dw @case_6 ; 6

@case_0:
    /* 89CE AD 33 05 */ lda wUnk0533

    /* 89D1 C9 1F    */ cmp #JID_UNK_1F
    /* 89D3 D0 0B    */ bne @LOC_89E0

    /* 89D5 A0 01    */ ldy #Unit.jid
    /* 89D7 B1 02    */ lda (zR02), Y

    /* 89D9 C9 13    */ cmp #JID_PRIEST
    /* 89DB F0 63    */ beq @LOC_8A40

    /* 89DD 4C 7D 8A */ jmp @LOC_8A7D

@LOC_89E0:
    /* 89E0 AD 2E 05 */ lda wUnk052E

    /* 89E3 C9 03    */ cmp #$03
    /* 89E5 F0 59    */ beq @LOC_8A40

    /* 89E7 4C 7D 8A */ jmp @LOC_8A7D

@case_1:
    /* 89EA AD 34 05 */ lda wUnk0533+1
    /* 89ED 2D 35 05 */ and wUnk0533+2
    /* 89F0 2D 36 05 */ and wUnk0533+3
    /* 89F3 2D 37 05 */ and wUnk0533+4

    /* 89F6 D0 0C    */ bne @LOC_8A04

    /* 89F8 A2 04    */ ldx #4

@LOC_89FA:
    /* 89FA BD 33 05 */ lda wUnk0533, X

    /* 89FD C9 15    */ cmp #JID_LORD
    /* 89FF F0 3F    */ beq @LOC_8A40

    /* 8A01 CA       */ dex
    /* 8A02 D0 F6    */ bne @LOC_89FA

@LOC_8A04:
    /* 8A04 4C 7D 8A */ jmp @LOC_8A7D

@case_2:
    /* 89EA AD 34 05 */ lda wUnk0533+1
    /* 89ED 2D 35 05 */ and wUnk0533+2
    /* 89F0 2D 36 05 */ and wUnk0533+3
    /* 89F3 2D 37 05 */ and wUnk0533+4

    /* 8A13 D0 14    */ bne @LOC_8A29

    /* 8A15 A2 04    */ ldx #4

@LOC_8A17:
    /* 8A17 BD 33 05 */ lda wUnk0533, X

    /* 8A1A C9 13    */ cmp #JID_PRIEST
    /* 8A1C F0 22    */ beq @LOC_8A40

    /* 8A1E C9 09    */ cmp #JID_THIEF
    /* 8A20 F0 1E    */ beq @LOC_8A40

    /* 8A22 C9 10    */ cmp #JID_COMMANDO
    /* 8A24 F0 1A    */ beq @LOC_8A40

    /* 8A26 CA       */ dex
    /* 8A27 D0 EE    */ bne @LOC_8A17

@LOC_8A29:
    /* 8A29 4C 7D 8A */ jmp @LOC_8A7D

@case_3:
    /* 8A2C AD 33 05 */ lda wUnk0533

    /* 8A2F C9 1F    */ cmp #JID_UNK_1F
    /* 8A31 D0 0A    */ bne @LOC_8A3D

    /* 8A33 A0 16    */ ldy #Unit.item+3
    /* 8A35 B1 02    */ lda (zR02), Y

    /* 8A37 29 0C    */ and #%00001100

    /* 8A39 C9 04    */ cmp #%00000100
    /* 8A3B F0 03    */ beq @LOC_8A40

@LOC_8A3D:
    /* 8A3D 4C 7D 8A */ jmp @LOC_8A7D

@LOC_8A40:
    /* 8A40 4C 79 8A */ jmp @LOC_8A79

@case_4:
    /* 8A43 AD 33 05 */ lda wUnk0533

    /* 8A46 C9 1F    */ cmp #JID_UNK_1F
    /* 8A48 D0 F3    */ bne @LOC_8A3D

    /* 8A4A A0 01    */ ldy #Unit.jid
    /* 8A4C B1 02    */ lda (zR02), Y

    /* 8A4E C9 13    */ cmp #JID_PRIEST
    /* 8A50 F0 EE    */ beq @LOC_8A40

    /* 8A52 C9 10    */ cmp #JID_COMMANDO
    /* 8A54 F0 EA    */ beq @LOC_8A40

    /* 8A56 C9 09    */ cmp #JID_THIEF
    /* 8A58 F0 E6    */ beq @LOC_8A40

    /* 8A5A 4C 7D 8A */ jmp @LOC_8A7D

@case_5:
    /* 89EA AD 34 05 */ lda wUnk0533+1
    /* 89ED 2D 35 05 */ and wUnk0533+2
    /* 89F0 2D 36 05 */ and wUnk0533+3
    /* 89F3 2D 37 05 */ and wUnk0533+4

    /* 8A69 D0 12    */ bne @LOC_8A7D

    /* 8A6B 4C 79 8A */ jmp @LOC_8A79

@case_6:
    /* 8A6E AD 2E 05 */ lda wUnk052E

    /* 8A71 C9 02    */ cmp #$02
    /* 8A73 F0 04    */ beq @LOC_8A79

    /* 8A75 C9 12    */ cmp #$12
    /* 8A77 D0 04    */ bne @LOC_8A7D

@LOC_8A79:
    /* 8A79 A9 FF    */ lda #$FF
    /* 8A7B 85 B8    */ sta zMapFloodAction

@LOC_8A7D:
    /* 8A7D 68       */ pla
    /* 8A7E A8       */ tay
    /* 8A7F 68       */ pla
    /* 8A80 AA       */ tax

    /* 8A81 60       */ rts

FUNC_03_8A82:
    /* 8A82 A6 C1    */ ldx zUnkC1
    /* 8A84 86 A2    */ stx zUnkA2

    /* 8A86 20 22 82 */ jsr GetMapMovementRow

    /* 8A89 A4 C0    */ ldy zUnkC0
    /* 8A8B 84 A1    */ sty zUnkA1

    /* 8A8D B1 6C    */ lda (zMapMovementRow), Y
    /* 8A8F 85 A3    */ sta zUnkA3

@lop:
    /* 8A91 A5 A3    */ lda zUnkA3
    /* 8A93 2A       */ rol A
    /* 8A94 2A       */ rol A
    /* 8A95 2A       */ rol A
    /* 8A96 29 03    */ and #$3
    /* 8A98 85 09    */ sta zR09

    /* 8A9A 0A       */ asl A
    /* 8A9B AA       */ tax

    /* 8A9C BD D8 8A */ lda DATA_03_8AD8.w, X
    /* 8A9F 18       */ clc
    /* 8AA0 65 C0    */ adc zUnkC0
    /* 8AA2 85 C0    */ sta zUnkC0

    /* 8AA4 BD D9 8A */ lda DATA_03_8AD8.w+1, X
    /* 8AA7 18       */ clc
    /* 8AA8 65 C1    */ adc zUnkC1
    /* 8AAA 85 C1    */ sta zUnkC1

    /* 8AAC AA       */ tax

    /* 8AAD 20 22 82 */ jsr GetMapMovementRow

    /* 8AB0 A4 C0    */ ldy zUnkC0
    /* 8AB2 B1 6C    */ lda (zMapMovementRow), Y

    /* 8AB4 C9 3D    */ cmp #$3D
    /* 8AB6 F0 18    */ beq @finish

    /* 8AB8 48       */ pha

    /* 8AB9 29 C0    */ and #$C0
    /* 8ABB 85 A3    */ sta zUnkA3
    /* 8ABD A5 09    */ lda zR09
    /* 8ABF 6A       */ ror A
    /* 8AC0 6A       */ ror A
    /* 8AC1 6A       */ ror A
    /* 8AC2 29 C0    */ and #$C0
    /* 8AC4 85 A4    */ sta zUnkA4

    /* 8AC6 68       */ pla

    /* 8AC7 29 3F    */ and #$3F
    /* 8AC9 05 A4    */ ora zUnkA4
    /* 8ACB 91 6C    */ sta (zMapMovementRow), Y

    /* 8ACD 4C 91 8A */ jmp @lop

@finish:
    /* 8AD0 A5 09    */ lda zR09
    /* 8AD2 6A       */ ror A
    /* 8AD3 6A       */ ror A
    /* 8AD4 6A       */ ror A
    /* 8AD5 91 6C    */ sta (zMapMovementRow), Y

    /* 8AD7 60       */ rts

DATA_03_8AD8:
    ;    x   y
    .db  0, +1
    .db -1,  0
    .db  0, -1
    .db +1,  0

DATA_03_8AE0:
    ;    x   y
    .db  0, -1
    .db +1,  0
    .db  0, +1
    .db -1,  0

FUNC_03_8AE8:
    /* 8AE8 AD 38 05 */ lda wUnk0538
    /* 8AEB 85 C0    */ sta zUnkC0

    /* 8AED AD 39 05 */ lda wUnk0539
    /* 8AF0 85 C1    */ sta zUnkC1

    /* 8AF2 A0 0D    */ ldy #Unit.mov
    /* 8AF4 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8AF6 85 A3    */ sta zUnkA3

    /* 8AF8 A9 00    */ lda #0
    /* 8AFA 85 C4    */ sta zUnkC4

@LOC_8AFC:
    /* 8AFC A6 C1    */ ldx zUnkC1
    /* 8AFE 86 C6    */ stx zUnkC6

    /* 8B00 20 22 82 */ jsr GetMapMovementRow

    /* 8B03 A4 C0    */ ldy zUnkC0
    /* 8B05 84 C7    */ sty zUnkC7

    /* 8B07 B1 6C    */ lda (zMapMovementRow), Y
    /* 8B09 2A       */ rol A
    /* 8B0A 2A       */ rol A
    /* 8B0B 2A       */ rol A
    /* 8B0C 29 03    */ and #$3
    /* 8B0E 85 09    */ sta zR09

    /* 8B10 A4 C4    */ ldy zUnkC4
    /* 8B12 99 20 05 */ sta wUnk0520, Y

    /* 8B15 0A       */ asl A
    /* 8B16 AA       */ tax

    /* 8B17 BD E0 8A */ lda DATA_03_8AE0.w, X
    /* 8B1A 18       */ clc
    /* 8B1B 65 C0    */ adc zUnkC0
    /* 8B1D 85 C0    */ sta zUnkC0

    /* 8B1F BD E1 8A */ lda DATA_03_8AE0.w+1, X
    /* 8B22 18       */ clc
    /* 8B23 65 C1    */ adc zUnkC1
    /* 8B25 85 C1    */ sta zUnkC1

    /* 8B27 AA       */ tax
    /* 8B28 20 22 82 */ jsr GetMapMovementRow

    /* 8B2B A4 C0    */ ldy zUnkC0
    /* 8B2D B1 6C    */ lda (zMapMovementRow), Y

    /* 8B2F 29 3F    */ and #$3F
    /* 8B31 F0 16    */ beq @LOC_8B49

    /* 8B33 85 A4    */ sta zUnkA4

    /* 8B35 38       */ sec
    /* 8B36 A5 A3    */ lda zUnkA3
    /* 8B38 E5 A4    */ sbc zUnkA4

    /* 8B3A 90 0D    */ bcc @LOC_8B49 ; blo

    /* 8B3C C4 A1    */ cpy zUnkA1
    /* 8B3E D0 04    */ bne @LOC_8B44

    /* 8B40 E4 A2    */ cpx zUnkA2
    /* 8B42 F0 0F    */ beq @LOC_8B53

@LOC_8B44:
    /* 8B44 E6 C4    */ inc zUnkC4

    /* 8B46 4C FC 8A */ jmp @LOC_8AFC

@LOC_8B49:
    /* 8B49 C6 C4    */ dec zUnkC4

    /* 8B4B A5 C7    */ lda zUnkC7
    /* 8B4D 85 C0    */ sta zUnkC0

    /* 8B4F A5 C6    */ lda zUnkC6
    /* 8B51 85 C1    */ sta zUnkC1

@LOC_8B53:
    /* 8B53 A6 C1    */ ldx zUnkC1
    /* 8B55 20 50 82 */ jsr GetMapCellRowInR04
    /* 8B58 A4 C0    */ ldy zUnkC0
    /* 8B5A B1 04    */ lda (zR04), Y

    /* 8B5C A8       */ tay
    /* 8B5D B9 F8 E8 */ lda Cell2TerrainRed, Y

    /* 8B60 C9 1F    */ cmp #TERRAIN_ENEMY
    /* 8B62 F0 0F    */ beq @LOC_8B73

    /* 8B64 C9 0E    */ cmp #TERRAIN_ALLY
    /* 8B66 F0 0B    */ beq @LOC_8B73

    /* 8B68 A5 AC    */ lda zUnkAC

    /* 8B6A 29 02    */ and #$2
    /* 8B6C F0 2D    */ beq @LOC_8B9B

    /* 8B6E 20 B0 8B */ jsr FUNC_03_8BB0

    /* 8B71 90 28    */ bcc @LOC_8B9B

@LOC_8B73:
    /* 8B73 A4 C4    */ ldy zUnkC4
    /* 8B75 B9 20 05 */ lda wUnk0520, Y

    /* 8B78 0A       */ asl A
    /* 8B79 AA       */ tax

    /* 8B7A BD D8 8A */ lda DATA_03_8AD8.w, X
    /* 8B7D 18       */ clc
    /* 8B7E 65 C0    */ adc zUnkC0
    /* 8B80 85 C0    */ sta zUnkC0

    /* 8B82 BD D9 8A */ lda DATA_03_8AD8.w+1, X
    /* 8B85 18       */ clc
    /* 8B86 65 C1    */ adc zUnkC1
    /* 8B88 85 C1    */ sta zUnkC1

    /* 8B8A C6 C4    */ dec zUnkC4
    /* 8B8C 10 C5    */ bpl @LOC_8B53

    /* 8B8E AD 3A 05 */ lda wUnk053A
    /* 8B91 D0 08    */ bne @LOC_8B9B

    /* 8B93 A9 01    */ lda #1
    /* 8B95 8D 3A 05 */ sta wUnk053A

    /* 8B98 4C AF 8B */ jmp @end

@LOC_8B9B:
    /* 8B9B A9 00    */ lda #0
    /* 8B9D 8D 3A 05 */ sta wUnk053A

    /* 8BA0 A5 C0    */ lda zUnkC0
    /* 8BA2 8D C1 05 */ sta wUnk05C1

    /* 8BA5 A5 C1    */ lda zUnkC1
    /* 8BA7 8D C0 05 */ sta wUnk05C0

    /* 8BAA A9 FF    */ lda #255
    /* 8BAC 8D C2 05 */ sta wUnk05C2

@end:
    /* 8BAF 60       */ rts

FUNC_03_8BB0:
    ; Input:
    ; - zUnitPtrRed = unit
    ; - zUnkC0 = X map position
    ; - zUnkC1 = Y map position
    ; Output:
    ; - C = set if unit def is higher or same to Map2 & $1F at given position

    /* 8BB0 8A       */ txa
    /* 8BB1 48       */ pha
    /* 8BB2 98       */ tya
    /* 8BB3 48       */ pha

    /* 8BB4 A0 0C    */ ldy #Unit.def
    /* 8BB6 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8BB8 85 A5    */ sta zUnkA5

    /* 8BBA A6 C1    */ ldx zUnkC1
    /* 8BBC 20 39 82 */ jsr GetMapRow2In9B
    /* 8BBF A4 C0    */ ldy zUnkC0
    /* 8BC1 B1 9B    */ lda (zUnk9B), Y
    /* 8BC3 29 1F    */ and #$1F

    /* 8BC5 C5 A5    */ cmp zUnkA5

    /* 8BC7 68       */ pla
    /* 8BC8 A8       */ tay
    /* 8BC9 68       */ pla
    /* 8BCA AA       */ tax

    /* 8BCB 60       */ rts

FUNC_03_8BCC:
    /* 8BCC A5 AC    */ lda zUnkAC
    /* 8BCE 29 02    */ and #$2
    /* 8BD0 F0 0F    */ beq @LOC_8BE1

    /* 8BD2 AD C1 05 */ lda wUnk05C1
    /* 8BD5 85 C0    */ sta zUnkC0

    /* 8BD7 AD C0 05 */ lda wUnk05C0
    /* 8BDA 85 C1    */ sta zUnkC1

    /* 8BDC 20 B0 8B */ jsr FUNC_03_8BB0

    /* 8BDF B0 03    */ bcs @LOC_8BE4

@LOC_8BE1:
    /* 8BE1 4C 82 8C */ jmp @end

@LOC_8BE4:
    /* 8BE4 20 37 80 */ jsr ClearMovementMap

    /* 8BE7 A0 0D    */ ldy #Unit.mov
    /* 8BE9 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8BEB 85 BF    */ sta zMapFloodRingCount

    /* 8BED A9 00    */ lda #0
    /* 8BEF 85 A4    */ sta zUnkA4

    /* 8BF1 AE C0 05 */ ldx wUnk05C0
    /* 8BF4 AC C1 05 */ ldy wUnk05C1

    /* 8BF7 20 22 82 */ jsr GetMapMovementRow

    /* 8BFA A9 3D    */ lda #$3D
    /* 8BFC 91 6C    */ sta (zMapMovementRow), Y

    /* 8BFE A9 00    */ lda #0
    /* 8C00 85 BE    */ sta zMapFloodRingNum

    /* 8C02 86 C1    */ stx zUnkC1
    /* 8C04 84 C0    */ sty zUnkC0

    /* 8C06 20 80 90 */ jsr FUNC_03_9080

@lop:
    /* 8C09 E6 BE    */ inc zMapFloodRingNum

    /* 8C0B A2 01    */ ldx #1

@lop_y:
    /* 8C0D A0 01    */ ldy #1

    /* 8C0F 8A       */ txa
    /* 8C10 48       */ pha

    /* 8C11 0A       */ asl A
    /* 8C12 AA       */ tax

    /* 8C13 BD 01 ED */ lda MapMovementRows.w, X
    /* 8C16 85 6C    */ sta zMapMovementRow
    /* 8C18 BD 02 ED */ lda MapMovementRows.w+1, X
    /* 8C1B 85 6D    */ sta zMapMovementRow+1

    /* 8C1D 68       */ pla
    /* 8C1E AA       */ tax

@lop_x:
    /* 8C1F B1 6C    */ lda (zMapMovementRow), Y
    /* 8C21 29 3F    */ and #$3F

    /* 8C23 C5 BE    */ cmp zMapFloodRingNum
    /* 8C25 D0 49    */ bne @continue

    /* 8C27 86 C1    */ stx zUnkC1
    /* 8C29 84 C0    */ sty zUnkC0

    /* 8C2B 20 50 82 */ jsr GetMapCellRowInR04

    /* 8C2E B1 04    */ lda (zR04), Y

    /* 8C30 A8       */ tay
    /* 8C31 B9 28 E8 */ lda Cell2TerrainBlue.w, Y
    /* 8C34 85 A3    */ sta zUnkA3

    /* 8C36 A4 C0    */ ldy zUnkC0

    /* 8C38 A5 A3    */ lda zUnkA3

    /* 8C3A C9 1F    */ cmp #UNK_E828_1F
    /* 8C3C F0 2F    */ beq @LOC_8C6D

    /* 8C3E 20 B0 8B */ jsr FUNC_03_8BB0

    /* 8C41 B0 0E    */ bcs @LOC_8C51

    /* 8C43 8C C1 05 */ sty wUnk05C1
    /* 8C46 8E C0 05 */ stx wUnk05C0

    /* 8C49 A9 FF    */ lda #255
    /* 8C4B 8D C2 05 */ sta wUnk05C2

    /* 8C4E 4C 82 8C */ jmp @end

@LOC_8C51:
    /* 8C51 A4 A3    */ ldy zUnkA3
    /* 8C53 B9 D8 EB */ lda DAT_EBD8.w, Y

    /* 8C56 48       */ pha
    /* 8C57 A4 C0    */ ldy zUnkC0
    /* 8C59 68       */ pla

    /* 8C5A C5 A4    */ cmp zUnkA4

    /* 8C5C F0 0F    */ beq @LOC_8C6D
    /* 8C5E 90 0D    */ bcc @LOC_8C6D ; blo

    /* 8C60 8E C0 05 */ stx wUnk05C0
    /* 8C63 8C C1 05 */ sty wUnk05C1

    /* 8C66 85 A4    */ sta zUnkA4

    /* 8C68 A9 FF    */ lda #255
    /* 8C6A 8D C2 05 */ sta wUnk05C2

@LOC_8C6D:
    /* 8C6D 20 80 90 */ jsr FUNC_03_9080

@continue:
    /* 8C70 C8       */ iny

    /* 8C71 CC 77 76 */ cpy sMapWidth
    /* 8C74 D0 A9    */ bne @lop_x

    /* 8C76 E8       */ inx

    /* 8C77 EC 76 76 */ cpx sMapHeight
    /* 8C7A 90 91    */ bcc @lop_y

    /* 8C7C A5 BE    */ lda zMapFloodRingNum

    /* 8C7E C5 BF    */ cmp zMapFloodRingCount
    /* 8C80 D0 87    */ bne @lop

@end:
    /* 8C82 60       */ rts

FUNC_03_8C83:
    /* 8C83 AE 76 76 */ ldx sMapHeight
    /* 8C86 E8       */ inx
    /* 8C87 86 0A    */ stx zR0A

    /* 8C89 AE 77 76 */ ldx sMapWidth
    /* 8C8C E8       */ inx
    /* 8C8D 86 0B    */ stx zR0B

    /* 8C8F A2 00    */ ldx #0

@lop_y:
    /* 8C91 20 22 82 */ jsr GetMapMovementRow

    /* 8C94 A0 00    */ ldy #$00

@lop_x:
    /* 8C96 C0 00    */ cpy #0
    /* 8C98 F0 25    */ beq @LOC_8CBF

    /* 8C9A CC 77 76 */ cpy sMapWidth
    /* 8C9D F0 20    */ beq @LOC_8CBF

    /* 8C9F E0 00    */ cpx #0
    /* 8CA1 F0 1C    */ beq @LOC_8CBF

    /* 8CA3 EC 76 76 */ cpx sMapHeight
    /* 8CA6 F0 17    */ beq @LOC_8CBF

    /* 8CA8 84 A3    */ sty zUnkA3

    /* 8CAA 20 50 82 */ jsr GetMapCellRowInR04

    /* 8CAD B1 04    */ lda (zR04), Y
    /* 8CAF A8       */ tay
    /* 8CB0 B9 F8 E8 */ lda Cell2TerrainRed.w, Y

    /* 8CB3 48       */ pha
    /* 8CB4 A4 A3    */ ldy zUnkA3
    /* 8CB6 68       */ pla

    /* 8CB7 C9 1F    */ cmp #$1F
    /* 8CB9 F0 04    */ beq @LOC_8CBF

    /* 8CBB A9 00    */ lda #$00
    /* 8CBD F0 02    */ beq @LOC_8CC1

@LOC_8CBF:
    /* 8CBF A9 FF    */ lda #$FF

@LOC_8CC1:
    /* 8CC1 91 6C    */ sta (zMapMovementRow), Y

    /* 8CC3 C8       */ iny

    /* 8CC4 C4 0B    */ cpy zR0B
    /* 8CC6 D0 CE    */ bne @lop_x

    /* 8CC8 E8       */ inx

    /* 8CC9 E4 0A    */ cpx zR0A
    /* 8CCB 90 C4    */ bcc @lop_y

    /* 8CCD 60       */ rts

FUNC_03_8CCE:
    /* 8CCE AD 42 05 */ lda wUnk0542
    /* 8CD1 20 4C C3 */ jsr Switch

    .dw FUNC_03_8CCE_case_0
    .dw FUNC_03_8CCE_case_1
    .dw FUNC_03_8CCE_case_2
    .dw FUNC_03_8CCE_case_3
    .dw FUNC_03_8CCE_case_4
    .dw CaseRet

FUNC_03_8CCE_case_0:
    /* 8CE0 A0 12    */ ldy #Unit.unk_12
    /* 8CE2 B1 9D    */ lda (zUnitPtrRed), Y

    /* 8CE4 C9 FF    */ cmp #$FF
    /* 8CE6 D0 06    */ bne @LOC_8CEE

    /* 8CE8 A9 04    */ lda #4
    /* 8CEA 8D 42 05 */ sta wUnk0542

    /* 8CED 60       */ rts

@LOC_8CEE:
    /* 8CEE A0 00    */ ldy #Unit.pid
    /* 8CF0 B1 9D    */ lda (zUnitPtrRed), Y
    /* 8CF2 85 A3    */ sta zUnkA3

    /* 8CF4 AC 74 76 */ ldy sMapNum
    /* 8CF7 88       */ dey
    /* 8CF8 B9 C1 A3 */ lda DAT_A3C1, Y

    /* 8CFB F0 6A    */ beq @LOC_8D67

    /* 8CFD 18       */ clc
    /* 8CFE 69 FF    */ adc #$FF
    /* 8D00 0A       */ asl A
    /* 8D01 A8       */ tay

    /* 8D02 B9 DA A3 */ lda DAT_A3DA, Y
    /* 8D05 85 02    */ sta zR02
    /* 8D07 B9 DB A3 */ lda DAT_A3DA+1, Y
    /* 8D0A 85 03    */ sta zR02+1

@LOC_8D0C:
    /* 8D0C A0 00    */ ldy #Unk_03_A3DA.unk_00
    /* 8D0E B1 02    */ lda (zR02), Y

    /* 8D10 F0 55    */ beq @LOC_8D67

    /* 8D12 C5 A3    */ cmp zUnkA3
    /* 8D14 D0 16    */ bne @LOC_8D2C

    /* 8D16 A0 16    */ ldy #Unit.item+3
    /* 8D18 B1 9D    */ lda (zUnitPtrRed), Y

    /* 8D1A 29 01    */ and #$1
    /* 8D1C D0 0E    */ bne @LOC_8D2C

    /* 8D1E A0 03    */ ldy #Unk_03_A3DA.unk_03
    /* 8D20 B1 02    */ lda (zR02), Y
    /* 8D22 8D 45 05 */ sta wUnk0545

    /* 8D25 F0 0D    */ beq @LOC_8D34

    /* 8D27 20 6D 8D */ jsr FUNC_03_8D6D

    /* 8D2A 90 08    */ bcc @LOC_8D34

@LOC_8D2C:
    /* 8D2C A0 04    */ ldy #_sizeof_Unk_03_A3DA
    /* 8D2E 20 83 C3 */ jsr IncR02ByY

    /* 8D31 4C 0C 8D */ jmp @LOC_8D0C

@LOC_8D34:
    /* 8D34 A0 01    */ ldy #Unk_03_A3DA.unk_01
    /* 8D36 B1 02    */ lda (zR02), Y
    /* 8D38 8D 43 05 */ sta wUnk0543

    /* 8D3B C8       */ iny ; Unk_03_A3DA.unk_02
    /* 8D3C B1 02    */ lda (zR02), Y
    /* 8D3E 8D 44 05 */ sta wUnk0544

    /* 8D41 AC C1 05 */ ldy wUnk05C1
    /* 8D44 AE C0 05 */ ldx wUnk05C0

    /* 8D47 E8       */ inx

    /* 8D48 20 C4 8E */ jsr FUNC_03_8EC4

    /* 8D4B F0 15    */ beq @LOC_8D62

    /* 8D4D CA       */ dex
    /* 8D4E CA       */ dex

    /* 8D4F 20 C4 8E */ jsr FUNC_03_8EC4

    /* 8D52 F0 0E    */ beq @LOC_8D62

    /* 8D54 E8       */ inx
    /* 8D55 C8       */ iny

    /* 8D56 20 C4 8E */ jsr FUNC_03_8EC4

    /* 8D59 F0 07    */ beq @LOC_8D62

    /* 8D5B 88       */ dey
    /* 8D5C 88       */ dey

    /* 8D5D 20 C4 8E */ jsr FUNC_03_8EC4

    /* 8D60 D0 05    */ bne @LOC_8D67

@LOC_8D62:
    /* 8D62 EE 42 05 */ inc wUnk0542
    /* 8D65 D0 05    */ bne @LOC_8D6C

@LOC_8D67:
    /* 8D67 A9 04    */ lda #4
    /* 8D69 8D 42 05 */ sta wUnk0542

@LOC_8D6C:
    /* 8D6C 60       */ rts

FUNC_03_8D6D:
    /* 8D6D A5 66    */ lda zUnk65+1
    /* 8D6F F0 0B    */ beq @LOC_8D7C

    /* 8D71 20 B4 8D */ jsr @LOC_8DB4

    /* 8D74 A0 11    */ ldy #Unit.x
    /* 8D76 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 8D78 A0 00    */ ldy #Unit.pid
    /* 8D7A 91 9F    */ sta (zUnitPtrBlue), Y

@LOC_8D7C:
    /* 8D7C 20 67 82 */ jsr GetBlueUnits

    /* 8D7F A2 00    */ ldx #0

@LOC_8D81:
    /* 8D81 A0 00    */ ldy #Unit.pid
    /* 8D83 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 8D85 CD 45 05 */ cmp wUnk0545
    /* 8D88 D0 0D    */ bne @LOC_8D97

    /* 8D8A A0 12    */ ldy #Unit.unk_12
    /* 8D8C B1 9F    */ lda (zUnitPtrBlue), Y

    /* 8D8E C9 FF    */ cmp #$FF
    /* 8D90 F0 0A    */ beq @LOC_8D9C

    /* 8D92 18       */ clc
    /* 8D93 08       */ php

    /* 8D94 4C 9E 8D */ jmp @LOC_8D9E

@LOC_8D97:
    /* 8D97 E8       */ inx
    /* 8D98 E0 37    */ cpx #$37
    /* 8D9A 90 10    */ bcc @LOC_8DAC

@LOC_8D9C:
    /* 8D9C 38       */ sec
    /* 8D9D 08       */ php

@LOC_8D9E:
    /* 8D9E A5 66    */ lda zUnk65+1
    /* 8DA0 F0 08    */ beq @LOC_8DAA

    /* 8DA2 20 B4 8D */ jsr @LOC_8DB4

    /* 8DA5 A9 00    */ lda #0
    /* 8DA7 A8       */ tay ; Unit.pid
    /* 8DA8 91 9F    */ sta (zUnitPtrBlue), Y

@LOC_8DAA:
    /* 8DAA 28       */ plp
    /* 8DAB 60       */ rts

@LOC_8DAC:
    /* 8DAC A9 1B    */ lda #_sizeof_Unit
    /* 8DAE 20 BC 91 */ jsr AddToBlueUnitPtr

    /* 8DB1 4C 81 8D */ jmp @LOC_8D81

@LOC_8DB4:
    /* 8DB4 85 A0    */ sta zUnitPtrBlue+1

    /* 8DB6 A5 65    */ lda zUnk65
    /* 8DB8 85 9F    */ sta zUnitPtrBlue

    /* 8DBA A9 36    */ lda #_sizeof_Unit*2
    /* 8DBC 20 BC 91 */ jsr AddToBlueUnitPtr

    /* 8DBF 60       */ rts

FUNC_03_8CCE_case_2:
    /* 8DC0 A9 20    */ lda #$20
    /* 8DC2 8D 3D 05 */ sta wUnk053D

    /* 8DC5 AD 44 05 */ lda wUnk0544

FUNC_03_8DC8:
    /* 8DC8 8D F1 77 */ sta sUnk77F1

    /* 8DCB A9 00    */ lda #0
    /* 8DCD 8D F0 77 */ sta sUnk77F0

    /* 8DD0 A9 01    */ lda #1
    /* 8DD2 8D F7 77 */ sta sUnk77F7

    /* 8DD5 AD 7A 76 */ lda sUnk767A
    /* 8DD8 D0 13    */ bne FUNC_03_8DED

    /* 8DDA AD 3D 05 */ lda wUnk053D

    /* 8DDD AC 42 05 */ ldy wUnk0542

    /* 8DE0 C0 02    */ cpy #2
    /* 8DE2 F0 06    */ beq @LOC_8DEA

    /* 8DE4 8D F2 06 */ sta wUnk06F2

    /* 8DE7 4C ED 8D */ jmp FUNC_03_8DED

@LOC_8DEA:
    /* 8DEA 8D F6 06 */ sta wUnk06F6

FUNC_03_8DED:
    /* 8DED A9 03    */ lda #3
    /* 8DEF 8D 42 05 */ sta wUnk0542

    /* 8DF2 60       */ rts

FUNC_03_8CCE_case_3:
    /* 8DF3 A9 01    */ lda #1
    /* 8DF5 85 97    */ sta zUnk97

    /* 8DF7 A9 71    */ lda #$71

    /* 8DF9 20 81 9A */ jsr LOC_9A81

    /* 8DFC F0 35    */ beq @LOC_8E33

    /* 8DFE A9 D8    */ lda #<wUnk04D8
    /* 8E00 85 00    */ sta zR00
    /* 8E02 A9 04    */ lda #>wUnk04D8
    /* 8E04 85 01    */ sta zR00+1

    /* 8E06 A0 00    */ ldy #0

@LOC_8E08:
    /* 8E08 B9 34 8E */ lda @DAT_8E34.w, Y
    /* 8E0B 91 00    */ sta (zR00), Y

    /* 8E0D C8       */ iny

    /* 8E0E C0 14    */ cpy #$14
    /* 8E10 D0 F6    */ bne @LOC_8E08

    /* 8E12 A9 80    */ lda #$80
    /* 8E14 85 22    */ sta zUnk22

    /* 8E16 AD 7A 76 */ lda sUnk767A
    /* 8E19 D0 13    */ bne @LOC_8E2E

    /* 8E1B AD 74 76 */ lda sMapNum

    /* 8E1E C9 19    */ cmp #MAP_19
    /* 8E20 D0 07    */ bne @LOC_8E29

    /* 8E22 A9 08    */ lda #8
    /* 8E24 8D F6 06 */ sta wUnk06F6

    /* 8E27 D0 05    */ bne @LOC_8E2E

@LOC_8E29:
    /* 8E29 A9 01    */ lda #1
    /* 8E2B 8D F5 06 */ sta wUnk06F5

@LOC_8E2E:
    /* 8E2E A9 00    */ lda #0
    /* 8E30 8D 42 05 */ sta wUnk0542

@LOC_8E33:
    /* 8E33 60       */ rts

@DAT_8E34:
    /* 8E34 ...      */ .db $3F, $10, $10, $0F, $36, $12, $0F, $0F
    /* 8E3C ...      */ .db $36, $26, $0F, $0F, $3C, $33, $0F, $0F
    /* 8E44 ...      */ .db $35, $15, $0F, $00

FUNC_03_8CCE_case_1:
    /* 8E48 20 52 8E */ jsr @LOC_8E52
    /* 8E4B 20 AF 8E */ jsr @LOC_8EAF

    /* 8E4E EE 42 05 */ inc wUnk0542

    /* 8E51 60       */ rts

@LOC_8E52:
    /* 8E52 20 67 82 */ jsr GetBlueUnits

@LOC_8E55:
    /* 8E55 A0 00    */ ldy #Unit.pid
    /* 8E57 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 8E59 F0 08    */ beq @LOC_8E63

    /* 8E5B A9 1B    */ lda #_sizeof_Unit
    /* 8E5D 20 BC 91 */ jsr AddToBlueUnitPtr

    /* 8E60 4C 55 8E */ jmp @LOC_8E55

@LOC_8E63:
    /* 8E63 20 A0 9E */ jsr LOC_9EA0

    /* 8E66 AD 43 05 */ lda wUnk0543

    /* 8E69 A0 00    */ ldy #Unit.pid
    /* 8E6B 91 9F    */ sta (zUnitPtrBlue), Y

    /* 8E6D A0 13    */ ldy #Unit.item+0
    /* 8E6F B1 9F    */ lda (zUnitPtrBlue), Y

    /* 8E71 48       */ pha

    /* 8E72 C8       */ iny ; Unit.item+1
    /* 8E73 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 8E75 48       */ pha

    /* 8E76 A9 00    */ lda #0

@LOC_8E78:
    /* 8E78 C8       */ iny

    /* 8E79 C0 1B    */ cpy #_sizeof_Unit
    /* 8E7B F0 05    */ beq @LOC_8E82

    /* 8E7D 91 9F    */ sta (zUnitPtrBlue), Y
    /* 8E7F 4C 78 8E */ jmp @LOC_8E78

@LOC_8E82:
    /* 8E82 68       */ pla
    /* 8E83 F0 09    */ beq @LOC_8E8E

    /* 8E85 A8       */ tay
    /* 8E86 88       */ dey
    /* 8E87 B9 7F D8 */ lda ItemInfo.uses, Y
    /* 8E8A A0 18    */ ldy #Unit.uses+1
    /* 8E8C 91 9F    */ sta (zUnitPtrBlue), Y

@LOC_8E8E:
    /* 8E8E 68       */ pla

    /* 8E8F A8       */ tay
    /* 8E90 88       */ dey
    /* 8E91 B9 7F D8 */ lda ItemInfo.uses, Y
    /* 8E94 A0 17    */ ldy #Unit.uses+0
    /* 8E96 91 9F    */ sta (zUnitPtrBlue), Y

    /* 8E98 A0 12    */ ldy #Unit.unk_12
    /* 8E9A A9 FF    */ lda #$FF
    /* 8E9C 91 9D    */ sta (zUnitPtrRed), Y

    /* 8E9E A9 00    */ lda #0
    /* 8EA0 91 9F    */ sta (zUnitPtrBlue), Y

    /* 8EA2 20 4E C0 */ jsr Rand

    /* 8EA5 29 07    */ and #$7 ; % 8

    /* 8EA7 A0 0B    */ ldy #Unit.lck
    /* 8EA9 91 9F    */ sta (zUnitPtrBlue), Y

    /* 8EAB 20 5D 9E */ jsr LOC_9E5D

    /* 8EAE 60       */ rts

@LOC_8EAF:
    /* 8EAF AD FA 76 */ lda sUnitBuf+Unit.cell
    /* 8EB2 85 A6    */ sta zUnkA6

    /* 8EB4 A9 0C    */ lda #$0C
    /* 8EB6 85 44    */ sta zFarFuncNum
    /* 8EB8 A9 06    */ lda #$06
    /* 8EBA 20 FA C9 */ jsr CallFarFunc

    /* 8EBD A5 A6    */ lda zUnkA6
    /* 8EBF A0 06    */ ldy #Unit.cell
    /* 8EC1 91 9F    */ sta (zUnitPtrBlue), Y

    /* 8EC3 60       */ rts

FUNC_03_8EC4:
    /* 8EC4 20 50 82 */ jsr GetMapCellRowInR04
    /* 8EC7 B1 04    */ lda (zR04), Y

    /* 8EC9 C9 2A    */ cmp #CELL_2A

    /* 8ECB 60       */ rts

FUNC_03_8CCE_case_4:
    /* 8ECC AD 48 05 */ lda wUnk0548
    /* 8ECF F0 15    */ beq @LOC_8EE6

    /* 8ED1 A9 00    */ lda #0
    /* 8ED3 8D 48 05 */ sta wUnk0548

    /* 8ED6 8D F0 77 */ sta sUnk77F0

    /* 8ED9 A9 6C    */ lda #$6C
    /* 8EDB 8D F1 77 */ sta sUnk77F1

    /* 8EDE A9 01    */ lda #$01
    /* 8EE0 8D F7 77 */ sta sUnk77F7

    /* 8EE3 4C ED 8D */ jmp FUNC_03_8DED

@LOC_8EE6:
    /* 8EE6 AD 7F 76 */ lda sUnk767F

    /* 8EE9 29 01    */ and #$1
    /* 8EEB D0 61    */ bne @LOC_8F4E

    /* 8EED A0 00    */ ldy #Unit.pid
    /* 8EEF B1 9D    */ lda (zUnitPtrRed), Y

    /* 8EF1 C9 9C    */ cmp #PID_9C
    /* 8EF3 D0 18    */ bne @LOC_8F0D

    /* 8EF5 AD 74 76 */ lda sMapNum

    /* 8EF8 C9 0F    */ cmp #MAP_0F
    /* 8EFA D0 11    */ bne @LOC_8F0D

    /* 8EFC A0 16    */ ldy #Unit.item+3
    /* 8EFE B1 9D    */ lda (zUnitPtrRed), Y
    /* 8F00 29 0C    */ and #%00001100
    /* 8F02 4A       */ lsr A
    /* 8F03 4A       */ lsr A

    /* 8F04 C9 03    */ cmp #3
    /* 8F06 D0 05    */ bne @LOC_8F0D

    /* 8F08 20 50 85 */ jsr FUNC_03_8550

    /* 8F0B F0 2F    */ beq @LOC_8F3C

@LOC_8F0D:
    /* 8F0D AD 7F 76 */ lda sUnk767F

    /* 8F10 29 02    */ and #$2
    /* 8F12 D0 3A    */ bne @LOC_8F4E

    /* 8F14 A0 1B    */ ldy #_sizeof_Unit+Unit.pid
    /* 8F16 B1 9D    */ lda (zUnitPtrRed), Y

    /* 8F18 C9 A5    */ cmp #PID_A5
    /* 8F1A D0 32    */ bne @LOC_8F4E

    /* 8F1C AD 74 76 */ lda sMapNum

    /* 8F1F C9 07    */ cmp #MAP_07
    /* 8F21 D0 2B    */ bne @LOC_8F4E

    /* 8F23 AD 75 76 */ lda sTurnNumber

    /* 8F26 C9 02    */ cmp #2
    /* 8F28 D0 24    */ bne @LOC_8F4E

    /* 8F2A AD 7F 76 */ lda sUnk767F
    /* 8F2D 09 02    */ ora #$2
    /* 8F2F 8D 7F 76 */ sta sUnk767F

    /* 8F32 A9 01    */ lda #$01
    /* 8F34 8D 3D 05 */ sta wUnk053D

    /* 8F37 A9 08    */ lda #$08

    /* 8F39 4C C8 8D */ jmp FUNC_03_8DC8

@LOC_8F3C:
    /* 8F3C AD 7F 76 */ lda sUnk767F
    /* 8F3F 09 01    */ ora #$1
    /* 8F41 8D 7F 76 */ sta sUnk767F

    /* 8F44 A9 40    */ lda #$40
    /* 8F46 8D 3D 05 */ sta wUnk053D

    /* 8F49 A9 09    */ lda #$09

    /* 8F4B 4C C8 8D */ jmp FUNC_03_8DC8

@LOC_8F4E:
    /* 8F4E A9 00    */ lda #0
    /* 8F50 8D 42 05 */ sta wUnk0542

    /* 8F53 60       */ rts

FUNC_03_8F54:
    /* 8F54 A0 01    */ ldy #Unit.jid
    /* 8F56 B1 9D    */ lda (zUnitPtrRed), Y

    /* 8F58 C9 13    */ cmp #JID_PRIEST
    /* 8F5A D0 3F    */ bne @end

    /* 8F5C A0 13    */ ldy #Unit.item+0
    /* 8F5E B1 9D    */ lda (zUnitPtrRed), Y

    /* 8F60 C9 3E    */ cmp #IID_FORTIFY+1
    /* 8F62 F0 2B    */ beq @fortify_staff

    /* 8F64 C9 36    */ cmp #IID_HEAL+1
    /* 8F66 F0 0B    */ beq @heal_staff

    /* 8F68 C9 37    */ cmp #IID_MEND+1
    /* 8F6A F0 07    */ beq @heal_staff

    /* 8F6C C9 38    */ cmp #IID_RECOVER+1
    /* 8F6E F0 03    */ beq @heal_staff

    /* 8F70 4C 9B 8F */ jmp @end

@heal_staff:
    /* 8F73 AC C1 05 */ ldy wUnk05C1
    /* 8F76 AE C0 05 */ ldx wUnk05C0

    /* 8F79 E8       */ inx

    /* 8F7A 20 9C 8F */ jsr FUNC_03_8F9C

    /* 8F7D CA       */ dex
    /* 8F7E CA       */ dex

    /* 8F7F 20 9C 8F */ jsr FUNC_03_8F9C

    /* 8F82 E8       */ inx
    /* 8F83 C8       */ iny

    /* 8F84 20 9C 8F */ jsr FUNC_03_8F9C

    /* 8F87 88       */ dey
    /* 8F88 88       */ dey

    /* 8F89 20 9C 8F */ jsr FUNC_03_8F9C

    /* 8F8C 4C 9B 8F */ jmp @end

@fortify_staff:
    /* 8F8F 20 4E C0 */ jsr Rand

    /* 8F92 C9 30    */ cmp #$30
    /* 8F94 B0 05    */ bcs @end ; bhs

    /* 8F96 A9 FD    */ lda #253
    /* 8F98 8D C2 05 */ sta wUnk05C2

@end:
    /* 8F9B 60       */ rts

FUNC_03_8F9C:
    /* 8F9C 86 B3    */ stx zUnkB3
    /* 8F9E 84 B2    */ sty zUnkB2

    /* 8FA0 98       */ tya
    /* 8FA1 48       */ pha
    /* 8FA2 8A       */ txa
    /* 8FA3 48       */ pha

    /* 8FA4 20 50 82 */ jsr GetMapCellRowInR04
    /* 8FA7 B1 04    */ lda (zR04), Y
    /* 8FA9 A8       */ tay

    /* 8FAA B9 F8 E8 */ lda Cell2TerrainRed, Y

    /* 8FAD C9 1F    */ cmp #TERRAIN_ENEMY
    /* 8FAF D0 1C    */ bne @end

    /* 8FB1 20 4A 91 */ jsr FindEnemyUnitAtToR02

    /* 8FB4 B0 17    */ bcs @end

    /* 8FB6 A0 03    */ ldy #Unit.hp_cur
    /* 8FB8 B1 02    */ lda (zR02), Y

    /* 8FBA 85 A3    */ sta zUnkA3

    /* 8FBC C8       */ iny ; Unit.hp_max
    /* 8FBD B1 02    */ lda (zR02), Y

    /* 8FBF C5 A3    */ cmp zUnkA3
    /* 8FC1 F0 0A    */ beq @end

    /* 8FC3 A5 AE    */ lda zUnkAE

    /* 8FC5 CD C3 05 */ cmp wUnk05C3
    /* 8FC8 F0 03    */ beq @end

    /* 8FCA 8D C2 05 */ sta wUnk05C2

@end:
    /* 8FCD 68       */ pla
    /* 8FCE AA       */ tax
    /* 8FCF 68       */ pla
    /* 8FD0 A8       */ tay

    /* 8FD1 60       */ rts

GetRedUnits:
    /* 8FD2 A9 78    */ lda #<sRedUnits
    /* 8FD4 85 9D    */ sta zUnitPtrRed
    /* 8FD6 A9 70    */ lda #>sRedUnits
    /* 8FD8 85 9E    */ sta zUnitPtrRed+1

    /* 8FDA 60       */ rts

GetRedUnitsInR02:
    /* 8FDB A9 78    */ lda #<sRedUnits
    /* 8FDD 85 02    */ sta zR02
    /* 8FDF A9 70    */ lda #>sRedUnits
    /* 8FE1 85 03    */ sta zR02+1

    /* 8FE3 60       */ rts

FloodMovementMap:
    /* 8FE4 AE 39 05 */ ldx wUnk0539
    /* 8FE7 AC 38 05 */ ldy wUnk0538

    /* 8FEA 20 22 82 */ jsr GetMapMovementRow

    /* 8FED A9 3D    */ lda #$3D
    /* 8FEF 91 6C    */ sta (zMapMovementRow), Y

    /* 8FF1 A9 00    */ lda #0
    /* 8FF3 85 BE    */ sta zMapFloodRingNum

    /* 8FF5 86 C1    */ stx zUnkC1
    /* 8FF7 84 C0    */ sty zUnkC0

    /* 8FF9 A5 B8    */ lda zMapFloodAction

    /* 8FFB F0 17    */ beq @case_0

    /* 8FFD C9 01    */ cmp #1
    /* 8FFF F0 0D    */ beq @case_1

    /* 9001 C9 02    */ cmp #2
    /* 9003 F0 03    */ beq @case_2

    /* 9005 4C 7F 90 */ jmp @end

@case_2:
    /* 9008 20 26 86 */ jsr FUNC_03_8626

    /* 900B 4C 17 90 */ jmp @common

@case_1:
    /* 900E 20 6F 81 */ jsr FUNC_03_816F

    /* 9011 4C 17 90 */ jmp @common

@case_0:
    /* 9014 20 1D 89 */ jsr FUNC_03_891D

@common:
    /* 9017 A5 B8    */ lda zMapFloodAction

    /* 9019 C9 FF    */ cmp #$FF
    /* 901B F0 62    */ beq @end

    /* 901D A5 BF    */ lda $BF
    /* 901F F0 5E    */ beq @end

    /* 9021 20 80 90 */ jsr FUNC_03_9080

@lop:
    /* 9024 E6 BE    */ inc zMapFloodRingNum

    /* 9026 A2 01    */ ldx #1

@lop_y:
    /* 9028 A0 01    */ ldy #1

    /* 902A 8A       */ txa
    /* 902B 48       */ pha

    /* 902C 0A       */ asl A
    /* 902D AA       */ tax

    /* 902E BD 01 ED */ lda MapMovementRows.w, X
    /* 9031 85 6C    */ sta zMapMovementRow
    /* 9033 BD 02 ED */ lda MapMovementRows.w+1, X
    /* 9036 85 6D    */ sta zMapMovementRow+1

    /* 9038 68       */ pla
    /* 9039 AA       */ tax

@lop_x:
    /* 903A B1 6C    */ lda (zMapMovementRow), Y
    /* 903C 29 3F    */ and #$3F

    /* 903E C5 BE    */ cmp zMapFloodRingNum
    /* 9040 D0 2B    */ bne @continue

    /* 9042 86 C1    */ stx zUnkC1
    /* 9044 84 C0    */ sty zUnkC0

    /* 9046 A5 B8    */ lda zMapFloodAction

    /* 9048 F0 17    */ beq @cell_case_0

    /* 904A C9 01    */ cmp #1
    /* 904C F0 0D    */ beq @cell_case_1

    /* 904E C9 02    */ cmp #2
    /* 9050 F0 03    */ beq @cell_case_2

    /* 9052 4C 7F 90 */ jmp @end

@cell_case_2:
    /* 9055 20 26 86 */ jsr FUNC_03_8626

    /* 9058 4C 64 90 */ jmp @cell_common

@cell_case_1:
    /* 905B 20 6F 81 */ jsr FUNC_03_816F

    /* 905E 4C 64 90 */ jmp @cell_common

@cell_case_0:
    /* 9061 20 1D 89 */ jsr FUNC_03_891D

@cell_common:
    /* 9064 A5 B8    */ lda zMapFloodAction

    /* 9066 C9 FF    */ cmp #$FF
    /* 9068 F0 15    */ beq @end

    /* 906A 20 80 90 */ jsr FUNC_03_9080

@continue:
    /* 906D C8       */ iny

    /* 906E CC 77 76 */ cpy sMapWidth
    /* 9071 D0 C7    */ bne @lop_x

    /* 9073 E8       */ inx

    /* 9074 EC 76 76 */ cpx sMapHeight
    /* 9077 90 AF    */ bcc @lop_y

    /* 9079 A5 BE    */ lda zMapFloodRingNum

    /* 907B C5 BF    */ cmp zMapFloodRingCount
    /* 907D D0 A5    */ bne @lop

@end:
    /* 907F 60       */ rts

FUNC_03_9080:
    /* 9080 8A       */ txa
    /* 9081 48       */ pha
    /* 9082 98       */ tya
    /* 9083 48       */ pha

    /* 9084 A2 00    */ ldx #0

@lop:
    /* 9086 8A       */ txa
    /* 9087 48       */ pha

    /* 9088 0A       */ asl A
    /* 9089 A8       */ tay

    /* 908A B9 3C 91 */ lda @direction_coord_lut.w, Y
    /* 908D 65 C0    */ adc zUnkC0
    /* 908F 85 B2    */ sta zUnkB2

    /* 9091 B9 3D 91 */ lda @direction_coord_lut.w+1, Y
    /* 9094 18       */ clc
    /* 9095 65 C1    */ adc zUnkC1
    /* 9097 85 B3    */ sta zUnkB3

    ; zUnkB2 = x coord
    ; zUnkB3 = y coord (= A)

    /* 9099 0A       */ asl A
    /* 909A A8       */ tay

    /* 909B B9 3D ED */ lda MapCellRows, Y
    /* 909E 85 04    */ sta zR04
    /* 90A0 B9 3E ED */ lda MapCellRows+1, Y
    /* 90A3 85 05    */ sta zR04+1

    /* 90A5 A4 B2    */ ldy zUnkB2
    /* 90A7 B1 04    */ lda (zR04), Y
    /* 90A9 AA       */ tax

    ; X = cell

    /* 90AA A4 B8    */ ldy zMapFloodAction

    /* 90AC 88       */ dey
    /* 90AD D0 0C    */ bne @red_active

    /* 90AF A0 01    */ ldy #Unit.jid
    /* 90B1 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 90B3 85 A5    */ sta zUnkA5

    /* 90B5 BD 28 E8 */ lda Cell2TerrainBlue.w, X

    /* 90B8 4C C4 90 */ jmp +

@red_active:
    /* 90BB A0 01    */ ldy #Unit.jid
    /* 90BD B1 9D    */ lda (zUnitPtrRed), Y
    /* 90BF 85 A5    */ sta zUnkA5

    /* 90C1 BD F8 E8 */ lda Cell2TerrainRed.w, X

+:
    ; zUnkA5 = unit jid
    ; A = terrain

    /* 90C4 48       */ pha

    /* 90C5 C9 1F    */ cmp #TERRAIN_ENEMY
    /* 90C7 D0 0D    */ bne @no_enemy_unit

    /* 90C9 68       */ pla

    /* 90CA 20 4A 91 */ jsr FindEnemyUnitAtToR02

    /* 90CD A0 06    */ ldy #Unit.cell
    /* 90CF B1 02    */ lda (zR02), Y

    /* 90D1 AA       */ tax
    /* 90D2 BD 28 E8 */ lda Cell2TerrainBlue.w, X

    /* 90D5 48       */ pha

@no_enemy_unit:
    /* 90D6 A4 A5    */ ldy zUnkA5

    /* 90D8 88       */ dey
    /* 90D9 98       */ tya
    /* 90DA 0A       */ asl A
    /* 90DB A8       */ tay

    /* 90DC B9 C8 E9 */ lda JobMoveCosts.w, Y
    /* 90DF 85 06    */ sta zR06
    /* 90E1 B9 C9 E9 */ lda JobMoveCosts.w+1, Y
    /* 90E4 85 07    */ sta zR06+1

    /* 90E6 68       */ pla

    /* 90E7 A8       */ tay
    /* 90E8 B1 06    */ lda (zR06), Y

    /* 90EA 18       */ clc
    /* 90EB 65 BE    */ adc zMapFloodRingNum

    ; jump if no unsigned overflow
    /* 90ED 90 04    */ bcc @LOC_90F3

@LOC_90EF:
    /* 90EF A9 3E    */ lda #$3E
    /* 90F1 D0 04    */ bne +

@LOC_90F3:
    /* 90F3 C9 3D    */ cmp #$3D
    /* 90F5 B0 F8    */ bcs @LOC_90EF ; bhs

+:
    /* 90F7 85 09    */ sta zR09

    /* 90F9 68       */ pla
    /* 90FA AA       */ tax

    /* 90FB 18       */ clc
    /* 90FC 6A       */ ror A
    /* 90FD 6A       */ ror A
    /* 90FE 6A       */ ror A
    /* 90FF 05 09    */ ora zR09
    /* 9101 85 0A    */ sta zR0A

    ; zR0A = (mov) | (dir << 6)

    /* 9103 A5 B3    */ lda zUnkB3
    /* 9105 0A       */ asl A
    /* 9106 A8       */ tay

    /* 9107 B9 01 ED */ lda MapMovementRows.w, Y
    /* 910A 85 6C    */ sta zMapMovementRow
    /* 910C B9 02 ED */ lda MapMovementRows.w+1, Y
    /* 910F 85 6D    */ sta zMapMovementRow+1

    /* 9111 A4 B2    */ ldy zUnkB2
    /* 9113 B1 6C    */ lda (zMapMovementRow), Y

    /* 9115 29 3F    */ and #$3F

    /* 9117 F0 12    */ beq @update_cell

    /* 9119 C9 3C    */ cmp #$3C
    /* 911B B0 12    */ bcs @continue ; bhs

    /* 911D C5 09    */ cmp zR09
    /* 911F D0 0E    */ bne @continue

    /* 9121 20 4E C0 */ jsr Rand

    /* 9124 C9 80    */ cmp #$80
    /* 9126 90 03    */ bcc @update_cell ; blo

    /* 9128 4C 2F 91 */ jmp @continue

@update_cell:
    /* 912B A5 0A    */ lda zR0A
    /* 912D 91 6C    */ sta (zMapMovementRow), Y

@continue:
    /* 912F E8       */ inx

    /* 9130 E0 04    */ cpx #4
    /* 9132 F0 03    */ beq @end

    /* 9134 4C 86 90 */ jmp @lop

@end:
    /* 9137 68       */ pla
    /* 9138 A8       */ tay
    /* 9139 68       */ pla
    /* 913A AA       */ tax

    /* 913B 60       */ rts

@direction_coord_lut:
    .db  0, -1
    .db +1,  0
    .db  0, +1
    .db -1,  0

FindPlayerUnitAtTo9F:
    ; Input:
    ; - zUnkB2 = x map position
    ; - zUnkB3 = y map position
    ; Output:
    ; - zUnitPtrBlue = unit at given position
    ; - zUnkAE = id of unit at given position
    ; - C = cleared if found

    /* 9144 20 67 82 */ jsr GetBlueUnits

    /* 9147 4C 86 91 */ jmp LOC_9186

FindEnemyUnitAtToR02:
    ; Input:
    ; - zUnkB2 = x map position
    ; - zUnkB3 = y map position
    ; Output:
    ; - zR02 = unit at given position
    ; - zUnkAE = id of unit at given position
    ; - C = cleared if found

    /* 914A 20 DB 8F */ jsr GetRedUnitsInR02

    /* 914D 4C 50 91 */ jmp LOC_9150

LOC_9150:
    ; Input:
    ; - zR02 = unit array to look through
    ; - zUnkB2 = x map position
    ; - zUnkB3 = y map position
    ; Output:
    ; - zUnkAE = id of unit at given position
    ; - C = cleared if found

    /* 9150 98       */ tya
    /* 9151 48       */ pha
    /* 9152 8A       */ txa
    /* 9153 48       */ pha

    /* 9154 A2 00    */ ldx #0

    /* 9156 F0 06    */ beq @begin

@lop:
    /* 9158 E8       */ inx

    /* 9159 A0 1B    */ ldy #_sizeof_Unit
    /* 915B 20 83 C3 */ jsr IncR02ByY

@begin:
    /* 915E A0 00    */ ldy #Unit.pid
    /* 9160 B1 02    */ lda (zR02), Y

    /* 9162 C9 00    */ cmp #0
    /* 9164 F0 1B    */ beq @end

    /* 9166 A0 12    */ ldy #Unit.unk_12
    /* 9168 B1 02    */ lda (zR02), Y

    /* 916A C9 FF    */ cmp #$FF
    /* 916C F0 EA    */ beq @lop

    /* 916E A0 10    */ ldy #Unit.y
    /* 9170 B1 02    */ lda (zR02), Y

    /* 9172 C5 B3    */ cmp zUnkB3
    /* 9174 D0 E2    */ bne @lop

    /* 9176 A0 11    */ ldy #Unit.x
    /* 9178 B1 02    */ lda (zR02), Y

    /* 917A C5 B2    */ cmp zUnkB2
    /* 917C D0 DA    */ bne @lop

    /* 917E 18       */ clc
    /* 917F 86 AE    */ stx zUnkAE

@end:
    /* 9181 68       */ pla
    /* 9182 AA       */ tax
    /* 9183 68       */ pla
    /* 9184 A8       */ tay

    /* 9185 60       */ rts

LOC_9186:
    ; Input:
    ; - zUnitPtrBlue = unit array to look through
    ; - zUnkB2 = x map position
    ; - zUnkB3 = y map position
    ; Output:
    ; - zUnkAE = id of unit at given position
    ; - C = cleared if found

    /* 9186 98       */ tya
    /* 9187 48       */ pha
    /* 9188 8A       */ txa
    /* 9189 48       */ pha

    /* 918A A2 00    */ ldx #0

    /* 918C F0 06    */ beq @begin

@lop:
    /* 918E E8       */ inx

    /* 918F A9 1B    */ lda #_sizeof_Unit
    /* 9191 20 BC 91 */ jsr AddToBlueUnitPtr

@begin:
    /* 9194 A0 00    */ ldy #Unit.pid
    /* 9196 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 9198 C9 00    */ cmp #0
    /* 919A F0 19    */ beq @end

    /* 919C A0 12    */ ldy #Unit.unk_12
    /* 919E B1 9F    */ lda (zUnitPtrBlue), Y
    /* 91A0 C9 FF    */ cmp #$FF
    /* 91A2 F0 EA    */ beq @lop

    /* 91A4 A0 10    */ ldy #Unit.y
    /* 91A6 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 91A8 C5 B3    */ cmp zUnkB3
    /* 91AA D0 E2    */ bne @lop

    /* 91AC A0 11    */ ldy #Unit.x
    /* 91AE B1 9F    */ lda (zUnitPtrBlue), Y

    /* 91B0 C5 B2    */ cmp zUnkB2
    /* 91B2 D0 DA    */ bne @lop

    /* 91B4 18       */ clc

@end:
    /* 91B5 86 AE    */ stx zUnkAE

    /* 91B7 68       */ pla
    /* 91B8 AA       */ tax
    /* 91B9 68       */ pla
    /* 91BA A8       */ tay

    /* 91BB 60       */ rts

AddToBlueUnitPtr:
    /* 91BC 18       */ clc
    /* 91BD 65 9F    */ adc zUnitPtrBlue
    /* 91BF 85 9F    */ sta zUnitPtrBlue
    /* 91C1 90 02    */ bcc +

    /* 91C3 E6 A0    */ inc zUnitPtrBlue+1

+:
    /* 91C5 60       */ rts

AddToRedUnitPtr:
    /* 91C6 18       */ clc
    /* 91C7 65 9D    */ adc zUnitPtrRed
    /* 91C9 85 9D    */ sta zUnitPtrRed
    /* 91CB 90 02    */ bcc +

    /* 91CD E6 9E    */ inc zUnitPtrRed+1

+:
    /* 91CF 60       */ rts

SpawnEnemyReinforcement:
    /* 91D0 AC 74 76 */ ldy sMapNum
    /* 91D3 88       */ dey
    /* 91D4 98       */ tya
    /* 91D5 0A       */ asl A
    /* 91D6 A8       */ tay

    /* 91D7 B9 9C 95 */ lda MapReinforcements, Y
    /* 91DA 85 76    */ sta zUnitLoadSrc
    /* 91DC B9 9D 95 */ lda MapReinforcements+1, Y
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

    /* 921E 20 6D 8D */ jsr FUNC_03_8D6D

    /* 9221 B0 37    */ bcs @continue

@LOC_9223:
    /* 9223 A0 08    */ ldy #EnemyInfo.unk_08
    /* 9225 B1 76    */ lda (zUnitLoadSrc), Y
    /* 9227 0A       */ asl A
    /* 9228 B0 09    */ bcs @multiple_turns

    /* 922A 4A       */ lsr A
    /* 922B CD 75 76 */ cmp sTurnNumber
    /* 922E F0 15    */ beq @on_turn

    /* 9230 4C 5A 92 */ jmp @continue

@multiple_turns:
    /* 9233 4A       */ lsr A
    /* 9234 CD 75 76 */ cmp sTurnNumber
    /* 9237 B0 21    */ bcs @continue ; bhs

    /* 9239 AC 74 76 */ ldy sMapNum
    /* 923C 88       */ dey

    /* 923D B9 4E A4 */ lda MapFirstReinforcementTurn, Y

    /* 9240 CD 75 76 */ cmp sTurnNumber
    /* 9243 90 15    */ bcc @continue ; blo

@on_turn:
    /* 9245 A0 05    */ ldy #EnemyInfo.y
    /* 9247 B1 76    */ lda (zUnitLoadSrc), Y
    /* 9249 85 B3    */ sta zUnkB3

    /* 924B C8       */ iny ; EnemyInfo.x
    /* 924C B1 76    */ lda (zUnitLoadSrc), Y
    /* 924E 85 B2    */ sta zUnkB2

    /* 9250 20 4A 91 */ jsr FindEnemyUnitAtToR02

    /* 9253 90 05    */ bcc @continue

    /* 9255 20 44 91 */ jsr FindPlayerUnitAtTo9F

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
    /* 9268 20 71 92 */ jsr InitEnemyUnitFromReinforcement

    /* 926B 20 2A 93 */ jsr CopyUnitBufToResult

    /* 926E A9 FF    */ lda #$FF

@end:
    /* 9270 60       */ rts

InitEnemyUnitFromReinforcement:
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
    /* 931C 20 50 82 */ jsr GetMapCellRowInR04
    /* 931F B1 04    */ lda (zR04), Y
    /* 9321 8D FA 76 */ sta sUnitBuf+Unit.cell
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
    /* 933A 91 9D    */ sta (zUnitPtrRed), Y
    /* 933C C8       */ iny
    /* 933D C0 1B    */ cpy #_sizeof_Unit
    /* 933F D0 F7    */ bne @lop

    /* 9341 68       */ pla
    /* 9342 A8       */ tay
    /* 9343 68       */ pla
    /* 9344 AA       */ tax

    /* 9345 60       */ rts

HealEnemyUnitsFromTerrain:
    /* 9346 20 D2 8F */ jsr GetRedUnits

    /* 9349 A2 00    */ ldx #0
    /* 934B 86 AD    */ stx zUnkAD

@lop:
    /* 934D A0 00    */ ldy #Unit.pid
    /* 934F B1 9D    */ lda (zUnitPtrRed), Y

    /* 9351 F0 43    */ beq @end

    /* 9353 A0 12    */ ldy #Unit.unk_12
    /* 9355 B1 9D    */ lda (zUnitPtrRed), Y

    /* 9357 C9 FF    */ cmp #$FF
    /* 9359 F0 2E    */ beq @continue

    /* 935B A0 06    */ ldy #Unit.cell
    /* 935D B1 9D    */ lda (zUnitPtrRed), Y

    /* 935F C9 4A    */ cmp #CELL_4A
    /* 9361 F0 08    */ beq @heal

    /* 9363 C9 AE    */ cmp #CELL_AE
    /* 9365 F0 04    */ beq @heal

    /* 9367 C9 4B    */ cmp #CELL_4B
    /* 9369 D0 1E    */ bne @continue

@heal:
    /* 936B A0 03    */ ldy #Unit.hp_cur
    /* 936D B1 9D    */ lda (zUnitPtrRed), Y
    /* 936F 85 A3    */ sta zUnkA3

    /* 9371 C8       */ iny ; Unit.hp_max
    /* 9372 B1 9D    */ lda (zUnitPtrRed), Y
    /* 9374 85 A4    */ sta zUnkA4

    /* 9376 20 4E C0 */ jsr Rand

    /* 9379 29 07    */ and #$7
    /* 937B 18       */ clc
    /* 937C 69 03    */ adc #3
    /* 937E 65 A3    */ adc zUnkA3

    /* 9380 C5 A4    */ cmp zUnkA4
    /* 9382 90 02    */ bcc +

    /* 9384 A5 A4    */ lda zUnkA4

+:
    /* 9386 88       */ dey ; Unit.hp_cur
    /* 9387 91 9D    */ sta (zUnitPtrRed), Y

@continue:
    /* 9389 A6 AD    */ ldx zUnkAD
    /* 938B E8       */ inx
    /* 938C 86 AD    */ stx zUnkAD

    /* 938E A9 1B    */ lda #_sizeof_Unit
    /* 9390 20 C6 91 */ jsr AddToRedUnitPtr

    /* 9393 4C 4D 93 */ jmp @lop

@end:
    /* 9396 EE 3F 05 */ inc wUnk053F

    /* 9399 60       */ rts

HealPlayerUnitsFromTerrain:
    /* 939A 20 67 82 */ jsr GetBlueUnits

    /* 939D A2 00    */ ldx #0
    /* 939F 86 AD    */ stx zUnkAD

@lop:
    /* 93A1 A0 00    */ ldy #Unit.pid
    /* 93A3 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 93A5 F0 43    */ beq @end

    /* 93A7 A0 12    */ ldy #Unit.unk_12
    /* 93A9 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 93AB C9 FF    */ cmp #$FF
    /* 93AD F0 2E    */ beq @continue

    /* 93AF A0 06    */ ldy #Unit.cell
    /* 93B1 B1 9F    */ lda (zUnitPtrBlue), Y

    /* 93B3 C9 4A    */ cmp #CELL_4A
    /* 93B5 F0 08    */ beq @heal

    /* 93B7 C9 AE    */ cmp #CELL_AE
    /* 93B9 F0 B0    */ beq HealEnemyUnitsFromTerrain@heal ; BUG

    /* 93BB C9 4B    */ cmp #CELL_4B
    /* 93BD D0 1E    */ bne @continue

@heal:
    /* 93BF A0 03    */ ldy #Unit.hp_cur
    /* 93C1 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 93C3 85 A3    */ sta zUnkA3

    /* 93C5 C8       */ iny ; Unit.hp_max
    /* 93C6 B1 9F    */ lda (zUnitPtrBlue), Y
    /* 93C8 85 A4    */ sta zUnkA4

    /* 93CA 20 4E C0 */ jsr Rand

    /* 93CD 29 07    */ and #7 ; % 8
    /* 93CF 18       */ clc
    /* 93D0 69 03    */ adc #3

    /* 93D2 65 A3    */ adc zUnkA3

    /* 93D4 C5 A4    */ cmp zUnkA4
    /* 93D6 90 02    */ bcc +

    /* 93D8 A5 A4    */ lda zUnkA4

+:
    /* 93DA 88       */ dey ; Unit.hp_cur
    /* 93DB 91 9F    */ sta (zUnitPtrBlue), Y

@continue:
    /* 93DD A6 AD    */ ldx zUnkAD
    /* 93DF E8       */ inx
    /* 93E0 86 AD    */ stx zUnkAD

    /* 93E2 A9 1B    */ lda #_sizeof_Unit
    /* 93E4 20 BC 91 */ jsr AddToBlueUnitPtr

    /* 93E7 4C A1 93 */ jmp @lop

@end:
    /* 93EA EE 3F 05 */ inc wUnk053F

    /* 93ED 60       */ rts

FUNC_03_93EE:
    /* 93EE AC 74 76 */ ldy sMapNum

    /* 93F1 C0 19    */ cpy #MAP_19
    /* 93F3 D0 32    */ bne @end

    /* 93F5 A9 38    */ lda #<DAT_A438
    /* 93F7 85 9D    */ sta zUnitPtrRed
    /* 93F9 A9 A4    */ lda #>DAT_A438
    /* 93FB 85 9E    */ sta zUnitPtrRed+1

@lop:
    /* 93FD A0 00    */ ldy #0
    /* 93FF B1 9D    */ lda (zUnitPtrRed), Y
    /* 9401 F0 24    */ beq @end

    /* 9403 CD 75 76 */ cmp sTurnNumber
    /* 9406 D0 17    */ bne @continue

    /* 9408 C8       */ iny
    /* 9409 B1 9D    */ lda (zUnitPtrRed), Y
    /* 940B 85 B3    */ sta zUnkB3

    /* 940D C8       */ iny
    /* 940E B1 9D    */ lda (zUnitPtrRed), Y
    /* 9410 85 B2    */ sta zUnkB2

    /* 9412 20 44 91 */ jsr FindPlayerUnitAtTo9F

    /* 9415 90 08    */ bcc @continue

    /* 9417 20 4A 91 */ jsr FindEnemyUnitAtToR02

    /* 941A 90 03    */ bcc @continue

    /* 941C 20 2B 94 */ jsr FUNC_03_942B

@continue:
    /* 941F A9 03    */ lda #3
    /* 9421 20 C6 91 */ jsr AddToRedUnitPtr

    /* 9424 4C FD 93 */ jmp @lop

@end:
    /* 9427 EE 3F 05 */ inc wUnk053F

    /* 942A 60       */ rts

FUNC_03_942B:
    /* 942B A9 80    */ lda #$80
    /* 942D 8D F0 06 */ sta wUnk06F0

    /* 9430 A6 B3    */ ldx zUnkB3
    /* 9432 20 50 82 */ jsr GetMapCellRowInR04

    /* 9435 A4 B2    */ ldy zUnkB2

    /* 9437 A9 3D    */ lda #CELL_3D
    /* 9439 91 04    */ sta (zR04), Y

    /* 943B 85 0B    */ sta zR0B
    /* 943D 85 A3    */ sta zUnkA3
    /* 943F 84 05    */ sty zR05
    /* 9441 84 A4    */ sty zUnkA4
    /* 9443 86 04    */ stx zR04
    /* 9445 86 A5    */ stx zUnkA5

    /* 9447 A9 0D    */ lda #$0D
    /* 9449 85 44    */ sta zFarFuncNum
    /* 944B A9 06    */ lda #$06
    /* 944D 20 FA C9 */ jsr CallFarFunc

    /* 9450 A5 A3    */ lda zUnkA3
    /* 9452 85 0B    */ sta zR0B
    /* 9454 A4 A4    */ ldy zUnkA4
    /* 9456 84 05    */ sty zR05
    /* 9458 A6 A5    */ ldx zUnkA5
    /* 945A 86 04    */ stx zR04

    /* 945C A9 07    */ lda #$07
    /* 945E 85 44    */ sta zFarFuncNum
    /* 9460 A9 06    */ lda #$06
    /* 9462 20 FA C9 */ jsr CallFarFunc

    /* 9465 60       */ rts
