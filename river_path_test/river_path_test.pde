ArrayList<ArrayList<PVector>> pointLists = new ArrayList<ArrayList<PVector>>();

ArrayList<PVector> pointsA = new ArrayList<PVector>();
ArrayList<PVector> pointsB = new ArrayList<PVector>();
ArrayList<PVector> pointsC= new ArrayList<PVector>();



void setup() {
  size(400, 400);
  pointLists.add(pointsA);
  pointLists.add(pointsB);
  pointLists.add(pointsC);
  float a1 = random(TWO_PI);
  float a1i = random(1,10);
  float r1 = 30;
  float a2 = random(TWO_PI);
  float a2i = random(1,10);
  float r2 = 30;
  
  for (int x = 0; x < width; x += width/16) {
    a1 += radians(a1i);
    a2 += radians(a2i);
    float x2 = (float(x)/width)*TWO_PI;

    float r = 4;

    float ax = float(x) + random(-10, 10);
    float ay = map(sin(x2), -1, 1, height-30, 30) + random(-r, r);
    
    pointsA.add( new PVector(ax,ay));
    if (pointsA.size() == 1) {
      pointsB.add(new PVector(ax, ay));
      pointsC.add(new PVector(ax, ay));
    } else {
      PVector pa1 = pointsA.get(pointsA.size()-2);
      PVector pa2 = pointsA.get(pointsA.size()-1);
      
      PVector v = PVector.sub(pa2,pa1).normalize();
      PVector v1 = new PVector(-v.y, v.x);
      PVector v2 = v1.copy();
      v2.mult(-1);
      v1.mult(sin(a1)*r1);
      v2.mult(cos(a2)*r2);
      v1.add(pa2);
      v2.add(pa2);
      pointsB.add(v1);
      pointsC.add(v2);
      
    }
  }
}


void draw() {
  background(0);
  stroke(255);
  noFill();
  //for (ArrayList<PVector> list : pointLists) {
  //  for (PVector p : list) {
  //    ellipse(p.x, p.y, 4, 4);
  //  }
  //}


  for (float t =0; t  < float(pointsA.size()-3); t += 0.005f) {
    PVector pa = splinePoint(t, pointsA);
    PVector pb = splinePoint(t, pointsB);
    PVector pc = splinePoint(t, pointsC);

    line(pa.x, pa.y, pb.x, pb.y);
    line(pb.x, pb.y, pc.x, pc.y);
  }
}
PVector splinePoint(float t, ArrayList<PVector> points) {

  PVector p = new PVector(0, 0);
  int p0, p1, p2, p3;

  p1 = (int)t + 1;
  p2 = p1 + 1;
  p3 = p2 + 1;
  p0 = p1 - 1;
  t = t - (int)t;

  float tt = t * t;
  float ttt = tt * t;

  float q1 = -ttt + 2*tt - t;
  float q2 = 3*ttt - 5 *tt + 2;
  float q3 = -3*ttt + 4*tt + t;
  float q4 = ttt - tt;

  float tx = 0.5 * (points.get(p0).x * q1 + points.get(p1).x * q2 + points.get(p2).x * q3 + points.get(p3).x * q4);
  float ty = 0.5 * (points.get(p0).y * q1 + points.get(p1).y * q2 + points.get(p2).y * q3 + points.get(p3).y * q4);
  p.set(tx, ty);

  return p;
}
