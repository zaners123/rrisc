beef:
    rb RAC   ; Equals 0xE0
    addi 5   ; acc=E5
    xori 0xA ; acc=FE
    andi 0xF ; acc=EF
    set RML
    xor RAC
    get RML
    andi 0xB
    set RMH  ; mem = BEEF
    nop
    nop
    nop
    nop
cafe:
    clr
    ori 0xA
    xori 0xC
    set R5 ; R5=CA
    sub R5
    subi 2
    set RML
    get R5
    set RMH
    nop
    nop
    nop
    nop