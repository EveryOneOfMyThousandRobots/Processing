

void setup() {
  size(600, 600);

  TILES_ACROSS = width / TILE_WIDTH;
  TILES_DOWN = height / TILE_HEIGHT;
  tiles = new Tile[TILES_ACROSS][TILES_DOWN];

  floors.put(FLOOR_TYPE_GRASS, new FloorType(color(20, 255, 30), "Grass"));
  floors.put(FLOOR_TYPE_WATER, new FloorType(color(10, 20, 200), "Water"));
  floors.put(FLOOR_TYPE_ROCK, new FloorType(color(100, 100, 100), "Rock"));
  floors.put(FLOOR_TYPE_MOUNTAIN, new FloorType(color(0, 0, 0), "Mountain"));

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      float xx = x * TILE_WIDTH;
      float yy = y * TILE_HEIGHT;
      Tile t = new Tile(xx, yy, TILE_WIDTH, TILE_HEIGHT);
      tiles[x][y] = t;
    }
  }
  
}



void draw() {
  background(0);
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile t = tiles[x][y];
      t.draw();
    }
  }
}
