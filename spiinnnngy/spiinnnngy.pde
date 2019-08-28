PVector[] points;
PVector pivot;
PVector prevPivot;
PVector A, B;
float angle = 0, angleInc = radians(1);
void setup() {
  size(300, 300);
  
  points = new PVector[10];
  for (int i = 0; i < points.length; i += 1) {
    points[i] = new PVector(random(width), random(height));
  }

  pivot = points[floor(random(points.length))];
}

boolean onLine(PVector a, PVector b, PVector c) {
  float aa = getArea(a, b, c);
  
  return abs(aa) < 1000;
}

float getArea(PVector a, PVector b, PVector c) {
  return 0.5 * ((a.x * (b.y-c.y))+(b.x * (c.y-a.y))+(c.x * (a.y-b.y)));
}

void draw() {
  background(0);


  if (prevPivot == null) {
    prevPivot = pivot;
  }
  angle += angleInc; 
  A = PVector.fromAngle(angle);
  B = PVector.fromAngle(angle + PI);
  A.mult(width);
  B.mult(width);
  A.add(pivot);
  B.add(pivot);
  line(A.x, A.y, B.x, B.y);



  for (PVector p : points) {
    if (p.equals(pivot)) {
      stroke(0, 60, 200);
      fill(0, 60, 200);
    } else {
      fill(255);
    }
    ellipse(p.x, p.y, 4, 4);
    if (!p.equals(pivot) && !p.equals(prevPivot)) {
      if (onLine(A, B, p)) {
        prevPivot = pivot;
        pivot = p;
      }
    }
  }
}
