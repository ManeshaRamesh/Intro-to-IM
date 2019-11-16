import processing.serial.*;
Serial port;
//initialize variables
PImage img;
float positionX;
float positionY;
int newGame = 1;
float warning;
float colour = 255;
int SIZE_X = 500;
int SIZE_Y = 500;
int BOMB_SIZE = 50;
int WHITE = 255;

//setup
void setup(){
  // set the size of the canvas
  size(500, 500);
  background(WHITE); // background colour
  img = loadImage("bomb.png"); //load image of the bomb
  port = new Serial(this, Serial.list()[0], 9600); // the port where all the information will be written to
}

void mouseClicked(){ //each time the user finds the location of the bomb reveal it. 
  if (mouseX > (positionX) && mouseX < (positionX + BOMB_SIZE) && mouseY < (positionY+BOMB_SIZE) && mouseY > (positionY)){
      image(img, positionX, positionY,BOMB_SIZE, BOMB_SIZE);
    println("YES");
   
    newGame = 1; //flag to indicate the new  game has begun
  }
}

void draw(){

  if (newGame == 1){ // ie new game randomize the next position of the bomb
    delay(100);
    positionX = random(BOMB_SIZE, SIZE_X - BOMB_SIZE);
    positionY = random(BOMB_SIZE, SIZE_Y - BOMB_SIZE);
    newGame = 0;
  }
  background(int(colour)); 

  warning = dist(mouseX, mouseY, positionX+(BOMB_SIZE/2), positionY+(BOMB_SIZE/2)); //find the distance between the mouse point and the location of the bomb
  //println(warning);
  
  //colour = map(warning, 0, 500, 255, 0);
  warning = map(warning, 0, 500, 0, 180); // map to an angle
  
  //println(warning); //debug
  //image(img, positionX, positionY, BOMB_SIZE, BOMB_SIZE); //debug
  port.write(int(warning)); //write to port
  
  
}
