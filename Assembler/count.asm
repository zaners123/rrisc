; For RRISC
; This counts to a seven segment display on memory mapped IO
; The display is written BCD data, and it just counts from 1 to 9 in an infinite loop

; R1 = ones
; R2 = tens
; R3 = hundreds
; R4 = thousands
    setsl stack
    clr
    addi 10
    set RCD
loop:
    jumpsr write
    setml loop

    get R1
    addi 1
    set R1

    set RCS
    jlt zero
    clr
    set R1

    get R2
    addi 1
    set R2

    set RCS
    jlt zero
    clr
    set R2


    get R3
    addi 1
    set R3

    set RCS
    jlt zero
    clr
    set R3

    get R4
    addi 1
    set R4

    jal zero


write:
    get R1
    set R5
    jumpsr segify
    setml 0xF0F0
    wb R5

    get R2
    set R5
    jumpsr segify
    setml 0xF0F1
    wb R5

    get R3
    set R5
    jumpsr segify
    setml 0xF0F2
    wb R5

    get R4
    set R5
    jumpsr segify
    setml 0xF0F3
    wb R5

    popml
    jal

segify: ; Turns R5 into segdata equivalent
    setml digits
    addmp R5
    rb R5
    popml
    jal


;    PGFEDCBA
digits:
.bin 00111111 ; 0
.bin 00000110 ; 1
.bin 01011011 ; 2
.bin 01001111 ; 3
.bin 01100110 ; 4
.bin 01101101 ; 5
.bin 01111101 ; 6
.bin 00000111 ; 7
.bin 01111111 ; 8
.bin 01100111 ; 9
.bin 01110111 ; A
.bin 01111100 ; B

stack: