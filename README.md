# RRISC
This repository is for my "Reduced Reduced Instruction Set Computer".

This project includes the assembler, LogiSim simulator/emulator, schematic, and PCB.

My primary goal for this project was to make a computer from "scratch" (no embedded microcontrollers/FPGAs/etc) to learn more about Computer Engineering.

## What is RISC? What does this computer do? 

A RISC computer commonly has somewhat simple operations to have reasonable efficiency. My computer has extremely simple operations to have extreme efficiency (ideally). My goal for this computer is for it to run at about 20MHz.

This is a General Purpose Von-Neumann-Architecture computer with 8-bit instructions.

# Assembler

Given an assembly file (Ex: code.asm), it turns it into a hex file (Ex: code.asm.hex) that can be loaded either onto the real computer, or the simulated computer in LogiSim.

# Simulation

This represents the computer's overall layout.

Open this with Logisim Evolution. I use "logisim-evolution-3.4.1-all.jar".

Upload the hex from the assembler into the RAM, start the controller, and watch it run!

# Hardware

This is made in KiCad, and contains the schematic (local layout of how things connect) and the PCB design (how to physically connect everything together).

The plan is to have the submodules used in LogiSim (registers, ALU, RAM, etc) be daughter board for the main PCB.
