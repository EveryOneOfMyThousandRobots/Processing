class Branch {
  PVector pos;
  Branch parent;
  PVector dir;
  PVector origDir;
  int count = 0;
  float len = 5;
  Branch(Branch parent, PVector pos, PVector dir) {
    this.pos = pos.copy();
    this.parent = parent;
    this.dir = dir.copy();
    this.origDir = dir.copy();
  }

  void reset() {
    dir = origDir.copy();
    count = 0;
  }


  Branch(Branch parent, float x, float y, PVector dir) {
    this(parent, new PVector(x, y), dir);
  }

  Branch next() {
    PVector newDir = PVector.mult(this.dir, len);
    PVector newPos = PVector.add(this.pos, newDir);
    return new Branch(this, newPos.copy(), this.dir.copy());
  }

  void draw(float sw) {
    if (parent != null) {
      stroke(255);
      strokeWeight(sw);
      line(pos.x, pos.y, pos.z, parent.pos.x, parent.pos.y, parent.pos.z);
    }
  }
}