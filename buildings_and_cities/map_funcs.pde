import java.util.HashSet;
void fixBuildings() {
  HashSet<IntPair> toRemove = new HashSet<IntPair>();

  for (Building building : buildings) {
    toRemove.clear();
    switch (building.facing) {
    case EAST:
    case WEST:
      for (int x = building.x; x <= building.x + building.w; x += 1) {
        int y1 = building.y;
        int y2 = building.y + building.h;
        if (countNeighbours(x, y1, 2) == 5) {
          toRemove.add(MakePair(x, y1));
        } 
        if (countNeighbours(x, y2, 3) == 5) {
          toRemove.add(MakePair(x, y2));
        }
      }

      break;
    case NORTH:
    case SOUTH:

      for (int y = building.y; y <= building.y + building.h; y += 1) {
        int x1 = building.x;
        int x2 = building.x + building.w;
        if (countNeighbours(x1, y, 0) == 5) {
          toRemove.add(MakePair(x1, y));
        } 
        if (countNeighbours(x2, y, 1) == 5) {
          toRemove.add(MakePair(x2, y));
        }
      }
      break;
    }

    for (IntPair ip : toRemove) {


      displayMap[ip.x][ip.y] = TYPES.INTERIOR;
      typeMap[ip.x][ip.y] = TYPES.INTERIOR;
    }
  }
  // add doors
  //println("add doors");
  for (Building building : buildings) {
    int xs = -1, xe = -1, ys = -1, ye = -1; 
    switch (building.facing) {
    case EAST:
      xs = building.x + building.w;
      xe = xs;
      ys = building.y + 1;
      ye = building.y + building.h - 2;
      break;
    case WEST:
      xs = building.x;
      xe = xs;
      ys = building.y + 1;
      ye = building.y + building.h - 2;    
      break;
    case NORTH:
      xs = building.x+1;
      xe = xs + building.w - 2;
      ys = building.y;
      ye = ys;    
      break;
    case SOUTH:
      xs = building.x+1;
      xe = xs + building.w - 2;
      ys = building.y + building.h;
      ye = ys;    
      break;
    }
    makeDoor(xs,xe,ys,ye);
  }
}

void makeEastDoor(Building b) {
}

void makeDoor(int xs, int xe, int ys, int ye) {
  if (xs >= 0 && xe >= 0 && ys >= 0 && ye >= 0) {
    int x = floor(random(xs, xe+1));
    int y = floor(random(ys, ye+1));

    TYPES t = getType(x, y);
    if (t != null && t == TYPES.WALL) {
      typeMap[x][y] = TYPES.INTERIOR;
      displayMap[x][y] = TYPES.INTERIOR;
      //println("\tadding door @ (" + x + "," + y + ")");
    }
  }
}

int countNeighbours(int x, int y, int pattern) {
  int count = 0;
  int xs = 0, xe = 0;
  int ys = 0, ye = 0;

  switch (pattern) {
  case 0:
    xs = x-1;
    xe = x;
    ys = y-1;
    ye = y+1;
    break;
  case 1:
    xs = x;
    xe = x+1;
    ys = y-1;
    ye = y+1;
    break;
  case 2:
    xs = x-1;
    xe = x+1;
    ys = y-1;
    ye = y;  
    break;
  default:
    xs = x-1;
    xe = x+1;
    ys = y;
    ye = y+1; 
    break;
  }


  for (int xx = xs; xx <= xe; xx += 1) {
    for (int yy = ys; yy <= ye; yy += 1) {
      if (xx == x && yy == y) continue;

      if (!OOB(xx, yy)) {
        TYPES t = getType(xx, yy);
        if (t != null && t == TYPES.WALL) {
          count += 1;
        }
      }
    }
  }



  return count;
}

void makeRoads() {  

  //roads down
  for (int x = 0; x < MAP_WIDTH; x += BLOCK_WIDTH) {
    for (int y = 0; y < MAP_HEIGHT; y += BLOCK_HEIGHT) {
      if (xChance(x)) {
        for (int yy = y; yy < y + BLOCK_HEIGHT && yy < MAP_HEIGHT; yy += 1) {
          for (int xx = x; xx < x + ROAD_WIDTH && xx < MAP_WIDTH; xx += 1) {
            typeMap[xx][yy] = TYPES.ROAD; 
            if (xChance(xx) || xChance(x)) {
              displayMap[xx][yy] = TYPES.ROAD;
            }
          }
        }
      }
    }
  }

  //roads across
  for (int y = 0; y < MAP_HEIGHT; y += BLOCK_HEIGHT) {
    for (int x = 0; x < MAP_WIDTH; x += BLOCK_WIDTH) {

      if (xChance(x)) {
        for (int xx = x; xx < x + BLOCK_HEIGHT && xx < MAP_WIDTH; xx += 1) {
          for (int yy = y; yy < y + ROAD_WIDTH && yy < MAP_HEIGHT; yy += 1) {
            typeMap[xx][yy] = TYPES.ROAD; 
            if (xChance(xx) || xChance(x)) {
              displayMap[xx][yy] = TYPES.ROAD;
            }
          }
        }
      }
    }
  }
}

TYPES getType(int x, int y) {
  if (OOB(x, y)) return null; 
  return typeMap[x][y];
}

boolean isBlocked(int x, int y) {
  if (OOB(x, y)) return true; 

  TYPES t = typeMap[x][y]; 

  return t == null;
}
