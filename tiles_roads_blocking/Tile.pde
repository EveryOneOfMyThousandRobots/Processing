int ID = 0;

class Tile {
  final int id;
  {
    ID += 1;
    id = ID;
  }
  final int x, y;
  TILE_TYPE type;
  boolean selected = false;
  Tile(int x, int y, TILE_TYPE type) {
    this.x = x;
    this.y = y;
    this.type = type;
  }

  void draw() {
    if (selected) {
      stroke(255);
    } else {
      stroke(128);
    }
    switch (type) {
    case EMPTY:
      fill(51);
      break;
    case GRASS:
      fill(20, 128, 20);
      break;
    case ROAD:
      fill(100);
      break;
    }
    rect(x * TS, y * TS, TS-1, TS-1);
  }
  
  @Override 
  boolean equals(Object o) {
    if (o instanceof Tile) {
      return ((Tile)o).id == id;
    } else {
      return false;
    }
  }
}
