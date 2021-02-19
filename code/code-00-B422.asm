
    .include "include/global.inc"
    .include "include/variables.inc"

    .proc FUNC_00_B422

    lda wUnk0474
    jsr Switch

    .word CaseRet
    .word LOC_B46E
    .word LOC_B476
    .word LOC_B486
    .word LOC_B48E
    .word LOC_B49E
    .word LOC_B4A5
    .word LOC_B4AC
    .word LOC_B4B3
    .word LOC_B4C3
    .word LOC_B4CB
    .word LOC_B4D7
    .word LOC_B4E6
    .word LOC_B4ED
    .word LOC_B507
    .word LOC_B510
    .word LOC_B51D
    .word LOC_B524
    .word LOC_B537
    .word LOC_B55D
    .word LOC_B54A
    .word LOC_B55D
    .word LOC_B550
    .word LOC_B55D
    .word LOC_B561
    .word LOC_B544
    .word LOC_B55D
    .word LOC_B56C
    .word LOC_B56C
    .word LOC_B577
    .word LOC_B580
    .word LOC_B58B

LOC_B468:
    /* B468 A9 00    */ lda #0
    /* B46A 8D 74 04 */ sta wUnk0474
    /* B46D 60       */ rts

LOC_B46E:
    /* B46E A9 40    */ lda #$40
    /* B470 85 2E    */ sta zUnk2E
    /* B472 EE 74 04 */ inc wUnk0474
    /* B475 60       */ rts

LOC_B476:
    /* B476 A5 2E    */ lda zUnk2E
    /* B478 F0 EE    */ beq LOC_B468

    /* B47A A5 30    */ lda zUnk30
    /* B47C 29 03    */ and #$3
    /* B47E D0 05    */ bne :+

    /* B480 A9 02    */ lda #2
    /* B482 8D F0 06 */ sta wUnk06F0

:
    /* B485 60       */ rts

LOC_B486:
    /* B486 A9 40    */ lda #$40
    /* B488 85 2E    */ sta zUnk2E
    /* B48A EE 74 04 */ inc wUnk0474
    /* B48D 60       */ rts

LOC_B48E:
    /* B48E A5 2E    */ lda zUnk2E
    /* B490 F0 D6    */ beq LOC_B468

    /* B492 A5 30    */ lda zUnk30
    /* B494 29 07    */ and #$7
    /* B496 D0 05    */ bne :+

    /* B498 A9 40    */ lda #$40
    /* B49A 8D F0 06 */ sta wUnk06F0

:
    /* B49D 60       */ rts

LOC_B49E:
    /* B49E A9 01    */ lda #1
    /* B4A0 8D F7 06 */ sta wUnk06F7
    /* B4A3 D0 C3    */ bne LOC_B468

LOC_B4A5:
    /* B4A5 A9 02    */ lda #2
    /* B4A7 8D F0 06 */ sta wUnk06F0
    /* B4AA D0 BC    */ bne LOC_B468

LOC_B4AC:
    /* B4AC A9 30    */ lda #$30
    /* B4AE 85 2E    */ sta zUnk2E
    /* B4B0 EE 74 04 */ inc wUnk0474

LOC_B4B3:
    /* B4B3 A5 2E    */ lda zUnk2E
    /* B4B5 F0 B1    */ beq LOC_B468

LOC_B4B7:
    /* B4B7 A5 30    */ lda zUnk30
    /* B4B9 29 0F    */ and #$F
    /* B4BB D0 05    */ bne :+

    /* B4BD A9 02    */ lda #2
    /* B4BF 8D F0 06 */ sta wUnk06F0

:
    /* B4C2 60       */ rts

LOC_B4C3:
    /* B4C3 A9 08    */ lda #8
    /* B4C5 8D F0 06 */ sta wUnk06F0
    /* B4C8 4C 68 B4 */ jmp LOC_B468

LOC_B4CB:
    /* B4CB A9 20    */ lda #$20
    /* B4CD 85 2E    */ sta zUnk2E
    /* B4CF A9 08    */ lda #8
    /* B4D1 8D F3 06 */ sta wUnk06F3
    /* B4D4 EE 74 04 */ inc wUnk0474

LOC_B4D7:
    /* B4D7 A5 2E    */ lda zUnk2E
    /* B4D9 D0 0A    */ bne :+

    /* B4DB A9 01    */ lda #1
    /* B4DD 8D F4 06 */ sta wUnk06F4
    /* B4E0 A9 00    */ lda #0
    /* B4E2 8D 74 04 */ sta wUnk0474

:
    /* B4E5 60       */ rts

LOC_B4E6:
    /* B4E6 A9 30    */ lda #$30
    /* B4E8 85 2E    */ sta zUnk2E
    /* B4EA EE 74 04 */ inc wUnk0474

LOC_B4ED:
    /* B4ED A5 2E    */ lda zUnk2E
    /* B4EF D0 0A    */ bne LOC_B4FB

    /* B4F1 8D 74 04 */ sta wUnk0474
    /* B4F4 A9 01    */ lda #1
    /* B4F6 8D F4 06 */ sta wUnk06F4
    /* B4F9 D0 0B    */ bne LOC_B506

LOC_B4FB:
    /* B4FB A5 30    */ lda zUnk30
    /* B4FD 29 07    */ and #$7
    /* B4FF D0 05    */ bne LOC_B506

    /* B501 A9 08    */ lda #8
    /* B503 8D F0 06 */ sta wUnk06F0

LOC_B506:
    /* B506 60       */ rts

LOC_B507:
    /* B507 A9 08    */ lda #$08
    /* B509 8D F0 06 */ sta wUnk06F0
    /* B50C A9 20    */ lda #$20
    /* B50E 85 2E    */ sta zUnk2E

LOC_B510:
    /* B510 A5 2E    */ lda zUnk2E
    /* B512 D0 08    */ bne :+

    /* B514 A9 40    */ lda #$40
    /* B516 8D F1 06 */ sta wUnk06F1
    /* B519 4C 68 B4 */ jmp LOC_B468

:
    /* B51C 60       */ rts

LOC_B51D:
    /* B51D A9 40    */ lda #$40
    /* B51F 85 2E    */ sta zUnk2E
    /* B521 EE 74 04 */ inc wUnk0474

LOC_B524:
    /* B524 A5 2E    */ lda zUnk2E
    /* B526 D0 03    */ bne LOC_B52B

    /* B528 4C 68 B4 */ jmp LOC_B468

LOC_B52B:
    /* B52B A5 30    */ lda zUnk30
    /* B52D 29 0F    */ and #$0F
    /* B52F D0 05    */ bne LOC_B536

    /* B531 A9 02    */ lda #$02
    /* B533 8D F4 06 */ sta wUnk06F4

LOC_B536:
    /* B536 60       */ rts

LOC_B537:
    /* B537 A9 60    */ lda #$60
    /* B539 85 2E    */ sta zUnk2E
    /* B53B A9 40    */ lda #$40
    /* B53D 8D F3 06 */ sta wUnk06F3
    /* B540 EE 74 04 */ inc wUnk0474
    /* B543 60       */ rts

LOC_B544:
    /* B544 A2 80    */ ldx #$80
    /* B546 A9 60    */ lda #$60
    /* B548 D0 0A    */ bne LOC_B554

LOC_B54A:
    /* B54A A2 02    */ ldx #$02
    /* B54C A9 50    */ lda #$50
    /* B54E D0 04    */ bne LOC_B554

LOC_B550:
    /* B550 A2 04    */ ldx #$04
    /* B552 A9 60    */ lda #$60

LOC_B554:
    /* B554 8E F7 06 */ stx wUnk06F7
    /* B557 85 2E    */ sta zUnk2E
    /* B559 EE 74 04 */ inc wUnk0474
    /* B55C 60       */ rts

LOC_B55D:
    /* B55D A5 2E    */ lda zUnk2E
    /* B55F D0 0A    */ bne LOC_B56B

LOC_B561:
    /* B561 A9 00    */ lda #$00
    /* B563 8D 74 04 */ sta wUnk0474
    /* B566 A9 01    */ lda #$01
    /* B568 8D F4 06 */ sta wUnk06F4

LOC_B56B:
    /* B56B 60       */ rts

LOC_B56C:
    /* B56C A9 02    */ lda #$02
    /* B56E 8D F3 06 */ sta wUnk06F3
    /* B571 A9 00    */ lda #$00
    /* B573 8D 74 04 */ sta wUnk0474
    /* B576 60       */ rts

LOC_B577:
    /* B577 A9 01    */ lda #$01
    /* B579 8D F4 06 */ sta wUnk06F4
    /* B57C EE 74 04 */ inc wUnk0474
    /* B57F 60       */ rts

LOC_B580:
    /* B580 A9 08    */ lda #$08
    /* B582 8D F0 06 */ sta wUnk06F0
    /* B585 A9 00    */ lda #$00
    /* B587 8D 74 04 */ sta wUnk0474
    /* B58A 60       */ rts

LOC_B58B:
    /* B58B A9 20    */ lda #$20
    /* B58D 8D F1 06 */ sta wUnk06F1
    /* B590 A9 00    */ lda #$00
    /* B592 8D 74 04 */ sta wUnk0474
    /* B595 60       */ rts

    .endproc ; FUNC_00_B422
