final int TILE_SIZE = 10;
Tile[][] tiles;
final int SCREEN_WIDTH = 800;
final int SCREEN_HEIGHT = 800;
final int TILES_ACROSS = SCREEN_WIDTH / TILE_SIZE;
final int TILES_DOWN = SCREEN_HEIGHT / TILE_SIZE;




PImage spriteSheet;

void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}
void setup() {


  tiles = new Tile[TILES_ACROSS][TILES_DOWN];

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile t = new Tile(x, y);
      tiles[x][y] = t;
    }
  }
  
  int x = floor(random(TILES_ACROSS));
  x += x % 2;
  
  turtles.add(new Turtle(x, TILES_DOWN - 1, NORTH));
}

void draw() {
  background(0);
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile t = tiles[x][y];

      t.draw();
    }
  }
  
  for (int i = turtles.size()-1; i >= 0; i -= 1){
    Turtle t = turtles.get(i);
    t.update();
    t.draw();
    if (!t.alive) {
      turtles.remove(i);
    }
  }
  
  if (turtles.size() == 0) {
    int a = floor(random(100));
    int b = floor(random(100));
    int x = -1;
    int y = -1;
    int facing = NORTH;
    if (a % 2 == 0) {
      x = floor(random(TILES_ACROSS));
      x += x % 2;
      y = 0;
      facing = SOUTH;
      if (b % 2 == 0) {
        y = TILES_DOWN - 1;
        facing = NORTH;
      }
    } else {
      y = floor(random(TILES_DOWN));
      y += y % 2;
      x = 0;
      facing = EAST;
      if (b % 2 == 0) {
        x = TILES_ACROSS - 1;
        facing = WEST;
      }
    }
    if (!OOB(x,y)) {
      turtles.add(new Turtle(x,y,facing));
    }
  }
  
  for (Tile t : path) {
    stroke(255);
    fill(255,0,0,128);
    rect(t.world_x, t.world_y, TILE_SIZE, TILE_SIZE);
  }
}


final int NORTH = 0;
final int EAST = 1;
final int SOUTH = 2;
final int WEST = 3;
ArrayList<Turtle> turtles = new ArrayList<Turtle>();



int XY(int x) {
  return TILE_SIZE * x;
}

int MXY(int x) {
  return (TILE_SIZE * x) + (TILE_SIZE / 2);
}


boolean OOB(int x, int y) {
  return (x < 0 || x > TILES_ACROSS-1 || y < 0 || y > TILES_DOWN-1);
}
