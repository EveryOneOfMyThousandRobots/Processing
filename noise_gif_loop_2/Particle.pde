

class Particle {
  NoiseLoop A, B;
  float maxSpeed = 2;
  PVector pos, vel, acc;
  color c;

  Particle() {
    A = new NoiseLoop(PARTICLE_RANGE, 0, 1);
    B = new NoiseLoop(PARTICLE_RANGE, 0, 1);
    c = color(random(255), 128, 255);
    pos = new PVector();
    //pos = new PVector(random(width), random(height));
    vel = new PVector();
    acc = new PVector();
    update(0);
  }

  void applyForce(PVector p) {
    acc.add(p);
  }



  void update(float angle) {

   pos.x = A.value(angle)*width;
   pos.y = B.value(angle)*height;
  }

  void draw() {
    noStroke();
    fill(c, 64);
    circle(pos.x, pos.y, 3);
  }
}
