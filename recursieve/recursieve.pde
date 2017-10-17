void setup() {
  size(500, 500);
  background(#605130);
  noStroke();
  recursive(width / 2, height / 2, width / 4);
}

void recursive( float x, float y, float sz) {
  float a, nx, ny;
  fill(lerpColor(#B5D333, #8F683F, random(1)), 100);

  ellipse(x, y, sz, sz);
  if (sz > 1) {
    int ii = 0;
    int i = (int) random(5);
    do {
      a = random(TWO_PI);
      nx = x + sz / 2 * sin(a);
      ny = y + sz / 2 * cos(a);
      recursive(nx, ny, sz * .75);
    } while (ii++ < i);
  }
}