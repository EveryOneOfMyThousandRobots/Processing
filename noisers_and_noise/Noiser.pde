final float MIN_RAD = 0.01;
final float MAX_RAD = 0.03;
float snap = 100;

class Noiser {

  float xc0, yc0, xc1, yc1;

  float a0, a1;
  float r0, r1;
  float as0, as1;
  float x0, y0, z0, x1, y1, z1;
  float v = 0;

  Noiser() {
    xc0 = random(0, 10);
    yc0 = random(0, 10);

    xc1 = random(0, 10);
    yc1 = random(0, 10);

    z0 = random(0, 10);
    z1 = random(0, 10);
    r0 = random(MIN_RAD, MAX_RAD);
    r1 = r0 + random(MIN_RAD, MAX_RAD);
    as0 = random(TWO_PI);
    as1 = random(TWO_PI);
  }

  void update() {
    float amt = (float)frame / (float) TOTAL_FRAMES;
    a0 = as0 + (TWO_PI * amt);
    a1 = as1 + (TWO_PI * amt);
    x0 = xc0 + r0 * cos(a0);
    y0 = yc0 + r0 * sin(a0);
    
    x1 = xc1 + r1 * cos(a1);
    y1 = yc1 + r1 * sin(a1);
    
    v = noise(x0, y0, z0) + noise(x1,y1,z1);
    v %= 1.0;


    if (v >= 0.25 && v <= 0.75) {
    }
  }
}
