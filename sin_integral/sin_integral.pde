float d = 0.1;
float start = 0;
float stop = TWO_PI;

void setup() {
  size(800, 800);
  noLoop();
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  float integral = 0;
  beginShape();
  for (float x = start; x < stop; x += d) {
    float xx = map(x, start, stop, 0, width);
    float yy = map(f(x), -1, 1, height, 0);

    vertex(xx, yy);
  }
  endShape();
  stroke(255, 0, 0);
  beginShape();
  for (float x = start; x < stop; x += d) {
    float xx = map(x, start, stop, 0, width);
    float yy = map(pow(f(x), 2), -1, 1, height, 0);

    vertex(xx, yy);
  }
  endShape();
  noStroke();
  fill(0, 255, 0, 64);
  for (float x = start; x < stop; x += d) {
    float xx = map(x, start, stop, 0, width);
    float yy = map(pow(f(x), 2), -1, 1, height, 0);

    rect(xx, yy, d * 10, yy);
  }

  println(integral);
}


float f(float x) {
  return sin(x);
}