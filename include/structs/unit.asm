
    UNIT_ITEM_COUNT = 4
    ENEMY_ITEM_COUNT = 2

    .struct Unit

    pid     db ; +00
    jid     db ; +01
    level   db ; +02
    hp_cur  db ; +03
    hp_max  db ; +04
    exp     db ; +05
    cell    db ; +06
    str     db ; +07
    skl     db ; +08
    wlv     db ; +09
    spd     db ; +0A
    lck     db ; +0B
    def     db ; +0C
    mov     db ; +0D
    unk_0E  db ; +0E
    res     db ; +0F
    y       db ; +10
    x       db ; +11
    unk_12  db ; +12
    item    ds UNIT_ITEM_COUNT ; +13
    uses    ds UNIT_ITEM_COUNT ; +17

    .endst

    .struct EnemyInfo

    pid    db ; +00
    jid    db ; +01
    level  db ; +02
    item   ds ENEMY_ITEM_COUNT ; +03
    y      db ; +05
    x      db ; +06
    unk_07 db ; +07
    unk_08 db ; +08
    unk_09 db ; +09
    unk_0A db ; +0A

    .endst
