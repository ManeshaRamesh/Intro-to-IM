void setup() {
  size(1000, 1000); 
  background(0);
}
float x = 0;
int count = 0;
int deltax = 0;
int deltay = 0;
int run = 0;
int shiftx = 0 ;
int shifty = 0 ;
int startx = 0;
int starty = 0;
int shiftmain = 0;

void horizontalLines(int shiftx, int shifty){ //draw the horizontal lines
  int x = 0;
  float thickness = 0; //for changing the thickness of the strokes
  pushMatrix();
  translate(deltax + shiftx,deltay + shifty); //draws the lines
  for (int i = 0; i< 6; i++){
    strokeWeight(thickness);
     stroke(255);
     line(x,0,x, 50);
     x = x + 10; 
     thickness = thickness + 0.5;
  }
 popMatrix();
}
void verticalLines(int shiftx, int shifty){ //for the vertical lines
  int y = 0;
  float thickness = 0;
   pushMatrix();
   translate(deltax + shiftx,deltay + shifty);
  for (int i = 0; i< 6; i++){ //draw the lines
     stroke(255);
     strokeWeight(thickness); //the stroke thickness
     line(0,y,50, y);
     y = y + 10; 
     thickness = thickness + 0.5;
  }
  popMatrix();
}
void pattern(int shiftx, int shifty){ //this function picks one either horizontal or vertical lines and prints them. 
   int pick = int(random(1,5));
   if (pick == 1){  horizontalLines(0, 0);}
   else if (pick ==2){  horizontalLines(0, 0);}
   else if (pick ==3){  verticalLines(0, 0);}
   else if (pick ==4){  verticalLines(0, 0);}
   else { println("Error: Not an option");}
   deltax = deltax + shiftx;
   deltay = deltay +shifty;
 
}

void deltaset(int x, int y){ //this is used to reset where each row starts
  deltax = x;
  deltay = y;
}


void draw() {

  if (run < 400){ // to stop the program from printing outside of the canvas
  pattern( 50, 0);
  
  if (run%20 == 0 && run !=0){
    deltaset(0, 50*(int(run/20))); //moves to the next row
    pattern( 50, 0);
  }
  
  println(run);
  run = run + 1; //keeps count of the number of runs
  }
  
}
