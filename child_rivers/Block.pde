class Block {
  PVector pos;
  PVector dims;
  Block(int x, int y, int w, int h) {
    pos = new PVector(x*BLOCK_SIZE,y*BLOCK_SIZE);
    dims = new PVector(w*BLOCK_SIZE,h*BLOCK_SIZE);
  }
  
  void draw() {
    stroke(0,128);
    fill(255,0,0,128);
    rect(pos.x, pos.y, dims.x, dims.y);
  }
  
  boolean pointInside(float x, float y) {
    return (x >= pos.x && x <= pos.x + dims.x && y >= pos.y && y <= pos.y + dims.y);
    
  }
}
