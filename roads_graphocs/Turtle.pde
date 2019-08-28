ArrayList<Tile> path = new ArrayList<Tile>();
HashMap<Tile, Tile> cameFrom = new HashMap<Tile, Tile>();
Tile getTile(int x, int y) {
  if (!OOB(x, y)) {
    return tiles[x][y];
  } else {
    return null;
  }
}
class Turtle {
  int changeCounter = 4;
  int x, y;
  int facing;
  ArrayList<Integer> directions = new ArrayList<Integer>();
  boolean alive = true;
  Tile prev;
  Tile current;
  Turtle(int x, int y, int facing) {
    this.x = x;
    this.y = y;
    this.facing = facing;
    prev = getTile(x, y);
    if (!path.contains(prev)) {
      path.add(prev);
    }
  }

  void addTile(int x, int y) {
    current = getTile(x, y);
    cameFrom.put(prev, current);
    if (!path.contains(current)) {
      path.add(current);
    }
    prev = current;
  }
  void update() {
    if (!alive) return;
    int nx = x;
    int ny = y;
    if (changeCounter <= 0) {
      directions.clear(); 
      for (int i = 0; i < 4; i += 1) {
        directions.add(facing);
      }
      switch(facing) {
      case NORTH:
      case SOUTH:
        directions.add(EAST);
        directions.add(WEST);
        break;
      case WEST:
      case EAST:
        directions.add(NORTH);
        directions.add(SOUTH);
        break;
      }

      facing = directions.get(floor(random(directions.size())));
      changeCounter = 4;
    } else {
      changeCounter -= 1;
    }
    switch (facing) {
    case NORTH:
      ny -= 1;

      break;
    case SOUTH:
      ny += 1;
      break;
    case WEST:
      nx -= 1;
      break;
    case EAST:
      nx += 1;
      break;
    }

    if (!OOB(nx, ny)) {
      x = nx;
      y = ny;
      addTile(x, y);
    } else {
      alive = false;
    }
  }

  void draw() {
    stroke(255);
    fill(255, 0, 0);
    ellipse(MXY(x), MXY(y), 5, 5);
  }
}
