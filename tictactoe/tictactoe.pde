//some macros to make code understandable
int BOARD_SIZE_X = 400;
int BOARD_SIZE_Y = 400;
int MARGIN = 50;
int SIZE_OF_SQUARE = 100;
int Player = 0;
//function to print the board
 void displayboard(){
   for (int j = 0; j< 3;j++){
     for (int i = 0; i< 3; i++){
       pushMatrix();
       translate(50 + (i*SIZE_OF_SQUARE), MARGIN + (j*SIZE_OF_SQUARE));
       fill(255);
       rect(0, 0,SIZE_OF_SQUARE,SIZE_OF_SQUARE); //prints the white squares
       popMatrix();
     }
   }   
 }

 //class for the circle
 class Circle {
  int indexX; 
  int indexY;
  
  Circle(int x, int y ){ //constructor that takes in the values of the indices in the matrix
    this.indexX = x;
    this.indexY = y;
  }
  void drawCircle(){ //draws a circle at the center of the the selected white square
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
  
  Cross(int x, int y ){ //constructor that takes in the values of the indices in the matrix
    this.indexX = x;
    this.indexY = y;
  }
  void drawCross(){ //draw a circle at the center of the the selected white square
    pushMatrix();
    stroke(150);
    translate(50 + (this.indexX*100), MARGIN + (this.indexY*SIZE_OF_SQUARE)); //finds the center of the white square
    line(25, 25, 75, 75);
    line(25, 75, 75, 25);
    popMatrix();
  }
}

int[][] board = {{0,0,0}, {0,0,0}, {0,0,0}}; //create a two dimensional matrix to represent the board
void setup(){
  size(400, 400);
  background(0); 
  displayboard();
}


 void mouseClicked(){ //defines what should be executed when teh mouse is clicked
   if (mouseX < 50 || mouseX > 350){ //ignore the mouse click if the user clicks outside of the matrix
     return;
   } 
   if (mouseY < 50 || mouseY > 350){ //ignore the mouse click if the user clicks outside of the matrix
     return;
   }
   int indexX = (mouseX-MARGIN)/100;
   int indexY = (mouseY-MARGIN)/100;
   //println("yay " , indexX, indexY);
   if (Player == 1){ //if it is player 2's turn draw a circle
     Circle circle1 = new Circle(indexX, indexY);
     circle1.drawCircle();
     Player = (Player+1)%2; //switch the player
     board[indexX][indexY] = 2;  //update the array
   }
   else{ //if it is player 1's turn draw a cross
     Cross cross1 = new Cross(indexX, indexY);
     cross1.drawCross(); 
     Player = (Player+1)%2; //switch the player
     board[indexX][indexY] = 1; //update the array
   }  
   return;   
  }

void draw(){
  println(mouseX, mouseY);   //for debugging
}
