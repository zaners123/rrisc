; Since the new RRISC design has no comparator chip (<, =, >), this is to test that comparisons are still possible


; Equality Test
clr
addi8 20
set R1
set R2

get R1

; ACC==R2 (20==20)
sub R2
jnz

; Less Than test
clr
addi8 15
set R1
addi 5
set R2

get R1
; ACC < R2 (15 < 20)
sub R2
jpos

; Less Than equals test
; ACC <= R2 (15 <= 20)

