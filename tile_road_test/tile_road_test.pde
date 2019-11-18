final int TILE_SIZE = 10;
final int W = 800;
final int H = 800;
final int TA = W / TILE_SIZE;
final int TD = H / TILE_SIZE;

Path path;

Tile[][] tiles;
void settings() {
  size(W, H);
}
int roadWidth = 2;
int blockWidth = 15;

int buildingSize = 3;
int buildingSizeMax = 7;
void setObstacles() {
  for (int x = 0; x < TA; x += blockWidth) {
    boolean goY = true;

    float c = 1 - (float(TA - x) / float(TA));
    for (int y = 0; y < TD; y += 1) {

      if (y % blockWidth == 1) {
        if (random(1)  < 0.3) {

          goY = random(1) < 0.6;
        }
      }

      if (goY) {

        Tile t = getTile(x, y);
        if (random(1) < c) {
          t.type= TILE_TYPE.ROAD;
        }
        t.markAs = TILE_TYPE.ROAD;
        t = getTile(x+1, y);
        if (t != null) {
          t.markAs = TILE_TYPE.ROAD;
          if (random(1) < c) {
            t.type= TILE_TYPE.ROAD;
          }
        }
      }
    }
  }

  for (int y = 0; y < TD; y += blockWidth) {
    boolean goX = true;
    for (int x = 0; x < TA; x += 1) {
      float c1 = 1 - (float(TA - x) / float(TA));
      if (x % blockWidth == 1) {
        if (random(1)  < 0.3) {
          float c = 1.0 - (float(TA - x) / float(TA));
          goX = random(1) < c;
        }
      }
      if (goX) {


        Tile t = getTile(x, y);
        t.markAs = TILE_TYPE.ROAD;
        if (random(1) < c1) {
          t.type= TILE_TYPE.ROAD;
        }
        t = getTile(x, y+1);
        if (t != null) {
          t.markAs = TILE_TYPE.ROAD;
          if (random(1) < c1) {
            t.type= TILE_TYPE.ROAD;
          }
        }
      }
    }
  }

  for (int y = 2; y < TD; y += blockWidth) {
    SearchForBuildings(y, 1);
    SearchForBuildings(y+(blockWidth-3), -1);
  }

  for (int x = 2; x < TA; x += blockWidth) {
    SearchForBuildingsX(x, 1);
    SearchForBuildingsX(x+(blockWidth-3), -1);
  }
}

Tile getRandomTile() {
  int x = floor(random(TA));
  int y = floor(random(TD));




  return getTile(x, y);
}

Tile tStart, tEnd;

void init() {
  tiles = new Tile[TA][TD];

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      tiles[x][y] = new Tile(x, y);
    }
  }

  setObstacles();


  while (tStart == null) {
    tStart = getRandomTile();
    if (tStart.type == TILE_TYPE.BUILDING) {
      tStart = null;
    }
  }
  tEnd = null;
  while (tEnd == null) {

    tEnd = getRandomTile();
    if (tEnd == tStart || tEnd.type == TILE_TYPE.BUILDING) {
      tEnd = null;
    }
  }



  path = new Path(tStart, tEnd);
  path.findPath();
}
void setup() {
  init();
}

void draw() {
  background(0);
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      Tile t = tiles[x][y];
      t.draw();
    }
  }

  //for (Tile n : path.path) {
  //  stroke(255, 0, 255);
  //  noFill();
  //  rect(n.wx, n.wy, TILE_SIZE, TILE_SIZE);
  //}
}

void mouseClicked() {
  init();
}
