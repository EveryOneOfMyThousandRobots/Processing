final float C = 10;
RVector GRAV = new RVector(0,0.1);
class RVector {
  private PVector p;
  float x, y;
  RVector(float x, float y) {
    p = new PVector(x,y);
  }
  
  void add(RVector a) {
    float lf = 1.0 / sqrt(1 - ((p.mag() + a.p.mag()) / pow(C,2)));
    p.add(a.p).div(lf);
    update();
  }
  
  RVector reverse() {
    PVector s = p.copy().mult(-1);
    RVector a = new RVector(s.x,s.y);
    return a;
  }
  
  void update() {
    this.x = p.x;
    this.y = p.y;
  }
  
  void mult(float x) {
    p.mult(x);
    update();
  }
  
  void div(float x) {
    p.div(x);
    update();
  }
  
  void sub(RVector a) {
    this.add(a.reverse());
    update();
  }
}
Mover m;
void setup() {
  size(400,400);
  m = new Mover(width / 2, height / 2);

}



void draw() {
  background(0);
  m.applyForce(GRAV);
  m.update();
  m.draw();
  fill(255);
  text(nfc(m.vel.y, 10), 10, 10);  
}

class Mover {
  PVector pos;
  RVector  vel, acc;
  
  Mover(float x, float y){
    pos = new PVector(x,y);
    vel = new RVector(0,0);
    acc = new RVector(0,0);
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel.p);
    acc.mult(0);
    
    if (pos.x < 0) {
      pos.x = width;
    } 
    if (pos.x > width) {
      pos.x = 0;
    }
    
    if (pos.y < 0) {
      pos.y = height;
    }
    
    if (pos.y > height) {
      pos.y = 0;
    }
    
  }
  
  void applyForce(RVector r) {
    acc.add(r);
  }
  
  void draw() {
    stroke(255);
    ellipse(pos.x, pos.y, 3, 3);
  }
  
}
