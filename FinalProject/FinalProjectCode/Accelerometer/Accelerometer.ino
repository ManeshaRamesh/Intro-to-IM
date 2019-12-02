/*
  Arduino LSM6DS3 - Simple Gyroscope

  This example reads the gyroscope values from the LSM6DS3
  sensor and continuously prints them to the Serial Monitor
  or Serial Plotter.

  The circuit:
  - Arduino Uno WiFi Rev 2 or Arduino Nano 33 IoT

  created 10 Jul 2019
  by Riccardo Rizzo

  This example code is in the public domain.
*/

#include <Arduino_LSM9DS1.h>
int inByte;
void setup() {
  Serial.begin(9600);
  while (!Serial);

  if (!IMU.begin()) {
    //    Serial.println("Failed to initialize IMU!");

    while (1);
  }
  establishContact();
}
float x, y, z;
int X, Y, Z;
void loop() {
  
  if (Serial.available() > 0) {
     
    inByte = Serial.read();
//    Serial.print("hello");
    if (inByte =='A') {
      
      if (IMU.accelerationAvailable()) {
//        Serial.write("hello");
        IMU.readAcceleration(x, y, z);
        X =int( map(x, -4, 4, 0, 255));
        Y =int( map(y, -4, 4, 0, 255));
        Z = int(map(z, -4, 4, 0, 255));
        Serial.write((X));
        //    Serial.print('\t');
        Serial.write((Y));
        //    Serial.print('\t');
        Serial.write((Z));
   
//                  Serial.print(int(X));
//                  Serial.print('\t');
//                  Serial.print(int(Y));
//                  Serial.print('\t');
//                  Serial.println(int(Z));

      }
    }
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.write('A');   // send a capital A
    delay(300);
  }
}
