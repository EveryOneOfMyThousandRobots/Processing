final int LEN = 23;
final int HALF_LEN = floor(LEN/2);
ArrayList<TP> picks = new ArrayList<TP>();
enum DIR {
  HORIZONTAL, VERTICAL;
}
int TP_ID = 0;
class TP implements Comparable<TP> {
  final int id;
  {
    TP_ID += 1;
    id = TP_ID;
  }
  int ax, ay, bx, by;
  DIR dir;

  boolean aTaken = false;
  boolean bTaken = false;

  TP(int x, int y, DIR dir) {
    this.dir = dir;
    if (dir == DIR.HORIZONTAL) {
      ax = x - HALF_LEN;
      bx = x + HALF_LEN;
      ay = y;
      by = y;
    } else {
      ax = x;
      bx = x;
      ay = y - HALF_LEN;
      by = y + HALF_LEN;
    }
  }
  boolean intersects(int x, int y, TP o) {
    if ((x == o.ax && y == o.ay) || (x == o.bx && y == o.by)) {
      return true;
    }

    return false;
  }

  boolean available(int x, int y, ArrayList<TP> others) {
    for (TP o : others) {
      if (!equals(o)) {
        if (intersects(x, y, o)) {
          return false;
        }
      }
    }

    return true;
  }

  TP createA(ArrayList<TP> others) {
    if (aTaken) return null;

    if (available(ax, ay, others)) {
      aTaken = true;
      return new TP(ax, ay, getReverseDIR(dir));
    }
    return null;
  }

  TP createB(ArrayList<TP> others) {
    if (bTaken) return null;

    if (available(bx, by, others)) {
      aTaken = true;
      return new TP(bx, by, getReverseDIR(dir));
    }
    return null;
  }

  void draw() {
    line(ax, ay, bx, by);
  }



  int compareTo(TP o) {
    if (id > o.id) {
      return 1;
    } else if (id < o.id) {
      return -1;
    } else {
      return 0;
    }
  }


  int hashCode() {
    return (id*11)+ax+bx+ay+by;
  }

  boolean equals(TP o) {
    return o.id == id;
  }
}
