int points = 10;
int pointsLimit = 300;
int limit = 20;
final int alpha = 128;
final int sat = 255, bri = 255;
int N = 2;
float CX, CY;

float rad;
float diam;
void setup() {
  size(800, 800);
  CX = width / 2;
  CY = height / 2;
  rad = CX * 0.95;
  diam = rad * 2;
  colorMode(HSB);
  //frameRate(2);
}


void draw() {
  background(0, 0, 0);

  stroke(map(points, 0, pointsLimit, 0, 255), 125, 255);
  noFill();
  circle(CX, CY, diam);

  //fill(, 0, 255);
  translate(CX, CY);
  //for (int i = 0; i < points; i += 1) {
  //  //float a = map(i, 0, points, 0, TWO_PI);
  //  //float x = rad * cos(a);
  //  //float y = rad * sin(a);


  //  PVector p = getVector(i);
  //  circle(p.x,p.y,4);

  //}

  //int N = 2;
  //int limit = 500;
  float angle = 0;
  for (int i = 0; i < limit; i += 1) {
    angle = getAngle(i);
    PVector a = getVector(i);
    PVector b = getVector(i * N);
    stroke(map(angle, 0, TWO_PI, 0, 255), sat, bri, alpha);
    line(a.x, a.y, b.x, b.y);
  }
  points += 1;
  limit = points;
  if (points > pointsLimit) {
    points = 10;
    N += 1;
    if (N > 10) {
      N = 2;
      
    }
  }
  
}

float getAngle(int i) {
  return map(i % points, 0, points, 0, TWO_PI);
}

PVector getVector(int i) {
  return PVector.fromAngle(getAngle(i)+PI).mult(rad);
}
