int CRT_ID = 0;
class Crt {
  
  PVector pos, vel, acc;
  private float maxSpeed = 4, maxForce = 0.2;
  private float r,d, facing;
  final int id;
  float detectRadius =50;
  
  Crt () {
    pos = new PVector(random(width), random(height));
    vel = new PVector();
    acc = new PVector();
    CRT_ID += 1;
    id  = CRT_ID;
    r = 5;
    d = r * 2;
    
  }
  
  void seek(PVector target) {
    PVector desired = PVector.sub(target, pos);
    desired.setMag(maxSpeed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
  void avoid(PVector target) {
    PVector desired = PVector.sub(pos,target);
    desired.setMag(maxSpeed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);
    applyForce(steer);
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
    vel.mult(0.999);
    
    facing = vel.heading() + HALF_PI;
    
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(facing);
    beginShape();
    vertex(0,-d);
    vertex(-r,r);
    vertex(r,r);
    
    endShape(CLOSE);
    popMatrix();
  }
}