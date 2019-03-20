int MP_ID = 0;

class MP {
  final int id;
  {
    MP_ID += 1;
    id = MP_ID;
  }
  int x;
  int y;
  int c;
  ArrayList<MP> neighbours = new ArrayList<MP>();

  MP(int x, int y, int c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }

  void addNeighbour(MP m) {
    if (m != null) {
      if (m.c != color(0)) {
        neighbours.add(m);
      }
    }
  }

  boolean equals(MP other) {
    return(x==other.x && y==other.y);
  }
  int hashCode() {
    return id;
  }
}

MP[][] list;
void make() {
  list = new MP[width][height];
  loadPixels();
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      MP p = new MP(x, y, get(x, y));
      list[x][y] = p;
    }
  }

  for (int x = 0; x < list.length; x += 1) {
    for (int y = 0; y < list[x].length; y += 1) {
      MP m = list[x][y];
      if (m.c == color(0)) continue;
      m.addNeighbour(getList(x-1, y));
      m.addNeighbour(getList(x, y-1));
      m.addNeighbour(getList(x, y+1));
      m.addNeighbour(getList(x+1, y));
    }
  }
}

MP getList(int x, int y ) {
  if (x < 0 ||  x > width-1 || y < 0 || y > height-1) {
    return null;
  } else {
    return list[x][y];
  }
}
