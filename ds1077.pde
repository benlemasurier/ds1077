/*
 * Ben LeMasurier 2k9'
 *
 * I2C SDA (data line)  = analog pin 4
 * I2C SDC (clock line) = analog pin 5
*/


#include <Wire.h>

void setup() {
    Wire.begin(); // We're I2C-Bus Master
}

void loop() {
}
