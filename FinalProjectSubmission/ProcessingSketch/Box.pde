float FRICTION_BOX = 0.6;
int DENSITY_BOX= 1;
class Box {

  Body body;
  float rotation;
  int w = 400;
  int h = 400;
  int x = width/2;
  int y = height/2;
  ArrayList<Vec2> points;
=
  ChainShape surface;
  Vec2[] vertices;
  float[] rotations = {3*PI/4, PI/4, 7*PI/4, 5*PI/4, 3*PI/4 };
  Box() {
    rotation =0;
    //STEP 1: Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC; 
    bd.position.set(box2d.coordPixelsToWorld(x, y));

    //STEP 2: Create Body
    body = box2d.createBody(bd);

    //STEP 3: Create Shape (the black box)
    points = new ArrayList<Vec2>();
    //tempPoints = new ArrayList<Vec2>();
    points.add(new Vec2((width/2) - 200, (height/2) - 200));
    points.add(new Vec2((width/2) + 200, (height/2) - 200));
    points.add(new Vec2((width/2) + 200, (height/2) + 200));
    points.add(new Vec2((width/2) - 200, (height/2) + 200));
    points.add(new Vec2((width/2) - 200, (height/2) - 200));
    CreateShape();
  }

  //displays the box
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
  //this function creates the shape
  void CreateShape() {
    // creates a shape]
    surface = new ChainShape();
    vertices = new Vec2[points.size()];
    Vec2 centVec=new Vec2(width/2, height/2); //vector to teh center of the screen
    Vec2 radiusVector = points.get(0).sub(centVec);//vector from teh center to the corner of the black box
    int count = 0;
    for (int i = 0; i < vertices.length; i++ ) {
      // recalculates the vectors to teh points of the black box and for every rotation
      Vec2 tempVector = new Vec2(radiusVector.length()*(cos(rotations[count]+rotation)), radiusVector.length()*(sin(rotations[count]+rotation)));
      if (count < 4) count++;
      vertices[i] = box2d.coordPixelsToWorld(tempVector.add(centVec)); 
    }
    //defining teh properties of the balck box
    surface.createChain(vertices, vertices.length);
    FixtureDef fd = new FixtureDef();
    fd.shape  = surface;
    fd.density = DENSITY_BOX;
    fd.friction = FRICTION_BOX; 

    //STEP5: attack body to shape with fixture
    body.createFixture(fd);
  }

//destroys teh black box to recreate the black box at each rotation
  void updateRotation(float angle) {
    body.destroyFixture(body.getFixtureList());
    //vertices=new Vec2[surface.size()];
    CreateShape();
    rotation = angle;
  }
}
