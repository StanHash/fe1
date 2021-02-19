    .ifndef GLOBAL_INC
    GLOBAL_INC = 1

    ; common

    FarFuncs        := $BFA0
    EVERYBANK_BFC0  := $BFC0
    FarSpriteGroups := $BFD0
    EVERYBANK_BFE0  := $BFE0

    EVERYBANK_BFFA  := $BFFA
    EVERYBANK_BFFC  := $BFFC

    ; bank 2

    DATA_02_8000 := $8000

    ; bank 3

    CODE_03_8000 := $8000
    CODE_03_8003 := $8003
    CODE_03_8006 := $8006
    CODE_03_8009 := $8009

    ; bank 6

    DATA_06_8000 := $8000

    ; bank 9

    DATA_09_8000 := $8000

    ; home

    .global LOC_C000
    .global LOC_C00D
    .global LOC_C01A
    .global LOC_C027
    .global LOC_C034
    .global LOC_C041

    .global Rand
    .global RandBounded

    .global Reset
    .global Nmi

    .global MemCopy
    .global MemFill
    .global ClearNameTables
    .global ClearOamBuf
    .global FUNC_C296
    .global UpdateInput
    .global FUNC_C336
    .global Switch
    .global ApplyPPUScroll
    .global IncR00ByY
    .global IncR00ByA
    .global IncR02ByY
    .global IncR02ByA
    .global IncR04ByY
    .global IncR04ByA
    .global Lsr5
    .global Lsr4
    .global Lsr3
    .global Asl5
    .global Asl4
    .global Asl3
    .global FUNC_C3A5
    .global BatchPPUTransfer
    .global PutTransferWTsa
    .global PutTransferRTsa
    .global PutTransferByte
    .global EndTransfer
    .global FUNC_C509
    .global GetScreenTilePPUAddr
    .global FUNC_C57D
    .global Neg
    .global SplitNibbles
    .global SplitByteDecDigits
    .global SplitLongDecDigits
    .global FUNC_C677
    .global FUNC_C698
    .global FUNC_C6BA
    .global Mul
    .global Div
    .global WaitFrame
    .global WaitForTransfer
    .global SetApplyDisableDisplay
    .global SetApplyPPUMask
    .global SetApplyEnableDisplay
    .global ApplyPPUControls
    .global CaseRet
    .global ClearDisableDisplay
    .global FUNC_C753
    .global FUNC_C764
    .global SetApplyDisableNmi
    .global SetApplyPPUControl
    .global SetApplyEnableNmi
    .global FUNC_C78A
    .global FUNC_C795
    .global FUNC_C7BA
    .global FUNC_C7EA
    .global FUNC_C81C
    .global FUNC_C842
    .global FUNC_C8CD
    .global GetMapSquare
    .global SwapBank
    .global SwapLoChrBankA
    .global SwapLoChrBankB
    .global SwapHiChrBankA
    .global SwapHiChrBankB
    .global SetMirrorH
    .global SetMirrorV
    .global FUNC_C9DE
    .global CallFarFunc
    .global PutSprite

    .global FUNC_CAAA
    .global FUNC_CB46
    .global FUNC_CB73
    .global ComputeFightStats
    .global FUNC_CBCF
    .global ComputeFightHit
    .global ComputeFightSpeed
    .global ComputeFightDamage
    .global ComputeFightDefense
    .global ComputeFightCrit
    .global ComputeFightDodge
    .global RollFightHits
    .global FUNC_CDA9
    .global RollFightCrits
    .global RollFightDevilEffect
    .global FUNC_CE62
    .global SwapBattlerIdY
    .global SwapBattlerIdX
    .global Rand100
    .global FUNC_CEA2
    .global FUNC_CEC1
    .global FUNC_CF11
    .global FUNC_CF2F
    .global FUNC_CF45
    .global FUNC_CF4C
    .global FUNC_CFB2
    .global FUNC_CFC6
    .global FUNC_CFEF
    .global GetBattlerStatPointers
    .global FightCheckForLevelGain
    .global CheckMercuriusStatGainBonus
    .global FUNC_D137
    .global FUNC_D156
    .global FUNC_D2AA
    .global FUNC_D2C7
    .global IsEffective
    .global FUNC_D321

    .global FUNC_D358
    .global UnpackMap
    .global FUNC_D419
    .global FUNC_D444
    .global FUNC_D469
    .global FUNC_D484
    .global GetMapRowIn6A
    .global FUNC_D4AD
    .global FUNC_D4E7
    .global FUNC_D50B
    .global FUNC_D53A
    .global FUNC_D558
    .global FUNC_D56B
    .global FUNC_D573
    .global FUNC_D57B
    .global FUNC_D595
    .global FUNC_D5B2
    .global FUNC_D5CC
    .global FUNC_D603
    .global FUNC_D635
    .global FUNC_D648
    .global FUNC_D64A

    .global ItemMightTable
    .global ItemWeaponLevelTable
    .global ItemWeightTable
    .global ItemHitTable
    .global ItemCritTable
    .global ItemCostTable
    .global ItemUsesTable
    .global ItemEffectivenessTable
    .global EffectivenessInfo
    .global ItemEffectTable
    .global ItemUnkTable_D9C3

    .global CharacterGrowthTable

    .global FUNC_E3CE
    .global FUNC_E3E8
    .global FUNC_E56C
    .global FUNC_E5CF

    .global FUNC_E65C
    .global FUNC_E66E
    .global FUNC_E684
    .global FUNC_E690
    .global FUNC_E69C
    .global FUNC_E6B2

    .global FUNC_E6F5
    .global FUNC_E70C
    .global PutFarSprite

    .global Cell2TerrainBlue
    .global Cell2TerrainRed
    .global JobMoveCosts
    .global DAT_EBD8

    .global JobStats

    .global DAT_ECF6

    .global MapMovementRows
    .global MapCellRows
    .global MapRows2

    .global DAT_EDB5

    .global FindUnitByPid
    .global FindPlayerUnitAt
    .global FindEnemyUnitAt
    .global GetPlayerUnitsInR00
    .global GetEnemyUnitsInR00
    .global FUNC_F123
    .global FUNC_F146
    .global FUNC_F167
    .global FUNC_F181
    .global FUNC_F187
    .global FUNC_F18D
    .global FUNC_F193
    .global FUNC_F199
    .global FUNC_F19F

    .global DAT_F1BF

    .global FUNC_F28F

    ; assertions

    .endif ; GLOBAL_INC
