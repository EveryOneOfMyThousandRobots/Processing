class Leaf {
  PVector pos;
  boolean reached = false;
  Leaf() {
    pos = new PVector(random(width), random(height-(height/4)));
  }
}
