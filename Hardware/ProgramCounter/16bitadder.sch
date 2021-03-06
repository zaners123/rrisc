EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 3
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1550 4950 0    50   Input ~ 0
CIN[0..15]
Wire Bus Line
	1550 4950 2050 4950
Text HLabel 9750 2600 2    50   Input ~ 0
COUT[0..15]
$Comp
L 74xx:74LS283 UADD?
U 1 1 628499F1
P 3000 3850
AR Path="/628499F1" Ref="UADD?"  Part="1" 
AR Path="/6282316B/628499F1" Ref="UADD0"  Part="1" 
F 0 "UADD0" H 2700 4500 50  0000 C CNN
F 1 "74x283" H 3200 4500 50  0000 C CNN
F 2 "aFootprint:R-PDSO-G16" H 3000 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS283" H 3000 3850 50  0001 C CNN
	1    3000 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 4050 2150 4050
Wire Wire Line
	2500 4150 2150 4150
Wire Wire Line
	2500 4250 2150 4250
Wire Wire Line
	2500 4350 2150 4350
$Comp
L power:GND #PWR?
U 1 1 62849A00
P 2400 3850
AR Path="/62849A00" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A00" Ref="#PWR0111"  Part="1" 
F 0 "#PWR0111" H 2400 3600 50  0001 C CNN
F 1 "GND" V 2400 3650 50  0000 C CNN
F 2 "" H 2400 3850 50  0001 C CNN
F 3 "" H 2400 3850 50  0001 C CNN
	1    2400 3850
	0    1    1    0   
$EndComp
Wire Wire Line
	2450 3850 2500 3850
Wire Wire Line
	2450 3850 2450 3750
Wire Wire Line
	2450 3750 2500 3750
Wire Wire Line
	2400 3850 2450 3850
Connection ~ 2450 3850
$Comp
L 74xx:74LS283 UADD?
U 1 1 62849A0B
P 4800 3850
AR Path="/62849A0B" Ref="UADD?"  Part="1" 
AR Path="/6282316B/62849A0B" Ref="UADD1"  Part="1" 
F 0 "UADD1" H 4500 4500 50  0000 C CNN
F 1 "74x283" H 5000 4500 50  0000 C CNN
F 2 "aFootprint:R-PDSO-G16" H 4800 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS283" H 4800 3850 50  0001 C CNN
	1    4800 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 3650 4250 3750
Connection ~ 4250 3650
Wire Wire Line
	4250 3550 4300 3550
Wire Wire Line
	4250 3650 4250 3550
Connection ~ 4250 3750
Wire Wire Line
	4250 3650 4300 3650
Wire Wire Line
	4250 3750 4300 3750
Wire Wire Line
	4250 3850 4250 3750
Wire Wire Line
	4250 3850 4300 3850
Wire Wire Line
	4200 3350 4300 3350
Entry Wire Line
	2050 4150 2150 4050
Entry Wire Line
	2050 4250 2150 4150
Entry Wire Line
	2050 4350 2150 4250
Entry Wire Line
	2050 4450 2150 4350
Entry Wire Line
	3950 3550 3850 3650
Entry Wire Line
	3950 3450 3850 3550
Entry Wire Line
	3950 3350 3850 3450
Entry Wire Line
	3950 3250 3850 3350
Wire Wire Line
	3850 3350 3500 3350
Wire Wire Line
	3500 3450 3850 3450
Wire Wire Line
	3500 3550 3850 3550
Wire Wire Line
	3500 3650 3850 3650
Wire Wire Line
	4300 4050 3950 4050
Wire Wire Line
	4300 4150 3950 4150
Wire Wire Line
	4300 4250 3950 4250
Wire Wire Line
	4300 4350 3950 4350
Entry Wire Line
	3850 4150 3950 4050
Entry Wire Line
	3850 4250 3950 4150
Entry Wire Line
	3850 4350 3950 4250
Entry Wire Line
	3850 4450 3950 4350
$Comp
L power:GND #PWR?
U 1 1 62849A35
P 3000 4650
AR Path="/62849A35" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A35" Ref="#PWR0112"  Part="1" 
F 0 "#PWR0112" H 3000 4400 50  0001 C CNN
F 1 "GND" H 3100 4550 50  0000 C CNN
F 2 "" H 3000 4650 50  0001 C CNN
F 3 "" H 3000 4650 50  0001 C CNN
	1    3000 4650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 62849A3B
P 4800 3050
AR Path="/62849A3B" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A3B" Ref="#PWR0113"  Part="1" 
F 0 "#PWR0113" H 4800 2900 50  0001 C CNN
F 1 "VCC" H 4817 3223 50  0000 C CNN
F 2 "" H 4800 3050 50  0001 C CNN
F 3 "" H 4800 3050 50  0001 C CNN
	1    4800 3050
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR?
U 1 1 62849A41
P 3000 3050
AR Path="/62849A41" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A41" Ref="#PWR0114"  Part="1" 
F 0 "#PWR0114" H 3000 2900 50  0001 C CNN
F 1 "VCC" H 3017 3223 50  0000 C CNN
F 2 "" H 3000 3050 50  0001 C CNN
F 3 "" H 3000 3050 50  0001 C CNN
	1    3000 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 62849A47
P 4800 4650
AR Path="/62849A47" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A47" Ref="#PWR0115"  Part="1" 
F 0 "#PWR0115" H 4800 4400 50  0001 C CNN
F 1 "GND" H 4900 4550 50  0000 C CNN
F 2 "" H 4800 4650 50  0001 C CNN
F 3 "" H 4800 4650 50  0001 C CNN
	1    4800 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 62849A4D
P 4250 3850
AR Path="/62849A4D" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A4D" Ref="#PWR0116"  Part="1" 
F 0 "#PWR0116" H 4250 3600 50  0001 C CNN
F 1 "GND" H 4100 3800 50  0000 C CNN
F 2 "" H 4250 3850 50  0001 C CNN
F 3 "" H 4250 3850 50  0001 C CNN
	1    4250 3850
	1    0    0    -1  
$EndComp
Connection ~ 4250 3850
Wire Wire Line
	3500 3850 3650 3850
Wire Wire Line
	3650 3850 3650 3750
Wire Wire Line
	4200 3750 4200 3350
$Comp
L 74xx:74LS283 UADD?
U 1 1 62849A5C
P 6600 3850
AR Path="/62849A5C" Ref="UADD?"  Part="1" 
AR Path="/6282316B/62849A5C" Ref="UADD2"  Part="1" 
F 0 "UADD2" H 6300 4500 50  0000 C CNN
F 1 "74x283" H 6800 4500 50  0000 C CNN
F 2 "aFootprint:R-PDSO-G16" H 6600 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS283" H 6600 3850 50  0001 C CNN
	1    6600 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 3650 6050 3750
Connection ~ 6050 3650
Wire Wire Line
	6050 3550 6100 3550
Wire Wire Line
	6050 3650 6050 3550
Connection ~ 6050 3750
Wire Wire Line
	6050 3650 6100 3650
Wire Wire Line
	6050 3750 6100 3750
Wire Wire Line
	6050 3850 6050 3750
Wire Wire Line
	6050 3850 6100 3850
Wire Wire Line
	6000 3350 6100 3350
Entry Wire Line
	5750 3550 5650 3650
Entry Wire Line
	5750 3450 5650 3550
Entry Wire Line
	5750 3350 5650 3450
Entry Wire Line
	5750 3250 5650 3350
Wire Wire Line
	5650 3650 5300 3650
Wire Wire Line
	5300 3350 5650 3350
Wire Wire Line
	5300 3450 5650 3450
Wire Wire Line
	5300 3550 5650 3550
Wire Wire Line
	6100 4050 5750 4050
Wire Wire Line
	6100 4150 5750 4150
Wire Wire Line
	6100 4250 5750 4250
Wire Wire Line
	6100 4350 5750 4350
Entry Wire Line
	5650 4150 5750 4050
Entry Wire Line
	5650 4250 5750 4150
Entry Wire Line
	5650 4350 5750 4250
Entry Wire Line
	5650 4450 5750 4350
$Comp
L power:VCC #PWR?
U 1 1 62849A7D
P 6600 3050
AR Path="/62849A7D" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A7D" Ref="#PWR0117"  Part="1" 
F 0 "#PWR0117" H 6600 2900 50  0001 C CNN
F 1 "VCC" H 6617 3223 50  0000 C CNN
F 2 "" H 6600 3050 50  0001 C CNN
F 3 "" H 6600 3050 50  0001 C CNN
	1    6600 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 62849A83
P 6600 4650
AR Path="/62849A83" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A83" Ref="#PWR0118"  Part="1" 
F 0 "#PWR0118" H 6600 4400 50  0001 C CNN
F 1 "GND" H 6700 4550 50  0000 C CNN
F 2 "" H 6600 4650 50  0001 C CNN
F 3 "" H 6600 4650 50  0001 C CNN
	1    6600 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 62849A89
P 6050 3850
AR Path="/62849A89" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62849A89" Ref="#PWR0119"  Part="1" 
F 0 "#PWR0119" H 6050 3600 50  0001 C CNN
F 1 "GND" H 5900 3800 50  0000 C CNN
F 2 "" H 6050 3850 50  0001 C CNN
F 3 "" H 6050 3850 50  0001 C CNN
	1    6050 3850
	1    0    0    -1  
$EndComp
Connection ~ 6050 3850
Wire Wire Line
	5300 3850 5450 3850
Wire Wire Line
	5450 3850 5450 3750
Wire Wire Line
	6000 3750 6000 3350
Connection ~ 2050 4950
Text Notes 7000 6650 0    50   ~ 0
A 16-bit adder made from four 4-bit adders
Text HLabel 1550 3550 0    50   Input ~ 0
COUNT+1
Text HLabel 1550 3650 0    50   Input ~ 0
COUNT+2
$Comp
L power:GND #PWR?
U 1 1 628581EB
P 2350 3350
AR Path="/628581EB" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/628581EB" Ref="#PWR0120"  Part="1" 
F 0 "#PWR0120" H 2350 3100 50  0001 C CNN
F 1 "GND" V 2350 3150 50  0000 C CNN
F 2 "" H 2350 3350 50  0001 C CNN
F 3 "" H 2350 3350 50  0001 C CNN
	1    2350 3350
	0    1    1    0   
$EndComp
Wire Wire Line
	2350 3350 2500 3350
Wire Wire Line
	1550 3550 2500 3550
Wire Wire Line
	1550 3650 2500 3650
$Comp
L 74xx:74LS283 UADD?
U 1 1 62863A6B
P 8400 3850
AR Path="/62863A6B" Ref="UADD?"  Part="1" 
AR Path="/6282316B/62863A6B" Ref="UADD3"  Part="1" 
F 0 "UADD3" H 8100 4500 50  0000 C CNN
F 1 "74x283" H 8600 4500 50  0000 C CNN
F 2 "aFootprint:R-PDSO-G16" H 8400 3850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS283" H 8400 3850 50  0001 C CNN
	1    8400 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 3650 7850 3750
Connection ~ 7850 3650
Wire Wire Line
	7850 3550 7900 3550
Wire Wire Line
	7850 3650 7850 3550
Connection ~ 7850 3750
Wire Wire Line
	7850 3650 7900 3650
Wire Wire Line
	7850 3750 7900 3750
Wire Wire Line
	7850 3850 7850 3750
Wire Wire Line
	7850 3850 7900 3850
Wire Wire Line
	7800 3350 7900 3350
Entry Wire Line
	7550 3550 7450 3650
Entry Wire Line
	7550 3450 7450 3550
Entry Wire Line
	7550 3350 7450 3450
Entry Wire Line
	7550 3250 7450 3350
Wire Wire Line
	7450 3350 7100 3350
Wire Wire Line
	7100 3450 7450 3450
Wire Wire Line
	7100 3550 7450 3550
Wire Wire Line
	7100 3650 7450 3650
Wire Wire Line
	7900 4050 7550 4050
Wire Wire Line
	7900 4150 7550 4150
Wire Wire Line
	7900 4250 7550 4250
Wire Wire Line
	7900 4350 7550 4350
Entry Wire Line
	7450 4150 7550 4050
Entry Wire Line
	7450 4250 7550 4150
Entry Wire Line
	7450 4350 7550 4250
Entry Wire Line
	7450 4450 7550 4350
$Comp
L power:VCC #PWR?
U 1 1 62863A8C
P 8400 3050
AR Path="/62863A8C" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62863A8C" Ref="#PWR0121"  Part="1" 
F 0 "#PWR0121" H 8400 2900 50  0001 C CNN
F 1 "VCC" H 8417 3223 50  0000 C CNN
F 2 "" H 8400 3050 50  0001 C CNN
F 3 "" H 8400 3050 50  0001 C CNN
	1    8400 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 62863A92
P 8400 4650
AR Path="/62863A92" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62863A92" Ref="#PWR0122"  Part="1" 
F 0 "#PWR0122" H 8400 4400 50  0001 C CNN
F 1 "GND" H 8500 4550 50  0000 C CNN
F 2 "" H 8400 4650 50  0001 C CNN
F 3 "" H 8400 4650 50  0001 C CNN
	1    8400 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 62863A98
P 7850 3850
AR Path="/62863A98" Ref="#PWR?"  Part="1" 
AR Path="/6282316B/62863A98" Ref="#PWR0123"  Part="1" 
F 0 "#PWR0123" H 7850 3600 50  0001 C CNN
F 1 "GND" H 7700 3800 50  0000 C CNN
F 2 "" H 7850 3850 50  0001 C CNN
F 3 "" H 7850 3850 50  0001 C CNN
	1    7850 3850
	1    0    0    -1  
$EndComp
Connection ~ 7850 3850
Wire Wire Line
	7100 3850 7250 3850
Wire Wire Line
	7250 3850 7250 3750
Wire Wire Line
	7800 3750 7800 3350
Text Label 2150 4050 0    50   ~ 0
CIN0
Text Label 2150 4150 0    50   ~ 0
CIN1
Text Label 2150 4250 0    50   ~ 0
CIN2
Text Label 2150 4350 0    50   ~ 0
CIN3
Text Label 3500 3350 0    50   ~ 0
COUT0
Text Label 3500 3450 0    50   ~ 0
COUT1
Text Label 3500 3550 0    50   ~ 0
COUT2
Text Label 3500 3650 0    50   ~ 0
COUT3
Text Label 5300 3350 0    50   ~ 0
COUT4
Text Label 5300 3450 0    50   ~ 0
COUT5
Text Label 5300 3550 0    50   ~ 0
COUT6
Connection ~ 5750 2600
Wire Bus Line
	3950 2600 5750 2600
Wire Wire Line
	3650 3750 4200 3750
Wire Bus Line
	2050 4950 3850 4950
Connection ~ 3850 4950
Connection ~ 7550 2600
Wire Bus Line
	5750 2600 7550 2600
Wire Wire Line
	5450 3750 6000 3750
Wire Bus Line
	3850 4950 5650 4950
Connection ~ 5650 4950
Text Label 3950 4050 0    50   ~ 0
CIN4
Text Label 3950 4150 0    50   ~ 0
CIN5
Text Label 3950 4250 0    50   ~ 0
CIN6
Text Label 3950 4350 0    50   ~ 0
CIN7
Text Label 5750 4050 0    50   ~ 0
CIN8
Text Label 5750 4150 0    50   ~ 0
CIN9
Text Label 5750 4250 0    50   ~ 0
CIN10
Text Label 5750 4350 0    50   ~ 0
CIN11
Text Label 7550 4050 0    50   ~ 0
CIN12
Text Label 7550 4150 0    50   ~ 0
CIN13
Text Label 7550 4250 0    50   ~ 0
CIN14
Text Label 7550 4350 0    50   ~ 0
CIN15
Text Label 5300 3650 0    50   ~ 0
COUT7
Text Label 7100 3350 0    50   ~ 0
COUT8
Text Label 7100 3450 0    50   ~ 0
COUT9
Text Label 7100 3550 0    50   ~ 0
COUT10
Text Label 7100 3650 0    50   ~ 0
COUT11
Entry Wire Line
	9350 3550 9250 3650
Entry Wire Line
	9350 3450 9250 3550
Entry Wire Line
	9350 3350 9250 3450
Entry Wire Line
	9350 3250 9250 3350
Wire Wire Line
	9250 3350 8900 3350
Wire Wire Line
	8900 3450 9250 3450
Wire Wire Line
	8900 3550 9250 3550
Wire Wire Line
	8900 3650 9250 3650
Text Label 8900 3350 0    50   ~ 0
COUT12
Text Label 8900 3450 0    50   ~ 0
COUT13
Text Label 8900 3550 0    50   ~ 0
COUT14
Text Label 8900 3650 0    50   ~ 0
COUT15
Text HLabel 9750 3850 2    50   Input ~ 0
COUNTCARRY
Connection ~ 9350 2600
Wire Bus Line
	9350 2600 9750 2600
Wire Bus Line
	7550 2600 9350 2600
Wire Wire Line
	7250 3750 7800 3750
Wire Bus Line
	5650 4950 7450 4950
Wire Wire Line
	9750 3850 8900 3850
Text Label 3800 3750 0    50   ~ 0
CARRY0
Text Label 5600 3750 0    50   ~ 0
CARRY1
Text Label 7450 3750 0    50   ~ 0
CARRY2
Wire Bus Line
	3850 4150 3850 4950
Wire Bus Line
	2050 4150 2050 4950
Wire Bus Line
	3950 2600 3950 3550
Wire Bus Line
	5650 4150 5650 4950
Wire Bus Line
	5750 2600 5750 3550
Wire Bus Line
	7450 4150 7450 4950
Wire Bus Line
	7550 2600 7550 3550
Wire Bus Line
	9350 2600 9350 3550
$EndSCHEMATC
