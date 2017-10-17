ArrayList<Path> paths = new ArrayList<Path>();
class Path {
  PVector start, end;
  PVector AB;
  float r;
  
  Path(float sx, float sy, float ex, float ey, float r) {
    start = new PVector(sx, sy);
    end = new PVector(ex, ey);
    AB = PVector.sub(end, start);
    this.r = r;
    
  }
  
  void draw() {
    stroke(0);
    line(start.x, start.y, end.x, end.y);
    pushMatrix();
    noStroke();
    fill(128, 64);
    translate(start.x, start.y);
    rotate(AB.heading());
    rect(0,-r,AB.mag()*2,r*2);
    popMatrix();
  }
}