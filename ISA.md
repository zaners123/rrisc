# Registers

There are 16 8-bit registers, named R0-R15.

### R0: acc

This is the accumulator register, and nearly every operation involves it somehow

### R1-R13: General Purpose Regsiters

### R14-R15: Memory Register

Every address in memory is 16-bits long, but the registers are 8-bits long. Because of this, two registers are used:
- R12 = SRH (StackRegister High, most significant 8 bits)
- R13 = SRL (StackRegister Low, least significant 8 bits)
- R14 = MEMH(Memory High, most  significant 8 bits)
- R15 = MEML(Memory Low , least significant 8 bits)

To jump, you set these registers, then call "jmp"

To read memory, you set these registers, put something in acc, then call "rb"

To write memory, you set these registers, put something in acc, then call "wb"

# Instruction Format
All instructions are, in hardware, a single byte. A 4-bit opcode, followed by a 4-bit number, imm.

imm must be a value from 0-15 (0000 to 1111)

If imm is negative, it will be inverted through two's compliment.

If imm is hexadecimal, it will be converted.

R[imm] = Register at imm

# Hardware-Implemented Instructions

These all take exactly one controller-cycle-per-instruction.

These ends up being around 4 clock cycles, since it uses somewhat of an IF,ID,EX,WB pipeline.

### (0x00) addi - Add Immediate 
```acc = acc + imm```
### (0x01) add - Add Register 
```acc = acc + R[imm]```
### (0x02) andi - And Immediate 
```acc = acc & imm```
Note that since imm is only 4 bits, it wipes the most-significant 4-bits
### (0x03) and - And Register
```acc = acc & R[imm]```
### (0x04) lsli - Logical Shift Left Immediate
```acc = acc << imm```

### jmp - Always Jump to Memory Register
``` PC = mem```

Keep in mind to set both memory registers, as mentioned above.

# Alias Instructions

### lsri - Logical Shift Right Immediate
```acc = acc >> imm```
This takes one tick and is equivalent to lsli (-i)"

### pushi - Push Immediate
```MEM[SR++] = imm```
Pushes the immediate value onto the nibble at the memory address the stack is at.
Then increments the stack pointer. (If SRL is FFFF: SRL=0; SRH++)
### pop - Pop
```acc = MEM[SR--]```
### subi - Subtract Immediate
```acc = acc - imm```