
LOC_8FDB:
    /* 8FDB A9 78    */ lda #<sUnitsEnemy
    /* 8FDD 85 02    */ sta zR02
    /* 8FDF A9 70    */ lda #>sUnitsEnemy
    /* 8FE1 85 03    */ sta zR02+1
    /* 8FE3 60       */ rts
