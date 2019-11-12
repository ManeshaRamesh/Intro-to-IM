
Table table; // stores the frequency of the letters
Letter[] letters; //array of all the letter objects
int consonants; //flag to indicate that the consonant button has been clicked
int vowels; //flag to indicate that the vowels button has been clicked
int buttonColor1 = 200;//to change colour of Button One
int buttonColor2 = 200; //to change colour of Button Two
float SPEED = 0.001; 
int RED_IDX = 0;
int GREEN_IDX = 1;
int BLUE_IDX = 2;
int CANVAS_SIZE_X = 500;
int CANVAS_SIZE_Y = 600;
int WHITE = 255;
int PERCENT = 100;
int FREQUENCY_RANGE_MIN = 0;
int FREQUENCY_RANGE_MAX = 30;
int MAPPED_FREQUENCY_RANGE_MIN = 50;
int MAPPED_FREQUENCY_RANGE_MAX = 300;
int LETTER_COLOR_MIN = 10;
int LETTER_COLOR_MAX =240;
int GREY = 200;
int BUTTON1_X_MIN = 50;
int BUTTON_X_SIZE = 150;
int BUTTON1_Y_MIN = 525;
int BUTTON_Y_SIZE = 50;
int BUTTON2_X_MIN = 300;
int BUTTON2_Y_MIN = 525;
int BUTTON_TEXT_Y = 555;
int CONSONANTS_TEXT_X = 90 ;
int VOWELS_TEXT_X = 355;

/////Class Defintion
class Letter {
  char letter;
  int Size;
  int PositionX;
  int PositionY;
  int[] Color;
  float perlinNoiseConstantX;
  float perlinNoiseConstantY;  
  //Constructor
  Letter(char character, int size, int positionX, int positionY, int r, int g, int b) {
    this.letter = character; 
    this.Size = size;
    this.PositionX = positionX;
    this.PositionY = positionY;
    this.Color = new int[3];
    this.Color[RED_IDX] = r;
    this.Color[GREEN_IDX] = g;
    this.Color[BLUE_IDX] = b;
    this.perlinNoiseConstantX = random(0, width);
    this.perlinNoiseConstantY = random(0, height);
  }
  //Get noise for the x direction for a given letter
  float getNoiseX() {
    return noise(this.perlinNoiseConstantX);
  }
  //Get noise for the y direction for a given letter

  float getNoiseY() {
    return noise(this.perlinNoiseConstantY);
  }
  //update the noise constant
  void updateConstant() {
    this.perlinNoiseConstantX = this.perlinNoiseConstantX + SPEED;
    this.perlinNoiseConstantY = this.perlinNoiseConstantY + SPEED;
  }
  //draw letter at intial position
  void drawLetter() {
    fill(Color[RED_IDX], Color[GREEN_IDX], Color[BLUE_IDX]);
    textSize(this.Size);
    text(letter, this.PositionX, this.PositionY);
  }
  //draw letter at a passed in coordinate 
  void drawLetter(float x, float y) {
    //background(0);
    fill(Color[RED_IDX], Color[GREEN_IDX], Color[BLUE_IDX]);
    textSize(this.Size);
    text(letter, x, y);
  }
}

//loading data to table
void loadData() {
  table = loadTable("letterFrequency.csv");
  int count = table.getRowCount();
  letters = new Letter[count];
}

void setup() {
  size(500, 600); 
  background(WHITE);
  loadData();
  //INTIALIZES THE LETTER OBJECTS
  for (int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    char character = row.getString(0).charAt(0);
    float size = int(row.getFloat(1)*PERCENT);   
    size = map(size, FREQUENCY_RANGE_MIN, FREQUENCY_RANGE_MAX, MAPPED_FREQUENCY_RANGE_MIN, MAPPED_FREQUENCY_RANGE_MAX);
    letters[i] = new Letter(character, int(size), int(random(100, 400)), int(random(100, 400)), int(random(LETTER_COLOR_MIN, LETTER_COLOR_MAX)), int(random(LETTER_COLOR_MIN, LETTER_COLOR_MAX)), int(random(LETTER_COLOR_MIN, LETTER_COLOR_MAX)) );
  }
}

// DEFINES THE ACTION OF THE BUTTONS - THE BUTTONS MANIPULATE THE FLAGS
void mousePressed() {
  if (mouseX > BUTTON1_X_MIN && mouseX < BUTTON1_X_MIN+BUTTON_X_SIZE && mouseY >BUTTON1_Y_MIN && mouseY <BUTTON1_Y_MIN+BUTTON_Y_SIZE) {
    consonants = 1;
    vowels = 0;
    buttonColor1 = WHITE;
    buttonColor2 = GREY;
  } else if (mouseX > BUTTON2_X_MIN && mouseX < BUTTON2_X_MIN+BUTTON_X_SIZE && mouseY >BUTTON2_Y_MIN && mouseY <BUTTON2_Y_MIN+BUTTON_Y_SIZE) {
    vowels = 1;
    consonants = 0;
    buttonColor2 = WHITE;
    buttonColor1 = GREY;
  } else {
    consonants = 0;
    vowels = 0;
    buttonColor1 = GREY;
    buttonColor2 = GREY;
  }
}

//function to print a letter
void printLetter(Letter letter) {

  pushMatrix();
  float perlinOutputX = letter.getNoiseX();
  float perlinOutputY = letter.getNoiseY();
  perlinOutputX = map(perlinOutputX, 0, 1, 0, width); //maps the perlin ouput to x and y coordiantes
  perlinOutputY = map(perlinOutputY, 0, 1, 0, height);
  //translate(letters[iterator].PositionX,letters[iterator].PositionY );
  // rotate(perlinOutput);
  letter.drawLetter(perlinOutputX, perlinOutputY);
  letter.updateConstant(); //updates the value
  popMatrix();
}
void draw() {
  background(WHITE);
  noStroke();
  textSize(12);

  //////Prints the buttons and the text
  fill(buttonColor1);
  rect(BUTTON1_X_MIN, BUTTON1_Y_MIN, BUTTON_X_SIZE, BUTTON_Y_SIZE);
  fill(buttonColor2);
  rect(BUTTON2_X_MIN, BUTTON2_Y_MIN, BUTTON_X_SIZE, BUTTON_Y_SIZE);
  fill(0);
  text("Consonants", CONSONANTS_TEXT_X, BUTTON_TEXT_Y);
  fill(0);
  text("Vowels", VOWELS_TEXT_X, BUTTON_TEXT_Y);
  /////
  int iterator = 0;
  if (vowels == 1) { // if the vowels button is clicked
    while (iterator <table.getRowCount()) {
      println(letters[iterator].letter);
      if (letters[iterator].letter == 'e' || letters[iterator].letter == 'a' || letters[iterator].letter == 'i'|| letters[iterator].letter == 'o' || letters[iterator].letter == 'u') {
        //all the vowels are printed
        printLetter(letters[iterator]);
      }
      iterator++;
    }
  } else   if (consonants == 1) { //if the consonants button is clicked
    while (iterator <table.getRowCount()) {
      println(letters[iterator].letter);
      if (letters[iterator].letter != 'e' && letters[iterator].letter != 'a' && letters[iterator].letter != 'i'&& letters[iterator].letter != 'o' && letters[iterator].letter != 'u') {
        //all letters but the vowels are printed
        printLetter(letters[iterator]);
      }
      iterator++;
    }
  } else { //if the user clicks anywhere else
    while (iterator <table.getRowCount()) {
      printLetter(letters[iterator]);
      iterator++;
    }
  }
}
