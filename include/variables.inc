    .ifndef VARIABLES_INC
    VARIABLES_INC = 1

    zR00            = $0000
    zR01            = $0001
    zR02            = $0002
    zR03            = $0003
    zR04            = $0004
    zR05            = $0005
    zR06            = $0006
    zR07            = $0007
    zR08            = $0008
    zR09            = $0009
    zR0A            = $000A
    zR0B            = $000B
    zSwitchPtr      = $000C
    zSwitchX        = $000E
    zSwitchY        = $000F
    zUnk10          = $0010
    zUnk11          = $0011
    zUnk12          = $0012
    zUnk13          = $0013
    zInputNew       = $0014
    zInputHeld      = $0016
    zInputRepeat    = $0018
    zInputRepeatCnt = $001A
    zUnk1C          = $001C
    zUnk1D          = $001D
    zUnk1E          = $001E
    zUnk1F          = $001F
    zFrameEnded     = $0020
    zTransferEnable = $0021
    zUnk22          = $0022 ; pending transfer id?
    zUnk23          = $0023
    zUnk24          = $0024
    zUnk25          = $0025 ; next game scene id?
    zUnk26          = $0026
    zBank29         = $0029
    zUnk2C          = $002C
    zUnk2D          = $002D
    zUnk2E          = $002E
    zUnk30          = $0030
    zRngA           = $0031
    zRngB           = $0032
    zSpriteY        = $0034 ; some sprite y offset
    zSpriteX        = $0035 ; some sprite x offset
    zSpriteNum      = $0036
    zSpriteIt       = $0037
    zUnk38          = $0038 ; has to do with sprite attributes
    zUnk39          = $0039 ; has to do with sprite attributes
    zUnk3A          = $003A ; has to do with sprite attributes... palette? some mask?
    zUnk3B          = $003B ; bool : mirror sprite?
    zSpriteGroup    = $003C
    zUnk3D          = $003D ; sprite write counter?
    zUnk3E          = $003E
    zUnk40          = $0040
    zUnk42          = $0042
    zUnk43          = $0043 ; scratch for sprite write?
    zFarFuncNum     = $0044
    zFarFuncPtr     = $0045
    zDivLeft        = $0048
    zDivRight       = $004A
    zDivResult      = $004B
    zBank51         = $0051
    zChr52          = $0052
    zUnk54          = $0054
    zUnk57          = $0057
    zUnk58          = $0058
    zChr59          = $0059
    zChr5A          = $005A
    zChr5B          = $005B
    zChr5C          = $005C
    zUnk5D          = $005D
    zUnk5E          = $005E
    zUnk5F          = $005F
    zUnk60          = $0060
    zUnk61          = $0061
    zUnk62          = $0062
    zUnk63          = $0063 ; cam x? y?
    zUnk64          = $0064 ; cam y? x?
    zUnk65          = $0065
    zUnk67          = $0067
    zUnk68          = $0068 ; map src ptr?
    zUnk6A          = $006A ; map dst ptr?
    zMapMovementRow = $006C
    zUnk6E          = $006E
    zUnk70          = $0070
    zUnk71          = $0072
    zUnitPtr72      = $0072 ; bank 8 : unit deployment ptr (lo)
    zUnitLoadDst    = $0074
    zUnitLoadSrc    = $0076
    zUnk78          = $0078
    zUnk7A          = $007A
    zUnk7B          = $007B ; y counter?

    zUnk84       = $0084

    zUnk89       = $0089
    zUnk8A       = $008A
    zUnk8B       = $008B

    zUnk97       = $0097 ; bool: cycle map+unit anims?
    zUnk98       = $0098 ; map+unit anims cycle timer?
    zUnk99       = $0099 ; current map+unit anim frame?

    zUnk9B       = $009B ; some map row ptr
    zUnitPtrRed  = $009D ; some unit ptr
    zUnitPtrBlue = $009F ; some unit ptr

    zUnkA1       = $00A1 ; some tmp?
    zUnkA2       = $00A2 ; some tmp?
    zUnkA3       = $00A3 ; some tmp?
    zUnkA4       = $00A4 ; some tmp?
    zUnkA5       = $00A5
    zUnkA6       = $00A6
    zUnkA7       = $00A7
    zUnkA8       = $00A8 ; some unit strength?
    zUnkA9       = $00A9
    zUnkAA       = $00AA
    zUnkAB       = $00AB
    zUnkAC       = $00AC
    zUnkAD       = $00AD
    zUnkAE       = $00AE
    zUnkAF       = $00AF
    zUnkB0       = $00B0
    zUnkB1       = $00B1 ; some unit defense
    zUnkB2       = $00B2 ; some map y
    zUnkB3       = $00B3 ; some map x

    zUnkB5       = $00B5 ; some unit strength

    zUnkB7       = $00B7
    zMapFloodAction = $00B8
    zUnkB9       = $00B9 ; best target some damage value?
    zUnkBA       = $00BA ; some damage value?
    zUnkBB       = $00BB ; some damage value
    zUnkBC       = $00BC ; best target priority?
    zUnkBD       = $00BD ; working target priority?
    zMapFloodRingNum = $00BE
    zMapFloodRingCount = $00BF
    zUnkC0       = $00C0 ; some map x
    zUnkC1       = $00C1 ; some map y
    zUnkC2       = $00C2 ; some map x
    zUnkC3       = $00C3 ; some map y
    zUnkC4       = $00C4

    zUnkC6       = $00C6 ; some map y?
    zUnkC7       = $00C7 ; some map x?
    zMirrorC8    = $00C8

    zPPUSCROLLV  = $00CA
    zPPUSCROLLH  = $00CB
    zPPUMASK     = $00CC
    zPPUCTRL     = $00CD

    zUnkD0       = $00D0

    wOamBuf    = $0200 ; 0100

    wUnk0300_2 = $0300 ; a map row number
    wUnk0301_2 = $0301 ; a counter
    wUnk0302_2 = $0302 ; an array

    wUnk0301   = $0301
    wUnk0302   = $0302
    wUnk0303   = $0303 ; some battle counter?
    wFightPid   = $0304
    wUnk0305   = $0305
    wFightJid  = $0306 ; battle unit classes?
    wFightLevel   = $0308
    wFightStartHp = $030A ; battle unit cur hps?
    wFightMaxHp   = $030C ; battle unit max hps?
    wFightExp   = $030E
    wFightExpGained   = $030F
    wUnk0310   = $0310 ; battle unit terrain avoid????
    wFightStrength = $0312 ; battle unit attacks?
    wFightSkill   = $0314 ; battle unit skills?
    wFightWeaponLevel = $0316
    wFightSpeed = $0318 ; battle unit speeds?
    wFightLuck = $031A ; battle unit lucks?
    wFightDefense = $031C ; battle unit defenses?
    wFight031E = $031E
    wFightIid  = $0320 ; Item ids?
    wFight0322 = $0322
    wFight0324 = $0324
    wFight0325 = $0325
    wFightResistance = $0326 ; battle unit reses?
    wUnk0328   = $0328

    wFightLevelAfter = $0329

    ; note: these need to be in this order in memory. See FUNC_01_B8CB
    wFightMaxHpAfter = $032A
    wFightExpAfter = $032B
    wFightStrAfter = $032C
    wFightSklAfter = $032D
    wFightWlvAfter = $032E
    wFightSpdAfter = $032F
    wFightLckAfter = $0330
    wFightDefAfter = $0331

    wFightCurrentHp     = $0334 ; battle unit new hps??
    wFight0336          = $0336
    wFightAttackSpeed   = $0338 ; battle unit attack speed?
    wFightAttackHit     = $033A
    wFightAttackDamage  = $033C ; battle unit attack?
    wFightAttackDefense = $033E ; battle unit defense?
    wFightAttackCrit    = $0340 ; battle unit attack crit?
    wFightAttackDodge   = $0342
    wFightHitsFirst     = $0344
    wFightHitsSecond    = $0346
    wFightFollowUp      = $0348 ; 1 if attacker follow-up, 2 if defender follow-up, 0 if before/no follow-up
    wFightMight         = $0349 ; battle unit weapon might?
    wFightCritsFirst    = $034B
    wFightCritsSecond   = $034D

    wUnk034F   = $034F
    wUnk0350   = $0350
    wUnk0351   = $0351
    wUnk0353   = $0353
    wUnk0355   = $0355
    wUnk0356   = $0356
    wUnk0357   = $0357
    wUnk0358   = $0358
    wUnk0359   = $0359
    wUnk035A   = $035A

    wFightPossibleStatGain   = $035E
    wFightTmpA = $035F
    wFightTmpB = $0360

    wUnk0367 = $0367

    wUnk0373_2 = $0373
    wUnk0374_2 = $0374

    wUnk0371   = $0371
    wUnk0372   = $0372
    wUnk0373   = $0373
    wFightCurrentBattlerId = $0374
    wUnk0375   = $0375

    wUnk0389   = $0389 ; 3 bytes
    wUnk038C   = $038C ; 3 bytes
    wUnk038F   = $038F ; 3 bytes
    wUnk0392   = $0392 ; 3 bytes
    wUnk0395   = $0395 ; 3 bytes
    wUnk0398   = $0398 ; 3 bytes, sprite numbers
    wUnk039B   = $039B ; 3 bytes, sprite Xs
    wUnk039E   = $039E ; 3 bytes, sprite Ys
    wUnk03A1   = $03A1 ; 3 bytes, sprite mirroring related
    wUnk03A4   = $03A4 ; 3 bytes, sprite attribute related
    wUnk03A7   = $03A7 ; 3 bytes
    wUnk03AA   = $03AA ; 3 bytes
    wUnk03AD   = $03AD ; 3 bytes
    wUnk03B0   = $03B0 ; 3 bytes
    wUnk03B3   = $03B3 ; 3 bytes
    wUnk03B6   = $03B6 ; 3 bytes
    wUnk03B9   = $03B9 ; 3 bytes
    wUnk03BC   = $03BC ; 3 bytes

    wUnk03C2   = $03C2
    wUnk03C3   = $03C3

    wUnk03D2   = $03D2 ; 4 bytes? sprite numbers
    wUnk03D6   = $03D6 ; 4 bytes? sprite numbers
    wUnk03DA   = $03DA

    wUnk03DC   = $03DC

    wUnk03E1   = $03E1 ; array, size 3C?

    wUnk0425   = $0425
    wUnk0426   = $0426 ; 6 bytes
    wUnk042C   = $042C ; 6 bytes
    wUnk0432   = $0432 ; 6 bytes
    wUnk0438   = $0438 ; 6 bytes

    wUnk043E   = $043E ; array[6]
    wUnk0444   = $0444 ; array[6]

    wUnk0457   = $0457
    wUnk0458   = $0458
    wUnk0459   = $0459

    wUnk0474   = $0474

    wUnk0476   = $0476
    wUnk0477   = $0477

    wUnk0479   = $0479
    wUnk047A   = $047A
    wUnk047B   = $047B

    wUnk047E   = $047E

    wUnk0482   = $0482
    wUnk0483   = $0483
    wUnk0484   = $0484

    wUnk0487   = $0487 ; 3 bytes, sprite groups

    wUnk048A   = $048A
    wUnk048B   = $048B

    wUnk04D8   = $04D8 ; array (20)

    wUnk0500   = $0500 ; some x
    wUnk0501   = $0501 ; some y

    wUnk050D   = $050D

    wUnk0520   = $0520 ; array

    wUnk052E   = $052E ; array (5)
    wUnk0533   = $0533 ; array (5), some jids?

    wUnk0538   = $0538 ; some unit x
    wUnk0539   = $0539 ; some unit y
    wUnk053A   = $053A

    wUnk053D   = $053D

    wUnk053F   = $053F

    wUnk0542   = $0542
    wUnk0543   = $0543
    wUnk0544   = $0544
    wUnk0545   = $0545

    wUnk0548   = $0548

    wUnk0550   = $0550 ; array[100]

    wUnk05C0   = $05C0 ; best target x
    wUnk05C1   = $05C1 ; best target y
    wUnk05C2   = $05C2 ; best target something
    wUnk05C3   = $05C3

    wUnk05C4   = $05C4

    wUnk05C6   = $05C6 ; a bank number (-1 for nothing)
    wUnk05C7   = $05C7 ; a bank number
    wUnk05C8   = $05C8 ; a sprite group

    wUnk05CC   = $05CC
    wUnk05CD   = $05CD
    wUnk05CE   = $05CE

    wUnk05D3   = $05D3
    wUnk05D4   = $05D4

    wUnk05DB   = $05DB

    wUnk05DE   = $05DE
    wUnk05DF   = $05DF

    wUnk05E8   = $05E8

    wUnk05EA   = $05EA

    wUnk05ED   = $05ED

    wInputDelayCnt = $05F1
    wInputRaw = $05F2

    wUnk05F4   = $05F4

    wUnk06F0   = $06F0 ; array?
    wUnk06F1   = $06F1
    wUnk06F2   = $06F2
    wUnk06F3   = $06F3
    wUnk06F4   = $06F4
    wUnk06F5   = $06F5
    wUnk06F6   = $06F6
    wUnk06F7   = $06F7
    wUnk06F8   = $06F8

    wUnk0700   = $0700

    wTransferCnt   = $0780
    wTransferScr   = $0781 ; array

    sBlueUnits   = $6A90 ; dat[081F]
    sRedUnits    = $7078 ; dat[0237]
    sMapCell     = $72AF ; map data
    sMapNum      = $7674 ; map number
    sTurnNumber  = $7675 ; turn number
    sMapHeight   = $7676 ; map y size
    sMapWidth    = $7677 ; map x size
    sUnk767A     = $767A
    sUnk767B     = $767B
    sUnk767F     = $767F
    sUnk76ED     = $76ED ; orred to class of unit then written to map
    sUnitBuf     = $76F4 ; unit load buf
    sUnk7715     = $7715

    sMapMovement = $7730

    ; ???
    sUnk7730     = $7730 ; BF bytes

    ; ???
    sUnk77F0     = $77F0
    sUnk77F1     = $77F1
    sUnk77F2     = $77F2
    sUnk77F4     = $77F4
    sUnk77F7     = $77F7
    sUnk7812     = $7812 ; 2 bytes
    sUnk7814     = $7814 ; 2 bytes
    sUnk7934     = $7934

    sMapData2    = $7AF0

    .endif ; VARIABLES_INC
