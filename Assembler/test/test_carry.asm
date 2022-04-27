; Tests if carries can be used to make multi-byte counters
; You don't have to do any setml here, since the default jump address is zero
; You could also do this with skips

    get R1
    addi 0xF
    set R1

    jcf

    get R2
    addi 0xF
    set R2

    jcf

    get R3
    addi 0xF
    set R3

    jcf

    get R4
    addi 0xF
    set R4

    jal