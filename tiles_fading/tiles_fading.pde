float tile_size = 8;
float tiles_across, tiles_down;
float zoff = 0;
float zoff_i = 0.01;
Tile[] tiles;

void setup() {
  size(800, 800);
  colorMode(HSB);
  tiles_across = width / tile_size;
  tiles_down = height / tile_size;

  tiles = new Tile[floor(tiles_across) * floor(tiles_down)];

  for (int x = 0; x < tiles_across; x += 1) {
    float xx = float(x) * 0.08;
    for (int y = 0; y < tiles_down; y += 1) {
      float yy = float(y) * 0.08;
      float ai = noise(xx, yy);
      ai = radians(ai);
      Tile t = new Tile(x * tile_size, y * tile_size);//, noise(xx,yy), ai);
      tiles[x + y * floor(tiles_across)] = t;
    }
  }
}

void draw() {
  background(0);
  noStroke();
  for (int i = 0; i < tiles.length; i += 1) {
    tiles[i].update();
    tiles[i].draw();
  }
  zoff += zoff_i;
}

class Tile {
  PVector pos;
  float a, ai;
  
  float c;

  Tile (float x, float y) {//, float a, float ai) {
    this.pos = new PVector(x, y);
    this.a = 0;
    setAi();
  }
  
  void setAi() {
    this.ai = radians(noise(pos.x * 0.01, zoff, pos.y * 0.01));
  }

  void update() {
    a += ai;
    a = a % TWO_PI;
    c = map(sin(a), -1, 1, 0, 255);
    setAi();
  }

  void draw() {
    fill(c, 128, 255);
    rect(pos.x, pos.y, tile_size, tile_size);
  }
}