float xLow, xHigh;
float xp;
float dx = 0.1;

void setup() {
  size(800,400);
  xLow = -4 * TWO_PI;
  xHigh = 4 * TWO_PI;
  xp = xLow;
}


void draw() {
  background(0);
  stroke(255);
  noFill();
  beginShape();
  for (float x = 0; x < width; x += 1) {
    float xx = map(x, 0, width, xLow, xHigh);
    float y = map(f(xx), -1, 1, height, 0);
    vertex(x,y);
    
  }
  endShape();
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  
  xp = (xp + 1) % width;
  
  float xxp = map(xp, 0, width, xLow, xHigh);
  float xxpy = map(f(xxp), -1, 1, height, 0);
  
  float dxxp = map(xp + dx, 0, width, xLow, xHigh);
  float dxxpy = map(f(dxxp), -1, 1, height,0);
  
  PVector A = new PVector(xp, xxpy);
  PVector B = new PVector(xp + dx, dxxpy);
  
  
  PVector AB = PVector.sub(B,A).normalize();
  PVector AB2 = AB.copy();
  AB2.mult(-1);
  
  AB.mult(500);
  AB2.mult(500);
  AB.add(A);
  AB2.add(A);
  stroke(255,0,0);
  line(A.x, A.y, AB.x, AB.y);
  line(A.x, A.y, AB2.x, AB2.y);
  
  
}


float f(float x) {
  return sin(x);
}
