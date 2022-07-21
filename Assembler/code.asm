
setml 0xF0F0
addi 15
wb acc

setml 0xF0F1
addi 15
wb acc




    addi 5
    set R1

    jumpsr doubler
.buffer 100
    ;jumpsr doubler
    ;jumpsr doubler
    ;jumpsr doubler ; TODO this is 39 bytes?

doubler:
    get R1
    add R0
    set R1

    jumpsr tripler

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