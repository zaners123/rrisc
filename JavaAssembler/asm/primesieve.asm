// memory test
xor acc
xor acc
set RMH
set RML     //mem[0]

xor acc
get RMH     //acc=0
get RML     //acc=0
addi 1      //acc=1
wb acc      //mem[0]=1

//run a little loop writing then reading from memory
xor acc     //acc=0
rb acc      //acc=1
set RML     //mem[1]
addi 1      //acc=2
wb acc      //mem[1]=2

xor acc     //acc=0
rb acc      //acc=2
set RML     //mem[2]
addi 1      //acc=3
wb acc      //mem[2]=3

xor acc     //acc=0
rb acc      //acc=3
set RML     //mem[3]
addi 1      //acc=4
wb acc      //mem[3]=4

xor acc     //acc=0
rb acc      //acc=4
set RML     //mem[4]
addi 1      //acc=5
wb acc      //mem[4]=5

//read that back
xor acc
set RMH
set RML     //mem[0]
rb RML      //addr = mem[0] = 1
get RML     //acc=1
rb RML      //addr = mem[1] = 2
get RML     //acc=2
rb RML      //addr = mem[2] = 3
get RML     //acc=3
rb RML      //addr = mem[3] = 4
get RML     //acc=4
rb RML      //addr = mem[4] = 5

//The actual prime sieve program, first made just for X up to 256
//{2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251}

//Step 1. Clear memory
xor acc
set RMH
set RML
set R1
setjl iterclear
iterclear:
wb R1
addi 1
set RML
jcf
//Step 2. Set mem[composite] to one
//acc = number being set to one
// R1 = increment amount (outer loop), starts at 2
xor acc
addi 2
set R1
// R2 = limit of outer loop (15, sqrt(256))
xor acc
addi 15
set R2
outer:
    setjl inner
    xor acc
    inner:
    add R1
    set RML
    wbcf R1       //Make mem[composite] nonzero, unless we're in the outer loop
    jcf
//outer loop, no optimization to skip composites
get R1
addi 1
set R1
setjl outer
sub R2      // subtraction carries if b<=a, aka carries if a>15
jcf

//Step 3. Print all numbers that are prime
setjl printloop
xor acc
set RMH
set RML
printloop:
    get RML
    addi 1
    set RML
    rb cmp  //acc == 0 if RML is prime
    jcnz    //jump if it's a composite
    //print RML
    get RML
    get RML
    get RML
    get RML
    get RML
    get RML
    get RML
    jal     //next number
