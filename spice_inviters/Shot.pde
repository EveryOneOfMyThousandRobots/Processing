class Shot {
  MovingEntity entity;
  Mover mover;
  final int id = ids.getNextId("Shot");
  int hashCode() {
    return id * 17;
  }
  Shot(float x, float y, float angle, float mag, PVector parentVel) {
    //MovingEntity (float x, float y, float w, float h, float drag, float maxSpeed, float maxForce, boolean facingIsRotation) {
    entity = new MovingEntity(x,y,2,2,0,6,1,false);
    entity.sprite.addVertex(-1,-1);
    entity.sprite.addVertex(1,-1);
    entity.sprite.addVertex(1,1);
    entity.sprite.addVertex(-1,1);
    mover = entity.mover;
    PVector force = PVector.fromAngle(angle);
    float dt = PVector.dot(force, parentVel);
    if (dt > 1) {
      force.mult(1 + (parentVel.mag() * 0.1));
    } else {
      force.mult(1 - (parentVel.mag() * 0.1));
    }
    //force.add(parentVel);
    force.setMag(mag);
    
    mover.applyForce(force);
    
  }
  
  void draw() {
    entity.sprite.draw();
  }
  
  void update() {
    
    entity.update();
  }
}

ArrayList<Shot> shots = new ArrayList<Shot>();

void addShot(float x, float y, float angle, float vel, PVector parentVel) {
  shots.add(new Shot(x,y,angle,vel, parentVel));
}
