class C {
  PVector pos;
  PVector size;
  PVector angle;
  PVector vel, accel;
  PVector velA, accelA;
  
  C (PVector pos, PVector size, PVector angle) {
    this.pos = pos.copy();
    this.size = size.copy();
    this.angle = angle.copy();
    vel = new PVector(0,0,0);
    velA = new PVector(0,0,0);
    accel = new PVector(0,0,0);
    accelA = new PVector(0,0,0);
  }
  
  void applyForce(PVector force) {
    accel.add(force);
    
  }
  
  void applyForceA(PVector force) {
    accelA.add(force);
  }
  
  void update() {
    vel.add(accel);
    accel.mult(0);
    
    velA.add(accelA);
    accelA.mult(0);
    
    pos.add(vel);
    angle.add(velA);
    vel.mult(0.99);
    velA.mult(0.99);
  }
   
   
   void draw() {
     stroke(0);
     fill(255);
     pushMatrix();
     translate(pos.x, pos.y, pos.z);
     rotateX(angle.x);
     rotateY(angle.y);
     rotateZ(angle.z);
     box(size.x, size.y, size.z);
     popMatrix();
   }
}

class P {
  PVector pos;
  P (PVector pos) {
    this.pos = pos.copy();
    this.pos.z = -1;
  }
  
  P(float x, float y) {
    this.pos = new PVector(x,y, -1);
  }
}