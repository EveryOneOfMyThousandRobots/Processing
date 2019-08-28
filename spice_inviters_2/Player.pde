class Player extends Entity {
  boolean thrusting = false;
  boolean shooting = false;
  float rotating = 0;
  private int shotCooldown = 0;
  private final float rotateInc = radians(3);
  int iFrames = 0;
  int iFrameSeconds = 2;
  Player(float x, float y) {
    super(x, y);
    sprite.add(0, -10);
    sprite.add(-10, 10);
    sprite.add(10, 10);
    finishedSprite();
    setFacingIsRotation(false);
    mover.setDrag(0.01);
    mover.setMaxSpeed(5);
    mover.setMaxForce(4);
    iFrames = int(frameRate * iFrameSeconds);
  }

  //override
  boolean collides(Entity e) {
    if (iFrames > 0) return false;
    return super.collides(e);
  }

  void reset() {
    thrusting = false;
    shooting = false;
    rotating = 0;
    shotCooldown = 0;
    mover.setPos(PLAYER_START_XPOS, PLAYER_START_YPOS);
    collided = false;
    mover.collider.collided = false;
    mover.vel.mult(0);
    mover.acc.mult(0);
    iFrames = int(frameRate * iFrameSeconds);
    println("reset player");
    score = 0;
    multiplier = 1;
    removeShots();
  }

  private void shoot() {
    addShot(mover.pos.x, mover.pos.y, rotation-HALF_PI, 5, mover.vel);
  }

  void update() {
    if (rotating != 0) {
      rotate(rotating);
    }
    if (thrusting) {
      thrust();
    }
    super.update();
    sprite.set(mover.pos.x, mover.pos.y, rotation);
    if (shotCooldown > 0) {
      shotCooldown -= 1;
    } else {
      if (shooting) {
        if (iFrames == 0) {
          shotCooldown = playerShotCoolDownTime;
          //shooting = false;
          shoot();
        }
      }
    }
    shooting = false;
    if (iFrames > 0) {
      iFrames -= 1;
    }
  }
  void thrust() {
    PVector vel = PVector.fromAngle(super.rotation-HALF_PI);
    //vel.normalize();
    mover.applyForce(vel);
  }

  void draw() {
    if (iFrames > 0) {
      sprite.setColour(128);
    } else {
      sprite.setColour(255);
    }
    super.draw();
  }


  void rotate(float a) {
    super.rotate(a * rotateInc);
  }
}
