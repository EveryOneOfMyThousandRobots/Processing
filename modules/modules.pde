


void setup() {
  size(600, 600, P2D);
  TILES_ACROSS = width / TILE_SIZE;
  TILES_DOWN = (height - (TILE_SIZE*3)) / TILE_SIZE;
  modules = new Module[TILES_ACROSS][TILES_DOWN];
  int x = 0;
  int y = int(TILES_DOWN / 2);
  modules[x][TILES_DOWN / 2] = new Module(x, y, 0, ioRIGHT);
  x = TILES_ACROSS - 1;
  modules[x][TILES_DOWN / 2] = new Module(x, y, ioLEFT, 0);
  for ( x = 0; x < TILES_ACROSS; x += 1) {
    for ( y = 0; y < TILES_DOWN; y += 1) {
      if (modules[x][y] == null) {
      }
    }
  }
}

void draw() {
  background(0);
  stroke(128, 128);
  for (int x = 0; x < width; x += TILE_SIZE) {

    line(x, 0, x, height);
  }



  for (int y = 0; y < height; y += TILE_SIZE) {
    line(0, y, width, y);
  }

  for (int x = 0; x < TILES_ACROSS; x += 1) {
    for (int y = 0; y < TILES_DOWN; y += 1) {
      if (modules[x][y] != null) {
        modules[x][y].draw();
      }
    }
  }
}