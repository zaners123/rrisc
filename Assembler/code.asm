; For RRISC
    setsl stack

    clr
    ori 5
    ori 0
    set R1

    clr
    ori 2
    ori 0
    set R2
mult:;R3 = R1 * R2
    setml multloop
    clr
    set R3;result
multloop:
    add R2
    add R2;carry=cut MSB
    set R2
    clr
    addct R1
    add R3
    add R0
    set R3

    get R2
    set RCS
    jnz
multdone:;R3 = 10
    get R3





