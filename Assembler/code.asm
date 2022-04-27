
    addi 5
    set R1

    jumpsr doubler
    jumpsr doubler
    jumpsr doubler
    jumpsr doubler ; TODO this is 39 bytes?

doubler:
    get R1
    add R0
    set R1
    popml
    jal

tripler:
    get R1
    add R0
    add R0
    set R1
    popml
    jal

stack: