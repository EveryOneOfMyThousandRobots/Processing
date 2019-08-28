class Tile {
  int ix, iy;
  PVector pos, dims;
  boolean top, bottom, right, left;
  boolean isWall = false;
  
  Tile(int ix, int iy, float x, float y, boolean isWall) {
    this.isWall = isWall;
    this.ix = ix;
    this.iy = iy;
    pos = new PVector(x,y);
    dims = new PVector(RES,RES);
    
  }
  
  void draw() {
    fill(isWall ? color(0) : color(255));
    noStroke();
    rect(pos.x, pos.y,dims.x, dims.y);
  }
}
