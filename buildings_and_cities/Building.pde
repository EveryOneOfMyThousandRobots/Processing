enum FACING {
  NORTH, SOUTH, EAST, WEST;
}
ArrayList<Building> buildings = new ArrayList<Building>();
class Building {
  int x, y, w, h;
  FACING facing;


  Building(int x, int y, int w, int h, FACING facing) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.facing = facing;
  }
}

void erodeBuildings() {
  for (Building b : buildings) {
    //if (!xChance2(b.x)) {
    Eroder e = new Eroder(b);
    e.erodeBuilding();
    //}
  }
}

class Eroder {
  ArrayList<IntPair> toCheck = new ArrayList<IntPair>();
  ArrayList<IntPair> newNodes = new ArrayList<IntPair>();
  int[][] map;
  final int w, h;
  Building b;

  boolean eOOB(int x, int y) {
    return (x < 0 || x > w-1 || y < 0 || y > h-1);
  }

  int eCn(int x, int y) {
    if (eOOB(x, y)) return 1;
    if (map[x][y] != 0) {
      return 1;
    } else {
      return 0;
    }
  }

  boolean eCheckNeighbours(int x, int y) {
    int n = 0;
    n += eCn(x-1, y);
    n += eCn(x+1, y);
    n += eCn(x, y+1);
    n += eCn(x, y-1);

    return n != 4;
  }

  Eroder(Building b) {
    this.b = b;
    this.w = b.w;
    this.h = b.h;
    map = new int[b.w][b.h];
  }
  void erodeBuilding() {
    int xStart = 0, yStart = 0;


    if (random(1) < 0.5) {
      if (random(1) < 0.5) {
        xStart = 0;
      } else {
        xStart = w;
      }
      yStart = floor(random(h+1));
    } else {
      if (random(1) < 0.5) {
        yStart = 0;
      } else {
        yStart = h;
      }
      xStart = floor(random(w+1));
    }
    toCheck.add(MakePair(xStart, yStart));

    int cycles = 10;
    int iterationRange = 6;
    
    for (int i = 0; i < cycles; i += 1) {
      if (toCheck.isEmpty()) break;
      
      int iterations = floor(random(1, iterationRange));
      for (int j = 0; j < iterations; j += 1) {
        boolean ok =false;
        while (!ok && !toCheck.isEmpty()) {
          IntPair p = toCheck.get(floor(random(toCheck.size())));

          if (!eCheckNeighbours(p.x, p.y)) {
            toCheck.remove(p);
            continue;
          }

          if (random(1) < 0.5) {
            //check x
            if (random(1) > 0.5) {
              ok = eSetNeighbour(p.x-1, p.y);
            } else {
              ok = eSetNeighbour(p.x+1, p.y);
            }
          } else {
            //check y

            if (random(1) > 0.5) {
              ok = eSetNeighbour(p.x, p.y-1);
            } else {
              ok = eSetNeighbour(p.x, p.y+1);
            }
          }

          //swap
          //toCheck.clear();
          toCheck.addAll(newNodes);
          newNodes.clear();
        }
      }
    }

    for (int x = 0; x < w; x += 1) {
      for (int y = 0; y < h; y += 1) {
        int v = map[x][y];

        if (v != 0) {
          int xx = b.x + x;
          int yy = b.y + y;

          typeMap[xx][yy] = null;
          displayMap[xx][yy] = null;
        }
      }
    }
  }

  void eAddToCheck(int x, int y) {
    IntPair p = MakePair(x, y);
    if (!toCheck.contains(p)) {
      toCheck.add(p);
    }
  }

  void eAddToNew(int x, int y) {
    IntPair p = MakePair(x, y);
    if (!newNodes.contains(p)) {
      newNodes.add(p);
    }
  }

  boolean eSetNeighbour(int x, int y) {
    if (eOOB(x, y)) return false;

    int v = map[x][y];

    if (v != 0) {
      return false;
    }

    map[x][y] = 1;

    eAddToNew(x, y);

    return true;
  }
}
