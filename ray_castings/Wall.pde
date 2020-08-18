int ID = 0;

class Surface {
  final int id;
  {
    ID += 1;
    id = ID;
  }
  float x0, y0, x1, y1;


  Surface(float x0, float y0, float x1, float y1) {
    this.x0 = x0;
    this.y0 = y0;
    this.x1 = x1;
    this.y1 = y1;
    surfaces.add(this);
  }

  void setStart(float x, float y) {
    this.x0 = x;
    this.y0 = y;
  }

  void setEnd(float x, float y) {
    this.x1 = x;
    this.y1 = y;
  }

  void draw() {
    stroke(255, 0, 0, 128);
    fill(255, 0, 0, 128);
    line(x0, y0, x1, y1);

    ellipse(x0, y0, 3, 3);
    ellipse(x1, y1, 3, 3);

    stroke(255, 64);



    PVector ip0 = null;
    float ip0Dist = Float.MAX_VALUE;
    PVector ip1 = null;
    float ip1Dist = Float.MAX_VALUE;

    for (Surface s : surfaces) {
      if (s.id == id) continue;
      if (linesIntersect(mouse.x, mouse.y, x0, y0, s.x0, s.y0, s.x1, s.y1)) {
        PVector p = getIntersectionPoint(mouse.x, mouse.y, x0, y0, s.x0, s.y0, s.x1, s.y1);
        float d = PVector.dist(mouse, p); 
        if (d < ip0Dist) {
          ip0 = p.copy();
          ip0Dist = d;
        }
      }


      if (linesIntersect(mouse.x, mouse.y, x1, y1, s.x0, s.y0, s.x1, s.y1)) {
        PVector p = getIntersectionPoint(mouse.x, mouse.y, x1, y1, s.x0, s.y0, s.x1, s.y1);
        float d = PVector.dist(mouse, p);
        if (d < ip1Dist) {
          ip1 = p.copy();
          ip1Dist = d;
        }
      }
    }
    if (ip0 == null ) {
      ip0 = new PVector(x0,y0);
    }
    
    if (ip1 == null) {
      ip1 = new PVector(x1,y1);
    }
    
    line(mouse.x, mouse.y, ip0.x, ip0.y);
    line(mouse.x, mouse.y, ip1.x, ip1.y);
  }
}
