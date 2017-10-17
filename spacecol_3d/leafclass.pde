class Leaf {
  boolean reached = false;
  PVector pos;
  Leaf() {
    
    this(random(width), random(height));
  }

  Leaf(float x, float y) {
    this.pos = new PVector(x, y);
  }
  
  Leaf (PVector pos) {
    this.pos = pos.copy();
  }

  void draw() {
    noStroke();
    fill(255, 100);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    ellipse(0,0, 4, 4);
    popMatrix();
  }
}