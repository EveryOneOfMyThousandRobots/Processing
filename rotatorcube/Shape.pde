class S {
  PVector pos;
  PVector posAcc;
  PVector posVel;

  PVector rot;
  PVector rotAcc;
  PVector rotVel;
  
  S(float x, float y, float z) {
    pos = new PVector(x,y,z);
    posAcc = new PVector();
    posVel = new PVector();
    rot = new PVector();
    rotVel = new PVector();
    rotAcc = new PVector();
    
  }
  
  void applyPosForce(PVector force) {
    posAcc.add(force);
  }
  
  void applyRotForce(PVector force) {
    rotAcc.add(force);
  }
  
  
  void update() {
    posVel.add(posAcc);
    posAcc.mult(0);
    pos.add(posVel);
    
    rotVel.add(rotAcc);
    rotAcc.mult(0);
    rot.add(rotVel);
    
    
    
    
  }
  
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    box(50);
    
    
    popMatrix();
  }
}
