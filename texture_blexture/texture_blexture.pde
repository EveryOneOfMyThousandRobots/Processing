final int TILE_SIZE = 32;
final int W = 512;
final int H = 512;
final int TA = W / TILE_SIZE;
final int TD = H / TILE_SIZE;

final int FADE_SIZE = 4;
final float COLOUR_DRIFT = 5;
void settings() {
  size(W, H);
}



Tile[][] tiles;
void setup() {
  tiles = new Tile[TA][TD];
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      Tile t = new Tile(x, y);
      tiles[x][y] = t;
    }
  }
  proc();
}

Tile getTile(int x, int y) {
  return tiles[x][y];
}

void proc() {


  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      Tile t = getTile(x, y);
      println("me = " + t.x + "," + t.y); 
      PImage n;
      boolean useBase = true;

      if (y > 0) {
        Tile north = getTile(x, y-1);

        n = north.get(0, TILE_SIZE-FADE_SIZE, TILE_SIZE, FADE_SIZE, useBase);    
        t.northCombine(n);
        println("north = " + north.x + "," + north.y);
      }

      if (x > 0) {
        Tile west = getTile(x-1, y);



        n = west.get(TILE_SIZE-FADE_SIZE, 0, FADE_SIZE, TILE_SIZE, useBase);
        println("west = " + west.x + "," + west.y);
        t.westCombine(n);
      }
      useBase = false;
    }
  }
}

void draw() {
  background(0);


  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      Tile t = tiles[x][y];
      t.draw();
      stroke(0);
    }
  }
}
