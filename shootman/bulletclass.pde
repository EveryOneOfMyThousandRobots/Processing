class Bullet {
  PVector pos;
  PVector dir;
  boolean dead = false;
  float speed = 10;
  boolean hitTarget = false;
  float range;
  float moved = 0;

  Bullet(float x, float y, float a, float dist) {
    pos = new PVector(x, y);
    dir = PVector.fromAngle(a);
    dir.normalize();
    dir.mult(speed);
    range = dist;
  }

  void update() {
    if (dead) return;
    moved += speed;
    pos.add(dir);
    if (outOfBounds(pos.x, pos.y)) {
      dead = true;
    }

    if (!dead) {
      for (Wall w : walls) {
        if (w.collides(pos.x, pos.y)) {
          dead = true;
        }
      }
    }
    if (!dead) {
      for (Target t : targets) {
        if (t.hit) continue;
        if (t.collides(pos.x,pos.y)) {
          dead = true;
          hitTarget = true;
          t.hit = true;
        }
      }
    }
    if (!dead) {
      if (moved >= range) {
        dead = true;
      }
      
    }
  }

  void draw() {
    if (dead) return;
    stroke(255, 0, 0);
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, 3, 3);
  }
}