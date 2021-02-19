
    .feature c_comments

    .segment "BANK_00"

    .include "data/data-00-8000.asm"
    .include "code/code-00-9EF3.asm"
    .include "code/code-00-A728.asm"
    .include "code/code-00-ABC8.asm"
    .include "code/code-00-B422.asm"

    .segment "BANK_00_FARFUNCS"

    .word FUNC_00_9EF3
    .word FUNC_00_A728
    .word FUNC_00_ABC8
    .word FUNC_00_B422

    .segment "BANK_00_BFC0" ; far ppu transfer scr array

    .word DATA_00_8E57

    .segment "BANK_00_FARSPRITES"

    .word DATA_00_8000
    .word DATA_00_8000
    .word DATA_00_8000
    .word DATA_00_8004
    .word DATA_00_8000
    .word DATA_00_8000
    .word DATA_00_8000
    .word DATA_00_8000
    .word DATA_00_8012
    .word DATA_00_8084
    .word DATA_00_8000
    .word DATA_00_8000

    .segment "BANK_00_BFFA"

    .word DATA_00_8F9F
    .word DATA_00_8E57
    .word DATA_00_8E6F
