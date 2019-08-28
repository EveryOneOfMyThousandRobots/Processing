static final String NORTH = "north";
static final String EAST = "east";
static final String SOUTH = "south";
static final String WEST = "west";


class Tile {

  HashMap<String, Edge> edges = new HashMap<String, Edge>();
  HashMap<String, Tile> neighbours = new HashMap<String, Tile>();
  int x, y;

  PVector TL, TR, BL, BR;
  boolean fixed = false;
  Tile(int x, int y, boolean fixed) {
    this.x = x;
    this.y = y;
    this.fixed = fixed;

    resetEdges();

    TL = new PVector(x * TILE_SIZE, y * TILE_SIZE);
    TR = new PVector(TL.x + TILE_SIZE, TL.y);
    BL = new PVector(TL.x, TL.y + TILE_SIZE);
    BR = new PVector(BL.x + TILE_SIZE, BL.y);
    neighbours.put(NORTH, null);
    neighbours.put(EAST, null);
    neighbours.put(SOUTH, null);
    neighbours.put(WEST, null);
  }

  void resetEdges() {
    edges.put(NORTH, null);
    edges.put(EAST, null);
    edges.put(SOUTH, null);
    edges.put(WEST, null);
  }

  void setNeighbours() {

    neighbours.put(NORTH, getTileAt(x, y-1));
    neighbours.put(EAST, getTileAt(x+1, y));
    neighbours.put(SOUTH, getTileAt(x, y+1));
    neighbours.put(WEST, getTileAt(x-1, y));
  }

  void draw() {
    //stroke(255);
    //fill(0);
    //rect(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
  }
}
