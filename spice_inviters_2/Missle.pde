class Missile extends Entity {
  
  Missile() {
    super(0,0);
    
    StartPos s = getRandomOffScreenPos();
    mover.setPos(s.pos.x, s.pos.y);
    float ms = random(2,5);
    s.vel.mult(ms);
    
    sprite.add(0, -3);
    sprite.add(3,0);
    sprite.add(3,6);
    sprite.add(6,9);
    sprite.add(-6,9);
    sprite.add(-3,6);
    sprite.add(-3,0);
    finishedSprite();
    setFacingIsRotation(true);
    mover.setMaxSpeed(ms);
    mover.setMaxForce(0.1);
    mover.applyForce(s.vel);
    mover.setDrag(0);
    
    
  }
  
  void steer() {
    PVector desired = PVector.sub(player.mover.pos, mover.pos);
    //desired.normalize();
    desired.setMag(mover.maxSpeed);
    PVector steer = PVector.sub(desired, mover.vel);
    //steer.setMag(mover.maxSpeed * 0.2);
    //steer.setMag(0.1);
    steer.limit(mover.maxForce);
    mover.applyForce(steer);
    //PVector v = PVector.fromAngle(mover.vel.heading());
    //v.mult(mover.maxSpeed * 0.01);
    //mover.applyForce(v);
  }
  
  void update() {
    steer();
    super.update();
    //mover.vel.setMag(mover.maxSpeed);
  }
}
