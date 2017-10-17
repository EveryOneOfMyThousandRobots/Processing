class Ship {
  PVector pos, vel, acc;
  float r = 10;
  float heading =0;
  float rotation = 0;
  boolean boosting = false;
  private int boostDir = 1;
  Ship() {
    pos = new PVector(width / 2, height / 2);
    vel = new PVector();
    acc = new PVector();
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    turn();
    if (boosting) {
      boost();
    }
    vel.add(acc);
    vel.limit(6);
    acc.mult(0);

    pos.add(vel);
    vel.mult(0.98);

    if (pos.x < -r) {
      pos.x = width + r;
    }

    if (pos.x > width + r) {
      pos.x = -r;
    }

    if (pos.y < -r) {
      pos.y = height + r;
    }

    if (pos.y > height + r) {
      pos.y = -r;
    }
    
    for (Asteroid asteroid : asteroids) {
      float dist = PVector.dist(asteroid.pos, pos);
      if (dist < asteroid.r + 10) {
        addExplosion(pos,vel);
        pos = new PVector(width / 2, height / 2);
        heading = 0;
        
        vel.mult(0);
        acc.mult(0);
        
      }
    }
  }

  void draw() {
    stroke(255,255);
    noFill();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(heading + ( PI / 2));
    triangle(-r, r, r, r, 0, -r);
    if (boosting) {
      noStroke();
      fill(255,0,0);
      rect(r- 2.5,r,5,5);
      rect(-r - 2.5,r,5,5);
    }
    popMatrix();
  }

  void setRotation(float newRotation) {
    rotation = newRotation;
  }

  void boostDir(int dir) {
    if (dir > 0 ) {
      boostDir = 1;
      boosting = true;
    } else if (dir < 0) {
      boostDir = -1;
      boosting = true;
    } else if (dir == 0 ) {
      boostDir = 1;
      boosting = false;
    }
  }

  private void boost() {

    PVector force = PVector.fromAngle(heading);
    force.mult(boostDir);
    force.mult(0.5);
    if (boostDir < 0) {
      force.mult(0.3);
    }
    applyForce(force);
  }

  void turn() {
    heading += rotation;
  }
}