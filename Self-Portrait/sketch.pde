void setup(){
  size(500, 500); //set size of window
  background(55); // set colour of background
  //the curly hair  
  for(int j = 0; j < 245; j++){
    for(int i = 0; i < 7; i++){
     stroke(5);
     noFill();
     arc(130+(j), 120 + i*40, 10, 20, PI/2, TWO_PI-PI/2);
     arc(130+(j), 140 + i*40, 10, 20, -PI/2, PI/2);
    }
  }
  
  //neck, face and ear
  fill(color(208, 111, 56));//for ellipse
  stroke(55);
  strokeWeight(10);
  rect(225, 250, 50, 50);
  arc(250, 200, 250, 150, 0, PI); // for face - lower half
  arc(370, 173, 35,45,-PI/2, PI/2 ); //ear
  
  noStroke();
  rect(130, 100, 240, 100);// face - upper half
  fill(color(0));
  noStroke();
  arc(250, 100, 250, 125, PI, TWO_PI); // hair fringe
  arc(250,100, 100, 100, 0, PI/2 );//hair fringe
  
  // to make te complicated bang
  rect(300, 100, 75, 50); //right side hair
  fill(color(208, 111, 56));//for ellipse
  arc(300,150, 140, 100,  TWO_PI-PI/2, TWO_PI ); //right side hair
  fill(color(0));
  rect(130, 100, 130, 50); // hair - bang
  rect(125, 100, 50, 100);// hair - bang
  fill(color(208, 111, 56));//for ellipse
  arc(180,200, 100, 100, PI, TWO_PI-PI/2 );
  
  // body  
  fill(color(128,128,0)); // 
  arc(250, 450, 400, 300, PI, TWO_PI);
  
  //Facial features
  //eye
  for(int eye = 0; eye <2; eye++){
    stroke(0);
    strokeWeight(5);
    fill(0);
    line(185+(eye*100), 175, 225+(eye*100), 175);
    arc(205+(eye*100),175, 25, 25, 0, PI );
  }
  //smirk
  noFill();
  arc(250, 230, 50, 50, PI/5, PI-(PI/5));
  
}

void draw(){
  println(mouseX, mouseY); //for debugging
}
