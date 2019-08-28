class Tri {
  PVector[] points;
  PVector A, B, C;
  PVector circumcenter;
  float circumRadius;
  float area = 0;
  Tri(PVector A, PVector B, PVector C) {
    this.A = A;
    this.B = B;
    this.C = C;
    circumcenter = GetCircumcenter(A, B, C);

    area = abs((A.x * (B.y - C.y) + B.x * (C.y - A.y) + C.x * (A.y - B.y)) / 2.0);

    circumRadius = PVector.dist(circumcenter, A);
    points = new PVector[3];
    ArrayList<PVector> pa = new ArrayList<PVector>();
    pa.add(A);
    pa.add(B);
    pa.add(C);
    int index = 0;
    for (float a = 0; a < TWO_PI; a += radians(1)) {
      float x = circumcenter.x + circumRadius * cos(a);
      float y = circumcenter.y + circumRadius * sin(a);
      PVector xy = new PVector(x, y);
      if (pa.size() == 0) break;
      PVector found = null;
      for (PVector n : pa) {
        if (PVector.dist(n, xy) < 3) {
          points[index] = n;
          found = n;
          break;
        }
      }
      if (found != null) {
        pa.remove(found);
        index += 1;
      }
    }


    A = points[0]; 
    B = points[1]; 
    C = points[2];
    println("tri\n\t" + A + "\n\t" + B + "\n\t" + C);
  }

  void draw() {
    PVLine(A, B);
    PVLine(B, C);
    PVLine(C, A);
    //circ(circumcenter, 6, RED);
    //drawCircumcircle();
  }


  boolean lineIntersects(PVector a, PVector b) {

    if (linesIntersect(A, B, a, b) || linesIntersect(A, C, a, b) || linesIntersect(B, C, a, b)) {
      return true;
    } else {
      return false;
    }
  }
  PVector GetCircumcenter(PVector a, PVector b, PVector c) {
    PVector midAB = midPoint(a, b);
    PVector midBC = midPoint(b, c);
    float slopeAB = -1 / slope(a, b);
    float slopeBC = -1 / slope(b, c);

    float bAB = midAB.y - slopeAB * midAB.x;
    float bBC = midBC.y - slopeBC * midBC.x;

    float x = (bAB - bBC) / (slopeBC - slopeAB);
    PVector circumcenter = new PVector(x, (slopeAB * x) + bAB);
    return circumcenter;
  }
  public PVector midPoint(PVector a, PVector b) {
    return new PVector ((a.x + b.x) / 2, (a.y + b.y) / 2);
  }

  public float slope(PVector a, PVector b) {
    return (b.y - a.y) / (b.x - a.x);
  }

  public void drawCircumcircle() {
    // draw circumcircle
    //PVector center = GetCircumcenter(A,B,C);
    float rad = circumcenter.dist(A);
    noFill();
    stroke(192, 192, 192);
    ellipse(circumcenter.x, circumcenter.y, rad * 2, rad * 2);
  }
}
