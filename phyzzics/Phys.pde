int PHYS_ID = 0;
class Phys {
  final int id;
  {
    PHYS_ID += 1;
    id = PHYS_ID;
  }
  PVector pos, vel, acc, dims, cpos;
  boolean collision_checked = false;
  float wsq;
  
  Phys(float x, float y) {
    pos = new PVector(x,y);
    
    vel = new PVector();
    acc = new PVector();
    dims = new PVector(10,5);
    wsq = dims.x * dims.x;
    cpos = new PVector(pos.x + (dims.x / 2), pos.y + (dims.y / 2));
  }
  void randomiseVel() {
    vel = PVector.random2D();
  }
  
  void applyForce(PVector f) {
    acc.add(f);
  }
  
  boolean collision(float x, float y) {
    boolean rt = false;
    
    float dist = sqDist(x,y,cpos.x, cpos.y);
    
    rt = dist < wsq;
    
    return rt;
  }
  
  void update() {
    vel.add(acc);
    acc.mult(0);
    vel.mult(0.999);
    vel.limit(4);
    
    
    for (Phys p : objs) {
      if (p.id == id) continue;
      
      
    }
    
    pos.add(vel);
    
  }
  
  void draw() {
    pushMatrix();
    stroke(255);
    noFill();
    translate(pos.x, pos.y);
    rectMode(CENTER);
    rect(0,0,dims.x,dims.y);
    popMatrix();
  }
}

float sqDist(float x1, float y1, float x2, float y2) {
  return pow(x1 - x2,2) + pow(y1 - y2,2);
}
