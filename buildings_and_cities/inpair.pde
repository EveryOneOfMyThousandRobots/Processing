class IntPair {
  final int x, y;
  final private String h;
  IntPair(int x, int y) {
    this.x = x;
    this.y = y;
    h = x + "_" + y;
  }

  int hashCode() {
    return h.hashCode();
  }

  @Override 
    boolean equals(Object o ) {
    if (o instanceof IntPair) {
      IntPair op = (IntPair) o;

      return (x == op.x && y == op.y);
    } else {
      return false;
    }
  }
}
IntPair MakePair(int x, int y) {
  return new IntPair(x, y);
}
