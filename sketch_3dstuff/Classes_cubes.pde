class MyCube {
  PVector pos;
  PVector size; 
  PVector angle;
  
  PVector vel, accel;
  PVector aVel, aAccel;
  
  MyCube (PVector pos, PVector size, PVector angle) {
    this.pos = pos.copy();
    this.size = size.copy();
    this.angle = angle.copy();
    vel = new PVector(0,0,0);
    accel = new PVector(0,0,0);
    aVel = new PVector(0,0,0);
    aAccel = new PVector(0,0,0);
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    rotateX(angle.x);
    rotateY(angle.y);
    rotateZ(angle.z);
    box(size.x, size.y, size.z);
    popMatrix();
  }
  
  void applyForce(PVector force) {
    accel.add(force);
  }
  
  void applyAngularForce(PVector force) {
    aAccel.add(force);
  }
  
  void update() {
    vel.add(accel);
    accel.mult(0);
    pos.add(vel);
    
    aVel.add(aAccel);
    aAccel.mult(0);
    angle.add(aVel);
  }
  
  
  

}