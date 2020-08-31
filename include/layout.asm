
    .memorymap
        defaultslot 2

        slotsize $0800
        slot 0 $0000 "RAM"

        slotsize $2000
        slot 1 $6000 "SRAM"

        slotsize $4000
        slot 2 $8000 "ROM-LO" ; banks 0-14
        slot 3 $C000 "ROM-HI" ; bank 15

        slotsize $1000
        slot 4 $2000 "CHR" ; banks 16-47
    .endme

    .rombankmap
        bankstotal 48

        ; PRG-ROM banks
        banksize $4000
        banks 16

        ; CHR-ROM banks
        banksize $1000
        banks 32
    .endro
