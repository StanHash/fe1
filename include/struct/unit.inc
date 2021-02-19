    .ifndef STRUCT_UNIT_INC
    STRUCT_UNIT_INC = 1

    UNIT_ITEM_COUNT = 4

    .struct Unit

    pid     .byte ; +00
    jid     .byte ; +01
    level   .byte ; +02
    hp_cur  .byte ; +03
    hp_max  .byte ; +04
    exp     .byte ; +05
    cell    .byte ; +06
    str     .byte ; +07
    skl     .byte ; +08
    wlv     .byte ; +09
    spd     .byte ; +0A
    lck     .byte ; +0B
    def     .byte ; +0C
    mov     .byte ; +0D
    unk_0E  .byte ; +0E
    res     .byte ; +0F
    y_pos   .byte ; +10
    x_pos   .byte ; +11
    unk_12  .byte ; +12
    item    .res 4 ; +13 ; UNIT_ITEM_COUNT
    uses    .res 4 ; +17 ; UNIT_ITEM_COUNT

    .endstruct

    ENEMY_ITEM_COUNT = 2

    .struct EnemyInfo

    pid    .byte ; +00
    jid    .byte ; +01
    level  .byte ; +02
    item   .res 2 ; +03 ; ENEMY_ITEM_COUNT
    y_pos  .byte ; +05
    x_pos  .byte ; +06
    unk_07 .byte ; +07
    unk_08 .byte ; +08
    unk_09 .byte ; +09
    unk_0A .byte ; +0A

    .endstruct

    .endif ; STRUCT_UNIT_INC
