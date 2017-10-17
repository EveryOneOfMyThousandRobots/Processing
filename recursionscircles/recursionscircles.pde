

void setup() {
  size(600, 400);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  colorMode(HSB);
  drawCircle(width / 2, height /2, width/2);
  noLoop();
}

void drawCircle(float x, float y, float d) {
  color c = color(map(y, height / 2, height, 0, 255), 255, 255);
  stroke(c);
  ellipse(x, y, d, d);
  if (d > 2) {
    drawCircle(x + d, y, d * 0.25);
    drawCircle(x - d, y, d * 0.25);
    drawCircle(x, y + d, d * 0.25);
    drawCircle(x, y - d, d * 0.5);
  }
}