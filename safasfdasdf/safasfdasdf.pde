import processing.sound.*;

Pulse pulse;
float x = 0;
float xi = 2;
float y = 0;
float yy = 0;
float lx, ly;
float f = 60;
float r = 0;
float a = 0;
void setup() {
  size(400, 400);
  pulse = new Pulse(this);
  r = 1;
  x = width / 2;
}


void draw() {
  xi = map(mouseX, 0, width, 1, 100);
  fill(255,255,255,5);
  noStroke();
  rect(0,0,width,height);
  a += f / frameRate;
  x += xi;
  if (x > width) {
    x %= width;
    lx = x;
  }
  if (a > TWO_PI) {
    a %= TWO_PI;
    
  }
  y = r * sin(a);
  yy = (height / 2) + map(y, 0, 1, 0, height / 4);
  stroke(0);
  fill(0);
  line(lx, ly, x, yy);
  lx = x;
  ly = yy;
}