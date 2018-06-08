ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();

class Vehicle {
  PVector pos, acc, vel, steering;
  PVector desired, target, startingPos;
  float facing = 0;
  float maxSpeed = 0.5;
  float maxForce = 0.3;
  
  Vehicle(float x, float y) {
    pos = new PVector(x,y);
    acc = new PVector();
    vel = new PVector();
    steering = new PVector();
    
    desired = new PVector();
    startingPos = pos.copy();
    target = startingPos.copy();
    vel = PVector.random2D();
    pos = new PVector(random(width), random(height));
    
  }
  
  
  String toString() {
    return "p:" + pos + " v:" + vel + " a:" + acc + " t:" + target; 
  }
  
  void update() {
    if (target != null) {
      behaviours();
    }    
    
    vel.add(acc);
    //vel.limit(4);
    pos.add(vel);
    acc.mult(0);
    
    vel.mult(0.9999);
    
    

    facing = vel.heading();
    
    
  }
  
  void behaviours() {
    seek(target);
    applyForce(steering);
  }
  
  void seek(PVector trgt) {
    desired = PVector.sub(trgt, pos);
    //target.set(trgt);
    desired.setMag(maxSpeed);
    steering = PVector.sub(desired, vel);
    //steering.setMag(maxSpeed);
    steering.limit(maxForce);
    
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void draw() {
    pushMatrix();
    noStroke();
    fill(255);
    translate(pos.x, pos.y);
    rotate(HALF_PI + facing);
    beginShape();
    vertex(-5,5);
    vertex(0, -10);
    vertex(5, 5);
    endShape(CLOSE);
    popMatrix();
  }
  
}
