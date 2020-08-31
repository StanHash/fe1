
LOC_C000:
    /* C000 A9 05    */ lda #$05
    /* C002 20 A6 C9 */ jsr SwapBank

    /* C005 20 A0 BF */ jsr $BFA0

    /* C008 A9 06    */ lda #$06
    /* C00A 4C A6 C9 */ jmp SwapBank

LOC_C00D:
    /* C00D A9 03    */ lda #:CODE_03_8000
    /* C00F 20 A6 C9 */ jsr SwapBank

    /* C012 20 00 80 */ jsr CODE_03_8000

    /* C015 A9 06    */ lda #$06
    /* C017 4C A6 C9 */ jmp SwapBank

LOC_C01A:
    /* C01A A9 03    */ lda #:CODE_03_8003
    /* C01C 20 A6 C9 */ jsr SwapBank

    /* C01F 20 03 80 */ jsr CODE_03_8003

    /* C022 A9 06    */ lda #$06
    /* C024 4C A6 C9 */ jmp SwapBank

LOC_C027:
    /* C027 A9 03    */ lda #:CODE_03_8006
    /* C029 20 A6 C9 */ jsr SwapBank

    /* C02C 20 06 80 */ jsr CODE_03_8006

    /* C02F A9 06    */ lda #$06
    /* C031 4C A6 C9 */ jmp SwapBank

LOC_C034:
    /* C034 A9 0D    */ lda #$0D
    /* C036 20 A6 C9 */ jsr SwapBank

    /* C039 20 00 80 */ jsr $8000

    /* C03C A9 06    */ lda #$06
    /* C03E 4C A6 C9 */ jmp SwapBank

LOC_C041:
    /* C041 A9 03    */ lda #:CODE_03_8009
    /* C043 20 A6 C9 */ jsr SwapBank

    /* C046 20 09 80 */ jsr CODE_03_8009

    /* C049 A9 06    */ lda #$06
    /* C04B 4C A6 C9 */ jmp SwapBank
