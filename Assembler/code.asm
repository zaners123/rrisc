; For RRISC
start:
    rb 0000; Equals 0xE0
    addi 5
    set R5 ; R5=F5
    addi 3
    addi 5
    sub R5
    subi 8
    nop
    nop
    nop
    nop
    nop
    nop
    addi 15
loop:
    subi 1
    jez loop
    nop
    nop
    nop
    nop
    nop