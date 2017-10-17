float heuristic(Node a, Node b) {
  //return abs(a.x - b.x) + abs(a.y - b.y) + pow(1 + a.cost, 5);
  //crow
  return PVector.dist(a.pos, b.pos) + pow(1 + a.cost, 2);
}

class Node {
  float f = 0;
  float g = 0;
  float h = 0;
  int x, y;
  int nodeId = 0;
  PVector pos;
  Node previous = null;
  boolean wall = false;
  float cost;

  ArrayList<Node> neighbours;
  {
    NODE_ID += 1;
    nodeId = NODE_ID;
    neighbours = new ArrayList<Node>();
    if (random(1) < WALL_CHANCE && CREATE_WALLS) {
      wall = true;
    }
  }

  int hashCode() {
    return nodeId * 17;
  }

  boolean equals(Node o) {
    if (this.hashCode() == o.hashCode()) {
      return true;
    } else {
      return false;
    }
  }

  Node(int x, int y, float f, float g, float h) {
    this(x, y);
    this.f = f;
    this.g = g;
    this.h = h;
  }

  Node (int x, int y) {
    this.x = x;
    this.y = y;
    pos = new PVector(x, y);
  }

  void addNeighbours(Node[][] grid) {
    neighbours.clear();
    //int x1 = x+1;
    //int y1 = y+1;
    // |- -|0 -|+ -|
    // |- 0| 0 |+ 0|
    // |- +|0 +|+ +|
    //


    if (x < COLS-1) {
      neighbours.add(grid[x+1][y]);
      if (y > 0) {
        neighbours.add(grid[x+1][y-1]);
      }
      if (y < ROWS - 1) {
        neighbours.add(grid[x+1][y+1]);
      }
    }
    if (y < ROWS-1) {
      neighbours.add(grid[x][y+1]);
    }



    if (x > 0 ) {
      neighbours.add(grid[x-1][y]);
      if (y > 0) {
        neighbours.add(grid[x-1][y-1]);
      }
      if (y < ROWS - 1) {
        neighbours.add(grid[x-1][y+1]);
      }
    }
    if (y > 0 ) {
      neighbours.add(grid[x][y-1]);
    }
  }

  void draw(color c) {

    stroke(0);
    fill(c);
    if (wall) {
      fill(0);
    }
    rect(this.x * CELL_WIDTH, this.y * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
  }

  void draw() {
    stroke(0);
    fill(map(cost,0,1,255,0));
    if (wall) {
      fill(0);
    }
    rect(this.x * CELL_WIDTH, this.y * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
  }

  String toString(boolean noNeighbours) {
    return"[" + nodeId + " (" + x +"," + y + ")]";
  }
  String toString() {
    String output = "";
    output = toString(false);
    output += " neighbours: ";
    for (Node n : neighbours) {
      output += n.toString(false);
    }
    return output;
  }
}