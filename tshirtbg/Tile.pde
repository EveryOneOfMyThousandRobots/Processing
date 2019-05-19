class Tile {
  Area parent;
  PVector pos;
  color c;
  boolean on = true;
  Tile(Area parent, float x, float y, color c) {
    pos = new PVector(x,y);
    this.c = c;
    this.parent = parent;
  }
  
  void draw() {
    noStroke();
    if (on) {
      fill(c);
      
    } else {
      fill(0);
    }
    rect(pos.x + parent.pos.x, pos.y + parent.pos.y, TILE_SIZE, TILE_SIZE);
    
  }
}
