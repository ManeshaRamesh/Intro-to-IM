//some macros to make code understandable
int BOARD_SIZE_X = 400;
int BOARD_SIZE_Y = 450;
int CONSOLE_SIZE_X = 400;
int CONSOLE_SIZE_Y = 50;
int MARGIN = 50;
int PLACE_TEXT_HEREX = 50;
int PLACE_TEXT_HEREY = 430;
int SIZE_OF_SQUARE = 100;
int Player = 0;
int flag = 0;
//function to print the board

int checkForWin(int indexX, int indexY) {
  //any vertical patterns
  if (board[indexX][0] == board[indexX][1]&& board[indexX][1]== board[indexX][2]) {
    return 1;
  }
  //any horizontal patterns
  if (board[0][indexY] == board[1][indexY]&& board[1][indexY]== board[2][indexY]) {
    return 1;
  }
  // for diagonal patterns
  if ((indexX ==0 && indexY == 0) || (indexX ==1 && indexY == 1) || (indexX ==2 && indexY == 2)) {
    if (board[0][0] == board[1][1]&& board[1][1]== board[2][2]) {
      return 1;
    }
  }
  if ((indexX ==2 && indexY == 0) || (indexX ==1 && indexY == 1) || (indexX ==0 && indexY == 2)) {
    if (board[2][0] == board[1][1]&& board[1][1]== board[0][2]) {
      return 1;
    }
  }
  //if no one has won
  return 0;
}
void displayboard() {
  for (int j = 0; j< 3; j++) {
    for (int i = 0; i< 3; i++) {
      pushMatrix();
      translate(50 + (i*SIZE_OF_SQUARE), MARGIN + (j*SIZE_OF_SQUARE));
      fill(255);
      rect(0, 0, SIZE_OF_SQUARE, SIZE_OF_SQUARE); //prints the white squares
      popMatrix();
    }
  }
  rect(0, 400, CONSOLE_SIZE_X, CONSOLE_SIZE_Y);
  fill(0, 102, 153);
  textSize(15);
  text("This is Tic Tac Toe. Click on a White Box", PLACE_TEXT_HEREX, PLACE_TEXT_HEREY);
}

//class for the circle
class Circle {
  int indexX; 
  int indexY;

  Circle(int x, int y ) { //constructor that takes in the values of the indices in the matrix
    this.indexX = x;
    this.indexY = y;
  }
  void drawCircle() { //draws a circle at the center of the the selected white square
    pushMatrix();
    stroke(150);
    noFill();
    translate(MARGIN + (this.indexX*100), MARGIN + (this.indexY*SIZE_OF_SQUARE)); //finds the center of the white square
    circle(50, 50, 50);
    popMatrix();
  }
}

//class for the Cross
class Cross {
  int indexX; 
  int indexY;

  Cross(int x, int y ) { //constructor that takes in the values of the indices in the matrix
    this.indexX = x;
    this.indexY = y;
  }
  void drawCross() { //draw a circle at the center of the the selected white square
    pushMatrix();
    stroke(150);
    translate(50 + (this.indexX*SIZE_OF_SQUARE), MARGIN + (this.indexY*SIZE_OF_SQUARE)); //finds the center of the white square
    line(25, 25, 75, 75);
    line(25, 75, 75, 25);
    popMatrix();
  }
}

int[][] board = {{3, 4, 5}, {6, 7, 8}, {9, 10, 11}}; //create a two dimensional matrix to represent the board
void setup() {
  size(400, 450);
  background(0); 
  displayboard();
}


void mouseClicked() { //defines what should be executed when teh mouse is clicked
  if (mouseX < 50 || mouseX > 350) { //ignore the mouse click if the user clicks outside of the matrix
    return;
  } 
  if (mouseY < 50 || mouseY > 350) { //ignore the mouse click if the user clicks outside of the matrix
    return;
  }
  int indexX = (mouseX-MARGIN)/SIZE_OF_SQUARE;
  int indexY = (mouseY-MARGIN)/SIZE_OF_SQUARE;
  //println("yay " , indexX, indexY);
  if (Player == 1) { //if it is player 2's turn draw a circle
    Circle circle1 = new Circle(indexX, indexY);
    circle1.drawCircle();
    Player = (Player+1)%2; //switch the player
    board[indexX][indexY] = 2;  //update the array
    if (checkForWin(indexX, indexY) == 1) {
      println("Player", Player, "has won.");
      flag = 2; //to update console
    }
  } else { //if it is player 1's turn draw a cross
    Cross cross1 = new Cross(indexX, indexY);
    cross1.drawCross(); 
    Player = (Player+1)%2; //switch the player
    board[indexX][indexY] = 1; //update the array
    if (checkForWin(indexX, indexY) == 1) {
      println("Player", Player, "has won.");
      flag = 1; //to update console
    }
  }  
  return;
}

void draw() {
  //println(mouseX, mouseY);   //for debugging
  //if player X has won, update console
  if (flag == 1) {
    fill(255);
    rect(0, 400, CONSOLE_SIZE_X, CONSOLE_SIZE_Y);
    textSize(25);
    fill(0, 102, 153);
    text("Player X has won", PLACE_TEXT_HEREX, PLACE_TEXT_HEREY);
  }
  //if player Y has won, update console
  if (flag == 2) {
    fill(255);
    rect(0, 400, CONSOLE_SIZE_X, CONSOLE_SIZE_Y);
    textSize(25);
    fill(0, 102, 153);
    text("Player O has won", PLACE_TEXT_HEREX, PLACE_TEXT_HEREY);
  }
}
