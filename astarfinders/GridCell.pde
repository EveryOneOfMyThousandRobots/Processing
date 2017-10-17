import java.util.Comparator;
enum CellType {
  WALL, PICKUP, DROPOFF, BLANK, CHECKIN;
}
enum DIR {
  NONE, NORTH, SOUTH, EAST, WEST;
}

class Grid {
  ArrayList<Aisle> aisles = new ArrayList<Aisle>();
  int id = getNextId("GRID");
  Cell[][] cells;
  int rows, cols;
  ArrayList<Cell> pickups = new ArrayList<Cell>();
  ArrayList<Cell> dropoffs = new ArrayList<Cell>();
  ArrayList<Cell> walls = new ArrayList<Cell>();
  Cell checkin;
  float size;
  float zoff = 0;


  Cell getCell(int x, int y) {
    if (x >= 0 && x < cols && y >= 0 && y < rows) {
      return cells[x][y];
    } else {
      return null;
    }
  }
  
  Cell getCellAtPos(float x, float y) {
    return getCell(floor(x / res), floor(y / res));
  }
  
  Cell getCellAtPos(PVector pos) {
    return getCellAtPos(pos.x, pos.y);
    
  }
  
  Grid() {

    cols = level.width;
    rows = level.height;
    size = res;
    cells = new Cell[cols][rows];
    level.loadPixels();
    boolean fastLane = false;
    DIR direction = DIR.NONE;
    for (int x = 0; x < level.width; x += 1) {
      for (int y = 0; y  < level.height; y += 1) {
        fastLane = false;
        int col = level.get(x, y) & 0xffffff;
        CellType type = CellType.BLANK;
        if (col == 0x000000) {
          type = CellType.WALL;
        } else if (col == 0x00ff00) {
          type = CellType.PICKUP;
        } else if (col == 0xff0000) {
          type = CellType.DROPOFF;
        } else if (col == 0x0000ff) {
          type = CellType.CHECKIN;
        } else {
          type = CellType.BLANK;
          if (col == 0xffffff) {
            fastLane = true;
          } else if (col == 0xff99ff) {
            direction = DIR.NORTH;
          } else if (col == 0xffbbff) {
            direction = DIR.SOUTH;
          }
        }
        //println(Integer.toHexString(col) + " " +type);
        Cell cell = new Cell(x, y, res, type, this, fastLane, direction);
        cells[x][y] = cell;
      }
    }
    renumberCells();
  }

  void renumberCells () {
    int startingId = 0;
    for (int x = 1; x < level.width-1; x += 4) {

      if (x % 8 == 1) { //go north
        for (int y = level.height-1; y >= 0; y -= 1) {
          for (int i = 0; i < 3; i += 2) {
            Cell c = cells[x+i][y];
            if (c.type == CellType.PICKUP) {
              startingId += 1;
              c.id = startingId;
            }
          }
        }
      } else { //go wweeeeest, I mean south
        for (int y = 0; y < level.height; y += 1) {
          for (int i = 0; i < 3; i += 2) {
            Cell c = cells[x+i][y];
            if (c.type == CellType.PICKUP) {
              startingId += 1;
              c.id = startingId;
            }
          }
        }
      }
    }
  }

  Cell getRandomPickup() {
    Cell p = null;
    while (p == null) {
      int r1 = floor(random(pickups.size()));
      float r2 = random(1);
      p = pickups.get(r1);
      if (r2 < p.demand) {
      } else {
        p = null;
      }
    }
    return p;
  }

  Cell getRandomDropOff() {
    if (dropoffs.isEmpty()) {
      stop();
      println("no dropoffs");
      return null;
    } else {
      int r1 = floor(random(dropoffs.size()));
      return dropoffs.get(r1);
    }
  }

  Cell getRandomBlank() {
    Cell cell = null;
    while (cell == null ) {
      int c = floor(random(cols));
      int r = floor(random(rows));
      cell = cells[c][r];
      if (cell.type != CellType.BLANK) {
        cell = null;
      }
    }
    return cell;
  }

  void draw() {
    zoff += 0.001;
    float highestTraffic = 0;
    for (int ix = 0; ix < cells.length; ix += 1) {
      for (int iy = 0; iy < cells[ix].length; iy += 1) {
        Cell c = cells[ix][iy];
        c.setDemand();

        if (c.traffic > highestTraffic && c.type == CellType.BLANK) {
          highestTraffic = c.traffic;
        }
      }
    }

    for (int ix = 0; ix < cells.length; ix += 1) {
      for (int iy = 0; iy < cells[ix].length; iy += 1) {
        Cell c = cells[ix][iy];
        if (c.type == CellType.BLANK) {
          c.trafficCol = c.traffic / highestTraffic;
        }
        c.draw();
      }
    }
  }
}





class Cell implements Comparable<Cell> {

  int id = getNextId("CELL");
  PVector pos;
  int ix, iy;
  float nx, ny;
  CellType type;
  float size;
  Grid grid;
  float demand;
  float traffic = 1;
  float trafficCol = 0;
  boolean fastLane = false;
  DIR direction;
  boolean occupied = false;
  
  void setOccupied() {
    occupied = true;
    
  }
  
  void clearOccupied() {
    occupied = false;
    
  }

  int compareTo(Cell o) {
    if (id > o.id) {
      return 1;
    } else {
      return -1;
    }
  }
  


  Cell (int ix, int iy, float size, CellType type, Grid grid, boolean fastLane, DIR direction) {
    this.ix = ix;
    this.iy = iy;
    nx = float(ix) * 0.1;
    ny = float(iy) * 0.1;

    pos = new PVector(ix * res, iy * res);
    this.size = size;
    this.type = type;
    this.grid = grid;
    setDemand();
    if (type == CellType.WALL) {
      grid.walls.add(this);
    } else if (type == CellType.PICKUP) {

      grid.pickups.add(this);
    } else if (type == CellType.DROPOFF) {
      grid.dropoffs.add(this);
    } else if (type == CellType.CHECKIN) {
      grid.checkin = this;
    }
    this.fastLane = fastLane;
    this.direction = direction;
  }

  void setDemand() {
    demand = noise(nx, ny, grid.zoff);
  }

  void draw() {
    color fill = 0;
    switch (this.type) {
    case WALL:
      fill = color(0);

      break;
    case PICKUP:
      fill = color(0, map(demand, 0, 1, 64, 255), 0);

      break;
    case DROPOFF:
      fill = color(0, 0, 255);

      break;
    case BLANK:
      fill = color(floor(map(trafficCol, 0, 1, 255, 51)));
      break;
    case CHECKIN:
      fill = color(100, 0, 100);
    }

    fill(fill);
    noStroke();
    if (occupied) {
      stroke(255,0,0);
    }
    
    
    rect(pos.x, pos.y, size, size);
    if (type == CellType.PICKUP) {
      fill(255);
      text(Integer.toHexString(id), pos.x, pos.y + size - 10) ;
    }
  }
}