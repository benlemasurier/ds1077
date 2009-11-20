/*
 * Ben LeMasurier 2k9'
 *
 * I2C SDA (data line) = analog pin 4
 * I2C SDC (clock line) = analog pin 5
*/
 
 
#include <Wire.h>
 
#define DS1077_ADDRESS 0b1011000
 
// command sets
#define DIV 0x01 // operating frequency
#define MUX 0x02 // mode of operation
#define BUS 0x0D // bus settings
#define E2  0x3F // EEPROM

void setup() {
    Wire.begin(); // We're I2C-Bus Master
 
    // Set OUT1 to 40kHz and OUT2 to 133Mhz
    // Also enabled CRTL1 as control pin for OUT1
    ds1077_write(MUX, 0b00001111, 0x00);
 
    // Sets DIV 'N' divisor to 1025
    set_n_divisor(1025);
}
 
void loop() {
}
 
void set_n_divisor(int n) {
    int msb, lsb;
 
    // DIV (n) = N + 2, lets keep it simple.
    n -= 2;
 
    ds1077_write(DIV, highByte(n), lowByte(n));
}
 
void ds1077_write(int command, int msb, int lsb) {
    Wire.beginTransmission(DS1077_ADDRESS);
    Wire.send(command);
 
    // MSB then LSB
    Wire.send(msb);
    Wire.send(lsb);
    Wire.endTransmission();
}
