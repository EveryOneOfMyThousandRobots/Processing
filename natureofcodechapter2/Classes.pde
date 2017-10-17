abstract class Mover {
  float mass;
  PVector loc, vel, acc;

  Mover(float x, float y, float mass) {
    loc = new PVector(x, y);
    this.mass = mass;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    acc.add(PVector.div(force, mass));
  }

  void applyGravity(PVector gravity) {
    applyForce(PVector.mult(gravity, mass));
  }

  void applyFriction(float c) {
    float normal = 1;
    float frictionMag = c* normal;
    PVector friction = vel.copy();
    friction.normalize();
    friction.mult(-1);
    friction.mult(frictionMag);
    applyForce(friction);
  }

  void update() {

    if (loc.x + vel.x >= width) {
      loc.x = width - 1;
      
      vel.x *= -1;
      applyFriction(0.1);
    } else if (loc.x + vel.x <= 0) {
      loc.x = 1;
      
      vel.x *= -1;
      applyFriction(0.1);
      //vel.x *= 0.99;
    }

    if (loc.y + vel.y >= height) {
      loc.y = height - 1;
      
      vel.y *= -1;
      applyFriction(5);
      //vel.y *= 0.99;
    }

    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }

  abstract void draw();
}

class Ball extends Mover {
  float radius;
  float diameter;
  Ball(float x, float y, float radius, float mass) {
    super(x, y, mass);
    this.radius = radius;
    this.diameter = radius * 2;
  }

  void draw() {
    stroke(175);
    fill(100);
    ellipse(loc.x, loc.y, diameter, diameter);
  }
}