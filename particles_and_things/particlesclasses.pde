float FRICTION = 0.3;

boolean within(Particle p, Block b) {
  boolean returnValue = false;

  int newX = (int) (p.pos.x + p.vel.x);
  int newY = (int) (p.pos.y + p.vel.y);
  int bx = (int) (b.x);
  int bxw = (int) (b.x + b.w);
  int by = (int) (b.y);
  int byh = (int) (b.y + b.h);
  if (newX > bx && newX < bxw && newY > by && newY < byh && b.exploded == false) {
    returnValue = true;
  }


  return returnValue;
}

boolean collides(Particle me, Particle them) {
  if (me.particleId == them.particleId) return false;

  boolean returnValue = false;

  int myX = (int) (me.pos.x + me.vel.x);
  int myY = (int) (me.pos.y + me.vel.y);

  int themX = (int) (them.pos.x + them.vel.x);
  int themY = (int) (them.pos.y + them.vel.y);

  if (myX == themX && myY == themY) {
    returnValue = true;
  }


  return returnValue;
}
int PARTICLE_ID = 0;
class Particle {
  int particleId;
  PVector pos;
  PVector acc;
  PVector vel;
  float lifeTime;
  boolean alive = true;


  Particle(float x, float y) {
    particleId = PARTICLE_ID;
    PARTICLE_ID += 1;
    pos = new PVector(x, y);
    acc = new PVector();
    vel = new PVector();
    lifeTime = random(25, 500);
  }

  void applyForce(PVector force) {
    acc.add(force.copy());
  }

  void draw() {
    stroke(255);
    point(pos.x, pos.y);
  }

  void update() {
    if (!alive) return;

    lifeTime -= 1;
    if (lifeTime <= 0) {
      alive = false;
    }
    boolean skipAdd = false;
    vel.add(acc);
    acc.mult(0);
    if (pos.x + vel.x <= 0) {
      vel.x *= -1;
      vel.mult(FRICTION);
      pos.x = 0;
      skipAdd = true;
    }
    if (pos.x + vel.x >= width) {
      vel.x *= -1;
      vel.mult(FRICTION);
      pos.x = width - 1;
      skipAdd = true;
    }

    if (pos.y + vel.y <= 0) {
      vel.y *= -1;
      vel.mult(FRICTION);
      pos.y = 0;
      skipAdd = true;
    }
    if (pos.y + vel.y >= height) {
      vel.y *= -1;
      vel.mult(FRICTION * FRICTION);
      pos.y = height - 1;
      skipAdd = true;
    }

    for (int i = 0; i < blocks.size(); i += 1) {
      Block block = blocks.get(i);
      if (!block.exploded) {

        if (within(this, block)) {
          skipAdd = true;
          vel.mult(-1);
          vel.mult(FRICTION);
          break;
        }
      }
    }

    for (int i = 0; i < particles.size(); i += 1) {
      Particle p = particles.get(i);
      if (p.alive) {
        if (collides(this, p)) {
          //skipAdd = true;
          vel.mult(-1);
          vel.mult(FRICTION);
          break;
        }
      }
    }

    //if (vel.y <= 0.01 && pos.y >= height - 2) {
    //  vel.mult(FRICTION * FRICTION * FRICTION);
    //}
    if (!skipAdd) 
      pos.add(vel);
  }
}