class Tile {
  final int x, y;
  final int wx, wy;
  TILE_TYPE type;
  TILE_TYPE markAs;
  Tile[] neighbours = new Tile[4];
  Tile(int x, int y) {
    this.x = x;
    this.y = y;
    this.wx = x * TILE_SIZE;
    this.wy = y * TILE_SIZE;
    type = TILE_TYPE.GROUND;
    markAs = TILE_TYPE.GROUND;
    
  }

  void setNeighbours() {
    neighbours[0] = getTile(x-1, y);
    neighbours[1] = getTile(x+1, y);
    neighbours[2] = getTile(x, y-1);
    neighbours[3] = getTile(x, y+1);
  }

  void draw() {
    noStroke();
    float c = 1.0 - (float(width - wx) / width);
    switch (type) {
    case ROAD:
      fill(51);
      break;
    case GROUND:
      float r = lerp(0x20,0x90,c);
      fill(r,  0xb0, 0);
      break;
    case BUILDING:
      fill(100);
      break;
    }

    rect(wx, wy, TILE_SIZE, TILE_SIZE);

    noFill();

    switch (markAs) {
    case ROAD:
      //stroke(200, 0, 0);
      //rect(wx, wy, TILE_SIZE, TILE_SIZE);
      break;
    case GROUND:

      break;
    case BUILDING:

      break;
    }
  }
}
Tile getTile(int x, int y) {
  if (!OOB(x, y)) {
    return tiles[x][y];
  } 
  return null;
}

boolean OOB(int x, int y) {
  return (x < 0 || x > TA-1 || y < 0 || y > TD-1);
}



enum TILE_TYPE {
  ROAD, GROUND, BUILDING;
}
