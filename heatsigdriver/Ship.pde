class Ship {
  PVector pos, vel, acc;
  float maxSpeed;
  float facing;
  
  Ship() {
    pos = new PVector(0,0);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    maxSpeed = 10;
    
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    acc.mult(0);
    pos.add(vel);
    
    facing = vel.heading() + HALF_PI;
  }
  
  void draw() {
    pushMatrix();
    rotate(facing);
    beginShape();
    
    vertex(0, -10);
    vertex(-5,5);
    vertex(5,5);
   
    endShape(CLOSE);
    
    popMatrix();
    
  }
  
}