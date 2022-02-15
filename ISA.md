# Registers

There are 16 8-bit registers, named R0-R15.

### R0: acc

This is the accumulator register, and nearly every operation involves it somehow

### R1-R13: General Purpose Regsiters

### R14-R15: Memory Register

Every address in memory is 16-bits long, but the registers are 8-bits long. Because of this, two registers are used:
- R11 = RMEMIO (Data from/to memory)
- R12 = SRH (StackRegister High, most significant 8 bits)
- R13 = SRL (StackRegister Low, least significant 8 bits)
- R14 = MEMH(Memory High, most  significant 8 bits)
- R15 = MEML(Memory Low , least significant 8 bits)

RSR  = {SRH,SRL}   = {R12,R13}
RMEM = {MEMH,MEML} = {R14,R15}

To jump, you set these registers, then call "jmp"

To read memory, you set these registers, put something in acc, then call "rb"

To write memory, you set these registers, put something in acc, then call "wb"

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
```acc = acc + imm```
### (0x1) add - Add Register 
```acc = acc + R[imm]```
### (0x2) andi - And Immediate 
```acc = acc & imm```
Note that since imm is only 4 bits, it wipes the most-significant 4-bits
### (0x3) and - And Register
```acc = acc & R[imm]```
### (0x4) swei - Swap Eor Immediate
```acc[3:0] <-> acc[7:4]^imm```
Useful for:
 - Turning most other operations into their inverses
 - Turning a 4bit operation into an 8-bit operation
   - EX: and by 0x53
```
andi 0x5
swei 0x0
andi 0x3
``` 
 - A NEG:
```
swei 0xF
swei 0xF
```
 - SUBTRACTION (acc = R3 - R2)
```
set_acc_to_R2:
    andi 0x0
    swei 0x0
    andi 0x0
    add R2
invert acc:
    swei 0xF
    swei 0xF
    addi 1
add_R3:
    add R3
```
### (0x5) shft - Shift (Logical/Arithmetic/Rotate)
```
IF IMMEDIATE-BASED SHIFT HARDWARE CHOSEN:
left = imm[3]
if left:
    acc = acc << imm
else:
    acc = acc >> imm
IF REGISTER-BASED SHIFT HARDWARE CHOSEN:
left = R[imm][7]
optional: rot = R[imm][6]
optional: arithmetic = R[imm][5]
if left:
    acc = acc << R[imm][3:0]
else:
    acc = acc >> R[imm][3:0]
```
### set (0x6)
### get (0x7)
### subi (0x8)
### sub (0x9)
### ori (0xA)
### or (0xB)
### ? (0xC)
### jif (0xD) - Jump If Flags
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
    E: ?
    F: ?
}
if jump:
    PC = RMEM
```
### rb (0xE) Read Byte from memory
```
R[imm] = mem[addr]
```
### wb (0xF) Write Byte to memory
```
mem[addr] = R[imm]
```
Keep in mind to set both memory registers, as mentioned above.
# Potential Master Instructions
- SUB / SUBI
- SWP-OR

- SWP-NOR (unnecessarily similar to or/nor)
- SWP-NAND (unnecessarily similar to and/nand)

# Alias Instructions

### lsri - Logical Shift Right Immediate
```acc = acc >> imm```
This takes one tick and is equivalent to lsli (-i)"

### push - Push
```MEM[SR++] = acc```

```
; Put acc in memio
set RMEMIO
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


### subi - Subtract Immediate
```acc = acc - imm```