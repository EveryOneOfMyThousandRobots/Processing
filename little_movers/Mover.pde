class Mover {
  PVector pos,acc,vel;
  float size = 5;
  float s2 = size / 2;
  float speed = 2;
  float force = 0.4;
  PVector target = null;
  
  Mover(float x, float y) {
    pos = new PVector(x,y);
    acc = new PVector();
    vel = new PVector();
    
    
  }
  
  
  void update() {
    vel.add(acc);
    vel.limit(speed);
    pos.add(vel);
    acc.mult(0);
    
    if (target != null) {
      seek(target);
    }
  }
  
  void seek(PVector t) {
    
    PVector steer = PVector.sub(t, pos);
    steer = PVector.sub(steer, vel).normalize().mult(force);
    
    
    applyForce(steer);
    
    
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading() + HALF_PI);
    beginShape();
    vertex(0, -size);
    vertex(-s2, s2);
    vertex(s2,s2);
    endShape(CLOSE);
    popMatrix();
  }
}
