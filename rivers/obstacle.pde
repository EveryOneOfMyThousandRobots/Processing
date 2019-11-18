class Block {
  PVector pos, dims;
  
  Block(float x, float y, float w, float h) {
    pos = new PVector(x,y);
    dims = new PVector(w,h);
  }
  
  
  void draw() {
    stroke(255);
    noFill();
    rect(pos.x, pos.y, dims.x, dims.y);
  }
}
