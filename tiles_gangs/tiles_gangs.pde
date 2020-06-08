enum TYPE {
  NONE, 
    WALL, 
    ROAD
}
class Tile {
  final int ix, iy;
  final int w, h;
  TYPE type;
  Tile (int x, int y, TYPE type) {
    this.ix = x;
    this.iy = y;
    w = tileSize;
    h = tileSize;
    this.type = type;
  }

  ArrayList<Tile> neighbours = new ArrayList<Tile>();

  void draw() {
    stroke(0);
    switch (type) {
    case NONE:
      fill(0);

      break;
    case WALL:
      fill(128);
      break;
    case ROAD:
      fill(200);
      break;
    }

    rect(ix * w, iy * h, w, h);
  }
}

int tileSize = 20;
int TA, TD;
Tile[][] tiles;

void setup () {
  size(460, 460);
  TA = width / tileSize;
  TD = height / tileSize;
  tiles = new Tile[TA][TD];
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      TYPE type = TYPE.NONE;
      if (x == 0 || y == 0 || x == TA-1 || y == TD-1) {
        type = TYPE.WALL;
      } else if (x % 4 == 1 || y % 4 == 1) {
        type = TYPE.ROAD;
      }


      tiles[x][y] = new Tile(x, y, type);
    }
  }
}


void draw() {
  background(0);
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      Tile t = tiles[x][y];
      t.draw();
    }
  }
}
