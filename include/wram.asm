
    .ramsection "ZP" slot "RAM" orga $0000

    zR00            db ; 0000
    zR01            db ; 0001
    zR02            db ; 0002
    zR03            db ; 0003
    zR04            db ; 0004
    zR05            db ; 0005
    zR06            db ; 0006
    zR07            db ; 0007
    zR08            db ; 0008
    zR09            db ; 0009
    zR0A            db ; 000A
    zR0B            db ; 000B
    zSwitchPtr      dw ; 000C
    zSwitchX        db ; 000E
    zSwitchY        db ; 000F
    zUnk10          db ; 0010
    zUnk11          db ; 0011
    zUnk12          db ; 0012
    zUnk13          db ; 0013
    zInputNew       db ; 0014
    .               db ; 0015
    zInputHeld      db ; 0016
    .               db ; 0017
    zInputRepeat    db ; 0018
    .               db ; 0019
    zInputRepeatCnt db ; 001A
    .               db ; 001B
    zUnk1C          db ; 001C
    zUnk1D          db ; 001D
    zUnk1E          db ; 001E
    zUnk1F          db ; 001F
    zFrameEnded     db ; 0020
    zTransferEnable db ; 0021
    zUnk22          db ; 0022 ; pending transfer id?
    zUnk23          db ; 0023
    zUnk24          db ; 0024
    zUnk25          db ; 0025 ; next game scene id?
    zUnk26          db ; 0026
    .               db ; 0027
    .               db ; 0028
    zBank29         db ; 0029
    .               db ; 002A
    .               db ; 002B
    zUnk2C          db ; 002C
    zUnk2D          db ; 002D
    zUnk2E          db ; 002E
    .               db ; 002F
    zUnk30          db ; 0030
    zRngA           db ; 0031
    zRngB           db ; 0032
    .               db ; 0033
    zSpriteY        db ; 0034 ; some sprite y offset
    zSpriteX        db ; 0035 ; some sprite x offset
    zSpriteNum      db ; 0036
    zSpriteIt       db ; 0037
    zUnk38          db ; 0038 ; has to do with sprite attributes
    zUnk39          db ; 0039 ; has to do with sprite attributes
    zUnk3A          db ; 003A ; has to do with sprite attributes... palette? some mask?
    zUnk3B          db ; 003B ; bool : mirror sprite?
    zSpriteGroup    db ; 003C
    zUnk3D          db ; 003D ; sprite write counter?
    zUnk3E          dw ; 003E
    zUnk40          dw ; 0040
    zUnk42          db ; 0042
    zUnk43          db ; 0043 ; scratch for sprite write?
    zFarFuncNum     db ; 0044
    zFarFuncPtr     dw ; 0045
    .               db ; 0047
    zDivLeft        dw ; 0048
    zDivRight       db ; 004A
    zDivResult      db ; 004B
    .               db ; 004C
    .               db ; 004D
    .               db ; 004E
    .               db ; 004F
    .               db ; 0050
    zBank51         db ; 0051
    zChr52          db ; 0052
    .               db ; 0053
    zUnk54          db ; 0054
    .               db ; 0055
    .               db ; 0056
    zUnk57          db ; 0057
    zUnk58          db ; 0058
    zChr59          db ; 0059
    zChr5A          db ; 005A
    zChr5B          db ; 005B
    zChr5C          db ; 005C
    zUnk5D          db ; 005D
    zUnk5E          db ; 005E
    zUnk5F          db ; 005F
    zUnk60          db ; 0060
    zUnk61          db ; 0061
    zUnk62          db ; 0062
    zUnk63          db ; 0063 ; cam x? y?
    zUnk64          db ; 0064 ; cam y? x?
    zUnk65          dw ; 0065
    zUnk67          db ; 0067
    zUnk68          dw ; 0068 ; map src ptr?
    zUnk6A          dw ; 006A ; map dst ptr?
    zMapMovementRow dw ; 006C
    zUnk6E          dw ; 006E
    zUnk70          db ; 0070
    zUnk71          db ; 0072
    zUnitPtr72      dw ; 0072 ; bank 8 : unit deployment ptr (lo)
    zUnitLoadDst    dw ; 0074
    zUnitLoadSrc    dw ; 0076
    zUnk78          dw ; 0078
    zUnk7A          db ; 007A
    zUnk7B          db ; 007B ; y counter?

    .ends

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
    wFight0316    = $0316
    wFightSpeed = $0318 ; battle unit speeds?
    wFightLuck   = $031A ; battle unit lucks?
    wFightDefense   = $031C ; battle unit defenses?
    wFight031E = $031E
    wFightIid  = $0320 ; Item ids?
    wFight0322 = $0322
    wFight0324 = $0324
    wFight0325 = $0325
    wFightResistance = $0326 ; battle unit reses?
    wUnk0328   = $0328
    wFightLevelAfter   = $0329
    wFight032A = $032A
    wFightExpAfter = $032B
    wFight032C = $032C
    wFight032D = $032D
    wFight032E = $032E
    wFight032F = $032F
    wFight0330 = $0330
    wFight0331 = $0331

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
    wUnk0348            = $0348 ; 1 if attacker follow-up, 2 if defender follow-up, 0 if before/no follow-up
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

    wUnk0474   = $0474

    wUnk0477   = $0477

    wUnk0479   = $0479
    wUnk047A   = $047A

    wUnk047E   = $047E

    wUnk0482   = $0482
    wUnk0483   = $0483
    wUnk0484   = $0484

    wUnk0487   = $0487 ; 3 bytes, sprite groups

    wUnk048A   = $048A

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

    wInputDelayCnt = $05F1
    wInputRaw = $05F2

    wUnk05F4   = $05F4

    wUnk06F0   = $06F0
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
