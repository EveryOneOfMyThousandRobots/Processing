Tile[][] tiles = new Tile[4][4];
void setup() {
  size(400, 400);
  float len = width / tiles.length;

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      tiles[x][y] = new Tile(x, y, len);
    }
  }

  addNumber();
  addNumber();
}

void draw() {
  background(255);

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile t = tiles[x][y];
      t.draw();
    }
  }
}

void addNumber() {
  while (true) {
    int xx = floor(random(tiles.length));
    int yy = floor(random(tiles[0].length));

    Tile t = tiles[xx][yy];

    if (t.value > 0) {
      continue;
    } else {
      t.value = 2;
      break;
    }
  }
}