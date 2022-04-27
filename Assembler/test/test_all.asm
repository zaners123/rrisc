; This file tests all features of the computer.
; While it runs, watch as it sets the memory register to specific words (BEEF, CAFE, BABE, etc)
; For the loops at the end, if they get stuck in an infinite loop, the test failed.

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
    set RMH ; mem = CAFE
    nop
    nop
    nop
    nop
loops:
    clr
    set CMP
    set DST
    sal
    addi 15
    sne
    addi 1 ; ACC=1
    ; This whole section should never jump
    setml babe
    set CMP;cmp=1
    jev; if even
    jct; carry true
    jez; equals zero
    jeq; equal
    jlz; less than zero
    set DST;dst=1
    jne; not equal
    xori 0xE ; acc=F0
    addi 1 ; acc=F1, carry=false
    jct
    set CMP;CMP=F1
    jgz
    addi 0xF ;carry=true
    jcf
    set CMP; CMP=0
    addi 1; carry=false
    set DST;CMP=0, DST=1

    ;At any time, there is exactly 8 jumps that won't happen
    ;There are exactly 8 skips that should happen

    jno;never
    sal
    jal

    jnz;!=0
    sez
    jal

    jlz;MSB
    sgz
    jal

    jge;>=
    slt
    jal

    jeq;!=
    sne
    jal

    jgt;>
    sle
    jal

    jod;odd
    sev
    jal

    jct
    scf
    jal

    ;all done - test adds
    clr
    addi 0
    addi 1
    addi 0x2
    addi 0b11
    addi 0x4
    addi 0b101
    addi 6
    addi 0x7
    addi 8
    addi 0b1001
    addi 10
    addi 11
    addi 12
    addi 0xD
    addi 0xE
    addi 0xF
    set CMP
    clr
    xori 8
    ori 7

    set DST
    jne;8 = mod(1+2+3+4+5+6+7+8+9+10+11+12+13+14+15,16)
aliastest:
    setsl stack
aliasloop:
    addi 1
    push
    setml aliasloop
    jal
stack: