; For RRISC
maintwo:
main:
    addi 1
    addi 1
    addi 1
    addi 1
    seti8 100
    subi 3
    subi 3
    subi 3
    nop
    nop
    ; Increment PC
    set R15
    addi 1
    mov R15
    ; Done inc PC
end:
    jmp main
