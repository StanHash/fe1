
FUNC_F28F:
    /* F28F A9 00    */ lda #0
    /* F291 85 37    */ sta zSpriteIt

    /* F293 A5 23    */ lda zUnk23
    /* F295 F0 03    */ beq @LOC_F29A

    /* F297 4C 9D F2 */ jmp @LOC_F29D

@LOC_F29A:
    /* F29A 4C 00 84 */ jmp $8400

@LOC_F29D:
    /* F29D 20 88 C2 */ jsr ClearOamBuf

    /* F2A0 A5 25    */ lda zUnk25
    /* F2A2 20 4C C3 */ jsr Switch

    /* F2A5 ...      */ .dw LOC_C034  ; 0
    /* F2A7 ...      */ .dw @LOC_F2CB ; 1
    /* F2A9 ...      */ .dw @LOC_F2D8 ; 2
    /* F2AB ...      */ .dw CaseRet   ; 3
    /* F2AD ...      */ .dw @LOC_F323 ; 4
    /* F2AF ...      */ .dw @LOC_F32A ; 5

    /* F2B1 4C 34 C0 */ jmp LOC_C034

    /* F2B4 A9 04    */ lda #4
    /* F2B6 85 25    */ sta zUnk25

    /* F2B8 A9 30    */ lda #<sUnk7730
    /* F2BA 85 00    */ sta zR00
    /* F2BC A9 77    */ lda #>sUnk7730
    /* F2BE 85 01    */ sta zR00+1

    /* F2C0 A9 BF    */ lda #<$00BF
    /* F2C2 85 02    */ sta zR02
    /* F2C4 A9 00    */ lda #>$00BF
    /* F2C6 85 03    */ sta zR02+1

    ; lda #0 ; implied

    /* F2C8 4C 25 C2 */ jmp MemFill

@LOC_F2CB:
    /* F2CB A9 02    */ lda #$02
    /* F2CD 20 A6 C9 */ jsr SwapBank

    /* F2D0 20 FA BF */ jsr $BFFA

    /* F2D3 A9 06    */ lda #$06
    /* F2D5 4C A6 C9 */ jmp SwapBank

@LOC_F2D8:
    /* F2D8 AE 80 07 */ ldx wTransferCnt

    /* F2DB A9 20    */ lda #>PPU_NT0
    /* F2DD 20 A2 C4 */ jsr PutTransferByte

    /* F2E0 A9 00    */ lda #<PPU_NT0
    /* F2E2 20 A2 C4 */ jsr PutTransferByte

    /* F2E5 A9 01    */ lda #1
    /* F2E7 20 A2 C4 */ jsr PutTransferByte

    /* F2EA A9 FF    */ lda #$FF
    /* F2EC 20 A2 C4 */ jsr PutTransferByte

    /* F2EF A9 00    */ lda #0
    /* F2F1 20 A2 C4 */ jsr PutTransferByte

    /* F2F4 8E 80 07 */ stx wTransferCnt

    /* F2F7 E6 21    */ inc zTransferEnable

    /* F2F9 A9 10    */ lda #$10

    /* F2FB 85 98    */ sta zUnk98
    /* F2FD 85 8B    */ sta zUnk8B
    /* F2FF 8D 0D 05 */ sta wUnk050D

    /* F302 A9 00    */ lda #0

    /* F304 85 23    */ sta zUnk23
    /* F306 85 24    */ sta zUnk24
    /* F308 85 84    */ sta zUnk84
    /* F30A 85 26    */ sta zUnk26
    /* F30C 8D DB 05 */ sta wUnk05DB
    /* F30F 8D CC 05 */ sta wUnk05CC
    /* F312 8D CD 05 */ sta wUnk05CD
    /* F315 8D CE 05 */ sta wUnk05CE
    /* F318 85 5D    */ sta zUnk5D
    /* F31A 8D ED 76 */ sta sUnk76ED

    /* F31D A9 01    */ lda #1
    /* F31F 8D F0 06 */ sta wUnk06F0

    /* F322 60       */ rts

@LOC_F323:
    /* F323 A9 04    */ lda #$04
    /* F325 85 44    */ sta zFarFuncId
    /* F327 4C FA C9 */ jmp CallFarFunc

@LOC_F32A:
    /* F32A AD F4 05 */ lda wUnk05F4
    /* F32D F0 09    */ beq @LOC_F338

    /* F32F A9 02    */ lda #$02
    /* F331 85 44    */ sta zFarFuncId
    /* F333 A9 04    */ lda #$04
    /* F335 4C FA C9 */ jmp CallFarFunc

@LOC_F338:
    /* F338 A9 0A    */ lda #$0A
    /* F33A 85 44    */ sta zFarFuncId
    /* F33C A9 0B    */ lda #$0B
    /* F33E 4C FA C9 */ jmp CallFarFunc
