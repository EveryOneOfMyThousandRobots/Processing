final int COLS = 100;
final int ROWS = 100;
final int WINDOW_WIDTH = 400;
final int WINDOW_HEIGHT = 400;
final float CELL_WIDTH = WINDOW_WIDTH / COLS;
final float CELL_HEIGHT = WINDOW_HEIGHT / ROWS;
int NODE_ID = 0;
final boolean CREATE_WALLS = true;
final float WALL_CHANCE = 0.1;
Node[][] grid;// = new float[COLS][ROWS];
ArrayList<Node> closedSet;
ArrayList<Node> openSet;
ArrayList<Node> path;
float totalCost = 0;
Node start, end;


void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT, P2D);
}


void setup() {
  //scale(4);
  //size(400, 400, P2D);
  grid = new Node[COLS][ROWS];
  openSet = new ArrayList<Node>();
  closedSet = new ArrayList<Node>();
  path = new ArrayList<Node>();
  for (int x = 0; x < grid.length; x += 1) {
    float xx = x * 0.1;
    for (int y = 0; y < grid[x].length; y += 1) {
      float yy = y * 0.1;
      grid[x][y] = new Node(x, y);
      grid[x][y].cost = noise(xx, yy);
    }
  }

  for (int x = 0; x < grid.length; x += 1) {

    for (int y = 0; y < grid[x].length; y += 1) {

      grid[x][y].addNeighbours(grid);
      println(grid[x][y]);
    }
  }




  start = grid[0][0];
  start.wall = false;
  end = grid[COLS-1][ROWS-1];
  end.wall = false;
  openSet.add(start);
}

void draw() {
  background(30);
  if (!openSet.isEmpty()) {

    int winner = 0;
    for (int i = 0; i < openSet.size(); i += 1) {
      if (openSet.get(i).f < openSet.get(winner).f) {
        winner = i;
      }
    }


    Node current = openSet.get(winner);
    path.clear();
    totalCost = 0;
    Node temp = current;
    path.add(temp);
    totalCost += temp.f;
    while (temp.previous != null) {
      path.add(temp.previous);
      totalCost += temp.previous.f;
      temp = temp.previous;
    }


    if (current.nodeId == end.nodeId) {

      println("DONE");
      stop();
    }

    openSet.remove(current);
    closedSet.add(current);

    ArrayList<Node> neighbours = current.neighbours;
    for (Node n : neighbours) {
      if (!closedSet.contains(n) && !n.wall) {
        float tempG = current.g + PVector.dist(current.pos, n.pos);
        boolean newPath = false;
        if (openSet.contains(n)) {
          if (tempG < n.g) {
            n.g = tempG;
            newPath = true;
          }
        } else {
          n.g = tempG;
          openSet.add(n);
          newPath = true;
        }
        if (newPath) {
          n.h = heuristic(n, end);
          n.f = n.g + n.h ;

          n.previous = current;
        }
      }
    }
  } else {
    println("no solution");
    stop();
  }

  for (int x = 0; x < grid.length; x += 1) {

    for (int y = 0; y < grid[x].length; y += 1) {

      grid[x][y].draw();
    }
  }

  for (Node open : openSet) {
    open.draw(color(0, 255, 0));
  }

  for (Node closed : closedSet) {
    closed.draw(color(255, 0, 0));
  }

  for (Node n : path) {
    n.draw(color(0, 0, 255));
  }
  
  fill(255);
  text(totalCost, 10, 10);
}