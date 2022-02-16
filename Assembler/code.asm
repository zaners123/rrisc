; For RRISC
start:
    setsl stack
delay:
    push
    addi 1
    jnz delay
    .buffer 10000
stack:

; rb 0000  ; Equals 0xE0
; addi 5   ; acc=E5
; xori 0xA ; acc=FE
; andi 0xF ; acc=EF
; set RML
; xor acc
; get RML
; andi 0xB
; set RMH ; mem = BEEF