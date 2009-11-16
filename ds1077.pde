/*
 * Ben LeMasurier 2k9'
 *
 * I2C SDA (data line)  = analog pin 4
 * I2C SDC (clock line) = analog pin 5
*/


#include <Wire.h>

#define DEBUG
#define DS1077_ADDRESS 0b1011000

void setup() {
#ifdef DEBUG
    Serial.begin(9600);
    Serial.print("DS1077 ADDRESS: ");
    Serial.println(DS1077_ADDRESS);
#endif

    Wire.begin(); // We're I2C-Bus Master
}

void loop() {
}

void ds1077_write(unsigned int address, int data) {
    Wire.beginTransmission(address);
    Wire.send(data);
    Wire.endTransmission();
}
