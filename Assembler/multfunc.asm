addi 15
set R5
wb R5
rb R1
rb R2
rb R3
rb R4




setsl stack
main:
    addi 5
    set R1
    ; jl mult
    pushml md
    jmp mult
    .buffer 1024
md:
    nop
    nop
    nop
    get R1

    .buffer 1024

#    addi 5
#
#.buffer 4
#
mult:
    get R1
    addi 6
    set R1
    popml
.buffer 50
    jal
.buffer 4
stack: