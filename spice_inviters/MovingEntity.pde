
class MovingEntity {
  Mover mover;
  Sprite sprite;
  float r;
  final boolean facingIsRotation;
  boolean wentOffScreen = false;
  final int id = ids.getNextId("movingEntity");
  int hashCode() {
    return id * 11;
  }
  
  boolean collided = false;

  MovingEntity (float x, float y, float w, float h, float drag, float maxSpeed, float maxForce, boolean facingIsRotation) {
    mover = new Mover(x, y, w, h, drag, maxSpeed, maxForce);
    sprite = new Sprite(x, y, 0);
    r = 0;

    this.facingIsRotation = facingIsRotation;
  }


  void update() {
    collided = mover.collider.collided;
    wentOffScreen = false;
    mover.update();
    if (facingIsRotation) {
      r = mover.direction;
    }
    float nx = mover.pos.x;
    float ny = mover.pos.y;
    if (mover.pos.x < ARENA_XPOS - (mover.dims.x / 2)) {
      nx = ARENA_XPOS + ARENA_WIDTH + mover.dims.x / 2;
      wentOffScreen = true;
    }

    if (mover.pos.x > ARENA_XPOS + ARENA_WIDTH + (mover.dims.x / 2)) {
      nx = ARENA_XPOS - mover.dims.x / 2;
      wentOffScreen = true;
    }

    if (mover.pos.y < ARENA_YPOS - (mover.dims.y / 2)) {
      ny = ARENA_YPOS + ARENA_HEIGHT + mover.dims.y / 2;
      wentOffScreen = true;
    }

    if (mover.pos.y > ARENA_YPOS + ARENA_HEIGHT + (mover.dims.y / 2)) {
      ny = ARENA_YPOS - mover.dims.y / 2;
      wentOffScreen = true;
    }
    mover.setPos(nx,ny);
    sprite.set(mover.pos.x, mover.pos.y, r);
  }

  void rotate(float a) {
    if (!facingIsRotation) {
      r += a;
    }
  }
  
  void draw() {
    sprite.draw();
    mover.draw();
  }
}
