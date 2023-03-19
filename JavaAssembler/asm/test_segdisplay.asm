; Test the usage of a seven segment display
#define DIGIT0 0xF0F0

setml DIGIT0

clr

loop:

setml loop


addi8 1
wb R0


jal