
    .feature c_comments

    .segment "HOME"

    .include "code/home/trampolines.asm"
    .include "code/home/rand.asm"
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

    .segment "DATA_0F_F807"

    .include "data/data-0F-F807.asm"

    .segment "HOME_FARINFO"

    .align $10 ; $?FA0
    .word $8000
    .word $8472
    .word $84BC
    .word $AA2B

    .align $10 ; $?FB0
    .word $FFFF

    .align $10 ; $?FC0
    .word $B44C
    .word $FFF2

    .align $10 ; $?FD0
    .word $FFFF

    .align $10 ; $?FE0
    .word $84E4
    .word $8853

    .segment "VECTORS"

    .word Nmi
    .word Reset
    .word Reset ; Irq (unused)
