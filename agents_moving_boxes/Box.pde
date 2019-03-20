// A rectangular box
class Box {
  //  Instead of any of the usual variables, we will store a reference to a Box2D Body
  Body body;      

  float w,h;

  Box(float x, float y, float w, float h) {
    this.w = w;
    this.h = h;

    // Build Body
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(world.coordPixelsToWorld(x,y));
    body = world.createBody(bd);


   // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = world.scalarPixelsToWorld(w/2);
    float box2dH = world.scalarPixelsToWorld(h/2);  // Box2D considers the width and height of a
    sd.setAsBox(box2dW, box2dH);            // rectangle to be the distance from the
                           // center to the edge (so half of what we
                          // normally think of as width or height.) 
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Attach Fixture to Body               
    body.createFixture(fd);
  }

  void draw() {
    // We need the Body’s location and angle
    Vec2 pos = world.getBodyPixelCoord(body);    
    float a = body.getAngle();

    pushMatrix();
    translate(pos.x,pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);              // translate and rotate the rectangle
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }

}
