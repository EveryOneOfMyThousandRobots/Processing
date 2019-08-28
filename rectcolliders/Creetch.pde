class Creech extends Wall{
  PVector acc, vel, newPos;
  Creech(float x, float y, float w, float h) {
    super(x,y,w,h);
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    newPos = new PVector(0,0);
  }
  
  void update() {
    vel.add(acc);
    acc.mult(0);
    
    newPos.set(pos);
    newPos.add(vel);
    col.setPos(newPos);
    for (Wall wall : walls) {
      if (col.collides(wall.col)) {
        vel.set(0,0);
        break;
      }
    }
    
    
    pos.add(vel);
    
    
  }
  
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  
  
  
  
}
