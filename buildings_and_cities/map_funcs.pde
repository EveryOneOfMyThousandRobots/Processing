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

    switch (building.facing) {
    case EAST:
      makeDoorEastWall(building);
      break;
    case WEST:
      makeDoorWestWall(building);
      break;
    case NORTH:
      makeDoorNorthWall(building);
      break;
    case SOUTH:
      makeDoorSouthWall(building);
      break;
    }

    int r = floor(random(0, 3));

    if (r > 0 && random(1) < 0.5) {
      for (int i = 0; i < r; i += 1) {
        int rr = floor(random(4));
        switch(rr) {
        case 0:
        makeDoorSouthWall(building);
          break;
        case 1:
        makeDoorNorthWall(building);
          break;
        case 2:
        makeDoorEastWall(building);
          break;
        case 3:
        makeDoorWestWall(building);
          break;
        }
      }
    }
  }
}

void makeDoorSouthWall(Building b) {

  int xs = b.x+1;
  int xe = xs + b.w - 2;
  int ys = b.y + b.h;
  int ye = ys;    
  makeDoor(xs, xe, ys, ye);
}

void makeDoorNorthWall(Building b) {

  int xs = b.x+1;
  int xe = xs + b.w - 2;
  int ys = b.y;
  int ye = ys;   
  makeDoor(xs, xe, ys, ye);
}

void makeDoorWestWall(Building b) {

  int xs = b.x;
  int xe = xs;
  int ys = b.y + 1;
  int ye = b.y + b.h - 2;
  makeDoor(xs, xe, ys, ye);
}

void makeDoorEastWall(Building b) {

  int xs = b.x + b.w;
  int xe = xs;
  int ys = b.y + 1;
  int ye = b.y + b.h - 2;
  makeDoor(xs, xe, ys, ye);
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



TYPES getType(int x, int y) {
  if (OOB(x, y)) return null; 
  return typeMap[x][y];
}

boolean isBlocked(int x, int y) {
  if (OOB(x, y)) return true; 

  TYPES t = typeMap[x][y]; 

  return t == null;
}
