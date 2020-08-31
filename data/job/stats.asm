
JobStats:
    .dw @CavalierStats ; 0
    .dw @KnightStats ; 1
    .dw @PegasusStats ; 2
    .dw @PaladinStats ; 3
    .dw @DracoknightStats ; 4
    .dw @SwordfighterStats ; 5
    .dw @AxefighterStats ; 6
    .dw @PirateStats ; 7
    .dw @ThiefStats ; 8
    .dw @HeroStats ; 9
    .dw @ArcherStats ; 10
    .dw @HunterStats ; 11
    .dw @BallisticianStats ; 12
    .dw @HorsemanStats ; 13
    .dw @SniperStats ; 14
    .dw @CommandoStats ; 15
    .dw @ManaketeStats ; 16
    .dw @MageStats ; 17
    .dw @PriestStats ; 18
    .dw @BishopStats ; 19
    .dw @LordStats ; 20
    .dw @GeneralStats ; 21

;                      str skl wlv spd lck def mov  hp
@CavalierStats:     .db  5,  2,  8,  6,  0,  7,  9, 16, $1E
@KnightStats:       .db  5,  1,  7,  3,  0, 11,  5, 16, $20
@PegasusStats:      .db  4,  5,  9, 11,  0,  6,  8, 16, $24
@PaladinStats:      .db  8,  7, 10, 11,  0,  9, 10, 22, $2C
@DracoknightStats:  .db  9,  3, 10,  6,  0, 14, 10, 22, $2C
@SwordfighterStats: .db  4,  8,  8, 10,  0,  5,  7, 16, $1C
@AxefighterStats:   .db  5,  1,  4,  7,  0,  4,  6, 18, $18
@PirateStats:       .db  5,  1,  5,  6,  0,  4,  6, 18, $18
@ThiefStats:        .db  3,  1,  2,  9,  0,  2,  7, 16, $28
@HeroStats:         .db  8, 14, 10, 14,  0,  8,  7, 24, $2E
@ArcherStats:       .db  4,  1,  9,  4,  0,  5,  5, 16, $1C
@HunterStats:       .db  6,  1,  5,  5,  0,  3,  6, 18, $1A
@BallisticianStats: .db  5,  1,  8,  3,  0, 14,  4, 20, $26
@HorsemanStats:     .db  4,  1,  3,  7,  0,  4,  9, 16, $1E
@SniperStats:       .db  7, 10, 10, 14,  0,  7,  7, 24, $2A
@CommandoStats:     .db  1,  1,  2, 10,  0,  4,  6, 16, $28
@ManaketeStats:     .db  1,  1,  7,  1,  0,  3,  6, 18, $2A
@MageStats:         .db  1,  1,  7,  5,  0,  3,  6, 16, $20
@PriestStats:       .db  1,  1,  7,  1,  0,  3,  5, 16, $1E
@BishopStats:       .db  3,  1, 10, 14,  0,  8,  6, 22, $2C
@LordStats:         .db  5,  3,  5,  7,  7,  7,  7, 18, $00
@GeneralStats:      .db  9,  1, 13,  4,  0, 14,  5, 28, $32
;                      str skl wlv spd lck def mov  hp
