float FRICTION_BOUNDARY = 0.6;
int DENSITY_BOUNDARY = 1;
class Boundary {
  
  Body body;

  int w = width;
  int h = height;
  int x = width/2;
  int y = height/2;
  ChainShape surface;
  Vec2[] vertices;
  ArrayList<Vec2> points;
  BodyDef bd;
 Boundary(){
    
    //STEP 1: Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC; 
    bd.position.set(box2d.coordPixelsToWorld(x, y));

    //STEP 2: Create Body
    body = box2d.createBody(bd);
     points = new ArrayList<Vec2>();
    //tempPoints = new ArrayList<Vec2>();
   points.add(new Vec2(0, 0));
    points.add(new Vec2(width, 0));
    points.add(new Vec2(width, height));
    points.add(new Vec2(0, height));
    points.add(new Vec2(0, 0));
    
    //STEP 3: Create Shape
    surface = new ChainShape();
    vertices = new Vec2[points.size()];

    for (int i = 0; i < vertices.length ;i++ ){

      vertices[i] = box2d.coordPixelsToWorld(points.get(i)); 
    }
    surface.createChain(vertices, vertices.length);   
   // STEP 4: Create Fixture
    FixtureDef fd = new FixtureDef();
    //properties of the outerboundary
    fd.shape  = surface;
    fd.density = DENSITY_BOUNDARY;
    fd.friction = FRICTION_BOUNDARY; 
    //STEP5: attacj body to shape with fixture
    body.createFixture(fd);

  }
//display the outerboundary of teh screen
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    fill(125);
    rect(pos.x, pos.y, w, h);
    popMatrix();
  } 
}
