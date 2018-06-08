PVector A, B, C;
PVector AB, BC, AC, BA;
float theta;

void setup() {
  size(500,500);
  resetTriangle();
  //noLoop();
}

void resetTriangle() {
  A = new PVector(width / 4, height * 0.75);
  B = new PVector(random(width), random(height));
  C = new PVector(random(width), random(height));
  
  AB = PVector.sub(B,A);
  BC = PVector.sub(C,B);
  BA = PVector.sub(A,B);
  AC = PVector.sub(C,A);
  theta = PVector.angleBetween(BA,BC);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  beginShape();
  vertex(A.x, A.y);
  vertex(B.x, B.y);
  vertex(C.x, C.y);
  endShape(CLOSE);
  text("A", A.x, A.y);
  text("B", B.x, B.y);
  text("C", C.x, C.y);
  text("calc length of C: " + getCLength(AB.mag(), BC.mag(), theta), 10, 10); 
  text("length of C:" + AC.mag(), 10, 20);
  text("angle: " + degrees(theta), 10, 30);
  
  
}

float getCLength(float a, float b, float theta) {
  return sqrt(pow(a, 2) + pow(b, 2) - (2 * a * b * cos(theta)));
}

void mouseReleased() {
  resetTriangle();
}
