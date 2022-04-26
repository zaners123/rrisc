# RRISC (Reduced Reduced Instruction Set Computer)

My primary goal for this project was to make a computer from "scratch"
(simple logic gates and memory, no embedded microcontrollers/FPGAs/etc) to learn more about Computer Engineering
as a "learn by doing" approach.

Since it's only made out of simple logic gates and hand-soldered, it needs to be simple in design
(no microcode/pipelining) and in implementation (trying to aim for around 50 logic chips,
none of which are more complex than a comparator).

This project includes the Assembler, LogiSim simulator/emulator, schematic, and PCB.
This is the computer at every level of abstraction, and as such this is Open Source Hardware.

## What is RISC? What does this computer do? 

A RISC computer commonly has simple operations to have higher instructions per second.
My computer has extremely simple operations to have extreme efficiency (ideally).
My goal for this computer is for it to run at about 20MHz.

This is a General Purpose Von-Neumann-Architecture computer with 8-bit instructions.
It has 64Kb of RAM and all 16 instructions follow a quick 3-stage IF/EX/WB cycle.

Instructions are broken up into two parts. Here's the entire **Instruction Set Architecture**:

 ID | Opcode  |  Description          |  Action
----|---------|-----------------------|-------------------------
 _  | 4 bits  | _                     | 4 bits
0x0 | ADDI    | Add Immediate         | ACC = ACC + imm
0x1 | ADD     | Add Register          | ACC = ACC + R\[imm\]
0x2 | SUBI    | Subtract Immediate    | ACC = ACC - imm
0x3 | SUB     | Subtract Register     | ACC = ACC - R\[imm\]
0x4 | ANDI    | And Immediate         | ACC = ACC & imm
0x5 | AND     | And Register          | ACC = ACC & R\[imm\]
0x6 | GET     | Get Register          | ACC = R\[imm\]
0x7 | SET     | Set Register          | R\[imm\] = ACC
0x8 | ORI     | Or Immediate          | ACC = ACC \| imm
0x9 | OR      | Or Register           | ACC = ACC \| R\[imm\]
0xA | XORI    | Xor Immediate         | ACC = ACC ^ imm
0xB | XOR     | Xor Register          | ACC = ACC ^ R\[imm\]
0xC | SIF     | Conditional Skip      | skip if eval(imm)
0xD | JIF     | Conditional Jump      | jump to MEM if eval(imm)
0xE | RB      | Read Byte from Memory | R\[imm\] = MEMORY\[MEM\]
0xF | WB      | Write byte to memory  | MEMORY\[MEM\] = R\[imm\]

# Assembler

Given an assembly file (Ex: code.asm), it turns it into a hex file (Ex: code.asm.hex) that can be loaded either onto
the real computer, or the simulated computer in LogiSim.

# Simulation

This represents the computer's overall layout. It is both a logical diagram for the computer and a convenient simulator for programs.

Open this with Logisim Evolution. I use "logisim-evolution-3.4.1-all.jar".
Upload the hex from the assembler into the RAM, start the controller, and watch it run!

# Hardware

This is made in KiCad, and contains the schematic (local layout of how things connect)
and the PCB design (how to physically connect everything together).

The plan is to have the submodules used in LogiSim (registers, ALU, RAM, etc) be a daughter board for the main PCB.

The plan is to design/order/build the PCBs in this order:
1. PC
2. ALU
3. Registers
4. RAM/ROM/Programmer
5. Motherboard/Controller

This way, I can test them all separately, and revisions can be made more easily.
