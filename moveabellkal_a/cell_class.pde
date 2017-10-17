class Cells {
  
  ArrayList<Cell> cells = new ArrayList<Cell>();
  int cellSize;
  int cols, rows;
  Cells(int cellSize) {
    cols = width / cellSize;
    rows = height / cellSize;
    this.cellSize = cellSize;
    
    
    for (int x = 0; x < cols; x += 1) {
      for (int y = 0; y < rows; y += 1) {
        cells.add(new Cell(x,y,cellSize));
      }
    }
  }
  
  void draw() {
    stroke(0);
    fill(200,40);
    for (Cell cell : cells) {
      rect(cell.pos_x, cell.pos_y, cell.size, cell.size);
    }
  }
  
  void addFood() {
    Food food = new Food();
    int index = (food.x / cellSize) + (food.
    
  }
}



class Cell {
  int index_x, index_y;
  float pos_x, pos_y;
  int size;
  Cell(int index_x, int index_y, int size) {
    this.index_x = index_x;
    this.index_y = index_y;
    this.size = size;
    pos_x = index_x * size;
    pos_y = index_y * size;
  }
}