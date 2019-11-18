class Shape {
  PVector pos;
  float radius;
  Shape(float x, float y) {
    pos = new PVector(x, y);
  }
  ArrayList<PVector> points = new ArrayList<PVector>();

  void addPoint(float x, float y) {
    points.add(new PVector(x, y));
  }

  ArrayList<PVector>  copyPoints() {
    ArrayList<PVector> copyPnts = new ArrayList<PVector>();
    
    
    for (PVector p : points) {
      copyPnts.add(p.copy());
    }


    return copyPnts;
  }

  void makeSquare(float s) {

    float s2 = s/2;
    radius = s2;
    points.clear();
    addPoint(0, -s2);
    addPoint(s2, 0);
    addPoint(0, s2);
    addPoint(-s2, 0);
  }


  boolean pointIsInBounds(float x, float y) {
    float dist = dist(x, y, pos.x, pos.y);
    //println(dist +" " + radius);
    return (dist < radius);
  }

  void update() {
  }

  void addAngle(float a) {

    for (int i = 0; i < points.size(); i += 1) {
      PVector P = points.get(i);

      //float xl = P.x - pos.x;
      //float yl = P.y - pos.y;
      float xx = P.x;
      float yy = P.y;
      P.x = xx * cos(a) - yy * sin(a);
      P.y = xx * sin(a) + yy * cos(a);
      //P.x += pos.x;
      //P.y += pos.y;
    }
  }

  ArrayList<PVector> getNorm() {
    ArrayList<PVector> normals = new ArrayList<PVector>();

    for (int i = 0; i < points.size(); i += 1) {

      int j = (i + 1) % points.size();

      PVector A = points.get(i);
      PVector B = points.get(j);

      PVector N = PVector.sub(B, A);
      N.set(-N.y, N.x);
      normals.add(N);
    }


    return normals;
  }



  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(shapeColor);
    noFill();
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}
