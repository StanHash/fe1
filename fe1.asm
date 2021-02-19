
    ; ===============
    ; = iNES HEADER =
    ; ===============

    .segment "HEADER"

    .byte "NES", $1A
    .byte 16        ; 16 * 16KiB PRG ROM
    .byte 16        ; 16 * 8KiB CHR ROM
    .byte $A2       ; Mapper 10 (MMC4); horizontal or vertical mirroring respectively
    .byte $00       ; Mapper 10 (MMC4); no NES 2.0

    ; ====================
    ; = BASE ROM INCBINS =
    ; ====================

    .macro base_prg_bank id
    .incbin "fe1-base.nes", $10+(id)*$4000, $4000
    .endmacro

    .segment "PRG_01"
    base_prg_bank 1

    .segment "PRG_02"
    base_prg_bank 2

    .segment "PRG_03"
    base_prg_bank 3

    .segment "PRG_04"
    base_prg_bank 4

    .segment "PRG_05"
    base_prg_bank 5

    .segment "PRG_06"
    base_prg_bank 6

    .segment "PRG_07"
    base_prg_bank 7

    .segment "PRG_08"
    base_prg_bank 8

    .segment "PRG_09"
    base_prg_bank 9

    .segment "PRG_0A"
    base_prg_bank 10

    .segment "PRG_0B"
    base_prg_bank 11

    .segment "PRG_0C"
    base_prg_bank 12

    .segment "PRG_0D"
    base_prg_bank 13

    .segment "PRG_0E"
    base_prg_bank 14

    .macro base_chr_bank id
    .incbin "fe1-base.nes", $40010+(id)*$1000, $1000
    .endmacro

    .segment "CHR_00"
    base_chr_bank 0

    .segment "CHR_01"
    base_chr_bank 1

    .segment "CHR_02"
    base_chr_bank 2

    .segment "CHR_03"
    base_chr_bank 3

    .segment "CHR_04"
    base_chr_bank 4

    .segment "CHR_05"
    base_chr_bank 5

    .segment "CHR_06"
    base_chr_bank 6

    .segment "CHR_07"
    base_chr_bank 7

    .segment "CHR_08"
    base_chr_bank 8

    .segment "CHR_09"
    base_chr_bank 9

    .segment "CHR_0A"
    base_chr_bank 10

    .segment "CHR_0B"
    base_chr_bank 11

    .segment "CHR_0C"
    base_chr_bank 12

    .segment "CHR_0D"
    base_chr_bank 13

    .segment "CHR_0E"
    base_chr_bank 14

    .segment "CHR_0F"
    base_chr_bank 15

    .segment "CHR_10"
    base_chr_bank 16

    .segment "CHR_11"
    base_chr_bank 17

    .segment "CHR_12"
    base_chr_bank 18

    .segment "CHR_13"
    base_chr_bank 19

    .segment "CHR_14"
    base_chr_bank 20

    .segment "CHR_15"
    base_chr_bank 21

    .segment "CHR_16"
    base_chr_bank 22

    .segment "CHR_17"
    base_chr_bank 23

    .segment "CHR_18"
    base_chr_bank 24

    .segment "CHR_19"
    base_chr_bank 25

    .segment "CHR_1A"
    base_chr_bank 26

    .segment "CHR_1B"
    base_chr_bank 27

    .segment "CHR_1C"
    base_chr_bank 28

    .segment "CHR_1D"
    base_chr_bank 29

    .segment "CHR_1E"
    base_chr_bank 30

    .segment "CHR_1F"
    base_chr_bank 31
