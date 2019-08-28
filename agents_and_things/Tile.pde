class Tile {
  final int x, y;
  final float wx, wy;
  final float cx, cy;
  
  Tile(int x, int y){
    this.x = x;
    this.y = y;
    this.wx = x * TS;
    this.wy = y * TS;
    this.cx = wx + (TS/2);
    this.cy = wy + (TS/2);
  }
  
  void draw() {
    stroke(0);
    fill(51);
    rect(wx,wy,TS,TS);
  }
}


Tile getTileFromWorld(float x, float y) {
  int ix = floor(x / (float)TS);
  int iy = floor(y / (float)TS);
  return getTile(ix, iy);
}
Tile getTile(int x, int y) {
  if (OOB(x,y)) {
    return null;
  } else {
    return tiles[x][y];
  }
}

boolean OOB(int x, int y) {
  return (x < 0 || x > TA-1 || y < 0 || y > TD - 1);
}
