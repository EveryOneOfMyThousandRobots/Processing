class Grid {
  ArrayList<Cell> cells = new ArrayList<Cell>();
  int rows, cols;

  ArrayList<Pickup> pickups = new ArrayList<Pickup>();
  ArrayList<DropOff> dropoffs = new ArrayList<DropOff>();

  Grid(int cols, int rows) {
    this.rows = rows;
    this.cols = cols;
    level.loadPixels();
    for (int x = 0; x < level.width; x += 1) {
      for (int y = 0; y < level.height; y += 1) {
        int pixel = level.get(x, y) & 0xffffff;
        if (pixel == 0) {
          cells.add(new Cell(x, y, x*res, y*res, res, true));
        } else {
          cells.add(new Cell(x, y, x*res, y*res, res, false));
        }
      }
    }
    
    for (int x = 0; x < cols; x += 1) {
      for (int y = 0; y < rows; y += 1) {
        Cell c = get(x,y);
        if (x < cols - 1) {
          c.neighbours.add(get(x+1,y));
          if (y > 0) {
            c.neighbours.add(get(x+1, y-1));
          }
          if (y < rows-1) {
            c.neighbours.add(get(x+1,y+1));
          }
        }
        if ( y < rows - 1) {
          c.neighbours.add(get(x,y+1));
        }
        
        if (x > 0) {
          c.neighbours.add(get(x-1, y));
          if (y > 0) {
            c.neighbours.add(get(x-1, y-1));
          }
          
          if (y < rows - 1) {
            c.neighbours.add(get(x-1, y+1));
          }
        }
        if (y > 0) {
          c.neighbours.add(get(x,y-1));
        }
      }
    }
    
    for (int i = 0; i < 30; i += 1) {
      addPickup();
      addDropOff();
    }
  }

  Cell getAtPos(float x, float y) {
    int ix = floor(x / res);
    int iy = floor(y / res);

    return get(ix, iy);
  }
  
  Cell getRandomNotWall() {
    Cell cell = null;
    while (cell == null) {
      cell = getRandom();
      if (cell != null) {
        if (cell.wall) {
          cell = null;
        }
      }
    }
    return cell;
  }

  Cell getRandom() {
    int c = floor(random(cols));
    int r = floor(random(rows));
    return get(c, r);
  }

  Cell get(int ix, int iy) {
    if (ix >= 0 && ix < cols && iy >= 0 && iy < rows) {
      return cells.get(ix + iy * cols);
    } else {
      return null;
    }
  }

  void addPickup() {
    boolean found = false;
    int tries = 0;
    while (!found && tries < 100) {
      tries += 1;

      Cell cell = getRandom();
      if (cell != null) {
        if (!cell.wall && cell.pickup == null && cell.dropoff == null) {
          cell.pickup = new Pickup(cell.pos.x, cell.pos.y, color(0, 255, 255));
          pickups.add(cell.pickup);
          found = true;
        }
      }
    }
  }
  void addDropOff() {
    boolean found = false;
    int tries = 0;
    while (!found && tries < 100) {
      tries += 1;

      Cell cell = getRandom();
      if (cell != null) {
        if (!cell.wall && cell.pickup == null && cell.dropoff == null) {
          cell.dropoff = new DropOff(cell.pos.x, cell.pos.y, color(128, 255, 255));
          dropoffs.add(cell.dropoff);
          found = true;
        }
      }
    }
  }

  void draw() {
    for (Cell cell : cells) {
      cell.draw();
    }
  }
}
int CELL_ID = 0;
class Cell {
  int id;
  {
    CELL_ID += 1;
    id = CELL_ID;
  }
  int ix, iy;
  float size;
  PVector pos, cpos;
  Pickup pickup = null;
  DropOff dropoff = null;
  Cell previous = null;
  float cost=0;

  boolean wall = false;
  float f = 0, g = 0, h = 0;
  ArrayList<Cell> neighbours = new ArrayList<Cell>();

  Cell(int ix, int iy, float x, float y, float size, boolean wall) {
    this.ix = ix;
    this.iy = iy;
    pos = new PVector(x, y);
    cpos = new PVector(x + size/2, y + size/2);
    this.size = size;
    this.wall = wall;
  }
  
  Cell copy() {
    Cell cell = new Cell(ix, iy, pos.x, pos.y, size, wall);
    cell.pickup = this.pickup;
    cell.dropoff = this.dropoff;
    
    return cell;
  }

  void draw() {
    if (wall) {
      fill(0);
    } else {
      fill(255);
    }
    rectMode(CORNER);
    rect(pos.x, pos.y, size, size);
  }
  
  int hashCode() {
    return id;
  }
}