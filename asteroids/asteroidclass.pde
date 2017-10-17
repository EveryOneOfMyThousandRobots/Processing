int ASTEROID_ID = 0;
class Asteroid {
  PVector pos, vel;
  float r = 0;
  float am; //angular momentum
  float a = 0;
  private float[] radii;
  private float[] angles;
  boolean alive = true;
  int id;

  Asteroid(Asteroid parent) {
    ASTEROID_ID += 1;
    id = ASTEROID_ID;
    
    float maxR = 50;
    if (parent == null) {
      pos = new PVector(random(width), random(height));
      vel = PVector.random2D();
      vel.mult(random(-2, 2));
    } else {
      pos = parent.pos.copy();
      maxR = parent.r * 0.5;
      vel = parent.vel.copy();
      vel.mult(random(1.2, 1.4));
      vel.add( PVector.random2D().mult(0.5));
    }
    //float 

    int numAngles = floor(random(5, 15));
    radii = new float[numAngles];
    angles = new float[numAngles];
    float angle_inc = TWO_PI / numAngles;
    float angle_inc_variance = angle_inc / 10;
    am = random(-radians(2), radians(2));

    for (int i = 0; i < numAngles; i += 1) {
      radii[i] = random(maxR/2, maxR);
      angles[i] = (angle_inc * i) + random(-angle_inc_variance, angle_inc_variance);
      if (radii[i] > r) {
        r = radii[i];
      }
    }
  }

  void breakApart() {
    alive = false;
    if (r > 10) {
      asteroids.add(new Asteroid(this));
      asteroids.add(new Asteroid(this));
    }
    addExplosion(this.pos, this.vel);
  }

  void draw() {
    stroke(255, 255);
    noFill();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    beginShape();
    for (int i = 0; i < radii.length; i += 1) {
      float x = radii[i] * cos(angles[i]);
      float y = radii[i] * sin(angles[i]);
      vertex(x, y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  void update() {
    a += am;
    pos.add(vel);

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
  }
}