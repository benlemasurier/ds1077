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

void ds1077_write(unsigned int data) {
#ifdef DEBUG
    Serial.print("WRITING ");
    Serial.print(data)
    Serial.print(" TO ");
    Serial.println(DS1077_ADDRESS);
#endif

    Wire.beginTransmission(DS1077_ADDRESS);

    // one or two bytes?
    if(data > 0xFF) {
        // low byte first, then high byte
        Wire.send(0xFF & data);
        Wire.send(data >> 8);
    } else {
        Wire.send(data);
    }

    Wire.endTransmission();
}

// notes:
//
// tie SDA/SCL to +5v via 3.9Kohm resistors to pull up the I2C bus when not in use.
//
// tie VCC to GND via a 0.1uF and 0.01uF ceramic caps to reduce as much line noise as possible.
//
// the slave address and the r/w bit is automatically sent by the Wire library.
//   when you call Wire.beginTransmission(ADDRESS)
//
// "acknowledgment from slave" is taken care of by the wire library.
// 
// the "command byte" is the address of the address of the desired register.
//   this is sent after Wire.beginTransmission(<address>) with via Wire.send(<COMMAND BYTE>);
//
// if multiple bytes need to be sent, just send them one after another (post acknowledgement)
//   finish with Wire.endTransmission();
//

