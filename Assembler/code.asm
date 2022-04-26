    setsl stack

    addi 4
    set R1

loopy:

    jumpsr doubler
    jumpsr doubler
    jumpsr doubler

    jmp loopy

.buffer 320

doubler:
    get R1
    add R0
    set R1
    popml
    jal
stack: