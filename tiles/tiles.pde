int TILE_SIZE = 25;
int TILES_ACROSS, TILES_DOWN;
Tile[][] tiles;

class Tile {
  PVector pos;
  float angle;
  float rate;

  Tile(float x, float y) {
    pos = new PVector(x, y);
    angle = noise(x * 0.01, y * 0.01) - 0.5;
    rate = radians(noise(x * 0.01, y * 0.01));
  }

  void draw() {
    noStroke();
    fill(map(sin(angle), -1, 1, 0, 255));
    rect(pos.x, pos.y, TILE_SIZE, TILE_SIZE);
  }


  void update() {
    angle += rate;
  }
}
void setup () {
  size(500, 500);
  background(0);
  TILES_ACROSS = width / TILE_SIZE;
  TILES_DOWN = height / TILE_SIZE;
  tiles = new Tile[TILES_ACROSS][TILES_DOWN];


  for (int x = 0; x < TILES_ACROSS; x += 1) {
    for (int y = 0; y < TILES_DOWN; y += 1) {
      Tile t = new Tile(x * TILE_SIZE, y * TILE_SIZE);
      tiles[x][y] = t;
    }
  }
}

void draw() {
  background(0);
  for (int x = 0; x < TILES_ACROSS; x += 1) {
    for (int y = 0; y < TILES_DOWN; y += 1) {
      //Tile t = new Tile(x * TILE_SIZE, y * TILE_SIZE);
      Tile t = tiles[x][y];
      t.update();
      t.draw();
    }
  }
}