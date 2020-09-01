
    .include "include/layout.asm"

    .include "include/constants/misc.asm"

    .include "include/constants/pids.asm"
    .include "include/constants/jids.asm"
    .include "include/constants/iids.asm"
    .include "include/constants/maps.asm"
    .include "include/constants/terrains.asm"

    .include "include/structs/unit.asm"
    .include "include/structs/unk-03-A3DA.asm"

    .macro BASE_BANK args BANKID

        .if BANKID < 15
            .bank BANKID slot "ROM-LO"
        .endif

        .if BANKID == 15
            .bank BANKID slot "ROM-HI"
        .endif

        .if BANKID >= 16
            .bank BANKID slot "CHR"
        .endif

        .org 0

        .if BANKID < 16
            .incbin "fe1-base.nes" skip 16 + BANKID*$4000 read $4000
        .else
            .incbin "fe1-base.nes" skip 16 + (16*$4000) + ((BANKID-16)*$1000) read $1000
        .endif

    .endm

    ; WRAM

    .include "include/wram.asm"
    .include "include/sram.asm"

    ; Base ROM data

    ; PRG banks
    BASE_BANK 0
    BASE_BANK 1
    BASE_BANK 2
    BASE_BANK 3
    BASE_BANK 4
    BASE_BANK 5
    BASE_BANK 6
    BASE_BANK 7
    BASE_BANK 8
    BASE_BANK 9
    BASE_BANK 10
    BASE_BANK 11
    BASE_BANK 12
    BASE_BANK 13
    BASE_BANK 14
    BASE_BANK 15

    ; CHR banks
    BASE_BANK 16
    BASE_BANK 17
    BASE_BANK 18
    BASE_BANK 19
    BASE_BANK 20
    BASE_BANK 21
    BASE_BANK 22
    BASE_BANK 23
    BASE_BANK 24
    BASE_BANK 25
    BASE_BANK 26
    BASE_BANK 27
    BASE_BANK 28
    BASE_BANK 29
    BASE_BANK 30
    BASE_BANK 31
    BASE_BANK 32
    BASE_BANK 33
    BASE_BANK 34
    BASE_BANK 35
    BASE_BANK 36
    BASE_BANK 37
    BASE_BANK 38
    BASE_BANK 39
    BASE_BANK 40
    BASE_BANK 41
    BASE_BANK 42
    BASE_BANK 43
    BASE_BANK 44
    BASE_BANK 45
    BASE_BANK 46
    BASE_BANK 47

    ; DISASSEMBLED DATA

    .bank 0 slot "ROM-LO"

    .orga $8000
    /* 8000 */ .include "data/data-00-8000.asm"
    /* 9EF3 */ .include "code/code-00-9EF3.asm"
    /* A728 */ .include "code/code-00-A728.asm"
    /* ABC8 */ .include "code/code-00-ABC8.asm"
    /* B422 */ .include "code/code-00-B422.asm"

    .orga EVERYBANK_FARFUNCS
    .dw FUNC_00_9EF3
    .dw FUNC_00_A728
    .dw FUNC_00_ABC8
    .dw FUNC_00_B422

    .orga EVERYBANK_BFC0 ; far ppu transfer scr array
    .dw DATA_00_8E57

    .orga EVERYBANK_SPRITEGROUPS ; far ?
    .dw DATA_00_8000
    .dw DATA_00_8000
    .dw DATA_00_8000
    .dw DATA_00_8004
    .dw DATA_00_8000
    .dw DATA_00_8000
    .dw DATA_00_8000
    .dw DATA_00_8000
    .dw DATA_00_8012
    .dw DATA_00_8084
    .dw DATA_00_8000
    .dw DATA_00_8000

    .orga EVERYBANK_BFFA ; ?
    .dw DATA_00_8F9F

    .orga EVERYBANK_BFFC
    .dw DATA_00_8E57
    .dw DATA_00_8E6F

    .bank 1 slot "ROM-LO"

    .orga $8000
    /* 8000 */ .include "data/data-01-8000.asm"

    .bank 3 slot "ROM-LO"

    .orga $8000
    /* 8000 */ .include "code/code-03-8000.asm"

    .orga $8FDB
    /* 8FDB */ .include "code/func-03-8FDB.asm"

    .orga $9144
    /* 9144 */ .include "code/func-03-9144.asm"

    .orga $91D0
    /* 91D0 */ .include "code/load-reinforcements.asm"

    .bank 6 slot "ROM-LO"

    .orga $8000

    DAT_06_8000:
    /* 8000 */ ; map related data, 4 bytes for each id

    .bank 8 slot "ROM-LO"

    .orga $BA7A
    /* BA7A */ .include "code/load-units.asm"

    .orga EVERYBANK_FARFUNCS
    .dw FN0_BA7A
    .dw FN1_BA93
    .dw LoadMapPlayerUnits
    .dw LoadMapEnemyUnits

    .bank 11 slot "ROM-LO"

    .orga EVERYBANK_FARFUNCS
    /* BFA0 */ .dw $9251, $8000, $C7EA, $B039
    /* BFA8 */ .dw $9858, $995F, $9F16, $9D25
    /* BFB0 */ .dw $A291, $A3B0, $B369, $A01C
    /* BFB8 */ .dw $9D52

    .orga EVERYBANK_BFC0 ; far ppu transfer scr array
    /* BFC0 */ .dw $9EF0

    .orga EVERYBANK_BFE0 ; far ?
    /* BFE0 */ .dw $9D85, $A766

    .bank 15 slot "ROM-HI"

    .orga $C000
    .include "code/home/trampolines.asm"
    .include "code/home/code-C04E.asm"
    .include "code/home/interrupt.asm"
    .include "code/home/core.asm"
    .include "code/home/battle.asm"
    .include "code/home/map.asm"
    .include "data/item-data.asm"
    .include "data/data-0F-DA1F.asm"
    .include "code/home/code-E3CE.asm"
    .include "data/data-0F-E5F1.asm"
    .include "code/home/code-E65C.asm"
    .include "code/home/code-E6F5.asm"
    .include "data/data-0F-E828.asm"
    .include "data/job/stats.asm"
    .include "data/data-0F-ECF6.asm"
    .include "data/map-rows.asm"
    .include "data/data-0F-EDB5.asm"
    .include "code/home/unit.asm"
    .include "data/data-0F-F1BF.asm"
    .include "code/home/code-F28F.asm"

    .orga $F807
    .include "data/data-0F-F807.asm"

    .orga $FFA0
    .dw $8000
    .dw $8472
    .dw $84BC
    .dw $AA2B

    .orga $FFC0
    .dw $B44C
    .dw $FFF2

    .orga $FFE0
    .dw $84E4
    .dw $8853

    .orga $FFFA
    .dw ENTRY_NMI
    .dw ENTRY_RESET
    .dw ENTRY_IRQ
