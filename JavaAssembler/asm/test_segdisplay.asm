; Test the usage of a seven segment display
#define DIGIT0 0xF0F0

setjl DIGIT0

clr

loop:

setjl loop


addi8 1
wb R0


jal