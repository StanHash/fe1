
ENTRY_IRQ:
ENTRY_RESET:
    /* C075 78       */ sei
    /* C076 D8       */ cld

    ; Initialize PPU?

    /* C077 A2 00    */ ldx #0
    /* C079 8E 00 20 */ stx PPUCTRL
    /* C07C 8E 01 20 */ stx PPUMASK

-:
    /* C07F AD 02 20 */ lda PPUSTATUS
    /* C082 10 FB    */ bpl -

-:
    /* C084 AD 02 20 */ lda PPUSTATUS
    /* C087 10 FB    */ bpl -

    ; Initialize SP

    /* C089 CA       */ dex
    /* C08A 9A       */ txs

    ; ?

    /* C08B A9 00    */ lda #0
    /* C08D 85 59    */ sta zChr59
    /* C08F 85 5A    */ sta zChr5A
    /* C091 85 5B    */ sta zChr5B
    /* C093 85 5C    */ sta zChr5C

    ; Zeroing out WRAM

    /* C095 A0 07    */ ldy #>$0700
    /* C097 84 01    */ sty zR00+1
    /* C099 A0 00    */ ldy #<$0700
    /* C09B 84 00    */ sty zR00

    /* C09D 98       */ tya ; lda #0

-:
    /* C09E 91 00    */ sta (zR00), Y
    /* C0A0 C8       */ iny
    /* C0A1 D0 FB    */ bne -

    /* C0A3 C6 01    */ dec zR00+1
    /* C0A5 10 F7    */ bpl -

    /* C0A7 A0 00    */ ldy #0
    /* C0A9 84 CB    */ sty zPPUSCROLLH
    /* C0AB 84 CA    */ sty zPPUSCROLLV
    /* C0AD 84 1F    */ sty zUnk1F
    /* C0AF 84 1E    */ sty zUnk1E
    /* C0B1 8C 05 20 */ sty PPUSCROLL
    /* C0B4 8C 05 20 */ sty PPUSCROLL
    /* C0B7 84 59    */ sty zChr59
    /* C0B9 84 5A    */ sty zChr5A
    /* C0BB 84 5B    */ sty zChr5B
    /* C0BD 84 5C    */ sty zChr5C
    /* C0BF 84 25    */ sty zUnk25
    /* C0C1 84 24    */ sty zUnk24
    /* C0C3 84 22    */ sty zUnk22
    /* C0C5 8C 80 07 */ sty wTransferCnt
    /* C0C8 8C 81 07 */ sty wTransferScr
    /* C0CB 84 21    */ sty zTransferEnable
    /* C0CD 84 57    */ sty zUnk57
    /* C0CF 84 58    */ sty zUnk58
    /* C0D1 84 97    */ sty zUnk97
    /* C0D3 C8       */ iny
    /* C0D4 84 23    */ sty zUnk23
    /* C0D6 8C C4 05 */ sty wUnk05C4
    /* C0D9 A0 FF    */ ldy #$FF
    /* C0DB 8D C6 05 */ sta wUnk05C6

    /* C0DE A9 00    */ lda #$00
    /* C0E0 8D 10 40 */ sta APUDMCA
    /* C0E3 8D 11 40 */ sta APUDMCB
    /* C0E6 8D 15 40 */ sta APUSTATUS
    /* C0E9 A9 0F    */ lda #$0F
    /* C0EB 8D 15 40 */ sta APUSTATUS
    /* C0EE A9 C0    */ lda #$C0
    /* C0F0 8D 17 40 */ sta APUCLOCK
    /* C0F3 A9 10    */ lda #$10
    /* C0F5 8D 00 40 */ sta APUPULSE1A
    /* C0F8 8D 04 40 */ sta APUPULSE2A
    /* C0FB 8D 0C 40 */ sta APUNOISEA
    /* C0FE A9 00    */ lda #$00
    /* C100 8D 08 40 */ sta APUTRIANGLEA

    ; 2C33 stuff?
    /* C103 A9 80    */ lda #$80
    /* C105 8D 00 20 */ sta PPUCTRL
    /* C108 8D 23 40 */ sta $4023
    /* C10B A9 03    */ lda #$03
    /* C10D 8D 23 40 */ sta $4023
    /* C110 A9 E8    */ lda #$E8
    /* C112 8D 8A 40 */ sta $408A
    /* C115 A9 80    */ lda #$80
    /* C117 8D 80 40 */ sta $4080

    /* C11A 20 3D C2 */ jsr ClearNameTables

    /* C11D 20 88 C2 */ jsr ClearOamBuf

    /* C120 20 D6 C9 */ jsr SetMirrorV

    /* C123 A9 90    */ lda #$90
    /* C125 8D 00 20 */ sta PPUCTRL
    /* C128 85 CD    */ sta zPPUCTRL
    /* C12A A9 02    */ lda #$02
    /* C12C 8D 01 20 */ sta PPUMASK
    /* C12F 85 CC    */ sta zPPUMASK

    /* C131 A9 06    */ lda #$06
    /* C133 20 A6 C9 */ jsr SwapBank

    /* C136 A5 61    */ lda zUnk61
    /* C138 F0 04    */ beq @LOC_C13E

    /* C13A A9 01    */ lda #1
    /* C13C 85 61    */ sta zUnk61

@LOC_C13E:
    /* C13E 20 7D C7 */ jsr SetApplyEnableNmi

    /* C141 4C 56 C1 */ jmp @wait_frame

@lop:
    /* C144 A9 00    */ lda #0
    /* C146 85 D0    */ sta zUnkD0
    /* C148 20 8F F2 */ jsr FUNC_F28F

    /* C14B 20 36 C3 */ jsr FUNC_C336

    /* C14E E6 30    */ inc zUnk30
    /* C150 A9 00    */ lda #0
    /* C152 85 20    */ sta zFrameEnded
    /* C154 85 D0    */ sta zUnkD0

@wait_frame:
    /* C156 A5 20    */ lda zFrameEnded
    /* C158 D0 03    */ bne @continue

    /* C15A 4C 56 C1 */ jmp @wait_frame

@continue:
    /* C15D 20 4E C0 */ jsr Rand

    /* C160 4C 44 C1 */ jmp @lop

ENTRY_NMI:
    /* C163 08       */ php
    /* C164 48       */ pha
    /* C165 8A       */ txa
    /* C166 48       */ pha
    /* C167 98       */ tya
    /* C168 48       */ pha

    /* C169 A9 00    */ lda #0
    /* C16B 8D 03 20 */ sta OAMADDR
    /* C16E A9 02    */ lda #>wOamBuf
    /* C170 8D 14 40 */ sta OAMDMA

    /* C173 A5 00    */ lda zR00
    /* C175 48       */ pha
    /* C176 A5 01    */ lda zR01
    /* C178 48       */ pha

    /* C179 20 A5 C3 */ jsr FUNC_C3A5

    /* C17C 20 96 C2 */ jsr FUNC_C296

    /* C17F 20 EC C1 */ jsr FUNC_C1EC

    /* C182 20 AD D4 */ jsr FUNC_D4AD

    /* C185 20 33 C7 */ jsr ApplyPPUControls

    /* C188 20 6A C3 */ jsr ApplyPPUScroll

    /* C18B 20 C4 C1 */ jsr FUNC_C1C4

    /* C18E 20 FB C1 */ jsr FUNC_C1FB

    /* C191 20 D9 C2 */ jsr UpdateInput

    /* C194 A0 01    */ ldy #1
    /* C196 84 20    */ sty zFrameEnded

    /* C198 68       */ pla
    /* C199 85 01    */ sta zR01
    /* C19B 68       */ pla
    /* C19C 85 00    */ sta zR00

    /* C19E A5 D0    */ lda $D0
    /* C1A0 F0 1B    */ beq @end

    /* C1A2 AD 7B 04 */ lda $047B
    /* C1A5 F0 16    */ beq @end

@spr0_wait:
    /* C1A7 AD 02 20 */ lda PPUSTATUS
    /* C1AA 29 40    */ and #PPUSTATUS.spr0_hit
    /* C1AC D0 F9    */ bne @spr0_wait

@spr0_wait2:
    /* C1AE AD 02 20 */ lda PPUSTATUS
    /* C1B1 29 40    */ and #PPUSTATUS.spr0_hit
    /* C1B3 F0 F9    */ beq @spr0_wait2

    /* C1B5 A9 00    */ lda #0
    /* C1B7 8D 00 D0 */ sta MMC4CHRHI1
    /* C1BA 8D 00 E0 */ sta MMC4CHRHI2

@end:
    /* C1BD 68       */ pla
    /* C1BE A8       */ tay
    /* C1BF 68       */ pla
    /* C1C0 AA       */ tax
    /* C1C1 68       */ pla
    /* C1C2 28       */ plp
    /* C1C3 40       */ rti

FUNC_C1C4:
    /* C1C4 A5 97    */ lda zUnk97
    /* C1C6 D0 1B    */ bne @end

    /* C1C8 C6 98    */ dec zUnk98
    /* C1CA D0 17    */ bne @end

    /* C1CC A4 99    */ ldy zUnk99
    /* C1CE C8       */ iny
    /* C1CF 98       */ tya
    /* C1D0 29 03    */ and #$3
    /* C1D2 A8       */ tay
    /* C1D3 84 99    */ sty zUnk99

    /* C1D5 B9 E8 C1 */ lda @duration_lut.w, Y
    /* C1D8 85 98    */ sta zUnk98

    /* C1DA B9 E4 C1 */ lda @chr_bank_lut.w, Y

    /* C1DD 20 BE C9 */ jsr SwapHiChrBankA
    /* C1E0 4C C6 C9 */ jmp SwapHiChrBankB

@end:
    /* C1E3 60       */ rts

@chr_bank_lut: .db $18, $19, $15, $19
@duration_lut: .db  14,   8,  14,   8

FUNC_C1EC:
    /* C1EC A5 5D    */ lda zUnk5D
    /* C1EE F0 0A    */ beq @end

    /* C1F0 A5 5E    */ lda zUnk5E
    /* C1F2 8D 00 D0 */ sta MMC4CHRHI1

    /* C1F5 A5 5F    */ lda zUnk5F
    /* C1F7 8D 00 E0 */ sta MMC4CHRHI2

@end:
    /* C1FA 60       */ rts

FUNC_C1FB:
    /* C1FB A9 0E    */ lda #$0E
    /* C1FD 8D 00 A0 */ sta MMC4BANK

    /* C200 20 00 80 */ jsr $8000

    /* C203 A5 29    */ lda zBank29
    /* C205 8D 00 A0 */ sta MMC4BANK

    /* C208 60       */ rts
