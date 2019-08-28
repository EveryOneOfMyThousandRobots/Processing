class Barrier {
  Body body;
  float w,h;
  
  Barrier(float x, float y, float w, float h) {
    
    this.h = h;
    this.w = w;
    BodyDef bd = new BodyDef(); 
    
    bd.type = BodyType.STATIC;
    bd.position.set(world.coordPixelsToWorld(x,y));
    body = world.createBody(bd);
    
    PolygonShape shape = new PolygonShape();
    float bw = world.scalarPixelsToWorld(w / 2);
    float bh = world.scalarPixelsToWorld(h / 2);
    shape.setAsBox(bw, bh);
    
    FixtureDef fixture = new FixtureDef();
    fixture.shape = shape;
    fixture.density = 1;
    fixture.friction = 0.3;
    fixture.restitution = 0.5;
    body.createFixture(fixture);
    
  }
  
  void draw() {
    Vec2 pos = world.getBodyPixelCoord(body);
    float angle = body.getAngle();
  
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-angle);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();

  }
  
}
