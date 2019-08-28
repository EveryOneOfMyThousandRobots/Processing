import java.awt.Polygon;
class Sprite {
  private float x, y, r;
  //ArrayList<PVector> vertices = new ArrayList<PVector>();
  Polygon polygon;
  color col = color(255);
  
  void setColour(color c) {
    col = c;
  }
  
  Sprite(float x, float y, float r) {
    set(x,y,r);
    polygon = new Polygon();
  }
  Rectangle getBounds() {
    Rectangle r = polygon.getBounds();
    r.x += x;
    r.y += y;
    return r;
  }
  
  
  void set(float x, float y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  void add(float x, float y) {
    addVertex(x,y);
  }
  
  void addVertex(float x, float y) {
    //vertices.add(new PVector(x,y));
    polygon.addPoint(int(x), int(y));
  }
  
  void draw() {
    pushMatrix();
    stroke(col);
    noFill();
    translate(x,y);
    rotate(r);
    beginShape();
    for (int i = 0; i < polygon.npoints; i += 1) {
      int x = polygon.xpoints[i];
      int y = polygon.ypoints[i];
      vertex(x,y);
    }
    //for (PVector p : vertices) {
    //  vertex(p.x, p.y);
    //}
    endShape(CLOSE);
    popMatrix();
  }
  
  
  
}
