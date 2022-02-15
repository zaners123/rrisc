; For RRISC
start:
    addi 5
    addi 20
    subi 25
    nop
    nop
    nop
    jmp start
    addi 1
    addi 1
    set R13
    wb
    addi 1
    addi 1
    addi 1
    rb
    addi 1
    addi 1
    addi 1
    jmp start



maintwo:
    addi 1
    addi 1
    addi 1
    addi 1
main:
    addi 1
    addi 1
    addi 1
    addi 1
    ; Increment PC
    ; set R15
    ; addi 1
    ; mov R15
    ; Done inc PC
end:
    jmp far
string:
    .asciiz "ABCDEFG"
stack:
    .buffer 500
far:
    nop
    nop
    addi 1
    andi 5
    jmp main
