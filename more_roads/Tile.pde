final int INDEX_TOP = 0;
final int INDEX_LEFT = 1;
final int INDEX_RIGHT = 2;
final int INDEX_BOTTOM = 3;

class Tile {
  int tries = 0;
  int rotation;
  PVector pos;
  PVector dims;
  TileType type;
  boolean top, bottom, left, right;
  Tile[] neighbours = new Tile[4];
  Tile[][] tileArray = null;
  int ix, iy;
  boolean ok = false;
  boolean cannotChange = false;

  PVector posTop, posBottom, posLeft, posRight;
  Tile (int ix, int iy, float x, float y, TILE_TYPE type) {
    this.ix = ix;
    this.iy = iy;
    tileArray = tiles;
    this.type = tileTypes.get(type);
    pos = new PVector(x, y);
    dims = new PVector(TILE_SIZE, TILE_SIZE);
    this.rotation = floor(random(4));
    posTop      = new PVector(pos.x + (dims.x / 2) - 2, pos.y);
    posBottom   = new PVector(pos.x + (dims.x / 2) - 2, pos.y + dims.y-4);
    posLeft     = new PVector(pos.x, pos.y + (dims.y/ 2)-2);
    posRight    = new PVector(pos.x + (dims.x )-4, pos.y + (dims.y/ 2)-2);
    setProperties();
  }

  void createNeighbours() {
    int[] nx = {-1, -1, -1, -1};
    int[] ny = {-1, -1, -1, -1};


    if (top) {
      nx[INDEX_TOP] = ix;
      ny[INDEX_TOP] = iy -1;
    }

    if (bottom) {
      nx[INDEX_BOTTOM] = ix;
      ny[INDEX_BOTTOM] = iy +1;
    }

    if (left) {
      nx[INDEX_LEFT] = ix-1;
      ny[INDEX_LEFT] = iy;
    }

    if (right) {
      nx[INDEX_RIGHT] = ix+1;
      ny[INDEX_RIGHT] = iy;
    }

    for (int i = 0; i < 4; i += 1) {
      int nnx = nx[i];
      int nny = ny[i];
      if (valid(nnx, nny)) {
        boolean createOk = false;
        int attempts = 0;
        Tile et = getTile(nnx, nny);

        if (et != null ) {
          if (et.ok || et.cannotChange) {
            continue;
          }
        }
        
        while (!createOk && attempts < 10) {
          attempts += 1;
          Tile t = new Tile(nnx, nny, nnx * TILE_SIZE, nny * TILE_SIZE, getRandomTileType());
          tiles[nnx][nny] = t;
          setNeighbours();
          t.setNeighbours();
          checkNeighbours();
          t.checkNeighbours();
          if (ok && t.ok) {
            createOk = true;
          } else {
            for (int tries = 0; tries < 4; tries += 1) {
              t.incRotation();
              setNeighbours();
              t.setNeighbours();
              checkNeighbours();
              t.checkNeighbours();
              if (ok && t.ok) {
                createOk = true;
              }
            }
          }
          tiles[nnx][nny] = null;
        }
      }
    }
  }

  void checkNeighbours() {
    ok = false;
    boolean thisCheck = true;
    for (int i = 0; i < neighbours.length; i += 1) {
      Tile n = neighbours[i];
      if (n == null) continue;
      switch (i) {
      case INDEX_LEFT:
        if (left && n.right) {
        } else {
          thisCheck = false;
        }
        break;
      case INDEX_RIGHT:
        if (right && n.left) {
        } else {
          thisCheck = false;
        }
        break;
      case INDEX_TOP:
        if (top && n.bottom) {
        } else {
          thisCheck = false;
        }

        break;
      case INDEX_BOTTOM:
        if (bottom && n.top) {
        } else {
          thisCheck = false;
        }
        break;
      }
    }

    if (thisCheck) {
      ok = true;
    }
  }

  void incRotation() {
    rotation = (rotation + 1) % 4;
    setProperties();
    tries += 1;
  }

  void randomIncRotation() {
    rotation = floor(random(100)) % 4;
    setProperties();
    tries += 1;
  }

  void addNeighbour(int i, int x, int y) {
    Tile t = getTile(x, y);
    if (t != null) {
      neighbours[i] = t;
    }
  }
  void setNeighbours() {
    neighbours[0] = null;
    neighbours[1] = null;
    neighbours[2] = null;
    neighbours[3] = null;

    addNeighbour(INDEX_LEFT, ix-1, iy); //left
    addNeighbour(INDEX_TOP, ix, iy-1); //above
    addNeighbour(INDEX_RIGHT, ix+1, iy); //right
    addNeighbour(INDEX_BOTTOM, ix, iy+1); //below
  }


  void draw() {
    pushMatrix();
    translate(pos.x+(dims.x/2), pos.y+(dims.y / 2));
    rotate(rotation * HALF_PI);
    image(type.img, -dims.x / 2, -dims.y / 2);
    popMatrix();
    stroke(0, 255, 0);
    fill(0, 255, 0);


    if (ok) {
      rect(posTop.x, posLeft.y, 4, 4);
    }

    if (top) {
      rect(posTop.x, posTop.y, 4, 4);
    }
    if (bottom) {
      rect(posBottom.x, posBottom.y, 4, 4);
    }
    if (left) {
      rect(posLeft.x, posLeft.y, 4, 4);
    }
    if (right) {
      rect(posRight.x, posRight.y, 4, 4);
    }
  }

  void setProperties() {
    top = left = right = bottom = false;
    switch (type.type) {
    case BUILDING:
      top = bottom = left = right = false;
      break;
    case STRAIGHT:
      switch(rotation) {
      case 0:
      case 2:
        top = bottom = true;
        break;
      default:
        left = right = true;
      }
      break;
    case TURN:
      switch(rotation) {
      case 0:
        bottom = left =true;
        break;
      case 1:
        top = left = true;
        break;
      case 2:
        top = right = true;
        break;
      default:
        right = bottom = true;
      }
      break;
    case FOUR_WAY:
      top = left = right = bottom = true;
      break;
    case THREE_WAY:
      switch(rotation) {
      case 0:
        left = right = bottom = true;
        break;
      case 1:
        top = left = bottom = true;
        break;
      case 2:
        left = top = right = true;
        break;
      default:
        top = right = bottom = true;
      }
      break;
    case END:
      switch(rotation) {
      case 0:
        bottom = true;
        break;
      case 1: 
        left = true;
        break;
      case 2:
        top = true;
        break;
      default:
        right = true;
        break;
      }
      break;
    }
  }
}
