class Point {
  PVector p;
  float value;
  Point() {
    p = new PVector(0, 0);
  }
}
class MC {
  float multiplier;
  int numPoints;
  float r;
  ArrayList<Point> points = new ArrayList<Point>();

  MC(float multiplier, int numPoints) {

    this.multiplier = multiplier;
    this.numPoints = numPoints;
    fillPoints();
  }

  void fillPoints() {
    points.clear();
    float ai = TWO_PI / numPoints;
    float cx = width / 2;
    float cy = height / 2;
    r = (width / 2) - 10;
    for (int i = 0; i < numPoints; i++) {
      Point p = new Point();

      p.p.x = cx + r * cos(PI + (ai * i));
      p.p.y = cy + r * sin(PI + (ai * i));
      p.value = i;
      points.add(p);
    }
  }

  color getColour(int c) {
    int cc = c % 10;
   
    float r = 0, g = 0, b = 0;

    switch(cc) {
    case 0:
      r = 128;
      break;
    case 1:
      g = 128;
      break;
    case 2:
      b = 128;
      break;
    case 3:
      r = 255;
      break;
    case 4:
      g = 255;
      break;
    case 5:
      b = 255;
      break;
    case 6:
      r = 128;
      b = 128;
      break;
    case 7:
      g = 128;
      b = 128;
      break;
    case 8:
      r = 255;
      b = 128;
      break;
    case 9:
      g = 255;
      b = 128;
      break;
    default:
      r = 128;
      g = 128;
      break;
    }
   



    return color(r,g,b);
  }

  void draw() {
    //for (Point p : points) {
    //  ellipse(p.p.x, p.p.y, 2, 2);

    //}

    for (float i = 0; i < points.size(); i += 1) {
      float result = (multiplier * i) % points.size();
      Point p1 = points.get((int)i);
      Point p2 = points.get((int)result);
      int r = (int) result;
      stroke(getColour(r));
      line(p1.p.x, p1.p.y, p2.p.x, p2.p.y);
    }
  }
}