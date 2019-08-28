

class Noisey {
  float value;
  float min, max;
  float angle, inc;
  float x, y;
  float cx, cy, cz;
  float radius;

  Noisey(float min, float max, float inc) {
    this.min = min;
    this.max = max;
    this.inc = inc;
    radius = random(1, 10);
    cx = random(0, 100);
    cy = random(0, 100);
    cz = random(0, 100);
  }

  float getValue() {
    angle += inc;
    angle %= TWO_PI;
    x = cx + radius * cos(angle);
    y = cy + radius * sin(angle);
    value = noise(x, y, cz);

    return map(value, 0, 1, min, max);
  }
}
