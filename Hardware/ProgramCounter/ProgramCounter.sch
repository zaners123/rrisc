EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74xx:74HCT273 UPR1
U 1 1 62688F39
P 10000 3900
F 0 "UPR1" H 9750 4550 50  0000 C CNN
F 1 "74HCT273" H 10250 4550 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 10000 3900 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 10000 3900 50  0001 C CNN
	1    10000 3900
	1    0    0    -1  
$EndComp
Text Notes 5250 7400 0    50   ~ 0
IN    =16xREGS_OUT_MEM \nOUT  =16xMEM_PC\n\nIN    = 8xREG_RCS\nIN    = 8xREG_RCD\n\nIN    = 4xOPCODE\nIN    = 4xIMM\n\nIN    = RST\nIN    = 1xFLAG_CARRY\nIN    = 1xCLK_WB\n\nPOWER= 4xGND/VCC
$Comp
L Connector_Generic:Conn_02x32_Row_Letter_First J1
U 1 1 6269020A
P 4200 5950
F 0 "J1" H 4250 7667 50  0000 C CNN
F 1 "Conn_02x32_Row_Letter_First" H 4250 7576 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x32_P2.54mm_Horizontal" H 4200 5950 50  0001 C CNN
F 3 "~" H 4200 5950 50  0001 C CNN
	1    4200 5950
	1    0    0    -1  
$EndComp
Entry Wire Line
	3650 4950 3550 4850
Entry Wire Line
	3650 4850 3550 4750
Entry Wire Line
	3650 4750 3550 4650
Entry Wire Line
	3650 4650 3550 4550
$Comp
L power:GND #PWR0101
U 1 1 6269CCD1
P 10000 4700
F 0 "#PWR0101" H 10000 4450 50  0001 C CNN
F 1 "GND" H 10100 4600 50  0000 C CNN
F 2 "" H 10000 4700 50  0001 C CNN
F 3 "" H 10000 4700 50  0001 C CNN
	1    10000 4700
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0102
U 1 1 6269D404
P 4000 4550
F 0 "#PWR0102" H 4000 4400 50  0001 C CNN
F 1 "VCC" V 4018 4677 50  0000 L CNN
F 2 "" H 4000 4550 50  0001 C CNN
F 3 "" H 4000 4550 50  0001 C CNN
	1    4000 4550
	0    -1   -1   0   
$EndComp
Text Label 3000 4550 0    50   ~ 0
OPCODE[0..3]
Text Label 4500 6050 0    50   ~ 0
PCOUT0
Wire Wire Line
	4000 4650 3650 4650
Wire Wire Line
	4000 4750 3650 4750
Wire Wire Line
	4000 4850 3650 4850
Wire Wire Line
	4000 4950 3650 4950
Entry Wire Line
	4900 6050 5000 6150
Entry Wire Line
	4900 6150 5000 6250
Entry Wire Line
	4900 6250 5000 6350
Entry Wire Line
	4900 6350 5000 6450
Entry Wire Line
	4900 6450 5000 6550
Entry Wire Line
	4900 6550 5000 6650
Entry Wire Line
	4900 6650 5000 6750
Entry Wire Line
	4900 6750 5000 6850
Entry Wire Line
	4900 6850 5000 6950
Entry Wire Line
	4900 6950 5000 7050
Entry Wire Line
	4900 7050 5000 7150
Entry Wire Line
	4900 7150 5000 7250
Entry Wire Line
	4900 7250 5000 7350
Entry Wire Line
	4900 7350 5000 7450
Entry Wire Line
	4900 7450 5000 7550
Entry Wire Line
	4900 7550 5000 7650
Text Label 5100 7650 0    50   ~ 0
PCOUT[0..15]
$Comp
L 74xx:74HCT273 UPR0
U 1 1 626B897A
P 10000 2000
F 0 "UPR0" H 9750 2650 50  0000 C CNN
F 1 "74HCT273" H 10250 2650 50  0000 C CNN
F 2 "Package_SO:SOIC-20W_7.5x12.8mm_P1.27mm" H 10000 2000 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/74HC_HCT273.pdf" H 10000 2000 50  0001 C CNN
	1    10000 2000
	1    0    0    -1  
$EndComp
Text Label 4500 4450 0    50   ~ 0
REGMEM0
Entry Wire Line
	4900 4450 5000 4550
Entry Wire Line
	4900 4550 5000 4650
Entry Wire Line
	4900 4650 5000 4750
Entry Wire Line
	4900 4750 5000 4850
Entry Wire Line
	4900 4850 5000 4950
Entry Wire Line
	4900 4950 5000 5050
Entry Wire Line
	4900 5050 5000 5150
Entry Wire Line
	4900 5150 5000 5250
Entry Wire Line
	4900 5250 5000 5350
Entry Wire Line
	4900 5350 5000 5450
Entry Wire Line
	4900 5450 5000 5550
Entry Wire Line
	4900 5550 5000 5650
Entry Wire Line
	4900 5650 5000 5750
Entry Wire Line
	4900 5750 5000 5850
Entry Wire Line
	4900 5850 5000 5950
Entry Wire Line
	4900 5950 5000 6050
Text Label 5100 6050 0    50   ~ 0
REGMEM[0..15]
Text Label 4500 4550 0    50   ~ 0
REGMEM1
Text Label 4500 4650 0    50   ~ 0
REGMEM2
Text Label 4500 4750 0    50   ~ 0
REGMEM3
Text Label 4500 4850 0    50   ~ 0
REGMEM4
Text Label 4500 4950 0    50   ~ 0
REGMEM5
Text Label 4500 5050 0    50   ~ 0
REGMEM6
Text Label 4500 5150 0    50   ~ 0
REGMEM7
Text Label 4500 5250 0    50   ~ 0
REGMEM8
Text Label 4500 5350 0    50   ~ 0
REGMEM9
Text Label 4500 5450 0    50   ~ 0
REGMEM10
Text Label 4500 5550 0    50   ~ 0
REGMEM11
Text Label 4500 5650 0    50   ~ 0
REGMEM12
Text Label 4500 5750 0    50   ~ 0
REGMEM13
Text Label 4500 5850 0    50   ~ 0
REGMEM14
Wire Wire Line
	4500 5850 4900 5850
Wire Wire Line
	4500 5750 4900 5750
Wire Wire Line
	4500 5650 4900 5650
Wire Wire Line
	4500 5550 4900 5550
Wire Wire Line
	4500 5950 4900 5950
Wire Wire Line
	4500 5450 4900 5450
Wire Wire Line
	4500 5350 4900 5350
Wire Wire Line
	4500 5250 4900 5250
Wire Wire Line
	4500 5150 4900 5150
Wire Wire Line
	4500 5050 4900 5050
Wire Wire Line
	4500 4950 4900 4950
Wire Wire Line
	4500 6050 4900 6050
Wire Wire Line
	4900 6150 4500 6150
Wire Wire Line
	4900 6250 4500 6250
Wire Wire Line
	4900 6350 4500 6350
Wire Wire Line
	4900 6450 4500 6450
Wire Wire Line
	4900 6550 4500 6550
Wire Wire Line
	4900 6650 4500 6650
Wire Wire Line
	4900 6750 4500 6750
Wire Wire Line
	4900 6850 4500 6850
Wire Wire Line
	4900 6950 4500 6950
Wire Wire Line
	4900 7050 4500 7050
Wire Wire Line
	4900 7150 4500 7150
Wire Wire Line
	4900 7250 4500 7250
Wire Wire Line
	4900 7350 4500 7350
Wire Wire Line
	4900 7450 4500 7450
Wire Wire Line
	4900 7550 4500 7550
Text Label 4500 5950 0    50   ~ 0
REGMEM15
Wire Wire Line
	4500 4450 4900 4450
Wire Wire Line
	4500 4550 4900 4550
Wire Wire Line
	4500 4650 4900 4650
Wire Wire Line
	4500 4750 4900 4750
Wire Wire Line
	4500 4850 4900 4850
Text Label 4500 6150 0    50   ~ 0
PCOUT1
Text Label 4500 6250 0    50   ~ 0
PCOUT2
Text Label 4500 6350 0    50   ~ 0
PCOUT3
Text Label 4500 6450 0    50   ~ 0
PCOUT4
Text Label 4500 6550 0    50   ~ 0
PCOUT5
Text Label 4500 6650 0    50   ~ 0
PCOUT6
Text Label 4500 6750 0    50   ~ 0
PCOUT7
Text Label 4500 6850 0    50   ~ 0
PCOUT8
Text Label 4500 6950 0    50   ~ 0
PCOUT9
Text Label 4500 7050 0    50   ~ 0
PCOUT10
Text Label 4500 7150 0    50   ~ 0
PCOUT11
Text Label 4500 7250 0    50   ~ 0
PCOUT12
Text Label 4500 7350 0    50   ~ 0
PCOUT13
Text Label 4500 7450 0    50   ~ 0
PCOUT14
Text Label 4500 7550 0    50   ~ 0
PCOUT15
Text Label 10500 1500 0    50   ~ 0
PCOUT0
Wire Wire Line
	10500 1500 10900 1500
Wire Wire Line
	10900 1600 10500 1600
Wire Wire Line
	10900 1700 10500 1700
Wire Wire Line
	10900 1800 10500 1800
Wire Wire Line
	10900 1900 10500 1900
Wire Wire Line
	10900 2000 10500 2000
Wire Wire Line
	10900 2100 10500 2100
Wire Wire Line
	10900 2200 10500 2200
Text Label 10500 1600 0    50   ~ 0
PCOUT1
Text Label 10500 1700 0    50   ~ 0
PCOUT2
Text Label 10500 1800 0    50   ~ 0
PCOUT3
Text Label 10500 1900 0    50   ~ 0
PCOUT4
Text Label 10500 2000 0    50   ~ 0
PCOUT5
Text Label 10500 2100 0    50   ~ 0
PCOUT6
Text Label 10500 2200 0    50   ~ 0
PCOUT7
Entry Wire Line
	10900 1500 11000 1600
Entry Wire Line
	10900 1600 11000 1700
Entry Wire Line
	10900 1700 11000 1800
Entry Wire Line
	10900 1800 11000 1900
Entry Wire Line
	10900 1900 11000 2000
Entry Wire Line
	10900 2000 11000 2100
Entry Wire Line
	10900 2100 11000 2200
Entry Wire Line
	10900 2200 11000 2300
$Comp
L power:VCC #PWR0103
U 1 1 627331BE
P 10000 1200
F 0 "#PWR0103" H 10000 1050 50  0001 C CNN
F 1 "VCC" H 10017 1373 50  0000 C CNN
F 2 "" H 10000 1200 50  0001 C CNN
F 3 "" H 10000 1200 50  0001 C CNN
	1    10000 1200
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0104
U 1 1 62733C1E
P 10000 3100
F 0 "#PWR0104" H 10000 2950 50  0001 C CNN
F 1 "VCC" H 9900 3150 50  0000 C CNN
F 2 "" H 10000 3100 50  0001 C CNN
F 3 "" H 10000 3100 50  0001 C CNN
	1    10000 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 627347D1
P 10000 2800
F 0 "#PWR0105" H 10000 2550 50  0001 C CNN
F 1 "GND" H 10100 2700 50  0000 C CNN
F 2 "" H 10000 2800 50  0001 C CNN
F 3 "" H 10000 2800 50  0001 C CNN
	1    10000 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	10900 3400 10500 3400
Wire Wire Line
	10900 3500 10500 3500
Wire Wire Line
	10900 3600 10500 3600
Wire Wire Line
	10900 3700 10500 3700
Wire Wire Line
	10900 3800 10500 3800
Wire Wire Line
	10900 3900 10500 3900
Wire Wire Line
	10900 4000 10500 4000
Wire Wire Line
	10900 4100 10500 4100
Text Label 10500 3400 0    50   ~ 0
PCOUT8
Text Label 10500 3500 0    50   ~ 0
PCOUT9
Text Label 10500 3600 0    50   ~ 0
PCOUT10
Text Label 10500 3700 0    50   ~ 0
PCOUT11
Text Label 10500 3800 0    50   ~ 0
PCOUT12
Text Label 10500 3900 0    50   ~ 0
PCOUT13
Text Label 10500 4000 0    50   ~ 0
PCOUT14
Text Label 10500 4100 0    50   ~ 0
PCOUT15
Entry Wire Line
	10900 3400 11000 3500
Entry Wire Line
	10900 3500 11000 3600
Entry Wire Line
	10900 3600 11000 3700
Entry Wire Line
	10900 3700 11000 3800
Entry Wire Line
	10900 3800 11000 3900
Entry Wire Line
	10900 3900 11000 4000
Entry Wire Line
	10900 4000 11000 4100
Entry Wire Line
	10900 4100 11000 4200
$Sheet
S 9900 5100 1050 1200
U 6282316B
F0 "16 Bit Adder" 50
F1 "16bitadder.sch" 50
F2 "COUNT+1" I L 9900 6100 50 
F3 "COUNT+2" I L 9900 6200 50 
F4 "COUNTCARRY" I R 10950 6200 50 
F5 "CIN[0..15]" I L 9900 5400 50 
F6 "COUT[0..15]" I R 10950 5400 50 
$EndSheet
Text Label 7750 650  0    50   ~ 0
PCINC[0..15]
Wire Bus Line
	10400 2900 11000 2900
Connection ~ 11000 2900
$Comp
L power:VCC #PWR0106
U 1 1 628DE3A1
P 4000 7450
F 0 "#PWR0106" H 4000 7300 50  0001 C CNN
F 1 "VCC" V 4018 7577 50  0000 L CNN
F 2 "" H 4000 7450 50  0001 C CNN
F 3 "" H 4000 7450 50  0001 C CNN
	1    4000 7450
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0107
U 1 1 628DE9D3
P 4000 4450
F 0 "#PWR0107" H 4000 4200 50  0001 C CNN
F 1 "GND" V 4000 4250 50  0000 C CNN
F 2 "" H 4000 4450 50  0001 C CNN
F 3 "" H 4000 4450 50  0001 C CNN
	1    4000 4450
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 628DFE8F
P 4000 7550
F 0 "#PWR0108" H 4000 7300 50  0001 C CNN
F 1 "GND" V 4000 7350 50  0000 C CNN
F 2 "" H 4000 7550 50  0001 C CNN
F 3 "" H 4000 7550 50  0001 C CNN
	1    4000 7550
	0    1    1    0   
$EndComp
Wire Wire Line
	9500 1500 9050 1500
Text Label 9050 1500 0    50   ~ 0
NEXTPC0
Wire Wire Line
	9500 1600 9050 1600
Wire Wire Line
	9050 1700 9500 1700
Wire Wire Line
	9050 1800 9500 1800
Wire Wire Line
	9050 1900 9500 1900
Wire Wire Line
	9050 2000 9500 2000
Wire Wire Line
	9050 2100 9500 2100
Wire Wire Line
	9050 2200 9500 2200
Wire Wire Line
	9050 3400 9500 3400
Wire Wire Line
	9050 3500 9500 3500
Wire Wire Line
	9050 3600 9500 3600
Wire Wire Line
	9050 3700 9500 3700
Wire Wire Line
	9050 3800 9500 3800
Wire Wire Line
	9050 3900 9500 3900
Wire Wire Line
	9050 4000 9500 4000
Wire Wire Line
	9050 4100 9500 4100
Text Label 9050 1600 0    50   ~ 0
NEXTPC1
Text Label 9050 1700 0    50   ~ 0
NEXTPC2
Text Label 9050 1800 0    50   ~ 0
NEXTPC3
Text Label 9050 1900 0    50   ~ 0
NEXTPC4
Text Label 9050 2000 0    50   ~ 0
NEXTPC5
Text Label 9050 2100 0    50   ~ 0
NEXTPC6
Text Label 9050 2200 0    50   ~ 0
NEXTPC7
Text Label 9050 3400 0    50   ~ 0
NEXTPC8
Text Label 9050 3500 0    50   ~ 0
NEXTPC9
Text Label 9050 3600 0    50   ~ 0
NEXTPC10
Text Label 9050 3700 0    50   ~ 0
NEXTPC11
Text Label 9050 3800 0    50   ~ 0
NEXTPC12
Text Label 9050 3900 0    50   ~ 0
NEXTPC13
Text Label 9050 4000 0    50   ~ 0
NEXTPC14
Text Label 9050 4100 0    50   ~ 0
NEXTPC15
Entry Wire Line
	8950 1400 9050 1500
Entry Wire Line
	8950 1500 9050 1600
Entry Wire Line
	8950 1600 9050 1700
Entry Wire Line
	8950 1700 9050 1800
Entry Wire Line
	8950 1800 9050 1900
Entry Wire Line
	8950 1900 9050 2000
Entry Wire Line
	8950 2000 9050 2100
Entry Wire Line
	8950 2100 9050 2200
Entry Wire Line
	8950 3300 9050 3400
Entry Wire Line
	8950 3400 9050 3500
Entry Wire Line
	8950 3500 9050 3600
Entry Wire Line
	8950 3600 9050 3700
Entry Wire Line
	8950 3700 9050 3800
Entry Wire Line
	8950 3800 9050 3900
Entry Wire Line
	8950 3900 9050 4000
Entry Wire Line
	8950 4000 9050 4100
Text Label 8950 1000 0    50   ~ 0
NEXTPC
Text Label 3550 7350 0    50   ~ 0
CLK_WB
Text Label 9050 4300 0    50   ~ 0
CLK_WB
Wire Wire Line
	9050 4300 9500 4300
Text Label 9050 2400 0    50   ~ 0
CLK_WB
Wire Wire Line
	9050 2400 9500 2400
Wire Wire Line
	9050 2500 9500 2500
Text Label 9050 2500 0    50   ~ 0
~RST
Text Label 9050 4400 0    50   ~ 0
~RST
Wire Wire Line
	9050 4400 9500 4400
Text Label 3550 7250 0    50   ~ 0
~RST
Wire Wire Line
	3550 7250 4000 7250
Wire Wire Line
	3550 7350 4000 7350
Text Label 3550 7150 0    50   ~ 0
FLAG_CARRY
Wire Wire Line
	3550 7150 4000 7150
Text Label 3400 2500 2    50   ~ 0
FLAG_CARRY
Wire Wire Line
	9150 6100 9900 6100
Wire Wire Line
	9150 6200 9900 6200
NoConn ~ 11050 6200
Text Label 3650 4650 0    50   ~ 0
OPCODE0
Text Label 3650 4750 0    50   ~ 0
OPCODE1
Text Label 3650 4850 0    50   ~ 0
OPCODE2
Text Label 3650 4950 0    50   ~ 0
OPCODE3
Wire Bus Line
	3550 4950 3150 4950
Entry Wire Line
	3650 5350 3550 5250
Entry Wire Line
	3650 5250 3550 5150
Entry Wire Line
	3650 5150 3550 5050
Entry Wire Line
	3650 5050 3550 4950
Text Label 3150 4950 0    50   ~ 0
IMM[0..3]
Wire Wire Line
	4000 5050 3650 5050
Wire Wire Line
	4000 5150 3650 5150
Wire Wire Line
	4000 5250 3650 5250
Wire Wire Line
	4000 5350 3650 5350
Text Label 3650 5050 0    50   ~ 0
IMM0
Text Label 3650 5150 0    50   ~ 0
IMM1
Text Label 3650 5250 0    50   ~ 0
IMM2
Text Label 3650 5350 0    50   ~ 0
IMM3
$Sheet
S 7850 850  1050 800 
U 629C34E6
F0 "16x 2to1 Mux" 50
F1 "16x2to1Mux.sch" 50
F2 "IN_A[0..15]" I L 7850 1000 50 
F3 "IN_B[0..15]" I L 7850 1150 50 
F4 "SELECT" I L 7850 1400 50 
F5 "~OE" I L 7850 1550 50 
F6 "OUT[0..15]" I R 8900 1000 50 
$EndSheet
Text Label 10400 2900 0    50   ~ 0
PCOUT[0..15]
Wire Bus Line
	7750 650  7750 1000
Wire Bus Line
	7750 1000 7850 1000
Wire Wire Line
	3650 5450 4000 5450
Wire Wire Line
	3650 5550 4000 5550
Wire Wire Line
	3650 5650 4000 5650
Wire Wire Line
	3650 5750 4000 5750
Wire Wire Line
	3650 5850 4000 5850
Wire Wire Line
	3650 5950 4000 5950
Wire Wire Line
	3650 6050 4000 6050
Wire Wire Line
	3650 6150 4000 6150
Wire Wire Line
	3650 6250 4000 6250
Wire Wire Line
	3650 6350 4000 6350
Wire Wire Line
	3650 6450 4000 6450
Wire Wire Line
	3650 6550 4000 6550
Wire Wire Line
	3650 6650 4000 6650
Wire Wire Line
	3650 6750 4000 6750
Wire Wire Line
	3650 6850 4000 6850
Wire Wire Line
	3650 6950 4000 6950
Entry Wire Line
	3550 5350 3650 5450
Entry Wire Line
	3550 5450 3650 5550
Entry Wire Line
	3550 5550 3650 5650
Entry Wire Line
	3550 5650 3650 5750
Entry Wire Line
	3550 5750 3650 5850
Entry Wire Line
	3550 5850 3650 5950
Entry Wire Line
	3550 5950 3650 6050
Entry Wire Line
	3550 6050 3650 6150
Entry Wire Line
	3550 6150 3650 6250
Entry Wire Line
	3550 6250 3650 6350
Entry Wire Line
	3550 6350 3650 6450
Entry Wire Line
	3550 6450 3650 6550
Entry Wire Line
	3550 6550 3650 6650
Entry Wire Line
	3550 6650 3650 6750
Entry Wire Line
	3550 6750 3650 6850
Entry Wire Line
	3550 6850 3650 6950
Wire Bus Line
	3550 5350 3150 5350
Wire Bus Line
	3000 4550 3550 4550
Wire Bus Line
	5000 6050 5600 6050
Wire Bus Line
	5000 7650 5550 7650
Text Label 3650 5450 0    50   ~ 0
RCS0
Text Label 3650 5550 0    50   ~ 0
RCS1
Text Label 3650 5650 0    50   ~ 0
RCS2
Text Label 3650 5750 0    50   ~ 0
RCS3
Text Label 3650 5850 0    50   ~ 0
RCS4
Text Label 3650 5950 0    50   ~ 0
RCS5
Text Label 3650 6050 0    50   ~ 0
RCS6
Text Label 3650 6150 0    50   ~ 0
RCS7
Text Label 3150 5350 0    50   ~ 0
RCS[0..3]
Text Label 3650 6250 0    50   ~ 0
RCD0
Text Label 3650 6350 0    50   ~ 0
RCD1
Text Label 3650 6450 0    50   ~ 0
RCD2
Text Label 3650 6550 0    50   ~ 0
RCD3
Text Label 3650 6650 0    50   ~ 0
RCD4
Text Label 3650 6750 0    50   ~ 0
RCD5
Text Label 3650 6850 0    50   ~ 0
RCD6
Text Label 3650 6950 0    50   ~ 0
RCD7
Wire Bus Line
	3550 6150 3150 6150
Text Label 3150 6150 0    50   ~ 0
RCD[0..3]
Wire Wire Line
	3550 7050 4000 7050
Text Label 7100 1150 0    50   ~ 0
REGMEM[0..15]
Wire Wire Line
	7850 1400 7500 1400
Text Label 7500 1400 0    50   ~ 0
IS_JMP
Wire Wire Line
	7850 1550 7550 1550
NoConn ~ 7550 1550
Text Label 8100 5850 2    50   ~ 0
IS_SKIP
Wire Bus Line
	7100 1150 7850 1150
$Comp
L 74xx_IEEE:74LS684 U1
U 1 1 62C79666
P 1550 2100
F 0 "U1" H 1300 3000 50  0000 C CNN
F 1 "74LS684" H 1750 3000 50  0000 C CNN
F 2 "Package_SO:SSOP-20_3.9x8.7mm_P0.635mm" H 1550 2100 50  0001 C CNN
F 3 "" H 1550 2100 50  0001 C CNN
	1    1550 2100
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0126
U 1 1 62C7A7D5
P 1550 600
F 0 "#PWR0126" H 1550 450 50  0001 C CNN
F 1 "VCC" H 1450 650 50  0000 C CNN
F 2 "" H 1550 600 50  0001 C CNN
F 3 "" H 1550 600 50  0001 C CNN
	1    1550 600 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0127
U 1 1 62C7B182
P 1550 2950
F 0 "#PWR0127" H 1550 2700 50  0001 C CNN
F 1 "GND" H 1650 2850 50  0000 C CNN
F 2 "" H 1550 2950 50  0001 C CNN
F 3 "" H 1550 2950 50  0001 C CNN
	1    1550 2950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 UNAND1
U 3 1 62C84FA1
P 5100 800
F 0 "UNAND1" H 5100 1000 50  0000 C CNN
F 1 "74LS00" H 5100 600 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 5100 800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 5100 800 50  0001 C CNN
	3    5100 800 
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 UNAND1
U 4 1 62C88A3A
P 6300 2950
F 0 "UNAND1" H 6300 3150 50  0000 C CNN
F 1 "74LS00" H 6300 2750 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 6300 2950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 6300 2950 50  0001 C CNN
	4    6300 2950
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 UNAND1
U 5 1 62C89F9E
P 1000 7050
F 0 "UNAND1" H 600 7400 50  0000 L CNN
F 1 "74LS00" H 1050 7400 50  0000 L CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 1000 7050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 1000 7050 50  0001 C CNN
	5    1000 7050
	1    0    0    -1  
$EndComp
Wire Bus Line
	8900 1000 8950 1000
$Comp
L 74xx:74LS00 UNAND1
U 1 1 62C7C1A0
P 2400 2050
F 0 "UNAND1" H 2400 2250 50  0000 C CNN
F 1 "74LS00" H 2400 1850 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 2400 2050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 2400 2050 50  0001 C CNN
	1    2400 2050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS00 UNAND1
U 2 1 62C839EC
P 6300 2400
F 0 "UNAND1" H 6300 2600 50  0000 C CNN
F 1 "74LS00" H 6300 2200 50  0000 C CNN
F 2 "Package_SO:TSSOP-14_4.4x5mm_P0.65mm" H 6300 2400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 6300 2400 50  0001 C CNN
	2    6300 2400
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0128
U 1 1 62CBF072
P 1000 6550
F 0 "#PWR0128" H 1000 6400 50  0001 C CNN
F 1 "VCC" H 900 6600 50  0000 C CNN
F 2 "" H 1000 6550 50  0001 C CNN
F 3 "" H 1000 6550 50  0001 C CNN
	1    1000 6550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0129
U 1 1 62CBF735
P 1000 7550
F 0 "#PWR0129" H 1000 7300 50  0001 C CNN
F 1 "GND" H 1100 7450 50  0000 C CNN
F 2 "" H 1000 7550 50  0001 C CNN
F 3 "" H 1000 7550 50  0001 C CNN
	1    1000 7550
	1    0    0    -1  
$EndComp
Text Label 2100 1650 0    50   ~ 0
cmpeq
Text Label 2050 2400 0    50   ~ 0
cmpgt
Wire Wire Line
	2100 2550 2300 2550
Wire Wire Line
	2300 2550 2300 2400
Text Label 2700 2050 0    50   ~ 0
cmplt
Wire Wire Line
	650  1300 1000 1300
Wire Wire Line
	650  1400 1000 1400
Wire Wire Line
	650  1500 1000 1500
Wire Wire Line
	650  1600 1000 1600
Wire Wire Line
	650  1700 1000 1700
Wire Wire Line
	650  1800 1000 1800
Wire Wire Line
	650  1900 1000 1900
Wire Wire Line
	650  2000 1000 2000
Wire Wire Line
	650  2200 1000 2200
Wire Wire Line
	650  2300 1000 2300
Wire Wire Line
	650  2400 1000 2400
Wire Wire Line
	650  2500 1000 2500
Wire Wire Line
	650  2600 1000 2600
Wire Wire Line
	650  2700 1000 2700
Wire Wire Line
	650  2800 1000 2800
Wire Wire Line
	650  2900 1000 2900
Entry Wire Line
	550  1200 650  1300
Entry Wire Line
	550  1300 650  1400
Entry Wire Line
	550  1400 650  1500
Entry Wire Line
	550  1500 650  1600
Entry Wire Line
	550  1600 650  1700
Entry Wire Line
	550  1700 650  1800
Entry Wire Line
	550  1800 650  1900
Entry Wire Line
	550  1900 650  2000
Entry Wire Line
	550  2100 650  2200
Entry Wire Line
	550  2200 650  2300
Entry Wire Line
	550  2300 650  2400
Entry Wire Line
	550  2400 650  2500
Entry Wire Line
	550  2500 650  2600
Entry Wire Line
	550  2600 650  2700
Entry Wire Line
	550  2700 650  2800
Entry Wire Line
	550  2800 650  2900
Text Label 650  1300 0    50   ~ 0
RCS0
Text Label 650  1400 0    50   ~ 0
RCS1
Text Label 650  1500 0    50   ~ 0
RCS2
Text Label 650  1600 0    50   ~ 0
RCS3
Text Label 650  1700 0    50   ~ 0
RCS4
Text Label 650  1800 0    50   ~ 0
RCS5
Text Label 650  1900 0    50   ~ 0
RCS6
Text Label 650  2000 0    50   ~ 0
RCS7
Text Label 600  1150 0    50   ~ 0
RCS[0..3]
Text Label 650  2200 0    50   ~ 0
RCD0
Text Label 650  2300 0    50   ~ 0
RCD1
Text Label 650  2400 0    50   ~ 0
RCD2
Text Label 650  2500 0    50   ~ 0
RCD3
Text Label 650  2600 0    50   ~ 0
RCD4
Text Label 650  2700 0    50   ~ 0
RCD5
Text Label 650  2800 0    50   ~ 0
RCD6
Text Label 650  2900 0    50   ~ 0
RCD7
Text Label 600  3000 0    50   ~ 0
RCD[0..3]
Wire Wire Line
	2100 1950 2000 1950
Wire Wire Line
	2000 1950 2000 1750
Wire Wire Line
	2000 2150 2100 2150
Wire Wire Line
	2300 2400 2000 2400
Wire Wire Line
	2000 2400 2000 2150
Wire Wire Line
	2100 1650 2300 1650
Wire Wire Line
	2300 1650 2300 1750
Wire Wire Line
	2000 1750 2300 1750
Wire Bus Line
	550  1150 1000 1150
Wire Bus Line
	550  3000 1000 3000
Wire Wire Line
	11050 6200 10950 6200
$Comp
L power:GND #PWR0130
U 1 1 62F187D1
P 3500 1800
F 0 "#PWR0130" H 3500 1550 50  0001 C CNN
F 1 "GND" V 3500 1600 50  0000 C CNN
F 2 "" H 3500 1800 50  0001 C CNN
F 3 "" H 3500 1800 50  0001 C CNN
	1    3500 1800
	0    1    1    0   
$EndComp
$Comp
L 74xx_IEEE:74151 U2
U 1 1 62DCAA22
P 4050 1900
F 0 "U2" H 3800 2600 50  0000 C CNN
F 1 "74151" H 4250 2600 50  0000 C CNN
F 2 "Package_SO:SOP-16_4.55x10.3mm_P1.27mm" H 4050 1900 50  0001 C CNN
F 3 "" H 4050 1900 50  0001 C CNN
	1    4050 1900
	1    0    0    -1  
$EndComp
NoConn ~ 3500 1900
Text Label 3400 2000 2    50   ~ 0
RCS7
Wire Wire Line
	3400 2000 3500 2000
Text Label 3400 2400 2    50   ~ 0
RCS0
Wire Wire Line
	3400 2400 3500 2400
Wire Wire Line
	3400 2500 3500 2500
Text Label 3400 2100 2    50   ~ 0
cmpgt
Wire Wire Line
	3400 2100 3500 2100
Text Label 3400 2200 2    50   ~ 0
cmpeq
Wire Wire Line
	3400 2200 3500 2200
Text Label 3400 2300 2    50   ~ 0
cmplt
Wire Wire Line
	3400 2300 3500 2300
Text Notes 2950 2900 0    50   ~ 0
Choose which condition to skip/jump on
$Comp
L power:GND #PWR0131
U 1 1 62F909F2
P 3500 1350
F 0 "#PWR0131" H 3500 1100 50  0001 C CNN
F 1 "GND" V 3500 1150 50  0000 C CNN
F 2 "" H 3500 1350 50  0001 C CNN
F 3 "" H 3500 1350 50  0001 C CNN
	1    3500 1350
	0    1    1    0   
$EndComp
Wire Bus Line
	2650 1250 2250 1250
Entry Wire Line
	2750 1650 2650 1550
Entry Wire Line
	2750 1550 2650 1450
Entry Wire Line
	2750 1450 2650 1350
Entry Wire Line
	2750 1350 2650 1250
Text Label 2250 1250 0    50   ~ 0
IMM[0..3]
Wire Wire Line
	3150 1350 2750 1350
Text Label 2750 1350 0    50   ~ 0
IMM0
Text Label 2750 1450 0    50   ~ 0
IMM1
Text Label 2750 1550 0    50   ~ 0
IMM2
Text Label 2750 1650 0    50   ~ 0
IMM3
Wire Wire Line
	2750 1450 3500 1450
Wire Wire Line
	2750 1550 3500 1550
Wire Wire Line
	2750 1650 3500 1650
$Comp
L power:GND #PWR0132
U 1 1 62FE2CA6
P 4050 2600
F 0 "#PWR0132" H 4050 2350 50  0001 C CNN
F 1 "GND" H 4150 2500 50  0000 C CNN
F 2 "" H 4050 2600 50  0001 C CNN
F 3 "" H 4050 2600 50  0001 C CNN
	1    4050 2600
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0133
U 1 1 62FE3062
P 4050 1250
F 0 "#PWR0133" H 4050 1100 50  0001 C CNN
F 1 "VCC" H 4067 1423 50  0000 C CNN
F 2 "" H 4050 1250 50  0001 C CNN
F 3 "" H 4050 1250 50  0001 C CNN
	1    4050 1250
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 UXOR1
U 1 1 62FE41EE
P 5100 1450
F 0 "UXOR1" H 5100 1650 50  0000 C CNN
F 1 "74HC86" H 5100 1250 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5100 1450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 5100 1450 50  0001 C CNN
	1    5100 1450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 UXOR1
U 2 1 62FE9339
P 1800 5450
F 0 "UXOR1" H 1800 5650 50  0000 C CNN
F 1 "74HC86" H 1800 5250 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 1800 5450 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 1800 5450 50  0001 C CNN
	2    1800 5450
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 UXOR1
U 3 1 62FEBF2A
P 8850 6200
F 0 "UXOR1" H 8850 6400 50  0000 C CNN
F 1 "74HC86" H 8850 6000 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 8850 6200 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 8850 6200 50  0001 C CNN
	3    8850 6200
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 UXOR1
U 4 1 62FEDD88
P 5300 3050
F 0 "UXOR1" H 5300 3250 50  0000 C CNN
F 1 "74HC86" H 5250 2850 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5300 3050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 5300 3050 50  0001 C CNN
	4    5300 3050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74HC86 UXOR1
U 5 1 62FF15B6
P 1800 7050
F 0 "UXOR1" H 1450 7400 50  0000 L CNN
F 1 "74HC86" H 1850 7400 50  0000 L CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 1800 7050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74HC86" H 1800 7050 50  0001 C CNN
	5    1800 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1000 6550 1400 6550
Connection ~ 1000 6550
Wire Wire Line
	1800 7550 1400 7550
Connection ~ 1000 7550
Wire Wire Line
	4650 1350 4650 1000
Wire Wire Line
	4650 1000 3150 1000
Wire Wire Line
	3150 1000 3150 1350
Text Label 6900 2400 2    50   ~ 0
IS_JMP
Text Label 6900 2950 2    50   ~ 0
IS_SKIP
$Comp
L 74xx:74LS21 UQAND1
U 1 1 63093CA7
P 6100 1300
F 0 "UQAND1" H 6100 1550 50  0000 C CNN
F 1 "74LS21" H 6100 1050 50  0000 C CNN
F 2 "Package_SO:MSOP-12-16_3x4mm_P0.5mm" H 6100 1300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 6100 1300 50  0001 C CNN
	1    6100 1300
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 UQAND1
U 2 1 63096EC2
P 1800 6050
F 0 "UQAND1" H 1800 6300 50  0000 C CNN
F 1 "74LS21" H 1800 5800 50  0000 C CNN
F 2 "Package_SO:MSOP-12-16_3x4mm_P0.5mm" H 1800 6050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 1800 6050 50  0001 C CNN
	2    1800 6050
	1    0    0    -1  
$EndComp
$Comp
L 74xx:74LS21 UQAND1
U 3 1 63098AAC
P 2650 7050
F 0 "UQAND1" H 2250 7400 50  0000 L CNN
F 1 "74LS21" H 2700 7400 50  0000 L CNN
F 2 "Package_SO:MSOP-12-16_3x4mm_P0.5mm" H 2650 7050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS21" H 2650 7050 50  0001 C CNN
	3    2650 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 6550 1800 6550
Connection ~ 1800 6550
Wire Wire Line
	1800 7550 2650 7550
Connection ~ 1800 7550
Wire Bus Line
	7750 650  11100 650 
Wire Bus Line
	9900 5400 9800 5400
Wire Bus Line
	9800 5400 9800 4950
Wire Bus Line
	9800 4950 11000 4950
Wire Bus Line
	10950 5400 11100 5400
Wire Bus Line
	11100 650  11100 5400
NoConn ~ 3550 7050
Text Label 4950 3150 2    50   ~ 0
OPCODE0
Text Label 4800 900  2    50   ~ 0
OPCODE1
Text Label 5700 1250 2    50   ~ 0
OPCODE2
Text Label 5700 1350 2    50   ~ 0
OPCODE3
$Comp
L power:VCC #PWR0134
U 1 1 6323B3E5
P 4700 700
F 0 "#PWR0134" H 4700 550 50  0001 C CNN
F 1 "VCC" H 4600 750 50  0000 C CNN
F 2 "" H 4700 700 50  0001 C CNN
F 3 "" H 4700 700 50  0001 C CNN
	1    4700 700 
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 700  4700 700 
Wire Wire Line
	5700 1350 5800 1350
Wire Wire Line
	5800 1250 5700 1250
Wire Wire Line
	5550 2300 6000 2300
Wire Wire Line
	5550 2300 5550 2850
Wire Wire Line
	5550 2850 6000 2850
Text Label 5950 2500 2    50   ~ 0
OPCODE0
$Comp
L power:VCC #PWR0135
U 1 1 632D8928
P 4950 2950
F 0 "#PWR0135" H 4950 2800 50  0001 C CNN
F 1 "VCC" H 4850 3000 50  0000 C CNN
F 2 "" H 4950 2950 50  0001 C CNN
F 3 "" H 4950 2950 50  0001 C CNN
	1    4950 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 2950 5000 2950
Wire Wire Line
	5600 3050 6000 3050
Wire Wire Line
	4950 3150 5000 3150
Wire Wire Line
	5950 2500 6000 2500
Wire Wire Line
	6900 2400 6600 2400
Wire Wire Line
	6900 2950 6600 2950
NoConn ~ 2100 5450
NoConn ~ 2100 6050
$Comp
L power:VCC #PWR0136
U 1 1 626E4355
P 1500 5900
F 0 "#PWR0136" H 1500 5750 50  0001 C CNN
F 1 "VCC" V 1500 6100 50  0000 C CNN
F 2 "" H 1500 5900 50  0001 C CNN
F 3 "" H 1500 5900 50  0001 C CNN
	1    1500 5900
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0137
U 1 1 626E4F2F
P 1500 6000
F 0 "#PWR0137" H 1500 5850 50  0001 C CNN
F 1 "VCC" V 1500 6200 50  0000 C CNN
F 2 "" H 1500 6000 50  0001 C CNN
F 3 "" H 1500 6000 50  0001 C CNN
	1    1500 6000
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0138
U 1 1 626E51D8
P 1500 6100
F 0 "#PWR0138" H 1500 5950 50  0001 C CNN
F 1 "VCC" V 1500 6300 50  0000 C CNN
F 2 "" H 1500 6100 50  0001 C CNN
F 3 "" H 1500 6100 50  0001 C CNN
	1    1500 6100
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0139
U 1 1 626E548F
P 1500 6200
F 0 "#PWR0139" H 1500 6050 50  0001 C CNN
F 1 "VCC" V 1500 6400 50  0000 C CNN
F 2 "" H 1500 6200 50  0001 C CNN
F 3 "" H 1500 6200 50  0001 C CNN
	1    1500 6200
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0140
U 1 1 626E5773
P 8550 6300
F 0 "#PWR0140" H 8550 6150 50  0001 C CNN
F 1 "VCC" V 8550 6500 50  0000 C CNN
F 2 "" H 8550 6300 50  0001 C CNN
F 3 "" H 8550 6300 50  0001 C CNN
	1    8550 6300
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0142
U 1 1 626F8DE5
P 1500 5350
F 0 "#PWR0142" H 1500 5200 50  0001 C CNN
F 1 "VCC" V 1500 5550 50  0000 C CNN
F 2 "" H 1500 5350 50  0001 C CNN
F 3 "" H 1500 5350 50  0001 C CNN
	1    1500 5350
	0    -1   -1   0   
$EndComp
$Comp
L power:VCC #PWR0143
U 1 1 626F90FB
P 1500 5550
F 0 "#PWR0143" H 1500 5400 50  0001 C CNN
F 1 "VCC" V 1500 5750 50  0000 C CNN
F 2 "" H 1500 5550 50  0001 C CNN
F 3 "" H 1500 5550 50  0001 C CNN
	1    1500 5550
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9150 6100 9150 5850
Wire Wire Line
	9150 5850 8400 5850
Wire Wire Line
	8400 5850 8400 6100
Wire Wire Line
	8400 6100 8550 6100
Wire Wire Line
	8400 5850 8100 5850
Connection ~ 8400 5850
Wire Wire Line
	4800 1350 4650 1350
Wire Wire Line
	4600 1550 4800 1550
Wire Wire Line
	5400 1450 5800 1450
Wire Wire Line
	5400 800  5600 800 
Wire Wire Line
	5600 800  5600 1150
Wire Wire Line
	5600 1150 5800 1150
NoConn ~ 4600 2250
Wire Wire Line
	5550 2300 5550 1900
Wire Wire Line
	5550 1900 6550 1900
Wire Wire Line
	6550 1900 6550 1300
Wire Wire Line
	6400 1300 6550 1300
Connection ~ 5550 2300
$Comp
L Device:C C1
U 1 1 628BABB7
P 1400 7050
F 0 "C1" H 1300 6950 50  0000 L CNN
F 1 ".1uF" H 1400 6950 50  0000 L CNN
F 2 "" H 1438 6900 50  0001 C CNN
F 3 "~" H 1400 7050 50  0001 C CNN
	1    1400 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 6900 1400 6550
Connection ~ 1400 6550
Wire Wire Line
	1400 6550 1800 6550
Wire Wire Line
	1400 7200 1400 7550
Connection ~ 1400 7550
Wire Wire Line
	1400 7550 1000 7550
$Comp
L Device:C C3
U 1 1 628E0193
P 2200 7050
F 0 "C3" H 2100 6950 50  0000 L CNN
F 1 ".1uF" H 2200 6950 50  0000 L CNN
F 2 "" H 2238 6900 50  0001 C CNN
F 3 "~" H 2200 7050 50  0001 C CNN
	1    2200 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 6900 2200 6550
Wire Wire Line
	2200 7200 2200 7550
$Comp
L Device:C C4
U 1 1 628F1AE9
P 3050 7050
F 0 "C4" H 2950 6950 50  0000 L CNN
F 1 ".1uF" H 3050 6950 50  0000 L CNN
F 2 "" H 3088 6900 50  0001 C CNN
F 3 "~" H 3050 7050 50  0001 C CNN
	1    3050 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 6900 3050 6550
Wire Wire Line
	3050 7200 3050 7550
Wire Wire Line
	3050 6550 2650 6550
Connection ~ 2650 6550
Wire Wire Line
	2650 7550 3050 7550
Connection ~ 2650 7550
Connection ~ 1550 600 
Wire Wire Line
	1550 600  1700 600 
$Comp
L Device:C C2
U 1 1 629281CA
P 1700 750
F 0 "C2" H 1600 650 50  0000 L CNN
F 1 ".1uF" H 1700 650 50  0000 L CNN
F 2 "" H 1738 600 50  0001 C CNN
F 3 "~" H 1700 750 50  0001 C CNN
	1    1700 750 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 62973523
P 1700 900
F 0 "#PWR0109" H 1700 650 50  0001 C CNN
F 1 "GND" H 1800 800 50  0000 C CNN
F 2 "" H 1700 900 50  0001 C CNN
F 3 "" H 1700 900 50  0001 C CNN
	1    1700 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 600  1550 1250
$Comp
L power:VCC #PWR0110
U 1 1 6299F7CB
P 4450 1700
F 0 "#PWR0110" H 4450 1550 50  0001 C CNN
F 1 "VCC" H 4550 1750 50  0000 C CNN
F 2 "" H 4450 1700 50  0001 C CNN
F 3 "" H 4450 1700 50  0001 C CNN
	1    4450 1700
	1    0    0    -1  
$EndComp
$Comp
L Device:C C5
U 1 1 6299F7D3
P 4450 1850
F 0 "C5" H 4350 1750 50  0000 L CNN
F 1 ".1uF" H 4450 1750 50  0000 L CNN
F 2 "" H 4488 1700 50  0001 C CNN
F 3 "~" H 4450 1850 50  0001 C CNN
	1    4450 1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0141
U 1 1 6299F7D9
P 4450 2000
F 0 "#PWR0141" H 4450 1750 50  0001 C CNN
F 1 "GND" H 4550 1900 50  0000 C CNN
F 2 "" H 4450 2000 50  0001 C CNN
F 3 "" H 4450 2000 50  0001 C CNN
	1    4450 2000
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0150
U 1 1 629CCC76
P 9200 2750
F 0 "#PWR0150" H 9200 2600 50  0001 C CNN
F 1 "VCC" H 9100 2800 50  0000 C CNN
F 2 "" H 9200 2750 50  0001 C CNN
F 3 "" H 9200 2750 50  0001 C CNN
	1    9200 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C6
U 1 1 629CCC7E
P 9200 2900
F 0 "C6" H 9100 2800 50  0000 L CNN
F 1 ".1uF" H 9200 2800 50  0000 L CNN
F 2 "" H 9238 2750 50  0001 C CNN
F 3 "~" H 9200 2900 50  0001 C CNN
	1    9200 2900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0151
U 1 1 629CCC84
P 9200 3050
F 0 "#PWR0151" H 9200 2800 50  0001 C CNN
F 1 "GND" H 9300 2950 50  0000 C CNN
F 2 "" H 9200 3050 50  0001 C CNN
F 3 "" H 9200 3050 50  0001 C CNN
	1    9200 3050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0152
U 1 1 62A06150
P 9500 2750
F 0 "#PWR0152" H 9500 2600 50  0001 C CNN
F 1 "VCC" H 9400 2800 50  0000 C CNN
F 2 "" H 9500 2750 50  0001 C CNN
F 3 "" H 9500 2750 50  0001 C CNN
	1    9500 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 62A06156
P 9500 2900
F 0 "C7" H 9400 2800 50  0000 L CNN
F 1 ".1uF" H 9500 2800 50  0000 L CNN
F 2 "" H 9538 2750 50  0001 C CNN
F 3 "~" H 9500 2900 50  0001 C CNN
	1    9500 2900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0153
U 1 1 62A0615C
P 9500 3050
F 0 "#PWR0153" H 9500 2800 50  0001 C CNN
F 1 "GND" H 9600 2950 50  0000 C CNN
F 2 "" H 9500 3050 50  0001 C CNN
F 3 "" H 9500 3050 50  0001 C CNN
	1    9500 3050
	1    0    0    -1  
$EndComp
Wire Bus Line
	3550 4550 3550 4850
Wire Bus Line
	3550 4950 3550 5250
Wire Bus Line
	2650 1250 2650 1550
Wire Bus Line
	3550 5350 3550 6050
Wire Bus Line
	3550 6150 3550 6850
Wire Bus Line
	550  2100 550  3000
Wire Bus Line
	550  1150 550  1900
Wire Bus Line
	11000 1600 11000 2900
Wire Bus Line
	11000 2900 11000 4950
Wire Bus Line
	5000 6150 5000 7650
Wire Bus Line
	5000 4550 5000 6050
Wire Bus Line
	8950 1000 8950 4000
$EndSCHEMATC
