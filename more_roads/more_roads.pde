Tile[][] tiles;

final int TILE_SIZE = 32;
final int TILE_NUM  = 20;
void settings() {
  size(TILE_NUM*TILE_SIZE, TILE_NUM*TILE_SIZE);

  tiles = new Tile[TILE_NUM][TILE_NUM];
}
void setup() {
  makeTileTypes();
  //frameRate(2);



  for (int xx = 0; xx < TILE_NUM; xx += 1) {
    float fx = xx * TILE_SIZE;
    float fy = (TILE_NUM-1)*TILE_SIZE;
    Tile t = new Tile(xx, 0, fx, 0.0, TILE_TYPE.BUILDING);
    t.cannotChange = true;
    tiles[xx][0] = t;
    t = new Tile(xx, TILE_NUM-1, fx, fy, TILE_TYPE.BUILDING);
    t.cannotChange = true;
    tiles[xx][TILE_NUM-1] = t;
  }

  for (int yy = 0; yy < TILE_NUM; yy += 1) {
    float fx = (TILE_NUM-1) * TILE_SIZE;
    float fy = yy*TILE_SIZE;
    Tile t = new Tile(0, yy, 0, fy, TILE_TYPE.BUILDING);
    t.cannotChange = true;
    tiles[0][yy] = t;
    t = new Tile(TILE_NUM-1, yy, fx, fy, TILE_TYPE.BUILDING);
    t.cannotChange = true;
    tiles[TILE_NUM-1][yy] = t;
  }

  addCorner(1, 1, 3);
  addCorner(1, TILE_NUM-2, 2);
  addCorner(TILE_NUM-2, 1, 0);
  addCorner(TILE_NUM-2, TILE_NUM-2, 1);



  //for (int xx = 1; xx < TILE_NUM-1; xx += 1) {


  //  for (int yy = 1; yy < TILE_NUM-1; yy += 1) {

  //    Tile tt = getTile(xx, yy);
  //    if (tt == null) {
  //      TILE_TYPE t = getRandomTileType();
  //      float x = xx * TILE_SIZE;
  //      float y = yy * TILE_SIZE;
  //      //println(t);
  //      tiles[xx][yy] = new Tile(xx, yy, x, y, t);
  //    }
  //  }
  //}


  setAllNeighbours();
  checkAllNeighbours();
}

void addCorner(int x, int y, int rot) {
  int xpos = x * TILE_SIZE;
  int ypos = y * TILE_SIZE;
  Tile t = new Tile(x, y, xpos, ypos, TILE_TYPE.TURN);
  t.rotation = rot;
  t.cannotChange = true;
  t.setProperties();
  tiles[x][y] = t;
}

void createNeighbours() {
  for (int x = 1; x < tiles.length-1; x += 1) {
    for (int y = 1; y < tiles[x].length; y += 1) {
      Tile t = tiles[x][y];
      if (t != null) {
        t.createNeighbours();
      }
    }
  }
}

void setAllNeighbours() {
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {

      Tile t = tiles[x][y];
      if (t == null) continue;
      t.setNeighbours();
    }
  }
}

void checkAllNeighbours() {
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile t = tiles[x][y];
      if (t != null) {
        t.checkNeighbours();
      }
    }
  }
}




void draw() {
  createNeighbours();

  background(0);
  for (Tile[] ta : tiles) {
    for (Tile t : ta) {
      if (t != null ) {
        t.draw();
      }
    }
  }
  setAllNeighbours();
  checkAllNeighbours();
}
