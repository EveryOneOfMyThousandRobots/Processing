int CELL_ID = 0;
class Cell {
  int x, y;
  boolean alive = true;
  float strength;
  float age;
  boolean disease = false;
  color c;
  float repro;
  float reprothreshold;
  Colony colony;
  final int id;
  {
    CELL_ID += 1;
    id = CELL_ID;
  }

  Cell (int x, int y, color c, Colony colony) {
    this.x = x;
    this.y = y;
    this.c = c;
    repro = 0;
    reprothreshold = random(REPROTHRESH_LOW, REPROTHRESH_HIGH);
    cells[x][y] = this;
    this.colony = colony;
    strength = random(STRENGTH_LOW, STRENGTH_HIGH);
  }

  void reproduce() {
    repro = 0;
    //int cx, cy;

    int[] coords = findEmpty();

    if (coords != null) {
      Cell child = new Cell(coords[0], coords[1], this.c, this.colony);
      child.strength = this.strength;
      
      if (random(1) < CHANCE_STRENGTH_MUTATE) {
        child.strength += random(-STRENGTH_MUTATE, STRENGTH_MUTATE);
      }
      child.reprothreshold = this.reprothreshold;
      if (random(1) < CHANCE_REPRO_MUTATE) {
        child.reprothreshold += random(-REPRO_MUTATE, REPRO_MUTATE);
      }
      child.reprothreshold = constrain(child.reprothreshold, REPROTHRESH_LOW,REPROTHRESH_HIGH);
      child.disease = this.disease;
      
      if (!child.disease && random(1) < CHANCE_DISEASE) {
        child.disease = true;
      } else if (child.disease && random(1) < CHANCE_CURE) {
        child.disease = false;
        
      }

      colony.cells.add(child);
    }
  }

  int hashCode() {
    return id * 11;
  }

  boolean equals(Cell o) {

    return o.id == this.id;
  }

  boolean sameColony(Cell o ) {
    return o.colony.id == this.colony.id;
  }

  int[] findEmpty () {
    int[] coords= null;
    FloorType dst = null;
    boolean found = false;

    for (int xx = x-1; xx <= x+1; xx += 1) {
      if (xx == x) continue;
      for (int yy = y -1; yy < y+1; yy += 1) {
        if (yy == y) continue;
        dst = map.get(xx, yy);
        if (dst == null) continue;
        if (dst == FloorType.LAND) {
          Cell c = cells[xx][yy];
          if (c == null ) {
            coords = new int[2];
            coords[0] = xx;
            coords[1] = yy;
            found = true;
            break;
          } else {
          }
        }
      }
      if (found) break;
    }

    return coords;
  }


  void die() {
    alive = false;
    cells[x][y] = null;
  }


  void move(int newx, int newy) {
    cells[x][y] = null;
    cells[newx][newy] = this;
    x = newx;
    y = newy;
  }

  void update() {
    float food = map.getFood(x,y);
    if (disease) {
      age += DISEASE_AGE_INC;
    } else {
      age += NORMAL_AGE_INC;
    }
    //age += (1 - food) * 10;
    if (food < 0.3) {
      strength *= 1 - map(food, 0, 0.3, 0.01,0.001);
    }
    
    
    repro += 1;
    if (age > strength) {
      die();
    } else {

      if (map.get(x, y) == FloorType.SEA) {
        die();
        return;
      }

      int dir = floor(random(4));
      int dx = x;
      int dy = y;
      FloorType dst = null;
      switch (dir) {
      case 0: //UP
        dy -=1;
        break;
      case 1: //DOWN
        dy += 1;
        break;
      case 2: //LEFT
        dx -= 1;
        break;
      case 3: //RIGHT
        dx += 1;
      }

      if (dy < 0 || dy > map.height-1 || dx < 0 || dx > map.width-1 || (dx == x && dy == y) ) {
        die();
        
      } else {
        Cell c = cells[dx][dy];
        if (c == null) { //not occupied
          dst = map.get(dx, dy);

          if (dst == FloorType.LAND) {
            move(dx, dy);
            if (repro > reprothreshold) reproduce();
          } else {
          }
        } else {
          if (!sameColony(c)) {
            float chance = strength / (c.strength + strength);
            if (random(1) <= chance) {
              c.die();
            } else {
              die();
            }
            //if (c.strength < this.strength) {
            //  c.die();
            //} else {
            //  this.die();
            //}
          }
        }
      }
    }
  }
}
