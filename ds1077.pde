/*
 * Ben LeMasurier 2k9'
 *
 * I2C SDA (data line)  = analog pin 4
 * I2C SDC (clock line) = analog pin 5
 *
 * MSB = most significant byte
 * LSB = least significant byte
*/


#include <Wire.h>

#define DEBUG
#define DS1077_ADDRESS 0b1011000

// command sets
#define DIV 0x01 // operating frequency
#define MUX 0x02 // mode of operation
#define BUS 0x0D // bus settings
#define E2  0x3F // EEPROM

void setup() {
#ifdef DEBUG
    Serial.begin(9600);
    Serial.print("DS1077 ADDRESS: ");
    Serial.println(DS1077_ADDRESS);
#endif

    Wire.begin(); // We're I2C-Bus Master


    // Set OUT1 to 40kHz and OUT2 to 133Mhz
    // Also enabled CRTL1 as control pin for OUT1
    ds1077_write(MUX, 0x11, 0x00);

    // Sets N to create 40kHz wave on OUT1
    ds1077_write(DIV, 0xCF, 0xC0);
}

void loop() {
}

void ds1077_write(unsigned int command, unsigned int msb, unsigned int lsb) {
#ifdef DEBUG
    Serial.print("WRITING ");
    Serial.print(data)
    Serial.print(" TO ");
    Serial.println(DS1077_ADDRESS);
#endif

    Wire.beginTransmission(DS1077_ADDRESS);
    Wire.send(command);

    // MSB then LSB
    Wire.send(msb);
    Wire.send(lsb);
    Wire.endTransmission();
}
