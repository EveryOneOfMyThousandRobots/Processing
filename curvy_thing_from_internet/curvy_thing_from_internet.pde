Double r = 0.3d;



ArrayList<Double> points = new ArrayList<Double>();
void setup() {
  size(600, 600);
  points.add(0.5d);
}


void draw() {
  background(0);
  if (points.size() < 1000) {
    double xn = points.get(points.size()-1);
    double xn1 = r * xn * (1 - xn);

    points.add(xn1);
    //println(xn + " " + xn1);
  }

  double maxY = getMaxY();

  stroke(255);
  noFill();
  beginShape();
  for (int i = 0; i < points.size(); i += 1) {
    double p = points.get(i);
    float xx = map(i, 0, points.size(), 0, width);
    float yy = map((float)p, 0, (float)maxY, height/2, 0);
    vertex(xx, yy);
  }
  endShape();
}


double getMaxY() {
  double y = 0;
  for (double p : points) {
    if (p > y) {
      y = p;
    }
  }

  return y;
}
