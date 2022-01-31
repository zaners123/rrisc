# Registers

There are 16 8-bit registers.

# Instruction Format
All instructions are, in hardware, a single byte. A 4-bit opcode, followed by a 4-bit number, imm.

imm must be a value from 0-15 (0000 to 1111)

If imm is negative, it will be inverted through two's compliment.

If imm is hexadecimal, it will be converted.

R[imm] = Register at imm

# Hardware-Implemented Instructions

These all take exactly one controller-cycle-per-instruction.

### addi - Add Immediate (0x00)
```acc = acc + imm```
### add - Add Register (0x01)
```acc = acc + R[imm]```
### andi - And Immediate (0x02)
```acc = acc & imm```
Note that since imm is only 4 bits, it wipes the most-significant 4-bits
### and - And Register
```acc = acc & R[imm]```
### lsli - Logical Shift Left Immediate
```acc = acc << imm```

### jmp
``` PC = mem```

# Alias Instructions

### lsri - Logical Shift Right Immediate
```acc = acc >> imm```
This takes one tick and is equivalent to lsli (-i)"