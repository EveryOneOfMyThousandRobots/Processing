PVector P0, P1, P2, P3;

void setup () {
  size(300,300);
  P0 = new PVector(0,height/2);
  P1 = new PVector(width / 3,height/4);
  P2 = new PVector(width * 0.66, height * 0.75);
  P3 = new PVector(width-1,height/2);
}

void draw() {
  background(0);
  stroke(255);
  for (float t = 0; t < 1; t += 1.0 / width) {
    float x = cubicBezierPoint(P0.x,P1.x,P2.x,P3.x,t);
    float y = cubicBezierPoint(P0.y,P1.y,P2.y,P3.y,t);
    
    point(x,y);
    
  }
}

float cubicBezierPoint(float a0, float a1, float a2, float a3, float t){

  return pow(1-t, 3) * a0 + 3* pow(1-t, 2) * t * a1 + 3*(1-t) * pow(t, 2) * a2 + pow(t, 3) * a3;
}
