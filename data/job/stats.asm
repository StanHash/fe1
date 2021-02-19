
JobStats:
    .word @CavalierStats ; 0
    .word @KnightStats ; 1
    .word @PegasusStats ; 2
    .word @PaladinStats ; 3
    .word @DracoknightStats ; 4
    .word @SwordfighterStats ; 5
    .word @AxefighterStats ; 6
    .word @PirateStats ; 7
    .word @ThiefStats ; 8
    .word @HeroStats ; 9
    .word @ArcherStats ; 10
    .word @HunterStats ; 11
    .word @BallisticianStats ; 12
    .word @HorsemanStats ; 13
    .word @SniperStats ; 14
    .word @CommandoStats ; 15
    .word @ManaketeStats ; 16
    .word @MageStats ; 17
    .word @PriestStats ; 18
    .word @BishopStats ; 19
    .word @LordStats ; 20
    .word @GeneralStats ; 21

;                        str skl wlv spd lck def mov  hp
@CavalierStats:     .byte  5,  2,  8,  6,  0,  7,  9, 16, $1E
@KnightStats:       .byte  5,  1,  7,  3,  0, 11,  5, 16, $20
@PegasusStats:      .byte  4,  5,  9, 11,  0,  6,  8, 16, $24
@PaladinStats:      .byte  8,  7, 10, 11,  0,  9, 10, 22, $2C
@DracoknightStats:  .byte  9,  3, 10,  6,  0, 14, 10, 22, $2C
@SwordfighterStats: .byte  4,  8,  8, 10,  0,  5,  7, 16, $1C
@AxefighterStats:   .byte  5,  1,  4,  7,  0,  4,  6, 18, $18
@PirateStats:       .byte  5,  1,  5,  6,  0,  4,  6, 18, $18
@ThiefStats:        .byte  3,  1,  2,  9,  0,  2,  7, 16, $28
@HeroStats:         .byte  8, 14, 10, 14,  0,  8,  7, 24, $2E
@ArcherStats:       .byte  4,  1,  9,  4,  0,  5,  5, 16, $1C
@HunterStats:       .byte  6,  1,  5,  5,  0,  3,  6, 18, $1A
@BallisticianStats: .byte  5,  1,  8,  3,  0, 14,  4, 20, $26
@HorsemanStats:     .byte  4,  1,  3,  7,  0,  4,  9, 16, $1E
@SniperStats:       .byte  7, 10, 10, 14,  0,  7,  7, 24, $2A
@CommandoStats:     .byte  1,  1,  2, 10,  0,  4,  6, 16, $28
@ManaketeStats:     .byte  1,  1,  7,  1,  0,  3,  6, 18, $2A
@MageStats:         .byte  1,  1,  7,  5,  0,  3,  6, 16, $20
@PriestStats:       .byte  1,  1,  7,  1,  0,  3,  5, 16, $1E
@BishopStats:       .byte  3,  1, 10, 14,  0,  8,  6, 22, $2C
@LordStats:         .byte  5,  3,  5,  7,  7,  7,  7, 18, $00
@GeneralStats:      .byte  9,  1, 13,  4,  0, 14,  5, 28, $32
;                        str skl wlv spd lck def mov  hp
