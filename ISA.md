# Registers

There are 16 8-bit registers, named R0-R15.

### R0: acc

This is the accumulator register, and nearly every operation involves it somehow

### R1-R13: General Purpose Regsiters

### R14-R15: Memory Register
- R0    = RAC - Accumulator. Output register for nearly every operation (unchanged in j, s, wb, set)
- R1-R9 = general-purpose registers
- R10   = RAT - Assembler Temporary (since nearly every instruction touches the ALU, used for push,jmp,etc)
- R11   = RCM = CMP - Compare. Used by jlt, sgt, jeq, jne, etc.
- R12   = RSH (StackRegister High, most significant 8 bits)
- R13   = RSL (StackRegister Low, least significant 8 bits)
- R14   = RMH (Memory High, most  significant 8 bits)
- R15   = RML (Memory Low , least significant 8 bits)

RSTK = {RSH,RSL} = {R12,R13}
RMEM = {RMH,RML} = {R14,R15}
RSRC = Source (aka input aka read-from)
RDST = Destination (aka output aka write-to)

## Examples:
- To jump, you set RMEM registers, then call a variant of jmp
- To read memory, you set RMEM, then call "rb {RSRC}"
- To write memory, you set RMEM then call "wb {RDST}"

# Instruction Format
All instructions are, in hardware, a single byte. A 4-bit opcode, followed by a 4-bit number, imm.

imm must be a value from 0-15 (0000 to 1111)

If imm is negative, it will be inverted through two's compliment.

If imm is hexadecimal, it will be converted.

R[imm] = Register at imm (R0 = acc)

# Hardware-Implemented Instructions

These all take exactly one controller-cycle-per-instruction.

These ends up being around 4 clock cycles, since it uses somewhat of an IF,ID,EX,WB pipeline.

### (0x0) addi - Add Immediate 
```
acc = acc + imm
flag-carry = true if a carry occurred
```
### (0x1) add - Add Register 
```
acc = acc + R[imm]
flag-carry = true if a carry occurred
```
### subi (0x2) - subtract immediate
```
acc = acc - imm
flag-carry = true if a carry (aka borrow) occurred
```
### sub (0x3) - subtract
```
acc = acc - R[imm]
flag-carry = true if a carry (aka borrow) occurred
```
### (0x2) andi - And Immediate 
```
acc = acc & imm
acc[3:0] <-> acc[7:4]
```
Note that since imm is only 4 bits, it wipes the most-significant 4-bits
### (0x3) and - And Register
```acc = acc & R[imm]```
### (0x4) eor - Eor Immediate
```
acc[3:0] = acc[3:0]^imm
acc[3:0] <-> acc[7:4]
```
### eori (0x5) - eor immediate
```acc = acc^R[imm]```
### set (0x6) - set register
```R[imm] = acc```
### get (0x7) - get register
```acc = R[imm]```
### ori (0xA) - logical or immediate
```
acc = acc or imm
acc[3:0] <-> acc[7:4]
```
### or (0xB) - logical or
```acc = acc or R[imm]```
### sif (0xC, 0b1100) - Skip If
```
skip = condition (see jmp conditions)
if skip:
    PC = PC+8 instead of PC+4
```
Will likely be added to make all instructions conditional (such as origz being ori )
### jif (0xD, 0b1101) - Jump If
```
jump = switch(imm) {
    0: JAL - always
    1: JNO - never
    2: JNZ - acc != 0
    3: JEZ - acc == 0
    4: JLZ - acc[MSB] == 1 (acc negative)
    5: JGZ - acc[MSB] == 0 (acc positive) 
    6: JLT - acc < R[memio]
    7: JGE - acc >= R[memio]
    8: JEQ - acc == R[memio]
    9: JNE - acc != R[memio]
    A: JGT - acc > R[memio]
    B: JLE - acc <= R[memio]
    C: JOD - acc%2 == 1
    D: JEV - acc%2 == 0
    E: JCT - carry flag true
    F: JCF - carry flag false
}
if jump:
    PC = RMEM
```
### rb (0xE, 0b1110) Read Byte from memory
```R[imm] = mem[addr]```
### wb (0xF, 0b1111) Write Byte to memory
```mem[addr] = R[imm]```
Keep in mind to set both memory registers, as mentioned above.

# Alias Instructions

### push - Push
```MEM[SR++] = acc```

```
; Put acc in memio
set RAT
; Increment RSRL
get RSRL
addi 1
set RSRL
jnz done


done:

```

Pushes the immediate value onto the nibble at the memory address the stack is at.
Then increments the stack pointer. (If SRL is FFFF: SRL=0; SRH++)
### pop - Pop
```acc = MEM[SR--]```
Problem: Push/Pop require a 16-bit add, but the computer only has 8 bit. This could be solved by using the carry, but how?
 - Dedicated Carry instruction: This would be over the top
 - Add is always add with carry: When/How does it know to specify when to add the carry?
   - "addi 0" uses and removes the carry bit could work, but would require at least 5 chips