
    LOC_85A4 = $85A4
    LOC_8CCE = $8CCE
    LOC_8FD2 = $8FD2
    LOC_8FDB = $8FDB
    LOC_8FE4 = $8FE4
    LOC_9144 = $9144
    LOC_914A = $914A
    LOC_91BC = $91BC
    LOC_91C6 = $91C6
    LOC_91D0 = $91D0
    LOC_99E6 = $99E6
    LOC_9EEE = $9EEE

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

    .dw CODE_03_8022
    .dw $9346
    .dw CODE_03_8026
    .dw FUNC_03_8270
    .dw $939A
    .dw $93EE
    .dw CODE_03_802D
    .dw CaseRet

CODE_03_8022:
    /* 8022 EE 3F 05 */ inc wUnk053F
    /* 8025 60       */ rts

CODE_03_8026:
    /* 8026 20 6F 80 */ jsr FUNC_03_806F

    /* 8029 EE 3F 05 */ inc wUnk053F
    /* 802C 60       */ rts

CODE_03_802D:
    /* 802D A9 20    */ lda #$20
    /* 802F 85 84    */ sta zUnk84

    /* 8031 A9 00    */ lda #0
    /* 8033 8D 3F 05 */ sta wUnk053F

    /* 8036 60       */ rts

FUNC_03_8037:
    /* 8037 AE 76 76 */ ldx sMapHeight
    /* 803A E8       */ inx
    /* 803B 86 0A    */ stx zR0A

    /* 803D AE 77 76 */ ldx sMapWidth
    /* 8040 E8       */ inx
    /* 8041 86 0B    */ stx zR0B

    /* 8043 A2 00    */ ldx #0

@lop_y:
    /* 8045 20 22 82 */ jsr GetMapRow3In6C

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
    /* 8062 91 6C    */ sta (zUnk6C), Y
    /* 8064 C8       */ iny
    /* 8065 C4 0B    */ cpy zR0B
    /* 8067 D0 E1    */ bne @lop_x

    /* 8069 E8       */ inx
    /* 806A E4 0A    */ cpx zR0A
    /* 806C 90 D7    */ bcc @lop_y

    /* 806E 60       */ rts

FUNC_03_806F:
    /* 806F 20 A8 80 */ jsr ClearMap2
    /* 8072 20 67 82 */ jsr GetPlayerUnitsIn9F

    /* 8075 A2 00    */ ldx #0
    /* 8077 86 AD    */ stx zUnkAD

@lop:
    /* 8079 A0 00    */ ldy #Unit.pid
    /* 807B B1 9F    */ lda (zUnk9F), Y
    /* 807D F0 28    */ beq @end

    /* 807F A0 12    */ ldy #Unit.unk_12
    /* 8081 B1 9F    */ lda (zUnk9F), Y

    /* 8083 C9 FF    */ cmp #-1
    /* 8085 F0 13    */ beq @LOC_809A

    /* 8087 A0 10    */ ldy #Unit.y
    /* 8089 B1 9F    */ lda (zUnk9F), Y
    /* 808B 8D 39 05 */ sta wUnk0539

    /* 808E C8       */ iny ; Unit.x
    /* 808F B1 9F    */ lda (zUnk9F), Y
    /* 8091 8D 38 05 */ sta wUnk0538

    /* 8094 20 CA 80 */ jsr FUNC_03_80CA

    /* 8097 20 2B 81 */ jsr FUNC_03_812B

@LOC_809A:
    /* 809A A6 AD    */ ldx zUnkAD
    /* 809C E8       */ inx
    /* 809D 86 AD    */ stx zUnkAD

    /* 809F A9 1B    */ lda #_sizeof_Unit
    /* 80A1 20 BC 91 */ jsr LOC_91BC

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
    /* 80CA AC 38 05 */ ldy wUnk0538
    /* 80CD AE 39 05 */ ldx wUnk0539
    /* 80D0 88       */ dey

    /* 80D1 20 17 81 */ jsr FUNC_03_8117

    /* 80D4 E8       */ inx
    /* 80D5 20 21 81 */ jsr FUNC_03_8121

    /* 80D8 CA       */ dex
    /* 80D9 88       */ dey
    /* 80DA 30 03    */ bmi +

    /* 80DC 20 21 81 */ jsr FUNC_03_8121

+:
    /* 80DF C8       */ iny
    /* 80E0 C8       */ iny
    /* 80E1 C8       */ iny
    /* 80E2 20 17 81 */ jsr FUNC_03_8117

    /* 80E5 CA       */ dex
    /* 80E6 20 21 81 */ jsr FUNC_03_8121

    /* 80E9 E8       */ inx
    /* 80EA C8       */ iny
    /* 80EB C0 1F    */ cpy #MAP_ROW_MAX_LENGTH-1
    /* 80ED 10 03    */ bpl +

    /* 80EF 20 21 81 */ jsr FUNC_03_8121

+:
    /* 80F2 88       */ dey
    /* 80F3 88       */ dey
    /* 80F4 CA       */ dex
    /* 80F5 20 17 81 */ jsr FUNC_03_8117

    /* 80F8 88       */ dey
    /* 80F9 20 21 81 */ jsr FUNC_03_8121

    /* 80FC C8       */ iny
    /* 80FD CA       */ dex
    /* 80FE 30 03    */ bmi +

    /* 8100 20 21 81 */ jsr FUNC_03_8121

+:
    /* 8103 E8       */ inx
    /* 8104 E8       */ inx
    /* 8105 E8       */ inx
    /* 8106 20 17 81 */ jsr FUNC_03_8117

    /* 8109 C8       */ iny
    /* 810A 20 21 81 */ jsr FUNC_03_8121

    /* 810D 88       */ dey
    /* 810E E8       */ inx
    /* 810F E0 1D    */ cpx #MAP_ROW_COUNT-1
    /* 8111 10 03    */ bpl +

    /* 8113 20 21 81 */ jsr FUNC_03_8121

+:
    /* 8116 60       */ rts

FUNC_03_8117:
    /* 8117 20 39 82 */ jsr GetMapRow2In9B

    /* 811A B1 9B    */ lda (zUnk9B), Y
    /* 811C 09 20    */ ora #$20
    /* 811E 91 9B    */ sta (zUnk9B), Y
    /* 8120 60       */ rts

FUNC_03_8121:
    /* 8121 20 39 82 */ jsr GetMapRow2In9B

    /* 8124 B1 9B    */ lda (zUnk9B), Y
    /* 8126 09 40    */ ora #$40
    /* 8128 91 9B    */ sta (zUnk9B), Y
    /* 812A 60       */ rts

FUNC_03_812B:
    /* 812B 20 0D C7 */ jsr WaitFrame

    /* 812E A0 07    */ ldy #Unit.str
    /* 8130 B1 9F    */ lda (zUnk9F), Y
    /* 8132 85 B5    */ sta zUnkB5

    /* 8134 A0 13    */ ldy #Unit.item
    /* 8136 B1 9F    */ lda (zUnk9F), Y
    /* 8138 A8       */ tay
    /* 8139 88       */ dey
    /* 813A B9 C3 D9 */ lda ItemInfo.Unk_D9C3, Y
    /* 813D 29 06    */ and #6
    /* 813F 4A       */ lsr A
    /* 8140 85 AF    */ sta zUnkAF

    /* 8142 B9 57 D6 */ lda ItemInfo.might, Y
    /* 8145 18       */ clc
    /* 8146 65 B5    */ adc zUnkB5
    /* 8148 85 B5    */ sta zUnkB5

    /* 814A C9 1F    */ cmp #31
    /* 814C 30 02    */ bmi +

    /* 814E A9 1F    */ lda #31

+:
    /* 8150 85 A7    */ sta zUnkA7

    /* 8152 A0 0D    */ ldy #Unit.mov
    /* 8154 B1 9F    */ lda (zUnk9F), Y
    /* 8156 85 BF    */ sta zUnkBF

    /* 8158 AD 38 05 */ lda wUnk0538
    /* 815B 8D 00 05 */ sta wUnk0500

    /* 815E AD 39 05 */ lda wUnk0539
    /* 8161 8D 01 05 */ sta wUnk0501

    /* 8164 A9 01    */ lda #1
    /* 8166 85 B8    */ sta zUnkB8

    /* 8168 20 37 80 */ jsr FUNC_03_8037

    /* 816B 20 E4 8F */ jsr LOC_8FE4

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
    /* 8217 B0 08    */ bcs +

    /* 8219 B1 9B    */ lda (zUnk9B), Y
    /* 821B 29 E0    */ and #$E0
    /* 821D 05 A7    */ ora zUnkA7
    /* 821F 91 9B    */ sta (zUnk9B), Y

+:
    /* 8221 60       */ rts

GetMapRow3In6C:
    /* 8222 8A       */ txa
    /* 8223 48       */ pha

    /* 8224 C9 1E    */ cmp #MAP_ROW_COUNT
    /* 8226 30 02    */ bmi +

    /* 8228 A9 00    */ lda #0

+:
    /* 822A 0A       */ asl A
    /* 822B AA       */ tax

    /* 822C BD 01 ED */ lda MapRows3.w, X
    /* 822F 85 6C    */ sta zUnk6C
    /* 8231 BD 02 ED */ lda MapRows3.w+1, X
    /* 8234 85 6D    */ sta zUnk6C+1

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

GetMapRowInR04:
    /* 8250 8A       */ txa
    /* 8251 48       */ pha

    /* 8252 C9 1E    */ cmp #MAP_ROW_COUNT
    /* 8254 30 02    */ bmi +

    /* 8256 A9 00    */ lda #0

+:
    /* 8258 0A       */ asl A
    /* 8259 AA       */ tax

    /* 825A BD 3D ED */ lda MapRows.w, X
    /* 825D 85 04    */ sta zR04
    /* 825F BD 3E ED */ lda MapRows.w+1, X
    /* 8262 85 05    */ sta zR04+1

    /* 8264 68       */ pla
    /* 8265 AA       */ tax

    /* 8266 60       */ rts

GetPlayerUnitsIn9F:
    /* 8267 A9 90    */ lda #<sUnitsPlayer
    /* 8269 85 9F    */ sta zUnk9F
    /* 826B A9 6A    */ lda #>sUnitsPlayer
    /* 826D 85 A0    */ sta zUnk9F+1
    /* 826F 60       */ rts

FUNC_03_8270:
    /* 8270 AD 42 05 */ lda wUnk0542
    /* 8273 F0 03    */ beq +

    /* 8275 4C 17 83 */ jmp CODE_03_8317

+:
    /* 8278 20 34 83 */ jsr FUNC_03_8334

    /* 827B 20 D2 8F */ jsr LOC_8FD2

    /* 827E A2 00    */ ldx #0
    /* 8280 86 AD    */ stx zUnkAD

CODE_03_8282:
    /* 8282 A0 00    */ ldy #Unit.pid
    /* 8284 B1 9D    */ lda (zUnk9D), Y
    /* 8286 D0 03    */ bne +

    /* 8288 4C 2C 83 */ jmp CODE_03_832C

+:
    /* 828B A0 12    */ ldy #Unit.unk_12
    /* 828D B1 9D    */ lda (zUnk9D), Y
    /* 828F C9 FF    */ cmp #-1
    /* 8291 D0 03    */ bne +

    /* 8293 4C 1F 83 */ jmp CODE_03_831F

+:
    /* 8296 A0 10    */ ldy #Unit.y
    /* 8298 B1 9D    */ lda (zUnk9D), Y
    /* 829A 8D 39 05 */ sta wUnk0539

    /* 829D C8       */ iny ; Unit.x
    /* 829E B1 9D    */ lda (zUnk9D), Y
    /* 82A0 8D 38 05 */ sta wUnk0538

    /* 82A3 A0 17    */ ldy #Unit.uses
    /* 82A5 B1 9D    */ lda (zUnk9D), Y
    /* 82A7 85 AC    */ sta zUnkAC

    /* 82A9 8E C3 05 */ stx wUnk05C3

    /* 82AC 20 00 84 */ jsr FUNC_03_8400

    /* 82AF 20 A4 85 */ jsr LOC_85A4

    /* 82B2 A0 12    */ ldy #Unit.unk_12
    /* 82B4 B1 9D    */ lda (zUnk9D), Y
    /* 82B6 C9 FF    */ cmp #-1
    /* 82B8 F0 03    */ beq FUNC_03_82BD

    /* 82BA 4C 98 83 */ jmp FUNC_03_8398

FUNC_03_82BD:
    /* 82BD A0 12    */ ldy #Unit.unk_12
    /* 82BF B1 9D    */ lda (zUnk9D), Y
    /* 82C1 C9 FF    */ cmp #-1
    /* 82C3 F0 52    */ beq CODE_03_8317

    /* 82C5 A0 01    */ ldy #Unit.jid
    /* 82C7 B1 9D    */ lda (zUnk9D), Y
    /* 82C9 C9 09    */ cmp #JID_THIEF
    /* 82CB D0 4A    */ bne CODE_03_8317

    /* 82CD A0 06    */ ldy #Unit.terrain
    /* 82CF B1 9D    */ lda (zUnk9D), Y
    /* 82D1 48       */ pha
    /* 82D2 C9 A5    */ cmp #TERRAIN_VILLAGE_OPENED
    /* 82D4 D0 2B    */ bne @LOC_8301

    /* 82D6 A9 A9    */ lda #TERRAIN_VILLAGE_DESTROYED
    /* 82D8 91 9D    */ sta (zUnk9D), Y

    /* 82DA A0 10    */ ldy #Unit.y
    /* 82DC B1 9D    */ lda (zUnk9D), Y
    /* 82DE AA       */ tax
    /* 82DF CA       */ dex
    /* 82E0 20 50 82 */ jsr GetMapRowInR04
    /* 82E3 C8       */ iny ; Unit.x
    /* 82E4 B1 9D    */ lda (zUnk9D), Y
    /* 82E6 A8       */ tay
    /* 82E7 A9 AD    */ lda #TERRAIN_HOUSE_DESTROYED
    /* 82E9 91 04    */ sta (zR04), Y
    /* 82EB 86 04    */ stx zR04
    /* 82ED 84 05    */ sty zR05
    /* 82EF 85 0B    */ sta zR0B

    /* 82F1 A9 0D    */ lda #$0D
    /* 82F3 85 44    */ sta zFarFuncId
    /* 82F5 A9 06    */ lda #$06
    /* 82F7 20 FA C9 */ jsr CallFarFunc

    /* 82FA A9 80    */ lda #$80
    /* 82FC 8D F0 06 */ sta wUnk06F0

    /* 82FF D0 15    */ bne @LOC_8316

@LOC_8301:
    /* 8301 68       */ pla
    /* 8302 C9 AB    */ cmp #TERRAIN_CHEST_CLOSED
    /* 8304 D0 11    */ bne CODE_03_8317

    /* 8306 A9 AC    */ lda #TERRAIN_CHEST_OPENED
    /* 8308 91 9D    */ sta (zUnk9D), Y
    /* 830A A9 80    */ lda #$80
    /* 830C 8D F0 06 */ sta wUnk06F0
    /* 830F A9 01    */ lda #1
    /* 8311 8D 48 05 */ sta wUnk0548

    /* 8314 D0 01    */ bne CODE_03_8317

@LOC_8316:
    /* 8316 68       */ pla

CODE_03_8317:
    /* 8317 20 CE 8C */ jsr LOC_8CCE

    /* 831A AD 42 05 */ lda wUnk0542
    /* 831D D0 10    */ bne CODE_03_832F

CODE_03_831F:
    /* 831F A6 AD    */ ldx zUnkAD
    /* 8321 E8       */ inx
    /* 8322 86 AD    */ stx zUnkAD

    /* 8324 A9 1B    */ lda #_sizeof_Unit
    /* 8326 20 C6 91 */ jsr LOC_91C6

    /* 8329 4C 82 82 */ jmp CODE_03_8282

CODE_03_832C:
    /* 832C EE 3F 05 */ inc wUnk053F

CODE_03_832F:
    /* 832F A9 27    */ lda #$27
    /* 8331 85 84    */ sta zUnk84
    /* 8333 60       */ rts

FUNC_03_8334:
    /* 8334 20 D2 8F */ jsr LOC_8FD2

    /* 8337 A2 00    */ ldx #0
    /* 8339 86 AD    */ stx zUnkAD

    /* 833B F0 49    */ beq @continue

@lop:
    /* 833D A0 12    */ ldy #Unit.unk_12
    /* 833F B1 9D    */ lda (zUnk9D), Y
    /* 8341 C9 FF    */ cmp #-1
    /* 8343 F0 06    */ beq +

    /* 8345 A0 00    */ ldy #Unit.pid
    /* 8347 B1 9D    */ lda (zUnk9D), Y
    /* 8349 D0 3B    */ bne @continue

+:
    /* 834B 20 D0 91 */ jsr LOC_91D0

    /* 834E C9 00    */ cmp #0
    /* 8350 F0 34    */ beq @continue

    /* 8352 A0 17    */ ldy #Unit.uses
    /* 8354 B1 9D    */ lda (zUnk9D), Y
    /* 8356 29 03    */ and #$03
    /* 8358 85 A3    */ sta zUnkA3
    /* 835A B1 9D    */ lda (zUnk9D), Y
    /* 835C 29 1C    */ and #$1C
    /* 835E 0A       */ asl A
    /* 835F 0A       */ asl A
    /* 8360 05 A3    */ ora zUnkA3
    /* 8362 A0 16    */ ldy #Unit.item+3
    /* 8364 91 9D    */ sta (zUnk9D), Y

    /* 8366 A0 00    */ ldy #0

    /* 8368 A0 11    */ ldy #Unit.x
    /* 836A B1 9D    */ lda (zUnk9D), Y
    /* 836C 8D 00 05 */ sta wUnk0500
    /* 836F 88       */ dey ; Unit.y
    /* 8370 B1 9D    */ lda (zUnk9D), Y
    /* 8372 8D 01 05 */ sta wUnk0501

    /* 8375 A9 F4    */ lda #<sUnitBuf
    /* 8377 85 74    */ sta zUnitLoadDst
    /* 8379 A9 76    */ lda #>sUnitBuf
    /* 837B 85 75    */ sta zUnitLoadDst+1

    /* 837D A9 0C    */ lda #$0C
    /* 837F 85 44    */ sta zFarFuncId
    /* 8381 A9 06    */ lda #$06
    /* 8383 20 FA C9 */ jsr CallFarFunc

@continue:
    /* 8386 A6 AD    */ ldx zUnkAD
    /* 8388 E8       */ inx
    /* 8389 E0 14    */ cpx #20
    /* 838B B0 0A    */ bcs @end

    /* 838D 86 AD    */ stx zUnkAD
    /* 838F A9 1B    */ lda #_sizeof_Unit
    /* 8391 20 C6 91 */ jsr LOC_91C6

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
    /* 83B1 B1 9D    */ lda (zUnk9D), Y

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

    /* 83E0 20 50 82 */ jsr GetMapRowInR04

    /* 83E3 B1 04    */ lda (zR04), Y
    /* 83E5 A8       */ tay
    /* 83E6 B9 F8 E8 */ lda DAT_E8F8, Y

    /* 83E9 C9 0E    */ cmp #UNK_E8F8_0E
    /* 83EB F0 E6    */ beq @LOC_83D3

    /* 83ED C9 1F    */ cmp #UNK_E8F8_1F
    /* 83EF F0 E2    */ beq @LOC_83D3

    /* 83F1 20 4A 91 */ jsr LOC_914A

    /* 83F4 90 DD    */ bcc @LOC_83D3

    /* 83F6 20 44 91 */ jsr LOC_9144

    /* 83F9 90 D8    */ bcc @LOC_83D3

@LOC_83FB:
    /* 83FB A9 28    */ lda #$28
    /* 83FD 85 84    */ sta zUnk84

    /* 83FF 60       */ rts

FUNC_03_8400:
    /* 8400 A0 16    */ ldy #Unit.item+3
    /* 8402 B1 9D    */ lda (zUnk9D), Y

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
    /* 8435 B1 9D    */ lda (zUnk9D), Y
    /* 8437 85 B0    */ sta zUnkB0
    /* 8439 88       */ dey ; Unit.hp_cur
    /* 843A B1 9D    */ lda (zUnk9D), Y
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
    /* 844C B1 9D    */ lda (zUnk9D), Y

    /* 844E C9 13    */ cmp #JID_PRIEST
    /* 8450 D0 03    */ bne @LOC_8455

@LOC_8452:
    /* 8452 4C 23 85 */ jmp @CODE_03_8523

@LOC_8455:
    /* 8455 A5 AC    */ lda zUnkAC
    /* 8457 29 80    */ and #$80
    /* 8459 F0 18    */ beq @LOC_8473

    /* 845B A0 18    */ ldy #Unit.uses+1
    /* 845D B1 9D    */ lda (zUnk9D), Y

    /* 845F CD 75 76 */ cmp sUnk7675
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

    /* 8486 20 67 82 */ jsr GetPlayerUnitsIn9F

    /* 8489 A2 00    */ ldx #0

@CODE_03_848B:
    /* 848B A0 00    */ ldy #Unit.pid
    /* 848D B1 9F    */ lda (zUnk9F), Y
    /* 848F D0 03    */ bne @CODE_03_8494

    /* 8491 4C 09 85 */ jmp @CODE_03_8509

@CODE_03_8494:
    /* 8494 A0 12    */ ldy #Unit.unk_12
    /* 8496 B1 9F    */ lda (zUnk9F), Y
    /* 8498 C9 FF    */ cmp #-1
    /* 849A F0 10    */ beq @CODE_03_84AC

    /* 849C A0 01    */ ldy #Unit.jid
    /* 849E B1 9F    */ lda (zUnk9F), Y

    /* 84A0 C9 13    */ cmp #JID_PRIEST
    /* 84A2 F0 11    */ beq @CODE_03_84B5

    /* 84A4 C9 10    */ cmp #JID_COMMANDO
    /* 84A6 F0 0D    */ beq @CODE_03_84B5

    /* 84A8 C9 09    */ cmp #JID_THIEF
    /* 84AA F0 09    */ beq @CODE_03_84B5

@CODE_03_84AC:
    /* 84AC E8       */ inx

    /* 84AD A9 1B    */ lda #_sizeof_Unit
    /* 84AF 20 BC 91 */ jsr LOC_91BC

    /* 84B2 4C 8B 84 */ jmp @CODE_03_848B

@CODE_03_84B5:
    /* 84B5 4C 23 85 */ jmp @CODE_03_8523

@CODE_03_84B8:
    /* 84B8 C9 04    */ cmp #$04
    /* 84BA D0 28    */ bne @CODE_03_84E4

    /* 84BC 20 DB 8F */ jsr LOC_8FDB

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
    /* 84E4 20 DB 8F */ jsr LOC_8FDB

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
    /* 8521 91 9D    */ sta (zUnk9D), Y

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
    /* 854A B1 9D    */ lda (zUnk9D), Y

    /* 854C C9 9C    */ cmp #PID_9C
    /* 854E F0 53    */ beq @CODE_03_85A3

@CODE_03_8550:
    /* 8550 A0 19    */ ldy #Unit.uses+2
    /* 8552 B1 9D    */ lda (zUnk9D), Y

    /* 8554 CD 39 05 */ cmp wUnk0539
    /* 8557 D0 4A    */ bne @CODE_03_85A3

    /* 8559 C8       */ iny ; Unit.uses+3
    /* 855A B1 9D    */ lda (zUnk9D), Y

    /* 855C CD 38 05 */ cmp wUnk0538
    /* 855F D0 42    */ bne @CODE_03_85A3

    /* 8561 AE 39 05 */ ldx wUnk0539
    /* 8564 20 50 82 */ jsr GetMapRowInR04

    /* 8567 A0 06    */ ldy #Unit.terrain
    /* 8569 B1 9D    */ lda (zUnk9D), Y

    /* 856B AC 38 05 */ ldy wUnk0538
    /* 856E 91 04    */ sta (zR04), Y

    /* 8570 85 0B    */ sta zR0B
    /* 8572 84 05    */ sty zR05
    /* 8574 86 04    */ stx zR04

    /* 8576 A9 0D    */ lda #$0D
    /* 8578 85 44    */ sta zFarFuncId
    /* 857A A9 06    */ lda #$06
    /* 857C 20 FA C9 */ jsr CallFarFunc

    /* 857F AE 39 05 */ ldx wUnk0539
    /* 8582 20 50 82 */ jsr GetMapRowInR04

    /* 8585 A0 06    */ ldy #Unit.terrain
    /* 8587 B1 9D    */ lda (zUnk9D), Y
    /* 8589 AC 38 05 */ ldy wUnk0538
    /* 858C 85 0B    */ sta zR0B
    /* 858E 84 05    */ sty zR05
    /* 8590 86 04    */ stx zR04

    /* 8592 A9 07    */ lda #$07
    /* 8594 85 44    */ sta zFarFuncId
    /* 8596 A9 06    */ lda #$06
    /* 8598 20 FA C9 */ jsr CallFarFunc

    /* 859B A9 FF    */ lda #-1
    /* 859D A0 12    */ ldy #Unit.unk_12
    /* 859F 91 9D    */ sta (zUnk9D), Y

    /* 85A1 A9 00    */ lda #0

@CODE_03_85A3:
    /* 85A3 60       */ rts
