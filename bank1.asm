
    .feature c_comments

    .segment "BANK_01"

    .include "data/data-01-8000.asm"
    .include "code/code-01-B8CB.asm"

    .segment "BANK_01_FARFUNCS"

    .word FUNC_01_B8CB
    .word FUNC_01_B963

    .segment "BANK_01_BFC0"

    .word DATA_01_A590

    .segment "BANK_01_FARSPRITES"

    .word DATA_01_8000
    .word DATA_01_801C
    .word DATA_01_804A
    .word DATA_01_806C
    .word DATA_01_8096
    .word DATA_01_80BE
    .word DATA_01_A590
    .word DATA_01_A5B2
    .word DATA_01_A5D4
    .word DATA_01_80DC
    .word DATA_01_80F4
    .word DATA_01_80F4

    .segment "BANK_01_BFFA"

    .word DATA_01_AADE
    .word DATA_01_A942
    .word DATA_01_A95A
