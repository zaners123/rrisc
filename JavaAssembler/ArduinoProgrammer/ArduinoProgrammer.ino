#define ADDR_SIZE 15
#define DATA_SIZE 8

const uint8_t PIN_ROM_ADDR[ADDR_SIZE] = {
  28,34,26,36,24,32,29,22,27,35,38,31,30,25,23//forwards (correct)
  //23,25,30,31,38,35,27,22,29,32,24,36,26,34,28//backwards
  //34,26,36,24,32,29,22,27,35,38,31,30,25,23,28//shift one
};

const uint8_t PIN_ROM_DATA[DATA_SIZE] = {
  52,50,51,44,48,42,40,46
};

const uint8_t PIN_NWE = 33;// Not Write  Enable
const uint8_t PIN_NCE = 39;// Not Chip   Enable
const uint8_t PIN_NOE = 37;// Not Output Enable

void disableROM() {
  digitalWrite(PIN_NWE,true);
  digitalWrite(PIN_NCE,true);
  digitalWrite(PIN_NOE,true);
}

void setAddress(uint16_t address) {
  for (uint8_t i=0; i<ADDR_SIZE; i++) {
    digitalWrite(PIN_ROM_ADDR[i],0b1 & (address>>i));
  }
}

void setData(uint8_t data) {
  for (uint8_t i=0; i<DATA_SIZE; i++) {
    digitalWrite(PIN_ROM_DATA[i],0b1 & (data>>i));
  }
}

uint8_t getData() {
  uint8_t ret = 0;
  for (uint8_t i=0;i<DATA_SIZE;i++) {
    uint8_t b = digitalRead(PIN_ROM_DATA[i])?1:0;
    ret |= b<<i;
  }
  return ret;
}

#include "hex.h"

void programWriteAddrData(uint16_t addr, uint8_t data) {
  setAddress(addr);
  setData(data);
  asm("nop");asm("nop");asm("nop");asm("nop");
  asm("nop");asm("nop");asm("nop");asm("nop");
  digitalWrite(PIN_NWE,false);//Latch addr
  asm("nop");asm("nop");asm("nop");asm("nop");
  asm("nop");asm("nop");asm("nop");asm("nop");
  digitalWrite(PIN_NWE,true);//Latch data
  for (long i=0;i<40000L;i++) asm("nop");
  
  asm("nop");asm("nop");asm("nop");asm("nop");
}

void programROM() {
  disableROM();
  Serial.println("Programming ROM");
  for (int i=0;i<DATA_SIZE;i++) pinMode(PIN_ROM_DATA[i],OUTPUT);
  
  Serial.print("Program Size:");
  Serial.print(PROGSIZE);Serial.println(" bytes.");
  digitalWrite(PIN_NCE,false);//Enable Chip
  // Using byte write method
  for (uint16_t addr=0; addr<PROGSIZE; addr++) {
    programWriteAddrData(addr,pgm_read_byte_near(PROG+addr));
  }
  disableROM();
  Serial.println("Programming Done!");
}

boolean verifyROM() {  
  boolean isBad = false;
  Serial.println("Verify ROM");
  for (int i=0;i<DATA_SIZE;i++) pinMode(PIN_ROM_DATA[i],INPUT);
  
  digitalWrite(PIN_NWE,true);
  digitalWrite(PIN_NCE,false);
  digitalWrite(PIN_NOE,false);
  for (uint16_t addr=0; addr<PROGSIZE; addr++) {
    setAddress(addr);
    asm("nop");asm("nop");asm("nop");asm("nop");
    for (int x=0;x<16;x++) asm("nop");asm("nop");asm("nop");asm("nop");
    uint8_t data = getData();
    
    if (pgm_read_byte_near(PROG+addr) != data) {
      isBad=true;
      Serial.print("BAD:");Serial.print(pgm_read_byte_near(PROG+addr),BIN);
      Serial.print(" != ");
    }
    Serial.print("ROM[0x");Serial.print(addr,HEX);
    Serial.print("] = 0x");Serial.print(data,HEX);
    Serial.print(" = 0b");Serial.print(data,BIN);
    Serial.println("");
    
  }
  disableROM();
  return isBad;
}

void softwareEraseROM() {
  // https://ww1.microchip.com/downloads/en/Appnotes/doc0544.pdf
  Serial.println("Clear ROM");
  
  digitalWrite(PIN_NCE,false);//Enable Chip
  programWriteAddrData(0xAAAAL, 0xAA);
  programWriteAddrData(0x5554L, 0x55);
  programWriteAddrData(0xAAAAL, 0x80);
  programWriteAddrData(0xAAAAL, 0xAA);
  programWriteAddrData(0x5554L, 0x55);
  programWriteAddrData(0xAAAAL, 0x10);
  
  /*programWriteAddrData(0x5555L, 0xAA);
  programWriteAddrData(0x2AAAL, 0x55);
  programWriteAddrData(0x5555L, 0x80);
  programWriteAddrData(0x5555L, 0xAA);
  programWriteAddrData(0x2AAAL, 0x55);
  programWriteAddrData(0x5555L, 0x10);*/
  //wait 20ms: 20MHz × 20ms = 400E3
  for (long i=0;i<400000L;i++) {
    asm("nop");
  }
  disableROM();
}

void setup() {
  //Verify right image
  Serial.begin(115200);
  Serial.print("\n\n\nType ");Serial.print(PROGNAME);Serial.println("to program it.");
  while (true) {
    String line = Serial.readString();
    line.trim();
    if (line==PROGNAME) break;
  }
  Serial.print("STARTING ");Serial.println(PROGNAME);

  for (int i=0;i<ADDR_SIZE;i++) pinMode(PIN_ROM_ADDR[i],OUTPUT);
  pinMode(PIN_NWE,OUTPUT);
  pinMode(PIN_NCE,OUTPUT);
  pinMode(PIN_NOE,OUTPUT);
  disableROM();

  //softwareEraseROM();
  
  verifyROM();  
  programROM();
  verifyROM();
  verifyROM();
  Serial.println("Done.\n\n");
}

void loop() {}
