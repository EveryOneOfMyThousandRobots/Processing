import java.awt.Polygon;
class Sprite {
  private float x, y, r;
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  Polygon polygon;
  
  Sprite(float x, float y, float r) {
    set(x,y,r);
  }
  
  
  void set(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  
  void addVertex(float x, float y) {
    vertices.add(new PVector(x,y));
  }
  
  void draw() {
    pushMatrix();
    stroke(255);
    noFill();
    translate(x,y);
    rotate(r);
    beginShape();
    for (PVector p : vertices) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  
  
  
}
