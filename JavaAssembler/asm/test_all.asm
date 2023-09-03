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
    set RML
    xor RAC
    get RML
    andi 0xB
    set RMH  		// mem = BEEF
    addi 0
    addi 0
    addi 0
    addi 0
cafe:
    xor acc
    ori 0xA
    xori 0xC
    set R5 		    // R5=CA
    sub R5
    subi 2
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

loops:
    addi 0
    addi 0
    addi 0
    //setml loops

    xor acc
    set CMP         // CMP=0
    sal
    addi 15
    sno
    addi 1 		    // ACC=1
    // This whole section should never jump
    jno             // never
    jco		        // cmp odd (false since cmp is 0)
    jcn             // cmp negative (false since cmp is 0)
    jcz             // cmp zero (false since it's 1)
    jae		        // acc odd (false since acc is 1)
    jan             // acc negative (false since it's positive)
    //don't test NEWCON since it's floating
    jct             // carry true (false since addi1 didn't carry)


addi 0
addi 0
addi 0
addi 0
addi 0
addi 0
addi 0
addi 0
addi 0
addi 0