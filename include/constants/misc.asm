
    ; this file contains misc constants for things that have no home yet

    ; IO Ports

    PPUCTRL   = $2000
    PPUMASK   = $2001
    PPUSTATUS = $2002
    OAMADDR   = $2003
    OAMDATA   = $2004
    PPUSCROLL = $2005
    PPUADDR   = $2006
    PPUDATA   = $2007

    OAMDMA    = $4014
    INPUT1    = $4016
    INPUT2    = $4017

    APUPULSE1A   = $4000
    APUPULSE1B   = $4001
    APUPULSE1C   = $4002
    APUPULSE1D   = $4003
    APUPULSE2A   = $4004
    APUPULSE2B   = $4005
    APUPULSE2C   = $4006
    APUPULSE2D   = $4007
    APUTRIANGLEA = $4008
    APUTRIANGLEB = $4009
    APUTRIANGLEC = $400A
    APUTRIANGLED = $400B
    APUNOISEA    = $400C
    APUNOISEB    = $400D
    APUNOISEC    = $400E
    APUNOISED    = $400F
    APUDMCA      = $4010
    APUDMCB      = $4011
    APUDMCC      = $4012
    APUDMCD      = $4013
    APUSTATUS    = $4015
    APUCLOCK     = $4017

    MMC4BANK   = $A000
    MMC4CHRLO1 = $B000
    MMC4CHRLO2 = $C000
    MMC4CHRHI1 = $D000
    MMC4CHRHI2 = $E000
    MMC4MIRROR = $F000

    PPUSTATUS.vblank   = $80
    PPUSTATUS.spr0_hit = $40
    PPUSTATUS.spr_lost = $20

    ; PPU Memory

    PPU_NT0   = $2000
    PPU_NT1   = $2400
    PPU_NT2   = $2800
    PPU_NT3   = $2C00

    ; Other constants

    SCREEN_TILE_W = 32
    SCREEN_TILE_H = 30

    UNK_E828_1F = $1F

    TERRAIN_ALLY = $0E
    TERRAIN_ENEMY = $1F

    MAP_ROW_COUNT      = $1E
    MAP_ROW_MAX_LENGTH = $20

    EVERYBANK_FARFUNCS = $BFA0
    EVERYBANK_BFC0 = $BFC0
    EVERYBANK_SPRITEGROUPS = $BFD0
    EVERYBANK_BFE0 = $BFE0
    EVERYBANK_BFFA = $BFFA
    EVERYBANK_BFFC = $BFFC
