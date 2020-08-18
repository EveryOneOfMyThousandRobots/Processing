enum TYPE {
  EMPTY, WALL;
}

ArrayList<Surface> surfaces = new ArrayList<Surface>();

Tile[][] tiles;
int TA, TD, TS = 20;

void setup() {
  size(400, 400);


  TA = width / TS;
  TD = height / TS;
  tiles = new Tile[TA][TD];

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      TYPE type = TYPE.EMPTY;
      if (x == 0 || y == 0 || x == TA-1 || y == TD -1) {
        type = TYPE.WALL;
      }

      tiles[x][y] = new Tile(x, y, type);
    }
  }
}

PVector mouse = new PVector(0,0);

void draw() {
  mouse.set(mouseX, mouseY);
  background(0);

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      Tile t = tiles[x][y];
      
      t.draw();
    }
  }
  
  for (Surface s : surfaces ) {
    s.draw();
  }
}
