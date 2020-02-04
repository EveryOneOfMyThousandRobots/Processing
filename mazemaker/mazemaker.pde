int COLS, ROWS;
int SIZE = 20;
import java.util.Stack;

Stack<Cell> stack = new Stack<Cell>();

Cell[] cells;
Cell current = null;

void setup() {
  size(400, 400, P2D);
  smooth();
  COLS = floor(width / SIZE);
  ROWS = floor(height / SIZE);

  cells = new Cell[COLS * ROWS];

  for (int x = 0; x < COLS; x += 1) {
    for (int y = 0; y < ROWS; y += 1) {
      Cell cell = new Cell(x, y);

      cells[x + y * COLS] = cell;
    }
  }

  current = cells[0];
}

void removeWalls(Cell me, Cell him) {
  int a = me.x - him.x;
  int b = me.y - him.y;

  if (a == 1 ) {
    me.left = false;
    him.right = false;
  } else if (a == -1) {
    me.right = false;
    him.left = false;
  } else if (b == 1) {
    me.top = false;
    him.bottom = false;
  } else {
    me.bottom = false;
    him.top = false;
  }
}

void draw() {
  background(51);
  current.visited = true;


  Cell next = current.checkNeighbours();
  if (next != null) {
    next.visited = true;
    stack.push(current);

    removeWalls(current, next);


    current = next;
  } else {
    if (stack.size() > 0 ) {
      current = stack.pop();
    } else {
      println("stopped");
      stop();
    }
  }


  for (Cell cell : cells) {
    cell.draw();
  }

  noStroke();
  fill(0, 128, 0, 128);
  rect(current.getXPos(), current.getYPos(), SIZE, SIZE);
}

int index(int x, int y) {
  if (x < 0 || y < 0 || x > COLS-1 || y > ROWS -1) {
    return -1;
  }
  return x + y * COLS;
}

class Cell {
  boolean top, bottom, left, right;
  boolean visited = false;
  int x, y;
  ArrayList<Cell> neighbours;
  Cell(int x, int y) {
    this.x = x;
    this.y = y;
    top = bottom = left = right = true;
    neighbours = new ArrayList<Cell>();
  }

  float getXPos() {
    return floor(x * SIZE);
  }
  float getYPos() {
    return floor(y * SIZE);
  }

  Cell checkNeighbours() {
    neighbours.clear();// = new Cell[4];
    Cell nLeft = null;
    Cell nRight = null;
    Cell nUp = null;
    Cell nDown = null;

    if (x > 0 ) {
      nLeft = cells[ index(x-1, y)]; //left
      if (!nLeft.visited) {
        neighbours.add(nLeft);
      }
    }
    if (x < COLS-1) {
      nRight = cells[ index(x+1, y)];//right
      if (!nRight.visited) {
        neighbours.add(nRight);
      }
    }

    if (y > 0 ) {
      nUp = cells[ index(x, y-1)];//up
      if (!nUp.visited) {
        neighbours.add(nUp);
      }
    }
    if (y < ROWS-1) {
      nDown = cells[ index(x, y+1)];//down
      if (!nDown.visited) {
        neighbours.add(nDown);
      }
    }


    Cell returnMe = null;
    if (neighbours.size() > 0 ) {
      int r1 = floor(random(neighbours.size()));
      returnMe = neighbours.get(r1);
    }


    return returnMe;
  }

  void draw() {
    int xx = x * SIZE;
    int yy = y * SIZE;
    stroke(255);
    if (top) {
      line(xx, yy, xx+SIZE, yy);
    }
    if (left) {
      line(xx, yy, xx, yy + SIZE);
    }
    if (right) {
      line(xx + SIZE, yy, xx+SIZE, yy+SIZE);
    }
    if (bottom) {
      line(xx, yy + SIZE, xx + SIZE, yy + SIZE);
    }
    if (visited) {
      noStroke();
      fill(255, 0, 100, 50);
      rect(xx, yy, SIZE, SIZE);
    }
  }
}
