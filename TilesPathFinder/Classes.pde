class Tile {
  PVector pos;
  PVector size;
  float cost;

  Tile (float x, float y, float w, float h, float cost) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    this.cost = cost;
  }

  void draw() {
    stroke(0);
    float r = map(cost, 0, 1, 0, 255);
    float g = map(cost, 0, 1, 255, 0);
    fill(r, g, 0);
    rect(pos.x, pos.y, size.x, size.y);
  }
}

Tile getTile(float x, float y) {

  if (x < 0 || x > width || y < 0 || y > height) {
    return null;
  }
  int xx = (int) (x / tileWidth);
  int yy = (int) (y / tileHeight);
  println(xx + "," + yy);
  Tile t = tiles.get(xx + yy * tilesAcross);

  return t;
}



class Path {
  ArrayList<Tile> pathTiles = new ArrayList<Tile>();
  ArrayList<Tile> tempList = new ArrayList<Tile>();
  PVector start;
  PVector current;
  PVector end;

  Path(float xs, float ys, float xe, float ye) {
    start = new PVector(xs, ys);
    current = start.copy();
    end = new PVector(xe, ye);
  }

  void fillTileList() {
    tempList.clear();

    Tile t;
    t = getTile(current.x - tileWidth, current.y);
    if (t != null) {
      tempList.add(t);
    }
    t = getTile(current.x + tileWidth, current.y);
    if (t != null) {
      tempList.add(t);
    }
    t = getTile(current.x, current.y - tileHeight);
    if (t != null) {
      tempList.add(t);
    }
    t = getTile(current.x, current.y + tileHeight);
    if (t != null) {
      tempList.add(t);
    }
  }



  void update() {

    fillTileList();
    Tile lowest = null;
    for (int i = 0; i < tempList.size(); i++) {
      if (i == 0) {
        lowest = tempList.get(i);
        continue;
      } else if (lowest != null && tempList.get(i).cost < lowest.cost) {
        lowest = tempList.get(i);
      }
    }

    if (lowest != null) {
      pathTiles.add(lowest);
      current.x = lowest.pos.x;
      current.y = lowest.pos.y;
    }
  }

  void draw() {
    Tile t = null, l = null;
    for (int  i = 0; i < pathTiles.size(); i++) {
      t = tiles.get(i);
      float tx = t.pos.x + (t.size.x / 2);
      float ty = t.pos.y + (t.size.y / 2);

      if (l != null) {
        float lx = l.pos.x + (l.size.x / 2);
        float ly = l.pos.y + (l.size.y / 2);
        line(tx, ty, lx, ly);
      }
      l =t;
    }
  }
}