
float cx, cy, r;
void setup() {
  size(800,800);
  background(0);
  stroke(255);
  cx = width / 2;
  cy = height / 2;
  r = width / 64;
  
}


float t = QUARTER_PI;
void draw() {
  float x = r * (16 * pow(sin(t), 3));
  float y = r * ((13 * cos(t)) - (5 * cos(2 * t)) - (2 * cos(3 * t)) - cos(4 *t));
  t += radians(1);
  point(cx + x, cy + y);
  
  
  
}
