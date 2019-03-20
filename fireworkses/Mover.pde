abstract class Mover {
  PVector pos, acc, vel;
  boolean alive = true;
  
  
  Mover (float x, float y, float xv, float yv) {
    pos = new PVector(x,y);
    acc = new PVector(0,0);
    vel = new PVector(xv, yv);
    
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update() {
    vel.add(acc);
    acc.mult(0);
    pos.add(vel);
    
  }
  
  abstract void draw();
  
}
