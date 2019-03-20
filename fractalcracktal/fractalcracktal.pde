PVector start;
//float len;
float a = radians(45);
float moveA = 0;
float moveAinc = radians(1);
float a_low = radians(45);
float a_high = radians(180);
float angleFactor = 0.9;
float lenFactor = 0.5;


void setup() {
  size(800, 800);
  start = new PVector(width / 2, height);
  //len = height / 4;
}


void draw() {
  moveA += moveAinc;
  if (moveA > TWO_PI) moveA -= TWO_PI;
  
  a = map(sin(moveA), 0, TWO_PI, a_low, a_high);
  
  
  background(0);
  stroke(255);
  translate(start.x, start.y);
  drawLine(height / 2, a);
}


void drawLine(float len, float angle) {
  if (len < 1) return;
  line(0, 0, 0, -len);
  translate(0, -len);
  pushMatrix();
  rotate(-angle);
  drawLine(len * lenFactor, angle * angleFactor);
  popMatrix();
  pushMatrix();
  rotate(angle);
  drawLine(len * lenFactor, angle * angleFactor);
  popMatrix();
}
