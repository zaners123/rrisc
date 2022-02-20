; For RRISC
beef:
    rb acc   ; Equals 0xE0
    addi 5   ; acc=E5
    xori 0xA ; acc=FE
    andi 0xF ; acc=EF
    set RML
    xor acc
    get RML
    andi 0xB
    set RMH  ; mem = BEEF
    nop
    nop
    nop
    nop
cafe:
    ori 0xA
    xori 0xC
    set R5 ; R5=CA
    sub R5
    subi 3
    set RML
    get R5
    set RMH
    nop
    nop
    nop
babe:


