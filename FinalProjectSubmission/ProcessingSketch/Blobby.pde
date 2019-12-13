int RADIUS_CENTER = 283;
int GRAVITY = 10;
int ZERO_GRAVITY = 0;
int DENSITY = 100;
int FRICTION = 0;
int BLOBBY_SIZE1 = 50;
int BLOBBY_SIZE2 = 100;
int BLOBBY_SIZE3 = 150;
int EYES_SIZE = 40;
class Blobby {

  Body body;
  int w;
  int h;
  //rgb colours
  int blobby_color1; 
  int blobby_color2; 
  int blobby_color3; 
  int eyeColor; 
  PImage blobby_img;
  boolean free;
  boolean first_time = true;
  int index; 
  Blobby(int x, int y, int size) {
    w = size;
    h = size;
    eyeColor = int(random(2));
    blobby_color1 = int(random(255));
    blobby_color2 = blobby_color1;
    blobby_color3 = blobby_color1;
    free = false;
    //steps to create a body in the box2d world
    //STEP 1: Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC; 
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    //STEP 2: Create Body
    body = box2d.createBody(bd);
    body.setGravityScale(GRAVITY);
    //STEP 3: Create Shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(w/2);
    //STEP 4: Create Fixture
    FixtureDef fd = new FixtureDef();
    fd.shape  = cs;
    fd.density = DENSITY;
    fd.friction = FRICTION; 
    fd.restitution = 0.9f;

    //STEP5: attacj body to shape with fixture
    body.createFixture(fd);
  }
  //a function that checks if the circle has left the box
  boolean checkifAngry() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (dist(pos.x, pos.y, width/2, height/2)> RADIUS_CENTER) {
      free = true;
      body.setGravityScale(ZERO_GRAVITY);
      if (first_time) {
        //the blobbies change colour when they leave the black box
        first_time = false;
        blobby_color1 = int(random(255));
        blobby_color2 = int(random(255));
        blobby_color3 = int(random(255));
        //changes teh size of the blobby
        w = int(random(BLOBBY_SIZE2, BLOBBY_SIZE3));
        h = int(random( BLOBBY_SIZE1, BLOBBY_SIZE2));
        return true;
      }
    }
    return false;
  }
//displays the blobbies
  void display(PImage eyes) {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    fill(this.blobby_color1, this.blobby_color2, this.blobby_color3);
    //nofill(255);
    translate(pos.x, pos.y);
    rotate(-a);
    rectMode(CENTER);
    noStroke();
    ellipse(0, 0, w, h);
    popMatrix();
    image(eyes, pos.x-(size/2), pos.y-(size/2), EYES_SIZE, EYES_SIZE);
  }
}
