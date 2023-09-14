// This file tests all features of the computer.
// While it runs, watch as it sets the memory register to specific words (BEEF, CAFE, BABE, etc)
// For the loops at the end, if they get stuck in an infinite loop, the test failed.


// A way to test ACC and the opcode
xor acc
xor acc
xor acc
xor acc

// Test ability to read ACC from debug plug

addi 1
addi 1
addi 1
addi 1
addi 1
addi 1
addi 1
addi 1
addi 1
addi 1

subi 1
subi 1
subi 1
subi 1
subi 1
subi 1
subi 1
subi 1
subi 1
subi 1

//test all registers
xor acc
addi 1
set RCS
addi 1
set R1
addi 1
set R2
addi 1
set R3
addi 1
set R4
addi 1
set R5
addi 1
set R6
addi 1
set R7
addi 1
set RML
addi 1
set RMH
addi 1
set RJL
addi 1
set RJH
addi 1
set R8
addi 1
set R9
xor acc
get RCS
get R1
get R2
get R3
get R4
get R5
get R6
get R7
get RML
get RMH
get RJL
get RJH
get R8
get R9

//test basic ops
xor acc
xor acc

xori 0x1            // acc=10
xori 0x2            // acc=21
xori 0x1            // acc=02
xori 0x2            // acc=00

ori 0xF             //acc = F0
ori 0xF             //acc = FF

xor acc
beef:
    xori 0xE 		// Equals 0xE0
    addi 5   		// acc=E5
    xori 0xA 		// acc=FE
    andi 0xF 		// acc=EF
    set RML         // acc=EF
    xor RAC         // acc=00
    get RML         // acc=EF
    andi 0xB        // acc=BE
    set RMH 		// mem = BEEF
    addi 0
    addi 0
    addi 0
cafe:
    xor acc
    ori 0xA         // R5=A0
    xori 0xC        // R5=CA
    set R5 		    // R5=CA
    sub R5          //ACC=00
    subi 2          //ACC=FE
    set RML
    get R5
    set RMH 		// mem = CAFE
    addi 0
    addi 0
    addi 0

//skip test
sal
addi 1
sal
addi 1

//setup for jump
xor acc
set RMH
set RML  //mem=0

xor acc
xor acc

set CMP         // CMP=0
sal
addi 15         //skipped
sno
addi 1 		    // ACC=1
// This whole section should never jump
jno             // never
jco		        // cmp odd (false since cmp is 0)
jcn             // cmp negative (false since cmp is 0)
jcnz             // cmp not zero (false since it IS zero)
jae		        // acc odd (false since acc is 1)
jan             // acc negative (false since it's positive)
//don't test NEWCON since it's floating
jct             // carry true (false since addi1 didn't carry)

addi 0
addi 0
addi 0
addi 0
//carry test
xor acc             //acc=00
subi 0              //acc=00, carry=true
jcf                 //shouldn't jump since carry is true
addi 0
addi 0

//loop until carry test
xor acc
setjl loop
loop:
addi 8
jcf

//loop until 10 test
xor acc
addi 10
set R3          //R3= bound

setjl loop10
loop10:
addi 1
set R1
sub R3
get R1
jcf             // for a-b, carry=true if B (R3) is less

//program is all done
xori 0xF
xori 0xF
xori 0xF
xori 0xF
addi 1
addi 2
addi 3
addi 4
//jump to 0
xor acc
set RMH
set RML
jal
