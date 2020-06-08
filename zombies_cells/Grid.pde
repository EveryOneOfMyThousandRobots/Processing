class Grid {
  final int CELLS_ACROSS;
  final int CELLS_DOWN;
  final float CELL_WIDTH, CELL_HEIGHT;
  Cell[][] cells;
  float[][] scent;
  float[][] scentNext;



  Grid(int a, int d) {
    CELLS_ACROSS = a;
    CELLS_DOWN   = d;
    CELL_WIDTH = width / (float)a;
    CELL_HEIGHT= height / (float)d;

    cells = new Cell[CELLS_ACROSS][CELLS_DOWN];
    scent = new float[CELLS_ACROSS][CELLS_DOWN];
    //scentNext = new float[CELLS_ACROSS][CELLS_DOWN];

    for (int x = 0; x < CELLS_ACROSS; x += 1) {
      for (int y = 0; y < CELLS_DOWN; y += 1) {
        CELL_TYPE type = CELL_TYPE.EMPTY;
        if (x == 0 || y == 0 || x == CELLS_ACROSS-1 || y == CELLS_DOWN -1) {
          type = CELL_TYPE.WALL;
        }
        cells[x][y] = new Cell(this, x, y, type);
      }
    }
  }

  void scentStep() {
    scentNext = new float[CELLS_ACROSS][CELLS_DOWN];

    for (int x = 0; x < CELLS_ACROSS; x += 1) {
      for (int y = 0; y < CELLS_DOWN; y += 1) {
        Cell cell = cells[x][y];

        if (cell.type == CELL_TYPE.WALL) {
          continue;
        } else {
          float count = 0;
          for (int xx = -1; xx < 2; xx += 1) {
            for (int yy = -1; yy < 2; yy += 1) {
              if (xx == 0 && yy == 0) continue;
              int ix = x + xx;
              int iy = y + yy;
              if (!OOB(ix, iy)) {
                Cell nc = cells[ix][iy];
                if (nc.type != CELL_TYPE.WALL) {
                  scentNext[ix][iy] += scent
                  count += 1;
                }
              }
            }
          }
          if (count > 0) {
            scentNext[x][y] = scent[x][y] - (scent[x][y] / count);
            scentNext[x][y] = constrain(scentNext[x][y], 0.0, 100.0);
          }
        }
      }
    }

    scent = scentNext;
  }

  void draw() {
    for (int x = 0; x < CELLS_ACROSS; x += 1) {
      for (int y = 0; y < CELLS_DOWN; y += 1) {
        cells[x][y].draw();
      }
    }
  }

  boolean OOB(int x, int y) {
    return (x < 0 || x > CELLS_ACROSS-1 || y < 0 || y > CELLS_DOWN-1);
  }

  void setScentAtScreenPos(float x, float y) {
    Cell cell = getCellAtScreenPos(x, y);

    if (cell != null) {
      scent[cell.x][cell.y] = 100;
      println("(" + cell.x + ","  +cell.y + ") = 100");
    } else {
      println("no cell at (" + x + "," + y + ")");
    }
  }

  Cell getCellAt(int x, int y) {
    if (!OOB(x, y)) {
      return cells[x][y];
    } else {
      return null;
    }
  }

  Cell getCellAtScreenPos(float x, float y) {
    int xx = (int)(x / (float)CELL_WIDTH);
    int yy = (int)(y / (float)CELL_HEIGHT);
    return getCellAt(xx, yy);
  }
}
