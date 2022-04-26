; For RRISC
; This counts to a seven segment display on memory mapped IO
; The display is written BCD data, and it just counts from 1 to 9 in an infinite loop
    addi 10
    set RCD
zero:
    clr
    set RCS
loop:
    get RCS
    addi 1
    set RCS
    jge zero
    setml digits
    addmp RCS
    rb acc
    ;          V Display Address
    setml 0xF0F0
    wb acc
    setml loop
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
