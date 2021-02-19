
    .proc FindUnitByPid

    ; Input: zR00 = unit array to look through, A = pid
    ; Output: zR00 = address of unit, C cleared if found

    /* F09E 85 02    */ sta zR02
    /* F0A0 4C A8 F0 */ jmp begin

lop:
    /* F0A3 A9 1B    */ lda #.sizeof(Unit)
    /* F0A5 20 79 C3 */ jsr IncR00ByA

begin:
    /* F0A8 A0 00    */ ldy #Unit::pid
    /* F0AA B1 00    */ lda (zR00), Y

    /* F0AC C9 00    */ cmp #0
    /* F0AE F0 15    */ beq end

    /* F0B0 A0 12    */ ldy #Unit::unk_12
    /* F0B2 B1 00    */ lda (zR00), Y

    /* F0B4 C9 FF    */ cmp #$FF
    /* F0B6 F0 EB    */ beq lop

    /* F0B8 C9 F0    */ cmp #$F0
    /* F0BA F0 E7    */ beq lop

    /* F0BC A0 00    */ ldy #Unit::pid
    /* F0BE B1 00    */ lda (zR00), Y

    /* F0C0 C5 02    */ cmp zR02
    /* F0C2 D0 DF    */ bne lop

    /* F0C4 18       */ clc

end:
    /* F0C5 60       */ rts

    .endproc ; FindUnitByPid

    .proc FindPlayerUnitAt

    ; Input:
    ; - zR02 = y position
    ; - zR03 = x position
    ; Output:
    ; - zR00 = address of unit
    ; - C = cleared if found

    /* F0C6 98       */ tya
    /* F0C7 48       */ pha
    /* F0C8 8A       */ txa
    /* F0C9 48       */ pha

    /* F0CA 20 11 F1 */ jsr GetPlayerUnitsInR00

    /* F0CD A2 36    */ ldx #$36
    /* F0CF D0 09    */ bne BeginUnitSearchAt

    .endproc ; FindPlayerUnitAt

    .proc FindEnemyUnitAt

    ; Input:
    ; - zR02 = y position
    ; - zR03 = x position
    ; Output:
    ; - zR00 = address of unit
    ; - C = cleared if found

    /* F0D1 98       */ tya
    /* F0D2 48       */ pha
    /* F0D3 8A       */ txa
    /* F0D4 48       */ pha

    /* F0D5 20 1A F1 */ jsr GetEnemyUnitsInR00

    /* F0D8 A2 14    */ ldx #$14
    ; bne BeginUnitSearchAt ; fallthrough

    .endproc ; FindEnemyUnitAt

    .proc BeginUnitSearchAt

    /* F0DA 4C E7 F0 */ jmp begin

lop:
    /* F0DD CA       */ dex

    /* F0DE E0 00    */ cpx #0
    /* F0E0 F0 2A    */ beq end

    /* F0E2 A9 1B    */ lda #.sizeof(Unit)
    /* F0E4 20 79 C3 */ jsr IncR00ByA

begin:
    /* F0E7 A0 00    */ ldy #Unit::pid
    /* F0E9 B1 00    */ lda (zR00), Y

    /* F0EB C9 00    */ cmp #0
    /* F0ED F0 1D    */ beq end

    /* F0EF A0 12    */ ldy #Unit::unk_12
    /* F0F1 B1 00    */ lda (zR00), Y

    /* F0F3 C9 FF    */ cmp #$FF
    /* F0F5 F0 E6    */ beq lop

    /* F0F7 C9 F0    */ cmp #$F0
    /* F0F9 F0 E2    */ beq lop

    /* F0FB A0 10    */ ldy #Unit::y_pos
    /* F0FD B1 00    */ lda (zR00), Y

    /* F0FF C5 02    */ cmp zR02
    /* F101 D0 DA    */ bne lop

    /* F103 A0 11    */ ldy #Unit::x_pos
    /* F105 B1 00    */ lda (zR00), Y

    /* F107 C5 03    */ cmp zR03
    /* F109 D0 D2    */ bne lop

    /* F10B 18       */ clc

end:
    /* F10C 68       */ pla
    /* F10D AA       */ tax
    /* F10E 68       */ pla
    /* F10F A8       */ tay

    /* F110 60       */ rts

    .endproc ; BeginUnitSearchAt

    .proc GetPlayerUnitsInR00

    /* F111 A9 90    */ lda #<sBlueUnits
    /* F113 85 00    */ sta zR00
    /* F115 A9 6A    */ lda #>sBlueUnits
    /* F117 85 01    */ sta zR00+1

    /* F119 60       */ rts

    .endproc ; GetPlayerUnitsInR00

    .proc GetEnemyUnitsInR00

    /* F11A A9 78    */ lda #<sRedUnits
    /* F11C 85 00    */ sta zR00
    /* F11E A9 70    */ lda #>sRedUnits
    /* F120 85 01    */ sta zR00+1

    /* F122 60       */ rts

    .endproc ; GetEnemyUnitsInR00

    .proc FUNC_F123

lop:
    /* F123 A9 1B    */ lda #.sizeof(Unit)
    /* F125 18       */ clc
    /* F126 65 74    */ adc zUnitLoadDst
    /* F128 85 74    */ sta zUnitLoadDst
    /* F12A 90 02    */ bcc :+

    /* F12C E6 75    */ inc zUnitLoadDst+1

:
    /* F12E A0 00    */ ldy #Unit::pid
    /* F130 B1 74    */ lda (zUnitLoadDst), Y

    /* F132 C9 00    */ cmp #0
    /* F134 F0 0F    */ beq end

    /* F136 A0 12    */ ldy #Unit::unk_12
    /* F138 B1 74    */ lda (zUnitLoadDst), Y
    /* F13A F0 E7    */ beq lop

    /* F13C C9 FF    */ cmp #$FF
    /* F13E F0 E3    */ beq lop

    /* F140 C9 F0    */ cmp #$F0
    /* F142 F0 DF    */ beq lop

    /* F144 18       */ clc

end:
    /* F145 60       */ rts

    .endproc ; FUNC_F123

    .proc FUNC_F146

lop:
    /* F146 A9 1B    */ lda #.sizeof(Unit)
    /* F148 18       */ clc
    /* F149 65 72    */ adc zUnitPtr72
    /* F14B 85 72    */ sta zUnitPtr72
    /* F14D 90 02    */ bcc :+

    /* F14F E6 73    */ inc zUnitPtr72+1

:
    /* F151 A0 00    */ ldy #Unit::pid
    /* F153 B1 72    */ lda (zUnitPtr72), Y

    /* F155 C9 00    */ cmp #0
    /* F157 F0 0D    */ beq end

    /* F159 A0 12    */ ldy #Unit::unk_12
    /* F15B B1 72    */ lda (zUnitPtr72), Y

    /* F15D C9 FF    */ cmp #$FF
    /* F15F F0 04    */ beq ret

    /* F161 C9 F0    */ cmp #$F0
    /* F163 D0 E1    */ bne lop

ret:
    /* F165 18       */ clc

end:
    /* F166 60       */ rts

    .endproc ; FUNC_F146

    .proc FUNC_F167

    /* F167 85 08    */ sta zR08

    /* F169 A2 00    */ ldx #0

    /* F16B F0 0A    */ beq begin

lop:
    /* F16D E8       */ inx
    /* F16E E0 36    */ cpx #$36
    /* F170 B0 0E    */ bcs end

    /* F172 A9 1B    */ lda #.sizeof(Unit)
    /* F174 20 79 C3 */ jsr IncR00ByA

begin:
    /* F177 A0 00    */ ldy #Unit::pid
    /* F179 B1 00    */ lda (zR00), Y

    /* F17B C5 08    */ cmp zR08
    /* F17D D0 EE    */ bne lop

    /* F17F 18       */ clc

end:
    /* F180 60       */ rts

    .endproc ; FUNC_F167

    .proc FUNC_F181

    /* F181 A9 04    */ lda #$04
    /* F183 8D F1 06 */ sta wUnk06F1
    /* F186 60       */ rts

    .endproc ; FUNC_F181

    .proc FUNC_F187

    /* F187 A9 01    */ lda #$01
    /* F189 8D F1 06 */ sta wUnk06F1
    /* F18C 60       */ rts

    .endproc ; FUNC_F187

    .proc FUNC_F18D

    /* F18D A9 08    */ lda #$08
    /* F18F 8D F1 06 */ sta wUnk06F1
    /* F192 60       */ rts

    .endproc ; FUNC_F18D

    .proc FUNC_F193

    /* F193 A9 10    */ lda #$10
    /* F195 8D F8 06 */ sta wUnk06F8
    /* F198 60       */ rts

    .endproc ; FUNC_F193

    .proc FUNC_F199

    /* F199 A9 02    */ lda #$02
    /* F19B 8D F1 06 */ sta wUnk06F1
    /* F19E 60       */ rts

    .endproc ; FUNC_F199

    .proc FUNC_F19F

    /* F19F AE 7A 76 */ ldx sUnk767A
    /* F1A2 D0 12    */ bne end

    /* F1A4 48       */ pha

    /* F1A5 29 0F    */ and #$0F
    /* F1A7 AA       */ tax
    /* F1A8 68       */ pla
    /* F1A9 29 F0    */ and #$F0
    /* F1AB 4A       */ lsr A
    /* F1AC 4A       */ lsr A
    /* F1AD 4A       */ lsr A
    /* F1AE 4A       */ lsr A
    /* F1AF A8       */ tay
    /* F1B0 BD B7 F1 */ lda DAT_F1B7, X
    /* F1B3 99 F0 06 */ sta wUnk06F0, Y

end:
    /* F1B6 60       */ rts

DAT_F1B7:
    /* F1B7 ...      */ .byte $01, $02, $04, $08, $10, $20, $40, $80

    .endproc ; FUNC_F19F
