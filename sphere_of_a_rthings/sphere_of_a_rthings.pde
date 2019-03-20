import peasy.*;
PeasyCam cam;

float p1 = 0;
float p2 = 0;

void setup() {
  size(400, 400, P3D);
  cam = new PeasyCam(this, 100);
}

void draw() {
  p1 += radians(0.1);
  p2 += radians(0.2);
  background(0);
  float r = 100;
  translate(width / 2, height / 2);
  stroke(255);
  noFill();
  beginShape();
  for (float a2 = p2; a2 < TWO_PI + p2; a2 += radians(5)) {
    for (float a1 = p1; a1 < TWO_PI + p1; a1 += radians(5)) {
      float x, y, z;
      x = y = z = 0;

      x = r * sin(a1) * cos(a2);
      y = r * sin(a1) * sin(a2);
      z = r * cos(a1);

      vertex(x, y, z);
    }
  }
  endShape(CLOSE);
}
