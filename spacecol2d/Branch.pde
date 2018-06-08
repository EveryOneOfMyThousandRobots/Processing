class Branch {
  PVector pos, dir;
  int count = 0;
  
  Branch parent;// = null;
  
  
  Branch(Branch parent, PVector direction, float x, float y) {
    pos = new PVector(x,y);
    this.parent = parent;
    this.dir = direction;
  }
  
  void draw() {
    stroke(255);
    if (parent != null) {
      line(pos.x, pos.y, parent.pos.x, parent.pos.y);
    }
  }
  
  
  Branch next() {
    Branch b = new Branch(this, dir.copy(), pos.x + dir.x, pos.y + dir.y);
    return b;
  }
}
