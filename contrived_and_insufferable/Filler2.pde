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
  
  String toString() {
    return "(" + x + "," + y + ")";
  }

  void addNeighbour(MP m) {
    if (m != null) {
      if (!isBlack(m.c)) {
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
      if (isBlack(m.c)) continue;
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

boolean flood(int x, int y, color fl, PGraphics p) {
  println("begin fill...");
  p.beginDraw();
  p.loadPixels();

  ArrayList<MP> open = new ArrayList<MP>();
  ArrayList<MP> closed = new ArrayList<MP>();
  ArrayList<MP> path = new ArrayList<MP>();

  MP c = getList(x, y);
  if (c != null) {
    open.add(c);
    if (!isBlack(c.c)) {
      c.c = fl;
      p.set(x, y, fl);
    } else {
      p.endDraw();
      println("end fill... (failed)");
      return false;
    }
  }




  while (!open.isEmpty()) {
    if (open.size() > 5000) {
      break;
    }
    //println(open.size());
    MP current = open.get(open.size()-1);

    //ArrayList<MP> neighbours = getNeighbours(current);
    path.clear();
    MP temp = current;
    path.add(temp);


    open.remove(current);
    closed.add(current);

    for (MP m : current.neighbours) {
      if (!closed.contains(m)) {
        m.c = fl;
        p.set(m.x, m.y, fl);
        open.add(m);
      }
    }
  }
  p.endDraw();
  println("end fill...");
  return true;

  //for (int yy = y; yy < width; yy += 1) {
  //  color ppc;
  //  for (int xx = x; xx > 0; xx -= 1) {
  //    color pc = get(xx,yy);
  //    if (brightness(pc) < 2) {
  //      break;
  //    } else {
  //      set(xx,yy,fl);

  //    }
  //  }
  //}
}

boolean isBlack(color c) {
  if (brightness(c) < 25) {
    return true;
  } else {
    return false;
  }
}
