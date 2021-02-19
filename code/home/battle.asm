
    .include "include/variables.inc"
    .include "include/global.inc"

    .include "include/struct/unit.inc"

    .include "include/constant/pids.inc"
    .include "include/constant/jids.inc"
    .include "include/constant/iids.inc"
    .include "include/constant/maps.inc"

    .proc FUNC_CAAA

    /* CAAA AD 01 03 */ lda wUnk0301
    /* CAAD F0 01    */ beq do_fight

    /* CAAF 60       */ rts

do_fight:
    /* CAB0 20 21 D3 */ jsr FUNC_D321

    /* CAB3 20 EF CF */ jsr FUNC_CFEF

    /* CAB6 20 37 D1 */ jsr FUNC_D137

    /* CAB9 20 AD CB */ jsr ComputeFightStats

    /* CABC 20 2F CF */ jsr FUNC_CF2F

    /* CABF A9 00    */ lda #0
    /* CAC1 8D 48 03 */ sta wFightFollowUp

    /* CAC4 AD 03 03 */ lda wUnk0303
    /* CAC7 D0 7C    */ bne end

    /* CAC9 AD 02 03 */ lda wUnk0302
    /* CACC D0 17    */ bne LOC_CAE5

    /* CACE 20 45 CF */ jsr FUNC_CF45

    /* CAD1 AD 34 03 */ lda wFightCurrentHp
    /* CAD4 F0 5B    */ beq attacker_dies

    /* CAD6 AD 35 03 */ lda wFightCurrentHp+1
    /* CAD9 F0 59    */ beq defender_dies

    /* CADB 20 4C CF */ jsr FUNC_CF4C

    /* CADE AD 34 03 */ lda wFightCurrentHp
    /* CAE1 F0 4E    */ beq attacker_dies

    /* CAE3 D0 1F    */ bne LOC_CB04

LOC_CAE5:
    /* CAE5 20 4C CF */ jsr FUNC_CF4C

    /* CAE8 AD 34 03 */ lda wFightCurrentHp
    /* CAEB D0 0A    */ bne LOC_CAF7

    /* CAED A9 00    */ lda #0
    /* CAEF 8D 55 03 */ sta wUnk0355
    /* CAF2 8D 56 03 */ sta wUnk0355+1

    /* CAF5 F0 3A    */ beq attacker_dies

LOC_CAF7:
    /* CAF7 20 45 CF */ jsr FUNC_CF45

    /* CAFA AD 34 03 */ lda wFightCurrentHp
    /* CAFD F0 32    */ beq attacker_dies

    /* CAFF AD 35 03 */ lda wFightCurrentHp+1
    /* CB02 F0 30    */ beq defender_dies

LOC_CB04:
    /* CB04 AD 38 03 */ lda wFightAttackSpeed
    /* CB07 CD 39 03 */ cmp wFightAttackSpeed+1
    /* CB0A F0 2E    */ beq nobody_dies

    /* CB0C B0 0F    */ bcs attacker_followsup ; bhs

defender_followsup:
    /* CB0E A9 02    */ lda #2
    /* CB10 8D 48 03 */ sta wFightFollowUp

    /* CB13 20 4C CF */ jsr FUNC_CF4C

    /* CB16 AD 34 03 */ lda wFightCurrentHp
    /* CB19 F0 16    */ beq attacker_dies

    /* CB1B D0 1D    */ bne nobody_dies

attacker_followsup:
    /* CB1D AD 58 03 */ lda wUnk0358
    /* CB20 D0 18    */ bne nobody_dies

    /* CB22 A9 01    */ lda #1
    /* CB24 8D 48 03 */ sta wFightFollowUp

    /* CB27 20 45 CF */ jsr FUNC_CF45

    /* CB2A AD 35 03 */ lda wFightCurrentHp+1
    /* CB2D F0 05    */ beq defender_dies

    /* CB2F D0 09    */ bne nobody_dies

attacker_dies:
    /* CB31 4C 3D CB */ jmp end_fight

defender_dies:
    /* CB34 20 85 D0 */ jsr FightCheckForLevelGain

    /* CB37 4C 3D CB */ jmp end_fight

nobody_dies:
    /* CB3A 20 73 CB */ jsr FUNC_CB73

end_fight:
    /* CB3D 20 46 CB */ jsr FUNC_CB46

    /* CB40 A9 01    */ lda #1
    /* CB42 8D 01 03 */ sta wUnk0301

end:
    /* CB45 60       */ rts

    .endproc ; FUNC_CAAA

    .proc FUNC_CB46

    /* CB46 AD 48 03 */ lda wFightFollowUp
    /* CB49 F0 0E    */ beq LOC_CB59

    /* CB4B AA       */ tax ; X = 1 or 2
    /* CB4C CA       */ dex ; X = 0 or 1 = follow-up battler
    /* CB4D 8A       */ txa ; A = follow-up battler
    /* CB4E 49 01    */ eor #1
    /* CB50 AA       */ tax

    /* CB51 BD 36 03 */ lda wFight0336, X
    /* CB54 D0 03    */ bne LOC_CB59

    /* CB56 9D 34 03 */ sta wFightCurrentHp, X

LOC_CB59:
    /* CB59 AD 06 03 */ lda wFightJid

    /* CB5C C9 13    */ cmp #JID_PRIEST
    /* CB5E D0 12    */ bne LOC_CB72

    /* CB60 AD 02 03 */ lda wUnk0302
    /* CB63 F0 0D    */ beq LOC_CB72

    /* CB65 AD 34 03 */ lda wFightCurrentHp
    /* CB68 F0 08    */ beq LOC_CB72

    /* CB6A A9 00    */ lda #0
    /* CB6C 8D 28 03 */ sta wUnk0328

    /* CB6F 20 85 D0 */ jsr FightCheckForLevelGain

LOC_CB72:
    /* CB72 60       */ rts

    .endproc ; FUNC_CB46

    .proc FUNC_CB73

    /* CB73 AD DF 05 */ lda wUnk05DF
    /* CB76 D0 34    */ bne end

    /* CB78 AD 03 03 */ lda wUnk0303
    /* CB7B D0 2F    */ bne end

    /* CB7D AD 44 03 */ lda wFightHitsFirst

    /* CB80 AE 48 03 */ ldx wFightFollowUp
    /* CB83 E0 01    */ cpx #1
    /* CB85 D0 04    */ bne LOC_CB8B

    /* CB87 18       */ clc
    /* CB88 6D 46 03 */ adc wFightHitsSecond

LOC_CB8B:
    /* CB8B 8D 79 04 */ sta wUnk0479
    /* CB8E F0 1C    */ beq end

    /* CB90 AD 0B 03 */ lda wFightStartHp+1
    /* CB93 38       */ sec
    /* CB94 ED 35 03 */ sbc wFightCurrentHp+1
    /* CB97 D0 07    */ bne LOC_CBA0

    /* CB99 A9 00    */ lda #0
    /* CB9B 8D 79 04 */ sta wUnk0479

    /* CB9E F0 0C    */ beq end

LOC_CBA0:
    /* CBA0 C9 14    */ cmp #20
    /* CBA2 90 02    */ bcc LOC_CBA6

    /* CBA4 A9 14    */ lda #20

LOC_CBA6:
    /* CBA6 8D 0F 03 */ sta wFightExpGained
    /* CBA9 20 85 D0 */ jsr FightCheckForLevelGain

end:
    /* CBAC 60       */ rts

    .endproc ; FUNC_CB73

    .proc ComputeFightStats

    /* CBAD 20 CF CB */ jsr FUNC_CBCF
    /* CBB0 20 4D CC */ jsr ComputeFightSpeed
    /* CBB3 20 2F CD */ jsr ComputeFightDodge
    /* CBB6 20 E5 CB */ jsr ComputeFightHit
    /* CBB9 20 F0 CC */ jsr ComputeFightDefense
    /* CBBC 20 64 CC */ jsr ComputeFightDamage
    /* CBBF 20 16 CD */ jsr ComputeFightCrit
    /* CBC2 20 3B CD */ jsr RollFightHits
    /* CBC5 20 D4 CD */ jsr RollFightCrits
    /* CBC8 20 12 CE */ jsr RollFightDevilEffect
    /* CBCB 20 62 CE */ jsr FUNC_CE62

    /* CBCE 60       */ rts

    .endproc ; ComputeFightStats

    .proc FUNC_CBCF

    /* CBCF AD 83 04 */ lda wUnk0483
    /* CBD2 F0 10    */ beq end

    /* CBD4 AD 20 03 */ lda wFightIid

    /* CBD7 C9 08    */ cmp #IID_LEVINSWORD
    /* CBD9 F0 04    */ beq yes

    /* CBDB C9 0E    */ cmp #IID_JAVELIN
    /* CBDD D0 05    */ bne end

yes:
    /* CBDF A9 00    */ lda #0
    /* CBE1 8D 83 04 */ sta wUnk0483

end:
    /* CBE4 60       */ rts

    .endproc ; FUNC_CBCF

    .proc ComputeFightHit

    /* CBE5 A0 01    */ ldy #1

lop_battler:
    ; A = battler skill
    /* CBE7 B9 14 03 */ lda wFightSkill, Y

    ; X = battler equipped iid
    /* CBEA BE 20 03 */ ldx wFightIid, Y

    /* CBED E0 08    */ cpx #IID_LEVINSWORD
    /* CBEF F0 48    */ beq magic_hit

    /* CBF1 E0 2A    */ cpx #IID_FIRST_MAGIC
    /* CBF3 B0 44    */ bcs magic_hit ; bhs

    /* CBF5 7D 6B D7 */ adc ItemHitTable, X
    /* CBF8 8D 60 03 */ sta wFightTmpB

    /* CBFB B9 20 03 */ lda wFightIid, Y

    /* CBFE C9 2A    */ cmp #IID_FIRST_MAGIC
    /* CC00 B0 13    */ bcs magic_avo ; bhs

    /* CC02 20 70 CE */ jsr SwapBattlerIdY

    /* CC05 B9 10 03 */ lda wUnk0310, Y
    /* CC08 18       */ clc
    /* CC09 79 38 03 */ adc wFightAttackSpeed, Y
    /* CC0C 8D 5F 03 */ sta wFightTmpA

    /* CC0F 20 70 CE */ jsr SwapBattlerIdY

    /* CC12 4C 21 CC */ jmp do_difference

magic_avo:
    /* CC15 20 70 CE */ jsr SwapBattlerIdY

    /* CC18 AD 1A 03 */ lda wFightLuck
    /* CC1B 8D 5F 03 */ sta wFightTmpA

    /* CC1E 20 70 CE */ jsr SwapBattlerIdY

do_difference:
    /* CC21 AD 60 03 */ lda wFightTmpB
    /* CC24 38       */ sec
    /* CC25 ED 5F 03 */ sbc wFightTmpA

    /* CC28 10 02    */ bpl :+

    /* CC2A A9 00    */ lda #0

:
    /* CC2C C9 64    */ cmp #100
    /* CC2E 90 02    */ bcc :+

    /* CC30 A9 64    */ lda #100

:
set_battle_hit:
    /* CC32 99 3A 03 */ sta wFightAttackHit, Y

    /* CC35 88       */ dey
    /* CC36 10 AF    */ bpl lop_battler

    /* CC38 60       */ rts

magic_hit:
    /* CC39 20 70 CE */ jsr SwapBattlerIdY

    /* CC3C BD 6B D7 */ lda ItemHitTable, X
    /* CC3F 38       */ sec
    /* CC40 F9 42 03 */ sbc wFightAttackDodge, Y

    /* CC43 10 02    */ bpl :+

    /* CC45 A9 00    */ lda #0

:
    /* CC47 20 70 CE */ jsr SwapBattlerIdY

    /* CC4A 4C 32 CC */ jmp set_battle_hit

    .endproc ; ComputeFightHit

    .proc ComputeFightSpeed

    /* CC4D A0 01    */ ldy #1

lop_battler:
    /* CC4F B9 18 03 */ lda wFightSpeed, Y

    /* CC52 BE 20 03 */ ldx wFightIid, Y
    /* CC55 38       */ sec
    /* CC56 FD 0F D7 */ sbc ItemWeightTable, X
    /* CC59 10 02    */ bpl :+

    /* CC5B A9 00    */ lda #0

:
    /* CC5D 99 38 03 */ sta wFightAttackSpeed, Y

    /* CC60 88       */ dey
    /* CC61 10 EC    */ bpl lop_battler

    /* CC63 60       */ rts

    .endproc ; ComputeFightSpeed

    .proc ComputeFightDamage

    /* CC64 A0 01    */ ldy #1

lop_battler:
    /* CC66 B9 12 03 */ lda wFightStrength, Y

    /* CC69 BE 20 03 */ ldx wFightIid, Y

    /* CC6C E0 08    */ cpx #IID_LEVINSWORD
    /* CC6E F0 4F    */ beq magic

    /* CC70 E0 2A    */ cpx #IID_FIRST_MAGIC
    /* CC72 B0 4B    */ bcs magic ; bhs

    /* CC74 7D 57 D6 */ adc ItemMightTable, X
    /* CC77 85 08    */ sta zR08

    /* CC79 BD 57 D6 */ lda ItemMightTable, X
    /* CC7C 99 49 03 */ sta wFightMight, Y

    /* CC7F BD DB D8 */ lda ItemEffectivenessTable, X
    /* CC82 F0 1D    */ beq not_effective

    /* CC84 20 EE D2 */ jsr IsEffective

    /* CC87 90 18    */ bcc not_effective

    /* CC89 A5 08    */ lda zR08
    /* CC8B 18       */ clc
    /* CC8C 7D 57 D6 */ adc ItemMightTable, X
    /* CC8F 7D 57 D6 */ adc ItemMightTable, X
    /* CC92 85 08    */ sta zR08
    /* CC94 B9 49 03 */ lda wFightMight, Y
    /* CC97 18       */ clc
    /* CC98 7D 57 D6 */ adc ItemMightTable, X
    /* CC9B 7D 57 D6 */ adc ItemMightTable, X
    /* CC9E 99 49 03 */ sta wFightMight, Y

not_effective:
    /* CCA1 A5 08    */ lda zR08
    /* CCA3 8D 60 03 */ sta wFightTmpB

    /* CCA6 20 70 CE */ jsr SwapBattlerIdY

    /* CCA9 B9 3E 03 */ lda wFightAttackDefense, Y
    /* CCAC 8D 5F 03 */ sta wFightTmpA

    /* CCAF 20 70 CE */ jsr SwapBattlerIdY

    /* CCB2 AD 60 03 */ lda wFightTmpB
    /* CCB5 38       */ sec
    /* CCB6 ED 5F 03 */ sbc wFightTmpA

    /* CCB9 10 18    */ bpl do_hi_cap

    /* CCBB A9 00    */ lda #0
    /* CCBD F0 14    */ beq do_hi_cap

magic:
    /* CCBF BD 57 D6 */ lda ItemMightTable, X
    /* CCC2 99 49 03 */ sta wFightMight, Y
    /* CCC5 20 70 CE */ jsr SwapBattlerIdY

    /* CCC8 38       */ sec
    /* CCC9 F9 26 03 */ sbc wFightResistance, Y
    /* CCCC 10 02    */ bpl :+

    /* CCCE A9 00    */ lda #0

:
    /* CCD0 20 70 CE */ jsr SwapBattlerIdY

do_hi_cap:
    /* CCD3 48       */ pha
    /* CCD4 AD 20 03 */ lda wFightIid
    /* CCD7 C9 0A    */ cmp #IID_FALCHION
    /* CCD9 D0 04    */ bne cap_at_40

    /* CCDB 68       */ pla
    /* CCDC 4C E6 CC */ jmp set_battle_damage

cap_at_40:
    /* CCDF 68       */ pla
    /* CCE0 C9 28    */ cmp #40
    /* CCE2 90 02    */ bcc set_battle_damage

    /* CCE4 A9 28    */ lda #40

set_battle_damage:
    /* CCE6 99 3C 03 */ sta wFightAttackDamage, Y

    /* CCE9 88       */ dey
    /* CCEA 30 03    */ bmi :+

    /* CCEC 4C 66 CC */ jmp lop_battler

:
    /* CCEF 60       */ rts

    .endproc ; ComputeFightDamage

    .proc ComputeFightDefense

    /* CCF0 A0 01    */ ldy #1

lop_battler:
    /* CCF2 20 70 CE */ jsr SwapBattlerIdY

    /* CCF5 B9 20 03 */ lda wFightIid, Y

    /* CCF8 C9 08    */ cmp #IID_LEVINSWORD
    /* CCFA F0 0D    */ beq magic

    /* CCFC C9 2A    */ cmp #IID_FIRST_MAGIC
    /* CCFE B0 09    */ bcs magic ; bhs

    /* CD00 20 70 CE */ jsr SwapBattlerIdY

    /* CD03 B9 1C 03 */ lda wFightDefense, Y
    /* CD06 4C 0F CD */ jmp continue

magic:
    /* CD09 20 70 CE */ jsr SwapBattlerIdY

    /* CD0C B9 26 03 */ lda wFightResistance, Y

continue:
    /* CD0F 99 3E 03 */ sta wFightAttackDefense, Y
    /* CD12 88       */ dey
    /* CD13 10 DD    */ bpl lop_battler

    /* CD15 60       */ rts

    .endproc ; ComputeFightDefense

    .proc ComputeFightCrit

    /* CD16 A0 01    */ ldy #1

lop_battler:
    /* CD18 B9 14 03 */ lda wFightSkill, Y
    /* CD1B 18       */ clc
    /* CD1C 79 1A 03 */ adc wFightLuck, Y
    /* CD1F 4A       */ lsr A

    /* CD20 BE 20 03 */ ldx wFightIid, Y

    /* CD23 18       */ clc
    /* CD24 7D C7 D7 */ adc ItemCritTable, X
    /* CD27 4A       */ lsr A

    /* CD28 99 40 03 */ sta wFightAttackCrit, Y

    /* CD2B 88       */ dey
    /* CD2C 10 EA    */ bpl lop_battler

    /* CD2E 60       */ rts

    .endproc ; ComputeFightCrit

    .proc ComputeFightDodge

    /* CD2F A0 01    */ ldy #1

lop:
    /* CD31 B9 1A 03 */ lda wFightLuck, Y
    /* CD34 99 42 03 */ sta wFightAttackDodge, Y

    /* CD37 88       */ dey
    /* CD38 10 F7    */ bpl lop

    /* CD3A 60       */ rts

    .endproc ; ComputeFightDodge

    .proc RollFightHits

    /* CD3B A0 01    */ ldy #1

lop_battler:
    /* CD3D A9 00    */ lda #0
    /* CD3F 99 44 03 */ sta wFightHitsFirst, Y
    /* CD42 99 46 03 */ sta wFightHitsSecond, Y

    /* CD45 20 70 CE */ jsr SwapBattlerIdY

    /* CD48 B9 1E 03 */ lda wFight031E, Y
    /* CD4B F0 10    */ beq LOC_CD5D

    /* CD4D 20 70 CE */ jsr SwapBattlerIdY

    /* CD50 BE 20 03 */ ldx wFightIid, Y
    /* CD53 BD C3 D9 */ lda ItemUnkTable_D9C3, X
    /* CD56 20 9B C3 */ jsr Lsr3

    /* CD59 B0 15    */ bcs LOC_CD70

    /* CD5B 90 45    */ bcc continue

LOC_CD5D:
    /* CD5D 20 70 CE */ jsr SwapBattlerIdY

    /* CD60 BE 20 03 */ ldx wFightIid, Y
    /* CD63 BD C3 D9 */ lda ItemUnkTable_D9C3, X
    /* CD66 BE 1E 03 */ ldx wFight031E, Y
    /* CD69 F0 01    */ beq LOC_CD6C

    /* CD6B 4A       */ lsr A

LOC_CD6C:
    /* CD6C 4A       */ lsr A
    /* CD6D 4A       */ lsr A
    /* CD6E 90 32    */ bcc continue

LOC_CD70:
    /* CD70 B9 3A 03 */ lda wFightAttackHit, Y
    /* CD73 F0 14    */ beq LOC_CD89

    /* CD75 20 A9 CD */ jsr FUNC_CDA9

    /* CD78 B0 0F    */ bcs LOC_CD89

    /* CD7A 20 7E CE */ jsr Rand100

    /* CD7D D9 3A 03 */ cmp wFightAttackHit, Y
    /* CD80 F0 02    */ beq LOC_CD84

    /* CD82 B0 05    */ bcs LOC_CD89

LOC_CD84:
    /* CD84 A9 01    */ lda #1
    /* CD86 99 44 03 */ sta wFightHitsFirst, Y

LOC_CD89:
    /* CD89 B9 3A 03 */ lda wFightAttackHit, Y
    /* CD8C F0 14    */ beq continue

    /* CD8E 20 A9 CD */ jsr FUNC_CDA9

    /* CD91 B0 0F    */ bcs continue

    /* CD93 20 7E CE */ jsr Rand100

    /* CD96 D9 3A 03 */ cmp wFightAttackHit, Y
    /* CD99 F0 02    */ beq LOC_CD9D

    /* CD9B B0 05    */ bcs continue

LOC_CD9D:
    /* CD9D A9 01    */ lda #1
    /* CD9F 99 46 03 */ sta wFightHitsSecond, Y

continue:
    /* CDA2 88       */ dey
    /* CDA3 30 03    */ bmi end

    /* CDA5 4C 3D CD */ jmp lop_battler

end:
    /* CDA8 60       */ rts

    .endproc ; RollFightHits

    .proc FUNC_CDA9

    /* CDA9 86 10    */ stx zUnk10
    /* CDAB 84 12    */ sty zUnk12
    /* CDAD 48       */ pha

    /* CDAE AD 74 76 */ lda sMapNum
    /* CDB1 C9 07    */ cmp #MAP_07
    /* CDB3 D0 0D    */ bne not_map_07

    /* CDB5 AD 05 03 */ lda wUnk0305
    /* CDB8 A2 03    */ ldx #(DAT_CDD0_end - DAT_CDD0)-1

lop:
    /* CDBA DD D0 CD */ cmp DAT_CDD0, X
    /* CDBD F0 0A    */ beq LOC_CDC9

    /* CDBF CA       */ dex
    /* CDC0 10 F8    */ bpl lop

not_map_07:
    /* CDC2 68       */ pla
    /* CDC3 A6 10    */ ldx zUnk10
    /* CDC5 A4 12    */ ldy zUnk12
    /* CDC7 18       */ clc
    /* CDC8 60       */ rts

LOC_CDC9:
    /* CDC9 68       */ pla
    /* CDCA A6 10    */ ldx zUnk10
    /* CDCC A4 12    */ ldy zUnk12
    /* CDCE 38       */ sec
    /* CDCF 60       */ rts

    ; .sizeof doesn't seem to work with forward referenced labels
    ; so as a work around we define a label immediately after
    ; and get the "size" of the label by doing end - start.

DAT_CDD0:
    .byte $A5, $B0, $B1, $B2
DAT_CDD0_end:

    .endproc ; FUNC_CDA9

    .proc RollFightCrits

    /* CDD4 A0 01    */ ldy #1

lop_battler:
    /* CDD6 A9 00    */ lda #0
    /* CDD8 99 4B 03 */ sta wFightCritsFirst, Y
    /* CDDB 99 4D 03 */ sta wFightCritsSecond, Y

    /* CDDE B9 40 03 */ lda wFightAttackCrit, Y
    /* CDE1 F0 1E    */ beq continue

    /* CDE3 20 7E CE */ jsr Rand100

    /* CDE6 D9 40 03 */ cmp wFightAttackCrit, Y
    /* CDE9 F0 02    */ beq LOC_CDED

    /* CDEB B0 05    */ bcs LOC_CDF2

LOC_CDED:
    /* CDED A9 01    */ lda #1
    /* CDEF 99 4B 03 */ sta wFightCritsFirst, Y

LOC_CDF2:
    /* CDF2 20 7E CE */ jsr Rand100

    /* CDF5 D9 40 03 */ cmp wFightAttackCrit, Y
    /* CDF8 F0 02    */ beq LOC_CDFC

    /* CDFA B0 05    */ bcs continue

LOC_CDFC:
    /* CDFC A9 01    */ lda #1
    /* CDFE 99 4D 03 */ sta wFightCritsSecond, Y

continue:
    /* CE01 88       */ dey
    /* CE02 10 D2    */ bpl lop_battler

    /* CE04 AD 83 04 */ lda wUnk0483
    /* CE07 F0 08    */ beq end

    /* CE09 A9 01    */ lda #1
    /* CE0B 8D 4B 03 */ sta wFightCritsFirst
    /* CE0E 8D 4D 03 */ sta wFightCritsSecond

end:
    /* CE11 60       */ rts

    .endproc ; RollFightCrits

    .proc RollFightDevilEffect

    /* CE12 A9 00    */ lda #0
    /* CE14 8D 55 03 */ sta wUnk0355

    /* CE17 AD 4F 03 */ lda wUnk034F
    /* CE1A D0 45    */ bne end

    /* CE1C AD 1E 03 */ lda wFight031E
    /* CE1F 0D 1F 03 */ ora wFight031E+1
    /* CE22 D0 3D    */ bne end

    /* CE24 AD 20 03 */ lda wFightIid

    /* CE27 C9 09    */ cmp #IID_DEVILSWORD
    /* CE29 F0 04    */ beq devil_weapon

    /* CE2B C9 1D    */ cmp #IID_DEVILAXE
    /* CE2D D0 32    */ bne end

devil_weapon:
    /* CE2F AD 44 03 */ lda wFightHitsFirst
    /* CE32 F0 2D    */ beq end

    /* CE34 A9 15    */ lda #21
    /* CE36 38       */ sec
    /* CE37 ED 1A 03 */ sbc wFightLuck

    /* CE3A 48       */ pha

    /* CE3B 20 7E CE */ jsr Rand100
    /* CE3E 85 00    */ sta zR00

    /* CE40 68       */ pla

    /* CE41 C5 00    */ cmp zR00
    /* CE43 90 1C    */ bcc end

    /* CE45 A9 01    */ lda #1
    /* CE47 8D 55 03 */ sta wUnk0355
    /* CE4A AD 12 03 */ lda wFightStrength
    /* CE4D 18       */ clc
    /* CE4E 6D 49 03 */ adc wFightMight
    /* CE51 38       */ sec
    /* CE52 ED 1C 03 */ sbc wFightDefense
    /* CE55 F0 02    */ beq LOC_CE59

    /* CE57 10 05    */ bpl LOC_CE5E

LOC_CE59:
    /* CE59 A9 00    */ lda #0
    /* CE5B 8D 55 03 */ sta wUnk0355

LOC_CE5E:
    /* CE5E 8D 56 03 */ sta wUnk0356

end:
    /* CE61 60       */ rts

    .endproc ; RollFightDevilEffect

    .proc FUNC_CE62

    /* CE62 AD 03 03 */ lda wUnk0303
    /* CE65 F0 08    */ beq end

    /* CE67 A9 00    */ lda #0
    /* CE69 8D 44 03 */ sta wFightHitsFirst
    /* CE6C 8D 46 03 */ sta wFightHitsSecond

end:
    /* CE6F 60       */ rts

    .endproc ; FUNC_CE62

    .proc SwapBattlerIdY

    /* CE70 48       */ pha
    /* CE71 98       */ tya
    /* CE72 49 01    */ eor #1
    /* CE74 A8       */ tay
    /* CE75 68       */ pla
    /* CE76 60       */ rts

    .endproc ; SwapBattlerIdY

    .proc SwapBattlerIdX

    /* CE77 48       */ pha
    /* CE78 8A       */ txa
    /* CE79 49 01    */ eor #1
    /* CE7B AA       */ tax
    /* CE7C 68       */ pla
    /* CE7D 60       */ rts

    .endproc ; SwapBattlerIdX

    .proc Rand100

    /* CE7E 20 4E C0 */ jsr Rand
    /* CE81 85 00    */ sta zR00

    /* CE83 A9 0A    */ lda #10
    /* CE85 85 01    */ sta zR01

    /* CE87 20 C9 C6 */ jsr Mul

    /* CE8A A5 01    */ lda zR00+1
    /* CE8C 85 49    */ sta zDivLeft+1
    /* CE8E A5 00    */ lda zR00
    /* CE90 85 48    */ sta zDivLeft

    /* CE92 A9 19    */ lda #25
    /* CE94 85 4A    */ sta zDivRight

    /* CE96 20 EB C6 */ jsr Div

    /* CE99 A5 48    */ lda zDivLeft

    ; A = (Rand * 10) / 25

    /* CE9B C9 64    */ cmp #100
    /* CE9D 90 02    */ bcc :+

    /* CE9F A9 64    */ lda #100

:
    /* CEA1 60       */ rts

    .endproc ; Rand100

    .proc FUNC_CEA2

    /* CEA2 A9 19    */ lda #25
    /* CEA4 85 4A    */ sta zDivRight

    /* CEA6 8C 72 03 */ sty wUnk0372
    /* CEA9 8E 71 03 */ stx wUnk0371

    /* CEAC 20 4E C0 */ jsr Rand

    /* CEAF 85 48    */ sta zDivLeft
    /* CEB1 A9 00    */ lda #0
    /* CEB3 85 49    */ sta zDivLeft+1

    /* CEB5 20 EB C6 */ jsr Div

    /* CEB8 A5 48    */ lda zDivLeft

    /* CEBA AC 72 03 */ ldy wUnk0372
    /* CEBD AE 71 03 */ ldx wUnk0371

    /* CEC0 60       */ rts

    .endproc ; FUNC_CEA2

    .proc FUNC_CEC1

    /* CEC1 AD 4F 03 */ lda wUnk034F
    /* CEC4 D0 4A    */ bne end

    /* CEC6 AD 82 04 */ lda wUnk0482
    /* CEC9 D0 45    */ bne end

    /* CECB AD 24 03 */ lda wFight0324
    /* CECE 30 40    */ bmi end

    /* CED0 AD 48 03 */ lda wFightFollowUp
    /* CED3 D0 07    */ bne LOC_CEDC

    /* CED5 AD 44 03 */ lda wFightHitsFirst
    /* CED8 F0 36    */ beq end

    /* CEDA D0 05    */ bne LOC_CEE1

LOC_CEDC:
    /* CEDC AD 46 03 */ lda wFightHitsSecond
    /* CEDF F0 2F    */ beq end

LOC_CEE1:
    /* CEE1 AD 1F 03 */ lda wFight031E+1
    /* CEE4 F0 0D    */ beq LOC_CEF3

    /* CEE6 AE 20 03 */ ldx wFightIid

    /* CEE9 BD C3 D9 */ lda ItemUnkTable_D9C3, X
    /* CEEC 20 9B C3 */ jsr Lsr3

    /* CEEF B0 12    */ bcs LOC_CF03

    /* CEF1 90 1D    */ bcc end

LOC_CEF3:
    /* CEF3 AE 20 03 */ ldx wFightIid

    /* CEF6 BD C3 D9 */ lda ItemUnkTable_D9C3, X

    /* CEF9 AE 1E 03 */ ldx wFight031E
    /* CEFC F0 01    */ beq LOC_CEFF

    /* CEFE 4A       */ lsr A

LOC_CEFF:
    /* CEFF 4A       */ lsr A
    /* CF00 4A       */ lsr A
    /* CF01 90 0D    */ bcc end

LOC_CF03:
    /* CF03 CE 24 03 */ dec wFight0324
    /* CF06 D0 08    */ bne end

    /* CF08 A9 01    */ lda #1
    /* CF0A 8D 58 03 */ sta wUnk0358
    /* CF0D 8D 7E 04 */ sta wUnk047E

end:
    /* CF10 60       */ rts

    .endproc ; FUNC_CEC1

    .proc FUNC_CF11

    /* CF11 AD DF 05 */ lda wUnk05DF

    /* CF14 C9 02    */ cmp #2
    /* CF16 90 16    */ bcc end

spr0_hit_await:
    /* CF18 AD 02 20 */ lda PPUSTATUS
    /* CF1B 29 40    */ and #$40 ; sprite 0 hit flag
    /* CF1D D0 F9    */ bne spr0_hit_await

spr0_hit_await_end:
    /* CF1F AD 02 20 */ lda PPUSTATUS
    /* CF22 29 40    */ and #$40 ; sprite 0 hit flag
    /* CF24 F0 F9    */ beq spr0_hit_await_end

    /* CF26 A9 00    */ lda #0
    /* CF28 8D 00 D0 */ sta MMC4CHRHI1
    /* CF2B 8D 00 E0 */ sta MMC4CHRHI2

end:
    /* CF2E 60       */ rts

    .endproc ; FUNC_CF11

    .proc FUNC_CF2F

    /* CF2F AD DF 05 */ lda wUnk05DF
    /* CF32 F0 10    */ beq end

    /* CF34 A9 0E    */ lda #$0E
    /* CF36 8D 22 03 */ sta wFight0322
    /* CF39 8D 23 03 */ sta wFight0322+1
    /* CF3C A9 00    */ lda #0
    /* CF3E 8D 10 03 */ sta wUnk0310
    /* CF41 8D 11 03 */ sta wUnk0310+1

end:
    /* CF44 60       */ rts

    .endproc ; FUNC_CF2F

    .scope CODE_CF45

entry_CF45:
    /* CF45 20 C1 CE */ jsr FUNC_CEC1

    /* CF48 A0 00    */ ldy #0
    /* CF4A F0 02    */ beq :+

entry_CF4C:
    /* CF4C A0 01    */ ldy #1

:
    /* CF4E B9 4F 03 */ lda wUnk034F, Y
    /* CF51 D0 5E    */ bne end

    /* CF53 AD 48 03 */ lda wFightFollowUp
    /* CF56 D0 13    */ bne LOC_CF6B

    /* CF58 C0 00    */ cpy #0
    /* CF5A D0 08    */ bne LOC_CF64

    /* CF5C AD 55 03 */ lda wUnk0355
    /* CF5F F0 03    */ beq LOC_CF64

    /* CF61 20 B2 CF */ jsr FUNC_CFB2

LOC_CF64:
    /* CF64 B9 44 03 */ lda wFightHitsFirst, Y
    /* CF67 F0 37    */ beq LOC_CFA0

    /* CF69 D0 05    */ bne LOC_CF70

LOC_CF6B:
    /* CF6B B9 46 03 */ lda wFightHitsSecond, Y
    /* CF6E F0 30    */ beq LOC_CFA0

LOC_CF70:
    /* CF70 20 C6 CF */ jsr FUNC_CFC6

    /* CF73 20 70 CE */ jsr SwapBattlerIdY

    /* CF76 AD 67 03 */ lda wUnk0367
    /* CF79 AE 48 03 */ ldx wFightFollowUp
    /* CF7C D0 03    */ bne LOC_CF81

    /* CF7E 99 51 03 */ sta wUnk0351, Y

LOC_CF81:
    /* CF81 99 53 03 */ sta wUnk0353, Y
    /* CF84 B9 34 03 */ lda wFightCurrentHp, Y
    /* CF87 38       */ sec
    /* CF88 ED 67 03 */ sbc wUnk0367
    /* CF8B 10 02    */ bpl LOC_CF8F

    /* CF8D A9 00    */ lda #0

LOC_CF8F:
    /* CF8F AE 48 03 */ ldx wFightFollowUp

    /* CF92 D0 03    */ bne LOC_CF97

    /* CF94 99 36 03 */ sta wFight0336, Y

LOC_CF97:
    /* CF97 99 34 03 */ sta wFightCurrentHp, Y

    /* CF9A 20 70 CE */ jsr SwapBattlerIdY

    /* CF9D 4C B1 CF */ jmp end

LOC_CFA0:
    /* CFA0 20 70 CE */ jsr SwapBattlerIdY

    /* CFA3 AD 48 03 */ lda wFightFollowUp
    /* CFA6 D0 06    */ bne LOC_CFAE

    /* CFA8 B9 34 03 */ lda wFightCurrentHp, Y
    /* CFAB 99 36 03 */ sta wFight0336, Y

LOC_CFAE:
    /* CFAE 20 70 CE */ jsr SwapBattlerIdY

end:
    /* CFB1 60       */ rts

    .endscope ; CODE_CF45

    FUNC_CF45 := CODE_CF45::entry_CF45
    FUNC_CF4C := CODE_CF45::entry_CF4C

    .proc FUNC_CFB2

    /* CFB2 AD 34 03 */ lda wFightCurrentHp
    /* CFB5 38       */ sec
    /* CFB6 ED 56 03 */ sbc wUnk0356
    /* CFB9 10 02    */ bpl LOC_CFBD

    /* CFBB A9 00    */ lda #0

LOC_CFBD:
    /* CFBD 8D 57 03 */ sta wUnk0357
    /* CFC0 8D 34 03 */ sta wFightCurrentHp

    /* CFC3 68       */ pla
    /* CFC4 68       */ pla

    /* CFC5 60       */ rts

    .endproc ; FUNC_CFB2

    .proc FUNC_CFC6

    /* CFC6 B9 3C 03 */ lda wFightAttackDamage, Y
    /* CFC9 8D 67 03 */ sta wUnk0367

    /* CFCC AD 48 03 */ lda wFightFollowUp
    /* CFCF F0 07    */ beq LOC_CFD8

    /* CFD1 B9 4D 03 */ lda wFightCritsSecond, Y
    /* CFD4 F0 18    */ beq end

    /* CFD6 D0 05    */ bne LOC_CFDD

LOC_CFD8:
    /* CFD8 B9 4B 03 */ lda wFightCritsFirst, Y
    /* CFDB F0 11    */ beq end

LOC_CFDD:
    /* CFDD AD 67 03 */ lda wUnk0367
    /* CFE0 0A       */ asl A
    /* CFE1 18       */ clc
    /* CFE2 6D 67 03 */ adc wUnk0367

    /* CFE5 C9 78    */ cmp #120
    /* CFE7 90 02    */ bcc :+

    /* CFE9 A9 78    */ lda #120

:
    /* CFEB 8D 67 03 */ sta wUnk0367

end:
    /* CFEE 60       */ rts

    .endproc ; FUNC_CFC6

    .proc FUNC_CFEF

    /* CFEF A2 06    */ ldx #6

lop:
    /* CFF1 20 4E D0 */ jsr GetBattlerStatPointers

    /* CFF4 A0 00    */ ldy #0
    /* CFF6 B1 04    */ lda (zR04), Y
    /* CFF8 91 08    */ sta (zR08), Y
    /* CFFA CA       */ dex
    /* CFFB 10 F4    */ bpl lop

    /* CFFD AD 0A 03 */ lda wFightStartHp
    /* D000 8D 34 03 */ sta wFightCurrentHp
    /* D003 8D 36 03 */ sta wFight0336

    /* D006 AD 0B 03 */ lda wFightStartHp+1
    /* D009 8D 35 03 */ sta wFightCurrentHp+1
    /* D00C 8D 37 03 */ sta wFight0336+1

    /* D00F AD 08 03 */ lda wFightLevel
    /* D012 8D 29 03 */ sta wFightLevelAfter

    /* D015 AD 0E 03 */ lda wFightExp
    /* D018 8D 2B 03 */ sta wFightExpAfter

    /* D01B AD 0F 03 */ lda wFightExpGained

    /* D01E C9 64    */ cmp #100
    /* D020 90 05    */ bcc :+

    /* D022 A9 64    */ lda #100
    /* D024 8D 0F 03 */ sta wFightExpGained

:
    /* D027 A9 00    */ lda #0
    /* D029 8D 4F 03 */ sta wUnk034F
    /* D02C 8D 50 03 */ sta wUnk0350
    /* D02F 8D 58 03 */ sta wUnk0358
    /* D032 8D 77 04 */ sta wUnk0477
    /* D035 8D 8A 04 */ sta wUnk048A

    /* D038 AD DF 05 */ lda wUnk05DF
    /* D03B F0 10    */ beq end

    /* D03D A9 00    */ lda #0
    /* D03F 8D 10 03 */ sta wUnk0310
    /* D042 8D 11 03 */ sta wUnk0310+1
    /* D045 A9 0E    */ lda #$0E
    /* D047 8D 22 03 */ sta wFight0322
    /* D04A 8D 23 03 */ sta wFight0322+1

end:
    /* D04D 60       */ rts

    .endproc ; FUNC_CFEF

    .proc GetBattlerStatPointers

    /* D04E 8A       */ txa
    /* D04F 48       */ pha

    /* D050 0A       */ asl A
    /* D051 AA       */ tax

    /* D052 BD 69 D0 */ lda battler_stat_before_addr_lut, X
    /* D055 85 04    */ sta zR04
    /* D057 BD 6A D0 */ lda battler_stat_before_addr_lut+1, X
    /* D05A 85 05    */ sta zR04+1

    /* D05C BD 77 D0 */ lda battler_stat_after_addr_lut, X
    /* D05F 85 08    */ sta zR08
    /* D061 BD 78 D0 */ lda battler_stat_after_addr_lut+1, X
    /* D064 85 09    */ sta zR08+1

    /* D066 68       */ pla
    /* D067 AA       */ tax

    /* D068 60       */ rts

battler_stat_before_addr_lut:
    /* D069 ...      */ .word wFightStrength, wFightSkill, wFight0316, wFightSpeed
    /* D071 ...      */ .word wFightLuck, wFightDefense, wFightMaxHp

battler_stat_after_addr_lut:
    /* D077 ...      */ .word wFight032C, wFight032D, wFight032E, wFight032F
    /* D07F ...      */ .word wFight0330, wFight0331, wFight032A

    .endproc ; GetBattlerStatPointers

    .proc FightCheckForLevelGain

    /* D085 AD 04 03 */ lda wFightPid
    /* D088 C9 29    */ cmp #PID_XANE

    /* D08A D0 0D    */ bne do_check

    /* D08C AD 06 03 */ lda wFightJid

    /* D08F C9 10    */ cmp #JID_COMMANDO
    /* D091 F0 06    */ beq do_check

    /* D093 A9 01    */ lda #1
    /* D095 8D 8A 04 */ sta wUnk048A

    /* D098 60       */ rts

do_check:
    /* D099 AD 08 03 */ lda wFightLevel
    /* D09C C9 14    */ cmp #20
    /* D09E F0 75    */ beq end

    /* D0A0 AD 0E 03 */ lda wFightExp
    /* D0A3 18       */ clc
    /* D0A4 6D 0F 03 */ adc wFightExpGained
    /* D0A7 8D 2B 03 */ sta wFightExpAfter

    /* D0AA C9 64    */ cmp #100
    /* D0AC 90 67    */ bcc end

    /* D0AE EE 29 03 */ inc wFightLevelAfter

    /* D0B1 AD 2B 03 */ lda wFightExpAfter
    /* D0B4 38       */ sec
    /* D0B5 E9 64    */ sbc #100
    /* D0B7 8D 2B 03 */ sta wFightExpAfter

    /* D0BA A9 01    */ lda #1
    /* D0BC 8D 5E 03 */ sta wFightPossibleStatGain

    /* D0BF A2 06    */ ldx #6

lop_stats:
    /* D0C1 20 16 D1 */ jsr CheckMercuriusStatGainBonus

    /* D0C4 20 4E D0 */ jsr GetBattlerStatPointers

    /* D0C7 20 4E C0 */ jsr Rand
    /* D0CA 85 48    */ sta zDivLeft
    /* D0CC A9 19    */ lda #25
    /* D0CE 85 4A    */ sta zDivRight
    /* D0D0 A9 00    */ lda #0
    /* D0D2 85 49    */ sta zDivLeft+1

    /* D0D4 20 EB C6 */ jsr Div

    /* D0D7 AC 04 03 */ ldy wFightPid
    /* D0DA 88       */ dey

    /* D0DB 98       */ tya
    /* D0DC 0A       */ asl A
    /* D0DD A8       */ tay

    /* D0DE B9 E0 E1 */ lda CharacterGrowthTable, Y
    /* D0E1 85 06    */ sta zR06
    /* D0E3 B9 E1 E1 */ lda CharacterGrowthTable+1, Y
    /* D0E6 85 07    */ sta zR06+1

    /* D0E8 8A       */ txa
    /* D0E9 A8       */ tay
    /* D0EA B1 06    */ lda (zR06), Y
    /* D0EC C9 0A    */ cmp #10
    /* D0EE F0 06    */ beq gain_stat

    /* D0F0 C5 48    */ cmp zDivLeft
    /* D0F2 F0 1E    */ beq continue

    /* D0F4 90 1C    */ bcc continue

gain_stat:
    /* D0F6 A0 00    */ ldy #0
    /* D0F8 B1 04    */ lda (zR04), Y

    /* D0FA 18       */ clc
    /* D0FB 6D 5E 03 */ adc wFightPossibleStatGain

    /* D0FE E0 06    */ cpx #6 ; HP
    /* D100 F0 08    */ beq hp_cap

    /* D102 C9 14    */ cmp #20
    /* D104 90 0A    */ bcc set_stat_after

    /* D106 A9 14    */ lda #20
    /* D108 D0 06    */ bne set_stat_after

hp_cap:
    /* D10A C9 34    */ cmp #52
    /* D10C 90 02    */ bcc set_stat_after

    /* D10E A9 34    */ lda #52

set_stat_after:
    /* D110 91 08    */ sta (zR08), Y

continue:
    /* D112 CA       */ dex
    /* D113 10 AC    */ bpl lop_stats

end:
    /* D115 60       */ rts

    .endproc ; FightCheckForLevelGain

    .proc CheckMercuriusStatGainBonus

    /* D116 AD 20 03 */ lda wFightIid

    /* D119 C9 07    */ cmp #IID_MERCURIUS
    /* D11B D0 11    */ bne end

    /* D11D A9 01    */ lda #1
    /* D11F 8D 5E 03 */ sta wFightPossibleStatGain

    /* D122 BD 2F D1 */ lda mask_lut, X
    /* D125 25 30    */ and zUnk30
    /* D127 D0 05    */ bne end

    /* D129 A9 02    */ lda #2
    /* D12B 8D 5E 03 */ sta wFightPossibleStatGain

end:
    /* D12E 60       */ rts

mask_lut:
    .byte %11000000
    .byte %01100000
    .byte %00110000
    .byte %00011000
    .byte %00001100
    .byte %00001100
    .byte %00000110
    .byte %00000011

    .endproc ; CheckMercuriusStatGainBonus

    .proc FUNC_D137

    /* D137 A0 00    */ ldy #0
    /* D139 8C 03 03 */ sty wUnk0303

    /* D13C C8       */ iny ; lda #1

lop_battler:
    /* D13D 8C 74 03 */ sty wFightCurrentBattlerId

    /* D140 BE 20 03 */ ldx wFightIid, Y

    /* D143 E0 35    */ cpx #IID_FIRST_EFFECT
    /* D145 90 05    */ bcc LOC_D14C ; blo

    /* D147 CC 02 03 */ cpy wUnk0302
    /* D14A D0 03    */ bne LOC_D14F

LOC_D14C:
    /* D14C 20 56 D1 */ jsr FUNC_D156

LOC_D14F:
    /* D14F AC 74 03 */ ldy wFightCurrentBattlerId

    /* D152 88       */ dey
    /* D153 10 E8    */ bpl lop_battler

    /* D155 60       */ rts

    .endproc ; FUNC_D137

    .proc FUNC_D156

    /* D156 BD 67 D9 */ lda ItemEffectTable, X
    /* D159 20 4C C3 */ jsr Switch

    .word CaseRet
    .word case_effect_01
    .word case_effect_02
    .word case_effect_03
    .word case_effect_04
    .word case_effect_05
    .word case_effect_06
    .word case_effect_07
    .word case_effect_08
    .word case_effect_09
    .word case_effect_0A
    .word case_effect_0B
    .word case_effect_0C
    .word case_effect_0D
    .word case_effect_0E

case_effect_01:
    /* D17A A9 0A    */ lda #10
    /* D17C D0 06    */ bne LOC_D184

case_effect_02:
    /* D17E A9 14    */ lda #20
    /* D180 D0 02    */ bne LOC_D184

case_effect_03:
    /* D182 A9 3C    */ lda #60

LOC_D184:
    /* D184 AC 74 03 */ ldy wFightCurrentBattlerId
    /* D187 20 70 CE */ jsr SwapBattlerIdY

    /* D18A 18       */ clc
    /* D18B 79 0A 03 */ adc wFightStartHp, Y
    /* D18E D9 0C 03 */ cmp wFightMaxHp, Y
    /* D191 90 03    */ bcc LOC_D196 ; blo

    /* D193 B9 0C 03 */ lda wFightMaxHp, Y

LOC_D196:
    /* D196 99 34 03 */ sta wFightCurrentHp, Y

case_effect_07:
    /* D199 20 84 D2 */ jsr LOC_D284

    /* D19C EE 03 03 */ inc wUnk0303
    /* D19F 60       */ rts

case_effect_09:
    /* D1A0 EE 59 03 */ inc wUnk0359
    /* D1A3 EE 03 03 */ inc wUnk0303

    /* D1A6 20 84 D2 */ jsr LOC_D284

    /* D1A9 60       */ rts

case_effect_04:
    /* D1AA AC 74 03 */ ldy wFightCurrentBattlerId
    /* D1AD 20 70 CE */ jsr SwapBattlerIdY

    /* D1B0 B9 20 03 */ lda wFightIid, Y

    /* D1B3 C9 0A    */ cmp #IID_FALCHION
    /* D1B5 F0 25    */ beq do_nothing

LOC_D1B7:
    /* D1B7 20 C7 D2 */ jsr FUNC_D2C7

    /* D1BA 90 20    */ bcc do_nothing

    /* D1BC AC 74 03 */ ldy wFightCurrentBattlerId
    /* D1BF 20 70 CE */ jsr SwapBattlerIdY

    /* D1C2 B9 06 03 */ lda wFightJid, Y

    /* D1C5 C9 13    */ cmp #JID_PRIEST
    /* D1C7 F0 13    */ beq do_nothing

    /* D1C9 C9 14    */ cmp #JID_BISHOP
    /* D1CB D0 07    */ bne LOC_D1D4

    /* D1CD B9 20 03 */ lda wFightIid, Y

    /* D1D0 C9 35    */ cmp #IID_FIRST_EFFECT
    /* D1D2 B0 08    */ bcs do_nothing ; bhs

LOC_D1D4:
    /* D1D4 A9 01    */ lda #1
    /* D1D6 99 4F 03 */ sta wUnk034F, Y

    /* D1D9 20 AA D2 */ jsr FUNC_D2AA

do_nothing:
    /* D1DC 60       */ rts

case_effect_0B:
    /* D1DD AC 74 03 */ ldy wFightCurrentBattlerId
    /* D1E0 20 70 CE */ jsr SwapBattlerIdY

    /* D1E3 B9 20 03 */ lda wFightIid, Y

    /* D1E6 C9 34    */ cmp #IID_STARLIGHT
    /* D1E8 F0 F2    */ beq do_nothing

    /* D1EA D0 CB    */ bne LOC_D1B7

case_effect_0E:
    /* D1EC AD 1E 03 */ lda wFight031E
    /* D1EF 0D 1F 03 */ ora wFight031E+1
    /* D1F2 D0 B6    */ bne case_effect_04

case_effect_05:
    /* D1F4 AC 74 03 */ ldy wFightCurrentBattlerId
    /* D1F7 20 70 CE */ jsr SwapBattlerIdY

    /* D1FA B9 06 03 */ lda wFightJid, Y

    /* D1FD C9 14    */ cmp #JID_BISHOP
    /* D1FF F0 A9    */ beq case_effect_04

    /* D201 C9 12    */ cmp #JID_MAGE
    /* D203 F0 A5    */ beq case_effect_04

    /* D205 B9 20 03 */ lda wFightIid, Y

    /* D208 C9 08    */ cmp #IID_LEVINSWORD
    /* D20A F0 9E    */ beq case_effect_04

    /* D20C D0 CE    */ bne do_nothing

case_effect_06:
    /* D20E AC 74 03 */ ldy wFightCurrentBattlerId
    /* D211 20 70 CE */ jsr SwapBattlerIdY

    /* D214 B9 06 03 */ lda wFightJid, Y

    /* D217 C9 18    */ cmp #JID_24
    /* D219 F0 C1    */ beq do_nothing

    /* D21B C9 17    */ cmp #JID_23
    /* D21D F0 BD    */ beq do_nothing

    /* D21F C9 12    */ cmp #JID_MAGE
    /* D221 F0 B9    */ beq do_nothing

    /* D223 C9 14    */ cmp #JID_BISHOP
    /* D225 F0 B5    */ beq do_nothing

    /* D227 C9 13    */ cmp #JID_PRIEST
    /* D229 F0 B1    */ beq do_nothing

    /* D22B AD 1E 03 */ lda wFight031E
    /* D22E 0D 1F 03 */ ora wFight031E+1
    /* D231 D0 A9    */ bne do_nothing

    /* D233 4C AA D1 */ jmp case_effect_04

case_effect_08:
    /* D236 A9 00    */ lda #0
    /* D238 8D 77 04 */ sta wUnk0477

    /* D23B EE 03 03 */ inc wUnk0303

    /* D23E 20 53 D2 */ jsr LOC_D253

    /* D241 AD 77 04 */ lda wUnk0477
    /* D244 D0 0C    */ bne :+

    /* D246 AC 21 03 */ ldy wFightIid+1
    /* D249 B9 7F D8 */ lda ItemUsesTable, Y
    /* D24C 8D 25 03 */ sta wFight0325
    /* D24F 20 84 D2 */ jsr LOC_D284

:
    /* D252 60       */ rts

LOC_D253:
    /* D253 AC 21 03 */ ldy wFightIid+1

    /* D256 B9 B3 D6 */ lda ItemWeaponLevelTable, Y
    /* D259 30 0D    */ bmi LOC_D268

    /* D25B C9 0B    */ cmp #11
    /* D25D B0 09    */ bcs LOC_D268 ; bhs

    /* D25F C0 44    */ cpy #IID_44
    /* D261 F0 05    */ beq LOC_D268

    /* D263 AD 25 03 */ lda wFight0325
    /* D266 10 05    */ bpl LOC_D26D

LOC_D268:
    /* D268 A9 01    */ lda #1
    /* D26A 8D 77 04 */ sta wUnk0477

LOC_D26D:
    /* D26D 60       */ rts

case_effect_0A:
    /* D26E EE 03 03 */ inc wUnk0303
    /* D271 EE 5A 03 */ inc wUnk035A

    /* D274 20 84 D2 */ jsr LOC_D284

    /* D277 60       */ rts

case_effect_0C:
    /* D278 EE 03 03 */ inc wUnk0303

    /* D27B A9 07    */ lda #7
    /* D27D 8D 27 03 */ sta wFightResistance+1

    /* D280 20 84 D2 */ jsr LOC_D284

    /* D283 60       */ rts

LOC_D284:
    /* D284 AD 24 03 */ lda wFight0324
    /* D287 30 0D    */ bmi LOC_D296

    /* D289 CE 24 03 */ dec wFight0324
    /* D28C D0 08    */ bne LOC_D296

    /* D28E A9 01    */ lda #1
    /* D290 8D 58 03 */ sta wUnk0358
    /* D293 8D 7E 04 */ sta wUnk047E

LOC_D296:
    /* D296 60       */ rts

case_effect_0D:
    /* D297 EE 03 03 */ inc wUnk0303

    /* D29A AC 21 03 */ ldy wFightIid+1

    /* D29D C0 3F    */ cpy #IID_FIRST_ITEM
    /* D29F B0 C7    */ bcs LOC_D268 ; blo

    /* D2A1 A9 FF    */ lda #$FF ; -1
    /* D2A3 8D 25 03 */ sta wFight0325

    /* D2A6 20 84 D2 */ jsr LOC_D284

    /* D2A9 60       */ rts

    .endproc ; FUNC_D156

    .proc FUNC_D2AA

    /* D2AA AD 02 03 */ lda wUnk0302
    /* D2AD D0 17    */ bne end

    /* D2AF AD 06 03 */ lda wFightJid

    /* D2B2 C9 13    */ cmp #JID_PRIEST
    /* D2B4 F0 0B    */ beq LOC_D2C1

    /* D2B6 C9 14    */ cmp #JID_BISHOP
    /* D2B8 D0 0C    */ bne end

    /* D2BA AD 20 03 */ lda wFightIid

    /* D2BD C9 35    */ cmp #IID_FIRST_EFFECT
    /* D2BF 90 05    */ bcc end ; blo

LOC_D2C1:
    /* D2C1 A9 00    */ lda #0
    /* D2C3 8D 4F 03 */ sta wUnk034F

end:
    /* D2C6 60       */ rts

    .endproc ; FUNC_D2AA

    .proc FUNC_D2C7

    /* D2C7 AC 74 03 */ ldy wFightCurrentBattlerId

    /* D2CA B9 1E 03 */ lda wFight031E, Y
    /* D2CD F0 0D    */ beq LOC_D2DC

    /* D2CF 20 70 CE */ jsr SwapBattlerIdY

    /* D2D2 BE 20 03 */ ldx wFightIid, Y
    /* D2D5 BD C3 D9 */ lda ItemUnkTable_D9C3, X
    /* D2D8 20 9B C3 */ jsr Lsr3

    /* D2DB 60       */ rts

LOC_D2DC:
    /* D2DC 20 70 CE */ jsr SwapBattlerIdY

    /* D2DF BE 20 03 */ ldx wFightIid, Y
    /* D2E2 BD C3 D9 */ lda ItemUnkTable_D9C3, X

    /* D2E5 BE 1E 03 */ ldx wFight031E, Y
    /* D2E8 F0 01    */ beq LOC_D2EB

    /* D2EA 4A       */ lsr A

LOC_D2EB:
    /* D2EB 4A       */ lsr A
    /* D2EC 4A       */ lsr A

    /* D2ED 60       */ rts

    .endproc ; FUNC_D2C7

    .proc IsEffective

    /* D2EE 8C 74 03 */ sty wFightCurrentBattlerId
    /* D2F1 8E 73 03 */ stx wUnk0373
    /* D2F4 0A       */ asl A
    /* D2F5 AA       */ tax
    /* D2F6 BD 37 D9 */ lda EffectivenessInfo, X
    /* D2F9 85 00    */ sta zR00
    /* D2FB BD 38 D9 */ lda EffectivenessInfo+1, X
    /* D2FE 85 01    */ sta zR00+1

    /* D300 AE 74 03 */ ldx wFightCurrentBattlerId
    /* D303 20 77 CE */ jsr SwapBattlerIdX

    /* D306 A0 00    */ ldy #0

lop:
    /* D308 B1 00    */ lda (zR00), Y
    /* D30A C9 FF    */ cmp #$FF
    /* D30C F0 08    */ beq ret_false

    /* D30E DD 06 03 */ cmp wFightJid, X
    /* D311 F0 06    */ beq ret_true

    /* D313 C8       */ iny
    /* D314 10 F2    */ bpl lop

ret_false:
    /* D316 18       */ clc
    /* D317 90 01    */ bcc end

ret_true:
    /* D319 38       */ sec

end:
    /* D31A AE 73 03 */ ldx wUnk0373
    /* D31D AC 74 03 */ ldy wFightCurrentBattlerId

    /* D320 60       */ rts

    .endproc ; IsEffective

    .proc FUNC_D321

    /* D321 AD ED 76 */ lda sUnk76ED
    /* D324 D0 0A    */ bne LOC_D330

    /* D326 A9 F4    */ lda #<sUnitBuf
    /* D328 85 00    */ sta zR00
    /* D32A A9 76    */ lda #>sUnitBuf
    /* D32C 85 01    */ sta zR00+1

    /* D32E D0 08    */ bne LOC_D338

LOC_D330:
    /* D330 A9 15    */ lda #<sUnk7715
    /* D332 85 00    */ sta zR00
    /* D334 A9 77    */ lda #>sUnk7715
    /* D336 85 01    */ sta zR00+1

LOC_D338:
    /* D338 A9 00    */ lda #0
    /* D33A 8D 82 04 */ sta wUnk0482

    /* D33D A0 13    */ ldy #Unit::item
    /* D33F A2 04    */ ldx #UNIT_ITEM_COUNT

lop:
    /* D341 B1 00    */ lda (zR00), Y

    /* D343 C9 5B    */ cmp #IID_LIGHTSPHERE+1
    /* D345 D0 05    */ bne not_lightsphere

    /* D347 A9 00    */ lda #0
    /* D349 8D 11 03 */ sta wUnk0310+1

not_lightsphere:
    /* D34C C9 58    */ cmp #IID_STARSPHERE+1
    /* D34E D0 03    */ bne not_starsphere

    /* D350 EE 82 04 */ inc wUnk0482

not_starsphere:
    /* D353 C8       */ iny

    /* D354 CA       */ dex
    /* D355 D0 EA    */ bne lop

    /* D357 60       */ rts

    .endproc ; FUNC_D321
