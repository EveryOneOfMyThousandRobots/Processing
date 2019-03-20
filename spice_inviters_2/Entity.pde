class Entity {
  Mover mover;
  Sprite sprite;
  float rotation;
  int scoreValue = 1;

  private boolean facingIsRotation;

  boolean wentOffScreen = false;

  final int id = ids.getNextId("Entity");

  int hashCode() {
    return id * 11;
  }

  boolean collided = false;
  
  boolean collides(Entity e) {
    
    boolean result = (mover.collider.collides(e.mover.collider));
    if (result) {
      println(e.id + " collided with " + id);
    }
   
    return result;
  }

  void setFacingIsRotation(boolean f) {
    facingIsRotation = f;
  }

  void setDrag(float d) {
    mover.drag = d;
  }

  Entity(float x, float y) {
    mover = new Mover(x, y, 0, 0, 0, 1, 1);
    sprite = new Sprite(x, y, 0);
    rotation = 0;
    facingIsRotation = false;
  }

  void finishedSprite() {
    Rectangle r = sprite.getBounds();
    mover.collider = new Collider(r.x, r.y, r.width, r.height);
    mover.setDims(r.width, r.height);
  }


  void rotate(float a) {
    if (!facingIsRotation) {
      rotation += a;
    }
  }

  void update() {
    collided = mover.collider.collided;
    wentOffScreen = false;
    mover.update();

    if (facingIsRotation) {
      rotation = mover.direction + HALF_PI;
    }

    float nx = mover.pos.x;
    float ny = mover.pos.y;
    float w2 = mover.dims.x / 2;
    float h2 = mover.dims.y / 2;
    int out = outOfBounds(mover);

    switch (out) {
    case NOT_OUT:
      break;
    case OUT_TOP:
      ny = PLAY_YPOS + PLAY_HEIGHT + h2;
      wentOffScreen = true;
      break;
    case OUT_BOTTOM:
      ny = PLAY_YPOS - h2;
      wentOffScreen = true;
      break;
    case OUT_LEFT:
      nx = PLAY_XPOS + PLAY_WIDTH + w2;
      wentOffScreen = true;
      break;
    case OUT_RIGHT:
      nx = PLAY_XPOS - w2;
      wentOffScreen = true;
      break;
    }
    mover.setPos(nx, ny);
    sprite.set(mover.pos.x,mover.pos.y, rotation);
    
  }


  void draw() {
    sprite.draw();
    mover.draw();
  }
}
