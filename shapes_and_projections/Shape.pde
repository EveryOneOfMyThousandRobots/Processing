class Plane {
  PVector A, B;
  
  Plane(float x1, float y1, float x2, float y2) {
    A = new PVector(x1,y1);
    B = new PVector(x2,y2);
  }
  
  void draw() {
    stroke(255,0,0);
    line(A.x, A.y, B.x, B.y);
  }
}

class Shape {
  final int numPoints;
  final float size;
  float rotation;
  PVector pos;
  PVector[] points;
  ArrayList<PVector> normals = new ArrayList<PVector>();
  Shape(int numPoints, float x, float y, float size) {
    pos = new PVector(x, y);
    this.numPoints = max(6, numPoints);
    this.size = size;
    points = new PVector[this.numPoints];

    for (int i = 0; i < this.numPoints; i += 1) {
      float a = (TWO_PI / (float)this.numPoints) * (float) i;
      float xx = pos.x + size * cos(a);
      float yy = pos.y + size * sin(a);

      points[i] = new PVector(xx, yy);
    }
  }
  
  void update() {
    normals.clear();
    for (int i = 0; i < numPoints; i += 1) {
      int j = (i + 1) % numPoints;
      
      PVector A = points[i];
      PVector B = points[j];
      PVector P = PVector.sub(B,A);
      P.normalize();
      normals.add(new PVector(P.y, -P.x));
      
    }
  }

  void project() {
    
    float min = PVector.dot(points[0],
    for 
    
    
    //PVector normal = PVector.sub(points[1], points[0]);
    
    //normal.set(normal.y, -normal.x);
    
    //normal.normalize();
    
    //PVector A = normal.copy();
    //A.mult(500);
    //A.add(points[0]);
    //A.add(PVector.sub(points[0],points[1]));
    //PVector B = normal.copy().mult(-1);
    //B.mult(500);
    //B.add(points[0]);
    //B.add(PVector.sub(points[0],points[1]));
    
    ////plane = new Plane(A.x, A.y, B.x, B.y);
    
    
    
    
    
  }

  void draw() {

    stroke(255);
    noFill();

    beginShape();
    for (int i = 0; i < numPoints; i += 1) {
      PVector p = points[i];
      text(i, p.x, p.y);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    
    for (PVector n : normals) {
      line(pos.x + n.x, pos.y + n.y, pos.x +  (n.x*50),pos.y +(n.y*50));
    }
    
    //if (plane != null) {
    //  plane.draw();
    //}
  }
}
