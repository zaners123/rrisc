init:
    setsl stack

    push16 out
    push16 out
    push16 out
    push16 out
    push16 out

    addi 3
    set R1

    ;TODO turn this into shortcut such as jwl:
    push16 out
    setml doubler
    jal
    out:

    push16 out2
    setml doubler
    jal
    out2:

    setml init
    jal

.buffer 80

doubler:
    get R1
    add R0
    set R1
    popml
    jal
stack: