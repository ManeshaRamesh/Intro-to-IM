/*
  Manesha Ramesh
*/

#include <Arduino_LSM9DS1.h>
int inByte;
int pressureSensor = A0;
int pressureValue = 0;
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
int val;
void loop() {

  //if value is found at the port
  if (Serial.available() > 0) {

    inByte = Serial.read();
    //    if you receive an A from the processing sketch, read the accelerometer and send  it to the processing
    if (inByte == 'A') {
      Serial.flush();
      if (IMU.accelerationAvailable()) {
        IMU.readAcceleration(x, y, z);
        //map the values to a btye so that it can be sent
        X = int( map(x*100, -400, 400, 0, 255));
        Y = int( map(y*100, -400, 400, 0, 255));
        Z = int(map(z*100, -400, 400, 0, 255));
//        read the value of pressure sensor
        pressureValue = analogRead(pressureSensor);
          //write the angles in the x,y and z direction
          Serial.write(X);
          Serial.write(Y);
          Serial.write(Z);
          //read the pressure and write it to the serial monitor
          if (pressureValue < 100){
            Serial.write((byte)0x1);
          }
          else{
           Serial.write((byte)0x0);
          }
      }
    }
  }
}

//handshaking
void establishContact() {
  while (Serial.available() <= 0) {
    Serial.write('A');   // send a capital A
    delay(300);
  }
}
