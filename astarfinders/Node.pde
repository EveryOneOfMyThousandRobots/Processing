class Node {
  float f = 0;
  float g = 0;
  float h = 0;
  float x, y;
  int ix, iy;
  int id;// = getNextId("NODE");
  int rows, cols;
  PVector pos;
  Node previous;
  boolean wall = false;
  float cost = 0;
  ArrayList<Node> neighbours = new ArrayList<Node>();
  Cell cell;
  DIR direction;

  int hashCode() {
    return id * 17;
  }

  void clear() {
    f = g = h = cost = 0;
    previous = null;
    if (!cell.fastLane) {
      cost = 1;
    }
    if (cell.occupied) {
      this.cost = 100;
    }
  }

  String toString() {
    return id + " (" + ix + "," + iy + ") " + pos;
  }

  CellType type;

  Node(Cell cell) {
    this.x = cell.pos.x + (res/2);
    this.y = cell.pos.y + (res/2);
    pos = new PVector(this.x, this.y);
    this.type = cell.type;
    this.ix = cell.ix;
    this.iy = cell.iy;
    this.id = cell.id;
    if (cell.type == CellType.WALL) {
      wall = true;
    }
    this.direction = cell.direction;
    this.cell = cell;
    if (cell.occupied) {
      this.cost = 100;
    }
    clear();
  }

  boolean equals(Cell o) {
    if (id == o.id) return true;
    return false;
  }
  
  Node findOpenNeighbour() {
    for (Node n : neighbours) {
      Cell c = n.cell;
      if (!n.wall && !c.occupied) {
        return n;
      }
    }
    return null;
  }

  void addNeighbour(int x, int y, Node[][] nodes) {
    x = ix + x;
    y = iy + y;
    if (x >= 0 && x < grid.cols && y >= 0 && y < grid.rows) {
      neighbours.add(nodes[x][y]);
    }
  }

  void findNeighbours(Node[][] nodes) {
    neighbours.clear();

    if (direction == DIR.NONE || direction == DIR.NORTH || direction == DIR.WEST) {
      addNeighbour(-1, -1, nodes);
    }
    if (direction == DIR.NONE || direction == DIR.NORTH || direction == DIR.WEST || direction == DIR.EAST) {
      addNeighbour(0, -1, nodes);
    }
    if (direction == DIR.NONE || direction == DIR.NORTH || direction == DIR.EAST) {
      addNeighbour(1, -1, nodes);
    }
    if (direction == DIR.NONE || direction == DIR.NORTH || direction == DIR.WEST || direction == DIR.SOUTH) {
      addNeighbour(-1, 0, nodes);
    }
    if (direction == DIR.NONE || direction == DIR.NORTH || direction == DIR.EAST || direction == DIR.SOUTH) {
      addNeighbour(1, 0, nodes);
    }
    if (direction == DIR.NONE || direction == DIR.WEST || direction == DIR.SOUTH) {
      addNeighbour(-1, 1, nodes);
    }
    if (direction == DIR.NONE || direction == DIR.WEST || direction == DIR.EAST || direction == DIR.SOUTH) {
      addNeighbour(0, 1, nodes);
    }

    if (direction == DIR.NONE || direction == DIR.EAST || direction == DIR.SOUTH) {

      addNeighbour(1, 1, nodes);
    }
    //if (ix < grid.cols - 1) {
    //  neighbours.add(nodes[ix + 1][iy]);
    //  if (iy > 0) {
    //    neighbours.add(nodes[ix+1][iy-1]);
    //  }
    //  if (iy < grid.rows -1) {
    //    neighbours.add(nodes[ix+1][iy+1]);
    //  }
    //}

    //if (iy < grid.rows - 1) {
    //  neighbours.add(nodes[ix][iy+1]);
    //}

    //if (ix > 0) {
    //  neighbours.add(nodes[ix-1][iy]);
    //  if (iy > 0) {
    //    neighbours.add(nodes[ix-1][iy-1]);
    //  }
    //  if (iy < grid.rows - 1) {
    //    neighbours.add(nodes[ix-1][iy+1]);
    //  }
    //}

    //if (iy > 0) {
    //  neighbours.add(nodes[ix][iy-1]);
    //}
  }
}