final String NORTH = "north";
final String SOUTH = "south";
final String EAST = "east";
final String WEST = "west";

class Tile {
  TYPE type = TYPE.EMPTY;
  final int x, y;
  PVector pTL, pTR, pBL, pBR;

  Surface Ns = null, Ss = null, Es = null, Ws = null;
  Tile Nt = null, St = null, Et = null, Wt = null;
  HashMap<String, Tile> nMap = new HashMap<String, Tile>();

  Tile(int x, int y, TYPE type) {
    this.x = x;
    this.y = y;
    this.type = type;
    pTL = new PVector(x * TS, y * TS);
    pTR = new PVector((x * TS) + TS, y * TS);
    pBL = new PVector(x * TS, (y * TS) + TS);
    pBR = new PVector((x * TS)+TS, (y * TS)+TS);
  }

  void setNeighbours() {
    nMap.clear();
    Nt = getTile(x, y-1);
    nMap.put(NORTH, Nt);
    St = getTile(x, y+1);
    nMap.put(SOUTH, St);
    Et = getTile(x+1, y);
    nMap.put(EAST, Et);
    Wt = getTile(x-1, y);
    nMap.put(EAST, Wt);
  }


  void setSurface() {

    Ns = null;
    Es = null;
    Ws = null;
    Ss = null;

    if (isWall(this)) {
      //northern surface
      if (Nt != null) {
        if (isEmpty(Nt)) {
          if (isWall(Wt)) {
            if (Wt.Ns != null) {
              Ns = Wt.Ns;
              Ns.setEnd(pTR.x, pTR.y);
            } else {
              Ns = new Surface(pTL.x, pTL.y, pTR.x, pTR.y);
            }
          } else {
            Ns = new Surface(pTL.x, pTL.y, pTR.x, pTR.y);
          }
        }
      }

      //southern surface
      if (St != null) {
        if (isEmpty(St)) {
          if (isWall(Wt)) {
            if (Wt.Ss != null) {
              Ss = Wt.Ss;
              Ss.setEnd(pBR.x, pBR.y);
            } else {
              Ss = new Surface(pBL.x, pBL.y, pBR.x, pBR.y);
            }
          } else {
            Ss = new Surface(pBL.x, pBL.y, pBR.x, pBR.y);
          }
        }
      }

      //western surface
      if (Wt != null) {
        if (isEmpty(Wt)) {
          if (isWall(Nt)) {
            if (Nt.Ws != null) {
              Ws = Nt.Ws;
              Ws.setEnd(pBL.x, pBL.y);
            } else {
              Ws = new Surface(pTL.x, pTL.y, pBL.x, pBL.y);
            }
          } else {
            Ws = new Surface(pTL.x, pTL.y, pBL.x, pBL.y);
          }
        }
      }

      //eastern surface
      if (Et != null) {
        if (isEmpty(Et)) {
          if (isWall(Nt)) {
            if (Nt.Es != null) {
              Es = Nt.Es;
              Es.setEnd(pBR.x, pBR.y);
            } else {
              Es = new Surface(pTR.x, pTR.y, pBR.x, pBR.y);
            }
          } else {
            Es = new Surface(pTR.x, pTR.y, pBR.x, pBR.y);
          }
        }
      }
    }
  }





  void toggle() {
    if (!isBorder(x, y)) {
      if (type == TYPE.EMPTY) {
        type = TYPE.WALL;
      } else {
        type = TYPE.EMPTY;
      }
    }
  }

  void draw() {
    stroke(0);
    switch (type) {
    case EMPTY:
      fill(0);
      break;
    case WALL:
      fill(128);
      break;
    }
    rect(x * TS, y * TS, TS, TS);
  }
}
Tile getTileCoords(float x, float y) {
  int xx = floor(x / TS);
  int yy = floor(y / TS);

  return getTile(xx, yy);
}

void setNeighbours() {
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      tiles[x][y].setNeighbours();
    }
  }
}

void setSurfaces() {
  surfaces.clear();
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      tiles[x][y].setSurface();
    }
  }
}



Tile getTile(int x, int y) {
  if (!OOB(x, y)) {
    return tiles[x][y];
  } else {
    return null;
  }
}

boolean OOB(int x, int y) {
  return (x < 0 || x > TA -1 || y < 0 || y > TD-1);
}

boolean isBorder(int x, int y) {
  return (x == 0 || x == TA-1 || y == 0 || y == TD-1);
}

boolean isWall(Tile t) {
  return (t == null || t.type == TYPE.WALL);
}

boolean isEmpty(Tile t) {
  return (t == null || t.type == TYPE.EMPTY);
}
