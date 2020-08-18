final int CELL_SIZE = 5;
final int HALF_CELL_SIZE = CELL_SIZE / 2;
final int W_W = 400;
final int W_H = 400;
final int CA = W_W / CELL_SIZE;
final int CD = W_H / CELL_SIZE;
float fz = 0;

boolean OOB(int x, int y) {
  return (x < 0 || x > CA-1 || y < 0 || y > CD -1);
}

Cell[][] cells;


void settings() {
  size(W_W, W_H);
}
void setup() {
  colorMode(HSB);
  cells = new Cell[CA][CD];
  println("CA = " + CA);
  println("CD = " + CD);
  println("CELL_SIZE = " + CELL_SIZE);
  println("HALF_CELL_SIZE = " + HALF_CELL_SIZE);

  //frameRate(5);

  for (int x = 0; x < cells.length; x += 1) {
    for (int y = 0; y < cells[x].length; y += 1) {
      Cell cell = new Cell(x, y, false);
      cells[x][y]= cell;
    }
  }

  for (int x = 0; x < cells.length; x += 1) {
    for (int y = 0; y < cells[x].length; y += 1) {

      cells[x][y].findNeighbours();
    }
  }
}


int global_turn = 0;

int x_index = 0;
int y_index = 0;
void draw() {
  background(0);
  global_turn = (global_turn + 1) % 100;
  fz += 0.1;

  //if (doUpdate) {
  //  Cell c = cells[x_index][y_index];
  //  c.update();

  //  x_index += 1;
  //  if (x_index > CA-1) {
  //    x_index = 0;
  //    y_index += 1;
  //    if (y_index > CD-1) {
  //      y_index = 0;
  //      global_turn += 1;
  //    }
  //  }

  //  //updateCells();
  // // doUpdate = false;
  //}
  updateCells();

  for (int x = 0; x < cells.length; x += 1) {
    for (int y = 0; y < cells[x].length; y += 1) {
      Cell cell = cells[x][y];

      cell.draw();
    }
  }


  fill(255);
  text(global_turn + "\n(" + x_index + "," + y_index + ")", 10, 10);
  //stop();
}

//boolean doUpdate = false;

void mouseReleased() {
  //doUpdate = !doUpdate;
  int xx = (int) ( (float)mouseX / (float)CELL_SIZE);
  int yy = (int) ( (float)mouseY / (float)CELL_SIZE);

  if (!OOB(xx, yy)) {
    Cell cell = cells[xx][yy];
    cell.newPressure += 100;
    cell.newPressure = constrain(cell.newPressure, 0, 100);
    cell.pressure = cell.newPressure;
    cell.turn = -100;
  } else {
    println("clicked out of bounds");
  }
}
