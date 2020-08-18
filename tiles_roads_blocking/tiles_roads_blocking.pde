enum TILE_TYPE {
  EMPTY, 
    GRASS, 
    ROAD
}

Node[][] nodes;








final int TS = 100;
final float NODE_DIST = (float) TS / 3.0;
int TA, TD;
int NA, ND;

Tile[][] tiles;
void setup() {
  size(800, 600);
  TA = width / TS;
  TD = height / TS;
  NA = (TA * 3)+1;
  ND = (TD * 3)+1;

  tiles = new Tile[TA][TD];
  nodes = new Node[NA][ND];

  for (int y = 0; y < TD; y += 1) {
    for (int x = 0; x < TA; x += 1) {
      tiles[x][y] = new Tile(x, y, TILE_TYPE.EMPTY);

      for (int ny = 0; ny < 3; ny += 1) {
        for (int nx = 0; nx < 3; nx += 1) {
          int inx = (x * 3) + nx;
          int iny = (y * 3) + ny;          
          nodes[inx][iny] = new Node(inx, iny);
        }
      }
      if (x == TA-1 || y == TD - 1) {
        int inx = (x * 3) + 3;
        int iny = (y * 3) + 3;
        nodes[inx][iny] = new Node(inx, iny);
        println("(" + x + "," + y + ") (" + inx + "," + iny + ")");
      }
    }
  }


}

void mouseReleased() {
  if (mouseButton == LEFT) {
    Tile t = getTileAtMouse();
    if (t != null) {
      t.selected = !t.selected;
    }
  } else if (mouseButton == RIGHT) {
    clearSelected();
  }
}





void draw() {
  background(0);
  for (int y = 0; y < TD; y += 1) {
    for (int x = 0; x < TA; x += 1) {
      Tile t = tiles[x][y];
      t.draw();
    }
  }

  for (int y = 0; y < ND; y += 1) {
    for (int x = 0; x < NA; x += 1) {
      Node n = nodes[x][y];
      if (n == null) {
        println("n is null"); //<>//
      } else {
        n.draw();
      }
    }
  }
}
