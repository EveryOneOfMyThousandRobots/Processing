class Man {
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  Mover m;
  PVector pos, vel, acc, dims, eyePos;
  float facing = 0;
  int id = getNextId("MAN");

  Man (float x, float y, float w, float h) {
    m = new Mover(x, y, w, h);
    pos = m.pos;
    eyePos = pos.copy();
    vel = m.vel;
    acc = m.acc;
    dims = m.dims;
  }

  void randomMove() {
    float r1 = random(1);
    if (r1 < 0.01) {
      jump();
    } else if (r1 < 0.05) {
      PVector force = PVector.random2D();
      force.y = 0;
      applyForce(force);
    }
  }

  void applyForce(PVector force) {
    m.applyForce(force);
  }

  void jump() {

    float angle = 0;
    if (random(1) < 0.5) {
      angle = -PI/4;
    } else {
      angle = PI + (PI / 4);
    }
    PVector jump = PVector.fromAngle(angle);
    jump.setMag(5);
    applyForce(jump);
  }

  void shootAt(PVector target) {
    PVector shoot = PVector.sub(target, m.pos);
    shoot.normalize();
    shoot.mult(11);
    Bullet b = new Bullet(m.pos.x, m.pos.y, shoot);
    bullets.add(b);
  }

  void update() {
    m.update();
    m.vel.limit(5);
    m.vel.mult(0.99);

    for (int i = bullets.size() - 1; i >= 0; i -= 1) {
      Bullet b = bullets.get(i);
      b.update();
      if (b.dead) {
        bullets.remove(i);
      }
    }
    if (m.vel.x > 0) {
      facing = 0;
      eyePos.set(m.pos);
      eyePos.x += 5;
    } else {
      facing = PI;
      eyePos.set(m.pos);
    }

    for (float a = facing - (PI / 4); a < facing + (PI / 4); a += radians(10)) {
      float angle = a;
      PVector ww = PVector.fromAngle(angle);
      PVector p = ww.copy();
      PVector posa = eyePos.copy();

      boolean hit = false;
      boolean hitBlock = false;
      boolean hitMan = false;
      for (float d = 0; d < 500; d += 5) {
        posa.add(p.x, p.y);

        for (Obstacle o : blocks) {
          if (o.pointCollides(posa)) {
            hit = true;
            hitBlock = true;
            break;
          }
        }
        if (hit) break;

        for (Man m : men) {
          if (m.m.pointCollides(posa)) {
            hit = true;
            hitMan = true;
            break;
          }
        }
        if (hit) break;
      }
      if (hit) {
        if (hitMan) {
          stroke(255, 0, 0);
          shootAt(posa);
        } else {

          stroke(255);
        }
        line(eyePos.x, eyePos.y, posa.x, posa.y);
      }
    }
  }

  void draw() {
    stroke(255);
    if (m.collided) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }

    for (Bullet b : bullets) {
      b.draw();
    }

    rect(pos.x, pos.y, dims.x, dims.y);
  }
}