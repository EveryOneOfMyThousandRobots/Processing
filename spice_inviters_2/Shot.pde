class Shot extends Entity {
  Shot(float x, float y, float angle, float mag, PVector parentVel) {
    super(x,y);
    sprite.add(-1,1);
    sprite.add(1,-1);
    sprite.add(1,1);
    sprite.add(-1,1);
    finishedSprite();
    mover.setMaxSpeed(mag);
    PVector force = PVector.fromAngle(angle + radians(random(-2,2)));
    float dt = PVector.dot(force, parentVel);
    
    if (dt > 1) {
      force.mult(1 + (parentVel.mag() * 0.1));
    } else {
      force.mult(1 - (parentVel.mag() * 0.1));
    }
    
    force.setMag(mag);
    mover.applyForce(force);
    
    
  }
}

void addShot(float x, float y, float angle, float vel, PVector parentVel) {
  entities.add(new Shot(x,y,angle,vel, parentVel));
}
