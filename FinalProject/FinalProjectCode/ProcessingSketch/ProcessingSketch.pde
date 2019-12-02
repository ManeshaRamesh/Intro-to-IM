 import processing.serial.*;

  int bgcolor;           // Background color
  int fgcolor;           // Fill color
  Serial myPort;                       // The serial port
  int[] serialInArray = new int[3];    // Where we'll put what we receive
  int serialCount = 0;                 // A count of how many bytes we receive
  int Xrotation, Yrotation, Zrotation;                // Starting position of the ball
  boolean firstContact = false;        // Whether we've heard from the microcontroller
    float angleX =0;
    float angleY =0;
  float angleZ =0;
  void setup() {
    size(500, 500, P3D);  // Stage size
    //noStroke();      // No border on the next thing drawn

    // Set the starting position of the ball (middle of the stage)
    //xpos = width / 2;
    //ypos = height / 2;

    // Print a list of the serial ports for debugging purposes
    // if using Processing 2.1 or later, use Serial.printArray()
    println(Serial.list());

    // I know that the first port in the serial list on my Mac is always my FTDI
    // adaptor, so I open Serial.list()[0].
    // On Windows machines, this generally opens COM1.
    // Open whatever port is the one you're using.
    String portName = "COM6";
    myPort = new Serial(this, portName, 9600);
  }

  void draw() {
 
    fill(fgcolor);
    // Draw the shape
    pushMatrix();
    background(255);
    translate(width/2, height/2);
    rotateX(angleX);
    rotateY(angleY);
    rotateZ(angleZ);
    box(150);
    popMatrix();
    
  }

  void serialEvent(Serial myPort) {
    // read a byte from the serial port:
    int inByte = myPort.read();
    // if this is the first byte received, and it's an A, clear the serial
    // buffer and note that you've had first contact from the microcontroller.
    // Otherwise, add the incoming byte to the array:
    if (firstContact == false) {
      if (inByte == 'A') {
        myPort.clear();          // clear the serial port buffer
        firstContact = true;     // you've had first contact from the microcontroller
        myPort.write('A');       // ask for more
      }
    }
    else {
      // Add the latest byte from the serial port to array:
      serialInArray[serialCount] = inByte;
      serialCount++;
    
      // If we have 3 bytes:
      if (serialCount > 2 ) {
        Xrotation = serialInArray[0];
        Yrotation = serialInArray[1];
        Zrotation = serialInArray[2];
        Xrotation = map(Xrotation, 0, 255, -4, 4);
        
        // print the values (for debugging purposes only):
        println(Xrotation + "\t" + Yrotation + "\t" + Zrotation);
        //angleX += Xrotation;
        //angleY += Yrotation;
        //angleZ += Zrotation;
    
        // Send a capital A to request new sensor readings:
        myPort.write('A');
        // Reset serialCount:
        serialCount = 0;
      }
    }
  }
