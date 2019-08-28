float modulo = 10;
float modLimit = 250;
float stepAngle, radius;
float cx, cy;
float tt = 2;
ArrayList<PVector> circlePoints = new ArrayList<PVector>();
void setup() {
  size(400, 400);


  //frameRate(6);

  background(0);
}

void drawCircle() {
  stroke(255);
  fill(255);
  circlePoints.clear();
  stepAngle = TWO_PI / modulo;
  radius = (width / 2);// - (width / 8);
  cx = width / 2;
  cy = height / 2;
  float x, y;
  for (float a = 0; a < TWO_PI; a += stepAngle) {

    x = cx + radius * cos(a);
    y = cy + radius * sin(a);
    PVector p = new PVector(x, y);
    circlePoints.add(p);
    //ellipse(x, y, 3, 3);
  }
  stroke(255,64);
  for (float i = 0; i < modulo; i += 1) {
    float answer = (tt * i) % modulo;
    PVector from = circlePoints.get((int)i);
    PVector to = circlePoints.get((int)answer);
    
    line(from.x, from.y, to.x, to.y);
  }
}

void draw() {
  background(0);
  drawCircle();
  //tt += 1;
  modulo += 1;
  
  if (modulo > modLimit) {
    modulo = 10;
    tt += 1;
  }
  
}
