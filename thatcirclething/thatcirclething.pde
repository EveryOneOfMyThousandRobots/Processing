float cx, cy;
float sx, sy;
float radius;
int steps = 45;
ArrayList<Line> lines = new ArrayList<Line>();


void setup() {
  size(800,800);
  cx = width / 2;
  cy = height / 2;
  radius = width / 16;
  float r  = radius / 2;//random(radius / 2);
  float a = 0 ;//random(0);
  
  sx = cx + r * cos(a);
  sy = cy + r * sin(a);
  noLoop();
}


void draw() {
  background(0);
  stroke(255);
  
  float ai = TWO_PI / float(steps);
  PVector start = new PVector(sx, sy);
  PVector cntr = new PVector(cx, cy);
  for (float a = 0; a < TWO_PI; a += ai) {
     float xx = cos(a);
     float yy = sin(a);
     PVector m = new PVector(xx,yy);
     m.normalize();
     
     
     m.mult(radius);
     m.add(sx, sy);
     lines.add( new Line(sx, sy, m.x, m.y));
    
    
    
    
  }
  noFill();
  ellipse(cx, cy, radius*2, radius*2);
  for (Line line : lines) {
    line.draw();
  }
  
  
}
