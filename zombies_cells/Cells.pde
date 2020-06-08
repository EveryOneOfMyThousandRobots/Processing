enum CELL_TYPE {
  EMPTY, WALL;
}
class Cell {
  CELL_TYPE type;
  final int x, y;
  Grid grid;
  float scent = 0;

  Cell(Grid grid, int x, int y, CELL_TYPE type) {
    this.grid = grid;
    this.x = x;
    this.y = y;
    this.type = type;
  }
  
  

  void draw() {
    scent = grid.scent[x][y];
    stroke(127);
    switch (type) {
    case EMPTY:
      
      fill(0,map(scent, 0, 100, 0, 255),0);
      break;
    case WALL:
      fill(51);
      break;
    }
    rect(x * grid.CELL_WIDTH, y * grid.CELL_HEIGHT, grid.CELL_WIDTH, grid.CELL_HEIGHT);
  }
}
