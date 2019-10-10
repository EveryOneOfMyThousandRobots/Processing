class Node {
  PVector pos;
  Node[] neighbours;
}

final String north = "north";
final String east = "east";
final String south = "south";
final String west = "west";


enum TileType {
    S_VERT, 
    S_HORIZ, 
    END_VERT, 
    END_HORIZ, 
    THREE_NORTH, 
    THREE_SOUTH, 
    THREE_EAST, 
    THREE_WEST, 
    CORNER_N_W, 
    CORNER_N_E, 
    CORNER_E_S, 
    CORNER_S_W, 
    FOUR, 
    GRASS
}

final int TILE_SIZE = 50;
final int W_WIDTH = 800;
final int W_HEIGHT = 600;
final int T_ACROSS = W_WIDTH / TILE_SIZE;
final int T_DOWN = W_HEIGHT / TILE_SIZE;
Tile[][] grid;


void settings() {
  size(W_WIDTH, W_HEIGHT);
}

void setup() {
  grid = new Tile[T_ACROSS][T_DOWN];



  for (int x = 0; x < T_ACROSS; x += 1) {
    for (int y = 0; y < T_DOWN; y += 1) {
      grid[x][y] = new Tile(x, y);
    }
  }

  
}




void draw() {
}
