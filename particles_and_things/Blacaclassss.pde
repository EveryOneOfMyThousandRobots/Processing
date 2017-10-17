float exLow = -3;
float exHigh = 3;
class Block {
  float x, y, w, h;
  int numParticles;
  boolean exploded = false;
  Block(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    numParticles = (int) (w * h);
  }

  void explode() {
    if (!exploded) {
      exploded = true;
      for (float xx = x; xx < x + w; xx += 1) {
        for (float yy = y; yy < y + h; yy += 1) {
          Particle p = new Particle(xx, yy);
          p.applyForce(new PVector(random(exLow, exHigh), random(exLow*2, 0)));
          particles.add(p);
        }
      }
    }
  }

  void draw() {
    if (!exploded) {
      stroke(255,0,0);
      fill(255);
      rect(x, y, w, h);
    }
  }
}