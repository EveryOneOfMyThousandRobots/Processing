B b;
void setup() {
  size(400,400);
  smooth();
  background(255);
  b = new B(width / 2, height / 2, height / 16);
  
}

void draw() {
  background(255);
  b.facePoint(new PVector(mouseX, mouseY));
  b.update();
  b.draw();
  
}

void mouseClicked() {
  b.update(new PVector(mouseX, mouseY));
  
}

class B {
  PVector pos;
  float radius;
  float facing;
  PVector towards = null;
  PVector towardsUnit = null;
  
  B (float x, float y,  float radius) {
    pos = new PVector(x,y);
    facing = 0;
    this.radius = radius;
  }
  
  void facePoint(PVector p) {
    facing = PVector.sub(p,pos).heading();
  }
  
  void update(PVector p) {
    towards = p.copy();
    towardsUnit = PVector.sub(towards, pos);
    towardsUnit.normalize();
  }
  
  void update() {
    if (towards != null) {
      
      pos.add(towardsUnit);
      if (pos.dist(towards) < 2) {
        towards = null;
        
      }
    }
    
  }
  
  void draw() {
    stroke(0);
    fill(255,0,0);
    ellipse(pos.x, pos.y, radius, radius);
    float xx = pos.x + radius * cos(facing);
    float yy = pos.y + radius * sin(facing);
    line(pos.x, pos.y, xx, yy);
    
  }
}