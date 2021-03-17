
    .include "include/global.inc"
    .include "include/variables.inc"

    .include "include/struct/unit.inc"

    .include "include/constant/iids.inc"

    .proc FUNC_01_B8CB

    /* B8CB AD 8B 04 */ lda wUnk048B
    /* B8CE 8D 7B 76 */ sta sUnk767B

    /* B8D1 AD 29 03 */ lda wFightLevelAfter

    /* B8D4 C9 14    */ cmp #20 ; TODO: max level constant
    /* B8D6 D0 05    */ bne not_max_level

    /* B8D8 A9 00    */ lda #0
    /* B8DA 8D 2B 03 */ sta wFightExpAfter

not_max_level:
    /* B8DD AD 76 04 */ lda wUnk0476
    /* B8E0 D0 74    */ bne finish

    /* B8E2 A9 F4    */ lda #<sUnitBuf
    /* B8E4 85 00    */ sta zR00
    /* B8E6 A9 76    */ lda #>sUnitBuf
    /* B8E8 85 01    */ sta zR00+1

    /* B8EA AD ED 76 */ lda sUnk76ED
    /* B8ED F0 08    */ beq :+

    ; enemy unit

    /* B8EF A9 15    */ lda #<sUnk7715
    /* B8F1 85 00    */ sta zR00
    /* B8F3 A9 77    */ lda #>sUnk7715
    /* B8F5 85 01    */ sta zR00+1

:
    /* B8F7 A2 00    */ ldx #0
    /* B8F9 A0 04    */ ldy #Unit::hp_max

lop:
    /* B8FB BD 2A 03 */ lda wFightMaxHpAfter, X
    /* B8FE 91 00    */ sta (zR00), Y
    /* B900 E8       */ inx
    /* B901 C8       */ iny

    ; skip unit cell field
    ; that is no stat

    /* B902 C0 06    */ cpy #Unit::cell
    /* B904 D0 01    */ bne :+

    /* B906 C8       */ iny

:
    /* B907 C0 0D    */ cpy #Unit::mov
    /* B909 90 F0    */ bcc lop

    /* B90B AD 29 03 */ lda wFightLevelAfter
    /* B90E A0 02    */ ldy #Unit::level
    /* B910 91 00    */ sta (zR00), Y

    /* B912 AD 34 03 */ lda wFightCurrentHp
    /* B915 A0 03    */ ldy #Unit::hp_cur
    /* B917 91 00    */ sta (zR00), Y

    /* B919 A0 0F    */ ldy #Unit::res
    /* B91B B1 00    */ lda (zR00), Y
    /* B91D 29 80    */ and #$80 ; TODO: what does this mean?
    /* B91F 0D 26 03 */ ora wFightResistance
    /* B922 91 00    */ sta (zR00), Y

    /* B924 AD 24 03 */ lda wFight0324
    /* B927 A0 17    */ ldy #Unit::uses
    /* B929 91 00    */ sta (zR00), Y

    /* B92B AE ED 76 */ ldx sUnk76ED
    /* B92E F0 08    */ beq :+

    ; enemy unit

    /* B930 AD 35 03 */ lda wFightCurrentHp+1
    /* B933 8D F7 76 */ sta sUnitBuf+Unit::hp_cur

    /* B936 10 1E    */ bpl finish

:
    /* B938 AD 35 03 */ lda wFightCurrentHp+1
    /* B93B 8D 18 77 */ sta sUnk7715+Unit::hp_cur

    /* B93E AD 20 03 */ lda wFightIid
    /* B941 C9 35    */ cmp #IID_FIRST_EFFECT
    /* B943 90 11    */ bcc finish ; blo

    ; is effect item

    /* B945 AD 25 03 */ lda wFight0325
    /* B948 8D 2C 77 */ sta sUnk7715+Unit::uses

    /* B94B AD 24 77 */ lda sUnk7715+Unit::res
    /* B94E 29 80    */ and #$80 ; TODO: what does this mean?
    /* B950 0D 27 03 */ ora wFightResistance+1
    /* B953 8D 24 77 */ sta sUnk7715+Unit::res

finish:
    /* B956 A9 00    */ lda #0
    /* B958 8D ED 05 */ sta wUnk05ED
    /* B95B 85 5D    */ sta zUnk5D

    /* B95D A9 01    */ lda #1
    /* B95F 8D F0 06 */ sta wUnk06F0

    /* B962 60       */ rts

    .endproc ; FUNC_01_B8CB

    .proc FUNC_01_B963

    /* B963 AD 57 04 */ lda wUnk0457
    /* B966 0A       */ asl A
    /* B967 AA       */ tax

    /* B968 BD D7 B9 */ lda DATA_B9D7, X
    /* B96B 85 08    */ sta zR08
    /* B96D BD D8 B9 */ lda DATA_B9D7+1, X
    /* B970 85 09    */ sta zR08+1

    /* B972 AD 58 04 */ lda wUnk0458
    /* B975 A8       */ tay
    /* B976 B1 08    */ lda (zR08), Y
    /* B978 8D 75 03 */ sta wUnk0375

    /* B97B C9 88    */ cmp #$88
    /* B97D F0 33    */ beq ret_true

    /* B97F C9 87    */ cmp #$87
    /* B981 D0 07    */ bne CODE_B98A

    /* B983 A9 00    */ lda #0
    /* B985 8D 58 04 */ sta wUnk0458

    /* B988 F0 D9    */ beq FUNC_01_B963

CODE_B98A:
    /* B98A 20 B4 B9 */ jsr FUNC_01_B9B4

    /* B98D 20 C5 B9 */ jsr FUNC_01_B9C5

    /* B990 AE 59 04 */ ldx wUnk0459
    /* B993 18       */ clc
    /* B994 7D 3E 04 */ adc wUnk043E, X
    /* B997 9D 3E 04 */ sta wUnk043E, X

    /* B99A AD 75 03 */ lda wUnk0375
    /* B99D 20 A0 C3 */ jsr Asl4

    /* B9A0 20 B4 B9 */ jsr FUNC_01_B9B4

    /* B9A3 AE 59 04 */ ldx wUnk0459
    /* B9A6 18       */ clc
    /* B9A7 7D 44 04 */ adc wUnk0444, X
    /* B9AA 9D 44 04 */ sta wUnk0444, X

    /* B9AD EE 58 04 */ inc wUnk0458

ret_false:
    /* B9B0 18       */ clc
    /* B9B1 60       */ rts

ret_true:
    /* B9B2 38       */ sec

end:
    /* B9B3 60       */ rts

    .proc FUNC_01_B9B4

    /* B9B4 0A       */ asl A
    /* B9B5 B0 07    */ bcs CODE_B9BE

    /* B9B7 4A       */ lsr A
    /* B9B8 20 9A C3 */ jsr Lsr4

    /* B9BB 4C B3 B9 */ jmp end

CODE_B9BE:
    /* B9BE 4A       */ lsr A
    /* B9BF 20 9A C3 */ jsr Lsr4

    /* B9C2 09 F8    */ ora #%11111000

    /* B9C4 60       */ rts

    .endproc ; FUNC_01_B9B4

    .proc FUNC_01_B9C5

    /* B9C5 48       */ pha

    /* B9C6 AD C2 03 */ lda wUnk03C2
    /* B9C9 4A       */ lsr A
    /* B9CA 90 09    */ bcc unchanged

    /* B9CC 68       */ pla

    /* B9CD 49 FF    */ eor #$FF ; not
    /* B9CF AA       */ tax
    /* B9D0 E8       */ inx
    /* B9D1 8A       */ txa

    /* B9D2 4C D6 B9 */ jmp end

unchanged:
    /* B9D5 68       */ pla

end:
    /* B9D6 60       */ rts

    .endproc ; FUNC_01_B9C5

DATA_B9D7:
    .word @DATA_B9F3
    .word @DATA_BA32
    .word $BA12
    .word $BA51
    .word $BA89
    .word $BAE4
    .word $BB55
    .word $BB45
    .word $BB88
    .word $BC1A
    .word $BC6B
    .word $BCA8
    .word $BCE5
    .word @DATA_BD1B

@DATA_B9F3:
    /* B9F3 ...      */ .byte $A1, $A2, $A1, $A2, $A1
    /* B9F8 ...      */ .byte $A2, $A1, $A2, $A1, $A1, $A1, $A1, $A1
    /* BA00 ...      */ .byte $A0, $A1, $A0, $A1, $A0, $A1, $A0, $91
    /* BA08 ...      */ .byte $90, $90, $91, $90, $90, $91, $90, $90
    /* BA10 ...      */ .byte $91, $88, $00, $00, $00, $00, $00, $00
    /* BA18 ...      */ .byte $00, $00, $00, $00, $00, $00, $00, $00
    /* BA20 ...      */ .byte $00, $00, $00, $00, $00, $00, $00, $00
    /* BA28 ...      */ .byte $00, $00, $00, $00, $00, $00, $00, $00
    /* BA30 ...      */ .byte $00, $00

@DATA_BA32:
    /* BA32 ...      */ .byte $A0, $A0, $A0, $A0, $A0, $A0
    /* BA38 ...      */ .byte $A0, $A0, $A0, $A0, $90, $90, $90, $90
    /* BA40 ...      */ .byte $90, $90, $90, $90, $90, $90
    /* BA46 ...      */ .byte $90, $90, $90, $90, $90, $90, $90, $90
    /* BA4E ...      */ .byte $90, $90, $88, $BE, $BE, $BE, $BF, $BE
    /* BA56 ...      */ .byte $BF, $BF, $BF, $BF, $B0, $BF, $BF, $B0
    /* BA5E ...      */ .byte $B0, $B0, $B0, $B0, $B0, $B0, $B1, $B0
    /* BA66 ...      */ .byte $B1, $B1, $B1, $B1, $B2, $B1, $B3, $B1
    /* BA6E ...      */ .byte $B2, $B2, $B2, $B2, $B1, $B1, $B1, $B1
    /* BA76 ...      */ .byte $B1, $B1, $B0, $B1, $B0, $B0, $B0, $B0
    /* BA7E ...      */ .byte $B0, $BF, $B0, $BF, $BF, $BF, $BF, $BE
    /* BA86 ...      */ .byte $BE, $BE, $87, $00, $00, $00, $00, $00
    /* BA8E ...      */ .byte $00, $A3, $AA, $A3, $AA, $AA, $A5, $00
    /* BA96 ...      */ .byte $00, $00, $00, $00, $00, $66, $66, $B4
    /* BA9E ...      */ .byte $B4, $BE, $B4, $C4, $4B, $CB, $4E, $CB
    /* BAA6 ...      */ .byte $4B, $B4, $B6, $BF, $B6, $4E, $4B, $CB
    /* BAAE ...      */ .byte $4D, $CB, $46, $AA, $AA, $00, $00, $00
    /* BAB6 ...      */ .byte $00, $00, $00, $66, $66, $B6, $B4, $B6
    /* BABE ...      */ .byte $B4, $4E, $4B, $C6, $44, $C4, $4B, $B4
    /* BAC6 ...      */ .byte $B6, $BE, $B4, $44, $4B, $CB, $4E, $CB
    /* BACE ...      */ .byte $46, $AA, $AA, $00, $00, $00, $00, $00
    /* BAD6 ...      */ .byte $00, $6D, $6E, $B4, $B6, $B4, $B6, $42
    /* BADE ...      */ .byte $4B, $CB, $46, $CB, $46, $87, $DC, $DC
    /* BAE6 ...      */ .byte $EE, $DE, $DE, $EF, $DE, $EE, $EE, $DF
    /* BAEE ...      */ .byte $EF, $DF, $EF, $E0, $EF, $EF, $FE, $EF
    /* BAF6 ...      */ .byte $FF, $EF, $FF, $E0, $FF, $EF, $FF, $F0
    /* BAFE ...      */ .byte $FF, $F0, $FF, $F0, $F0, $EF, $F0, $F0
    /* BB06 ...      */ .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    /* BB0E ...      */ .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    /* BB16 ...      */ .byte $F0, $F0, $F0, $F0, $F0, $F0, $F1, $F0
    /* BB1E ...      */ .byte $F0, $F1, $F1, $F0, $F1, $F0, $E0, $F1
    /* BB26 ...      */ .byte $F0, $E1, $F0, $E2, $F0, $E2, $E0, $F2
    /* BB2E ...      */ .byte $E2, $F2, $E2, $F2, $E2, $F2, $E2, $F3
    /* BB36 ...      */ .byte $E2, $F3, $E2, $F3, $E2, $F3, $E3, $E3
    /* BB3E ...      */ .byte $E3, $E3, $E3, $E3, $E3, $E3, $88, $00
    /* BB46 ...      */ .byte $00, $00, $00, $00, $00, $00, $00, $00
    /* BB4E ...      */ .byte $00, $00, $00, $00, $00, $00, $00, $C0
    /* BB56 ...      */ .byte $C0, $C0, $C0, $C0, $C0, $C0, $B0, $C0
    /* BB5E ...      */ .byte $B0, $B0, $C0, $B0, $B0, $B0, $B0, $B0
    /* BB66 ...      */ .byte $B0, $A0, $B0, $A0, $B0, $A0, $B0, $A0
    /* BB6E ...      */ .byte $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0
    /* BB76 ...      */ .byte $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0
    /* BB7E ...      */ .byte $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0
    /* BB86 ...      */ .byte $A0, $88, $00, $00, $00, $00, $00, $00
    /* BB8E ...      */ .byte $00, $00, $00, $00, $00, $00, $00, $00
    /* BB96 ...      */ .byte $00, $00, $00, $00, $00, $00, $F1, $F1
    /* BB9E ...      */ .byte $F1, $F1, $01, $01, $11, $11, $10, $10
    /* BBA6 ...      */ .byte $11, $11, $10, $11, $01, $11, $01, $01
    /* BBAE ...      */ .byte $01, $F1, $01, $F1, $F1, $F0, $F1, $F1
    /* BBB6 ...      */ .byte $F1, $F1, $F1, $01, $01, $11, $11, $10
    /* BBBE ...      */ .byte $10, $11, $11, $10, $11, $01, $11, $01
    /* BBC6 ...      */ .byte $01, $01, $F1, $01, $F1, $F1, $F0, $F1
    /* BBCE ...      */ .byte $F1, $F1, $F1, $F1, $01, $01, $11, $11
    /* BBD6 ...      */ .byte $10, $10, $11, $11, $10, $11, $01, $11
    /* BBDE ...      */ .byte $01, $01, $01, $F1, $01, $F1, $F1, $F0
    /* BBE6 ...      */ .byte $F1, $F1, $F1, $F1, $F1, $01, $01, $11
    /* BBEE ...      */ .byte $11, $10, $10, $11, $11, $10, $11, $01
    /* BBF6 ...      */ .byte $11, $01, $01, $01, $F1, $01, $F1, $F1
    /* BBFE ...      */ .byte $F0, $F1, $F1, $F1, $F1, $F1, $01, $01
    /* BC06 ...      */ .byte $11, $11, $10, $10, $11, $11, $10, $11
    /* BC0E ...      */ .byte $01, $11, $01, $01, $01, $F1, $01, $F1
    /* BC16 ...      */ .byte $F1, $F0, $F1, $88, $10, $10, $10, $10
    /* BC1E ...      */ .byte $10, $10, $10, $10, $10, $10, $10, $10
    /* BC26 ...      */ .byte $10, $1F, $10, $10, $1F, $10, $1F, $10
    /* BC2E ...      */ .byte $1F, $10, $1F, $1F, $10, $1F, $1F, $1F
    /* BC36 ...      */ .byte $1F, $1F, $1E, $1F, $1F, $1F, $1F, $1E
    /* BC3E ...      */ .byte $1F, $1E, $1F, $1E, $1E, $1E, $1E, $1E
    /* BC46 ...      */ .byte $0E, $1C, $0E, $0E, $0E, $0E, $FF, $FE
    /* BC4E ...      */ .byte $0F, $0F, $FF, $FF, $FF, $F0, $FF, $FF
    /* BC56 ...      */ .byte $F0, $F0, $F0, $F0, $F1, $F0, $F1, $F1
    /* BC5E ...      */ .byte $01, $01, $01, $11, $11, $11, $11, $10
    /* BC66 ...      */ .byte $11, $10, $10, $10, $88, $01, $11, $11
    /* BC6E ...      */ .byte $11, $11, $11, $10, $11, $10, $11, $10
    /* BC76 ...      */ .byte $11, $10, $10, $10, $10, $10, $10, $10
    /* BC7E ...      */ .byte $10, $10, $10, $10, $10, $10, $10, $10
    /* BC86 ...      */ .byte $10, $1F, $10, $10, $1F, $10, $10, $1F
    /* BC8E ...      */ .byte $1F, $1F, $1F, $10, $1F, $1E, $1F, $1F
    /* BC96 ...      */ .byte $1E, $1E, $1C, $0E, $FE, $FE, $FF, $FF
    /* BC9E ...      */ .byte $F0, $F1, $01, $01, $11, $11, $11, $10
    /* BCA6 ...      */ .byte $10, $88, $12, $12, $12, $12, $11, $11
    /* BCAE ...      */ .byte $12, $11, $11, $11, $11, $11, $11, $10
    /* BCB6 ...      */ .byte $11, $11, $10, $11, $10, $11, $10, $10
    /* BCBE ...      */ .byte $10, $10, $10, $10, $11, $10, $1F, $10
    /* BCC6 ...      */ .byte $10, $1F, $1F, $1F, $1F, $1F, $1F, $0F
    /* BCCE ...      */ .byte $0F, $0F, $FF, $FF, $F0, $F0, $F0, $F1
    /* BCD6 ...      */ .byte $F1, $F1, $01, $01, $11, $11, $11, $11
    /* BCDE ...      */ .byte $10, $10
    /* BCE0 ...      */ .byte $10, $1F, $10, $1F, $88, $02, $02, $02
    /* BCE8 ...      */ .byte $01, $01, $F1, $01, $01, $01, $F1, $F1
    /* BCF0 ...      */ .byte $F1, $F1, $F1, $F1, $F1, $F0, $F0, $F0
    /* BCF8 ...      */ .byte $F1, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    /* BD00 ...      */ .byte $F1, $F1, $01, $01, $12, $10, $10, $11
    /* BD08 ...      */ .byte $10, $10, $10, $1F, $10, $10, $1F, $1F
    /* BD10 ...      */ .byte $FF, $F0, $F0, $F0, $F0, $F0, $F0, $10
    /* BD18 ...      */ .byte $F0, $F1, $88

@DATA_BD1B:
    /* BD1B ...      */ .byte $10, $10, $1F, $10, $1F
    /* BD20 ...      */ .byte $10, $1F, $10, $1F, $10, $1F, $1F, $10
    /* BD28 ...      */ .byte $1F, $1F, $1F, $1E, $1F, $1E, $1E, $0F
    /* BD30 ...      */ .byte $1E, $0E, $0E, $FE, $0F, $FE, $FE, $FF
    /* BD38 ...      */ .byte $FF, $FF, $F0, $FF, $F0, $FF, $F0, $F0
    /* BD40 ...      */ .byte $F0, $F0, $F0, $F0, $F1, $F0, $F1, $F0
    /* BD48 ...      */ .byte $F1, $F0, $F0, $F0, $F0, $F0, $F0, $F0
    /* BD50 ...      */ .byte $F0, $F0, $F0, $F0, $F0, $F0, $F0, $FF
    /* BD58 ...      */ .byte $F0, $FF, $F0, $FF, $F0, $FF, $F0, $88

    .endproc ; FUNC_01_B963
