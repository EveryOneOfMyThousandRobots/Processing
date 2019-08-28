ArrayList<PVector> circle = new ArrayList<PVector>();
ArrayList<PVector> square = new ArrayList<PVector>();
float circle_radius, square_radius, cx, cy;
final float ONE_RAD = radians(1);
float spacing  = radians(5);
float amt = 0;
float angle = 0;

void setup() {
  size(500,500);
  
  circle_radius = width / 3;
  square_radius = width / 3;
  cx = width / 2;
  cy = height / 2;
  PVector start = polarToVector(PI + QUARTER_PI,square_radius);
  int counter = 1;
  PVector end = polarToVector(PI + QUARTER_PI + HALF_PI, square_radius);
  float ii = 0;
  float step = spacing / HALF_PI;
  
  for (float a = PI + QUARTER_PI; a < PI + QUARTER_PI + TWO_PI; a += spacing) {
    circle.add(polarToVector(a,circle_radius));
    
    PVector sq = PVector.lerp(start, end, ii); 
    
    square.add(sq);
    //println(ii + " : " + sq);
    ii += step;
    if (ii >= 1) {
      counter += 1;
      ii = 0;
      start = end;
      end = polarToVector(PI + QUARTER_PI + (HALF_PI * counter), square_radius);
    }
  }
  //noLoop();
}
float x, y;
void draw(){
  
  background(255);
  stroke(51);
  strokeWeight(3);
  noFill();
  //drawShape(circle);
  //drawShape(square);
  angle += ONE_RAD;
  angle = angle % TWO_PI;
  amt = map(sin(angle), -1, 1, 0,1);
  beginShape();
  for (int i = 0; i < circle.size(); i += 1) {
    PVector c = circle.get(i);
    PVector s = square.get(i);
    
    x = lerp(c.x, s.x, amt);
    y = lerp(c.y, s.y, amt);
    vertex(x,y);
    //ellipse(x,y,4,4);
    
  }
  endShape(CLOSE);
}

PVector polarToVector(float a, float r) {
  return new PVector(cx + r * cos(a), cy + r * sin(a));
}

void drawShape(ArrayList<PVector> points) {
  beginShape();
  for (PVector p : points) {
    vertex(p.x, p.y);
  }
  endShape();
  for (PVector p : points) {
    ellipse(p.x, p.y, 4, 4);
  }
}