# Registers

There are 16 8-bit registers, named R0-R15.

### R0: acc

This is the accumulator register, and nearly every operation involves it somehow

### R1-R13: General Purpose Regsiters

### R14-R15: Memory Register
- R0    = RAC Accumulator. Output register for nearly every operation (unchanged in j, s, wb, set)
- R1-R8 = general-purpose registers
- R9    = RAT Assembler Temporary (since nearly every instruction touches the ALU, used for push,jmp,etc)
- R10   = RCS Compare Source. Unary sif/jif instructions use this. In form "(op) RCS"
  - Ex: jnz jumps if "RCS != 0"
- R11   = RCD Compare Dst. Binary sif/jif instructions use this. In form "RCS (op) RCD"
  - Ex: jlt jumps if "RCS < RCD" 
- R12   = RSH (StackRegister High, most significant 8 bits)
- R13   = RSL (StackRegister Low, least significant 8 bits)
- R14   = RMH (Memory High, most  significant 8 bits)
- R15   = RML (Memory Low , least significant 8 bits)

RSTK = {RSH,RSL} = {R12,R13}, The stack pointer
RMEM = {RMH,RML} = {R14,R15}, The memory pointer

## Examples:
- To double acc, call "add acc" (acc = acc + acc)
- To jump, you set RMEM, then call a variant of jmp
- To read memory, you set RMEM, then call "rb {RDST}"
- To write memory, you set RMEM then call "wb {RSRC}"

# Instruction Format
All instructions are, in hardware, a single byte. A 4-bit opcode, followed by a 4-bit number, imm.

imm must be a value from 0-15 (0000 to 1111)

If imm is negative, it will be inverted through two's compliment.

If imm is hexadecimal, it will be converted.

R[imm] = Register at imm (R0 = acc)

# Hardware-Implemented Instructions

These all take exactly one controller-cycle-per-instruction.

These are always 3 clock cycles, since it uses an IF,EX,WB pipeline.

### (0x0, 0b0000) addi - Add Immediate 
```
acc = acc + imm
flag-carry = true if a carry occurred
```
### (0x1, 0b0001) add - Add Register 
```
acc = acc + R[imm]
flag-carry = true if a carry occurred
```
### (0x2, 0b0010) subi - subtract immediate
```
acc = acc - imm
flag-carry = true if a carry (aka borrow) occurred
```
### (0x3, 0b0011) sub - subtract
```
acc = acc - R[imm]
flag-carry = true if a carry (aka borrow) occurred
```
### (0x4, 0b0100) andi - And Immediate 
```
acc = acc & imm
acc[3:0] <-> acc[7:4]
```
Note that since imm is only 4 bits, it wipes the most-significant 4-bits
### (0x5, 0b0101) and - And Register
```acc = acc & R[imm]```
### (0x6, 0b0110) get - get register
```R[imm] = acc```
### (0x7, 0b0111) set - set register
```acc = R[imm]```
### (0x8, 0b1000) ori - logical or immediate
```
acc = acc or imm
acc[3:0] <-> acc[7:4]
```
### (0x9, 0b1001) or - logical or
```acc = acc or R[imm]```
### (0xA, 0b1010) xori - eor immediate
```acc = acc^R[imm]```
### (0xB, 0b1011) xor - Eor Immediate
```
acc[3:0] = acc[3:0]^imm
acc[3:0] <-> acc[7:4]
```
### (0xC, 0b1100) sif - Skip If
```
skip = condition (see jmp conditions)
if skip:
    PC = PC+8 instead of PC+4
```
Will likely be added to make all instructions conditional (such as origz being ori )
### (0xD, 0b1101) jif - Jump If
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
### (0xE, 0b1110) rb Read Byte from memory
```R[imm] = mem[addr]```
### (0xF, 0b1111) wb Write Byte to memory
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