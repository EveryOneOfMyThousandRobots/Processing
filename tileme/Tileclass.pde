class Tile {
  PVector pos;
  int xi, yi;
  WorkTile work = null;

  Tile(float x, float y, int xi, int yi) {
    pos = new PVector(x, y);
    this.xi = xi;
    this.yi = yi;
  }
  
  void setWorkTile(WorkTile wt) {
    this.work = wt;
  }

  void draw() {
    noStroke();
    fill(51);
    rect(pos.x, pos.y, tileSize, tileSize);
    //fill(255);
    //text(xi + "," + yi, pos.x, pos.y+tileSize);
  }
}