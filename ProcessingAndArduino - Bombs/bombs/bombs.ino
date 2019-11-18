/*
  Manesha Ramesh
  Bombs
*/

#include <Servo.h>
const int servoPin = 9;      // the pin that the servo is attached to
Servo myservo;

void setup() {
  // initialize the serial communication:
  Serial.begin(9600);
  // initialize the servoPin as an output:

  myservo.attach(servoPin);
}

void loop() {
  int angle;

  // check if data has been sent from the computer:
  if (Serial.available()) {
    // read the most recent byte (which will be from -90 to 90):
    angle = Serial.read();
    // set the angle of the servo
    myservo.write(angle);
  }
  
}
