import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;
import processing.serial.*;
//constants
int ACCELEROMETER_LOW = -400;
int ACCELEROMETER_HIGH = 400;
int BYTES_FROM_PORT = 4;
int GAME_START_SCREEN = 1;
int GAME_SCREEN = 2;
int GAME_OVER_SCREEN = 3;
int ROUND_TITLE_SCREEN = 4;
int WINNING_SCREEN = 6;
int LARGE_TEXT = 1500;
int ONE_SECOND = 1000;
int BIG_TEXT = 200;
int SMALL_TEXT = 100;
int TEXT_MARGIN = 100;
int WHITE = 255;
int BLACK = 0;
int GREY = 125;
int screen = 1;
int round = 0;
int size =0;
int t;
int beginGame = 0;
int free = 0;
int currentTime = 0;
boolean GameOver = false;
int NumberOfBlobbies = 60;
int GameBegin = 0;
Box2DProcessing box2d;
Serial myPort;
int[] serialInArray = new int[4];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
float Xrotation, Yrotation, Zrotation, pressureSensor;                // Starting position of the ball
boolean firstContact = false;        // Whether we've heard from the microcontroller
//the three angles
float angleX =0;
float angleY =0;
float angleZ =0;
boolean start;
//images of the blobbies blinking
PImage eyes_open;
PImage eyes_closed;
//PImage NYUADimg;
PImage eyes_angry ;
int timer = 30000; //30 seconds
int startTime;

//stops more blobbies from being made after a certain point
boolean flag = true;

ArrayList<Blobby> boxes;
//Blobby character;
Boundary OuterBoundary;
Box wall;


void setup() {
  pressureSensor = 0;
  eyes_open = loadImage("black.png");
  eyes_closed = loadImage("untitled.png");

  fullScreen();
  String portName = Serial.list()[1]; //setting the port

  myPort = new Serial(this, portName, 9600);
  myPort.buffer(BYTES_FROM_PORT);
  //array to hold the blobbies
  boxes = new ArrayList<Blobby>();
  //character = 
  //create a world 
  box2d = new Box2DProcessing(this);
  box2d.createWorld(); 
  wall = new Box();
  //character =new Blobby(width/2, height/2 - 50); //display blobby at width/2 and height/2
  OuterBoundary = new Boundary();
}
//every time a round is finished the followng function disposes of all teh blobboes and clears the list
void reset() {
  for (Blobby delete : boxes) {
    box2d.destroyBody(delete.body);
    flag = true;
  }
  boxes.clear();
  startTime = millis();
  t = timer/1000;
}

//a space bar is used to begin teh game and return to teh title screens after the game is over 
void keyPressed() {

  if (key == ' ') {
    if (screen == GAME_START_SCREEN && GameBegin !=0) {
      screen = ROUND_TITLE_SCREEN;
    }
    if (screen ==GAME_OVER_SCREEN || screen ==WINNING_SCREEN) {
      screen = GAME_START_SCREEN;
    }
  }
}

//display teh screen for moving onto the next round
void nextRound() {
  if (pressureSensor ==0.0) {
    if (screen ==ROUND_TITLE_SCREEN) { 
      if (round ==0) {
        //the first round
        fill(WHITE);
        textSize(BIG_TEXT);
        text("Round 1", TEXT_MARGIN, height/4);
        textSize(SMALL_TEXT);
        text("Shake the blobbies out of their boundaires!!", TEXT_MARGIN, height*2/4);
        textSize(SMALL_TEXT);
        text("Tap the bottom of the box to start", TEXT_MARGIN, height*3/4);
        screen = GAME_SCREEN;
        beginGame = 1;
        reset(); //reset
        //the second screen
      } else  if (round ==1) {
        fill(WHITE);
        textSize(BIG_TEXT);
        text("Round 2", TEXT_MARGIN, height/4);
        textSize(SMALL_TEXT);
        text("Bigger Blobbies, shake harder", TEXT_MARGIN, height*2/4);
        textSize(SMALL_TEXT);
        text("Tap the bottom of the box to start", TEXT_MARGIN, height*3/4);
        screen = GAME_SCREEN;
        beginGame = 1;
        reset(); //reset
        //the third screen
      } else  if (round ==2) {
        fill(WHITE);
        textSize(200);
        text("Round 3", TEXT_MARGIN, height/4);
        textSize(SMALL_TEXT);
        text("Eeeeeven Bigger, KEEP SHAKING", TEXT_MARGIN, height*2/4);
        textSize(SMALL_TEXT);
        text("Tap the bottom of the box to start", TEXT_MARGIN, height*3/4);
        screen = GAME_SCREEN;
        beginGame = 1;
        reset();//reset
      }
    }
  }

  if (pressureSensor == 1.0) {
    if (screen ==GAME_START_SCREEN && GameBegin == 0) {
      screen = 4;
      GameBegin =GameBegin +1;
    }
  }
}
void draw() {

  if (myPort.available() > 0) {
    //println("Available");
    serialEvent(myPort);
  }
  nextRound(); //diplays the title screen of the next round
  background(GREY);
//title screen
  if (screen ==GAME_START_SCREEN) {
    fill(WHITE);
    textSize(200);
    text("Free the blobbies!!", TEXT_MARGIN, height/2);
    if (GameBegin ==0) {
      textSize(100);
      text("Pick up the black box to start!", 100, height*3/4);
    } else {
      textSize(100);
      text("Hit the spacebar", TEXT_MARGIN, height*3/4);
    }
  } else if (screen == GAME_SCREEN) {//the screen with game
  //
    //add box2d world
    if (beginGame == 1 && screen == GAME_SCREEN) { 
      if (flag == true) {
          //teh size of teh blobby chnage sin each round
        if (round == 0) {
          size = 30;
        } else if (round ==1) {
          size = 40;
        } else if (round ==2) {
          size = 60;
        }
        //for (int i = 0; i< 99; i++) {
        Blobby p = new Blobby(width/2, (height/2), size); // creates anew blobby

        boxes.add(p);//adds it to the list
        if (boxes.size() >=  NumberOfBlobbies) {
          flag = false; //
        }
      }
    }
    //
    box2d.step(); //
    background(GREY);
    OuterBoundary.display(); //the outerboundaryto prevent the blobbies form leaving the screen
//the screen with the game
    if (screen ==GAME_SCREEN) {
      fill(WHITE);
      textSize(1500);
      //reinitialize the timer
      currentTime = millis();
      if ( (currentTime - startTime)  > ONE_SECOND ) {
        startTime = currentTime;
        t = t-1;
        GameOver = true;
      }
      //displays the countdown timer
      if (t < 10) {
        text("0"+(t), 0, height );
      } else {
        text(t, 0, height );
      }
      wall.display(); //display the wall


      //update the angle of the black box
      wall.updateRotation(angleX);
      //display all the  blobbies that blink
      for (Blobby b : boxes) {
        int pick_eyes = int(random(20));
        if (pick_eyes == 0 ) {
          b.display(eyes_open);
        } else if (pick_eyes == 1 ) { 
          b.display(eyes_closed);
        }
        b.display(eyes_open);
        if (b.checkifAngry()) { //check if the blobbies have left the black box
          free = free + 1;
        }
      }
      //if all the balls have not be relased before the 30 seconds end, move onto teh next round  
      if (free < NumberOfBlobbies && t < 0) { 
        screen = GAME_OVER_SCREEN;
      }
      //if all the blobbies  are freed move onto teh next round
      if (free >=NumberOfBlobbies ) {
        if (round >=2) { //after the three rounds have been successfuly completed end the game
          reset();
          screen = WINNING_SCREEN;
          free = 0;
        } else {
        //move onto the next round
          round = round + 1;
          screen = ROUND_TITLE_SCREEN;
          reset(); //reset after each round ends
          free = 0;
        }
      }
    }
  } 
  //the final winning screen  
  if (screen == WINNING_SCREEN) {
    fill(WHITE);
    textSize(BIG_TEXT);
    text("Congratulations!\nYou freed yourself!!!!", 400, height/4);
    round = 0;
    free = 0; //re initialize free
  }
  //show the game over screen
  if (screen ==GAME_OVER_SCREEN) {
    fill(WHITE);
    textSize(BIG_TEXT);
    text("Game Over", SMALL_TEXT, height/4);
    textSize(SMALL_TEXT);
    text(" These blobbies have \nyet to be freed!!", TEXT_MARGIN, height*2/4);
    round = 0;
    free = 0;
  }
}

int inByte;
void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  inByte = myPort.read();
  //myPort.clear();
  //println(inByte + "is read");
  // if this is the first byte received, and it's an A, clear the serial
  // buffer and note that you've had first contact from the microcontroller.
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
  } else {
    // Add the latest byte from the serial port to array:
    //println("Hello",serialCount, inByte);
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 4 bytes:
    if (serialCount > 3 ) {
      //read the engles in each axis
      Xrotation = serialInArray[0];
      Yrotation = serialInArray[1];
      Zrotation = serialInArray[2];
      //value of the pressure sensor
      pressureSensor = serialInArray[3];
      //mapping all the rotations from the size of a byte to range
      Xrotation = map(Xrotation, 0, 255, ACCELEROMETER_LOW, ACCELEROMETER_HIGH);
      Yrotation = map(Yrotation, 0, 255, ACCELEROMETER_LOW, ACCELEROMETER_HIGH);
      Zrotation = map(Zrotation, 0, 255, ACCELEROMETER_LOW, ACCELEROMETER_HIGH);
      calcAngles(Xrotation/100, Yrotation/100, Zrotation/100);
      // Send a capital A to request new sensor readings:
      myPort.clear();
      myPort.write('A'); //handshaking
      // Reset serialCount:
      serialCount = 0;
    }
  }
}

void calcAngles(float ax, float ay, float az) {
  //use values from the accelerometer and convert them to angles
  float xAngle = atan( ax / (sqrt((ay*ay) + (az*az))));
  float yAngle = atan( ay / (sqrt((ax*ax) + (az*az))));
  float zAngle = atan( sqrt((ax*ax) + (ay*ay)) / az);
  angleX = (xAngle + yAngle+zAngle)/3;//find the average of the angles
}
