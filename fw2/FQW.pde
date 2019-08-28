class FW {
  PVector pos, lastPos, acc, vel;
  int timer;
  int sparks;
  boolean alive = true;
  float fuel;
  float thrust;
  float wobble;
  float thrustAngle = 0;
  color c;

  FW(float x, float y) {
    pos = new PVector(x, y);
    lastPos = pos.copy();
    acc = new PVector();
    vel = new PVector();

    applyForce(new PVector(random(-1, 1), random(-3, -6)));
    sparks = floor(random(100, 200));
    fuel = random(1, 10);
    thrust = random(0.1, 0.3);
    timer = floor(random(30, 200));
    wobble = random(-1, 1);
    if (random(1) < 0.1) {
      thrustAngle = radians(random(-15, 15));
    } else if (random(1) < 0.1) {
      thrustAngle = radians(random(-90, 90));
    }
    c = color(random(128, 255), random(128, 255), random(128, 255));
  }

  void update() {
    if (fuel > 0 ) {
      PVector a = PVector.fromAngle(vel.heading() + thrustAngle);
      a.x += random(1) * wobble;
      a.mult(thrust);
      fuel -= pow(thrust, 2);
      applyForce(a);
    }
    vel.add(acc);
    vel.limit(thrust*20);
    acc.mult(0);
    lastPos.set(pos);
    pos.add(vel);
    if (pos.x < 0 || pos.x > width || pos.y > height + 20) {
      alive =false;
    }

    if (vel.y > 0 || timer < 0) {
      alive = false;
      expls.add(new Explosion(pos.x, pos.y, sparks, vel));
    }
    timer -= 1;
    if (random(1) < 0.5) {
      particles.add(new Particle(pos.x, pos.y, c, PVector.mult(vel, 0.1)));
    }
  }


  void applyForce(PVector f) {
    acc.add(f);
  }


  void draw() {
    if (alive) {
      stroke(c);
      ellipse(pos.x, pos.y, 2, 2);

      //bg.beginDraw();
      //bg.stroke(c);
      //bg.line(lastPos.x, lastPos.y, pos.x, pos.y);
      //bg.endDraw();
    }
  }
}
