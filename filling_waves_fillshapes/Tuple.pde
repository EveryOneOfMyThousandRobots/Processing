class Tuple implements Comparable<Tuple> {
  Integer x, y, d;
  

  Tuple(int x, int y, int d) {
    this.x = x;
    this.y = y;
    this.d = d;
  }
  
  public String toString() {
    return "(" + x + "," + y + "," + d + ")";
  }


  int hashCode() {
    return (x * 7) + (y * 3);
  }
  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    
    if (o instanceof Tuple) {
      Tuple t = (Tuple)o;
      return x == t.x && y == t.y;
    } else {
      return false;
    }
    
  }


  int compareTo(Tuple o) {
    Integer i = IX(x, y);
    Integer io = IX(o.x, o.y);
    return i.compareTo(io);
  }
}


Tuple tup(int x, int y, int d) {
  return new Tuple(x,y,d);
}

Tuple tup(Node n) {
  return tup(n.x, n.y, n.d);
}

Tuple tup(Node n, int d) {
  return tup(n.x, n.y, d);
}
