class Node implements Comparable<Node> {
  final int x, y;
  int d;

  Node(int x, int y ) {
    this.x = x;
    this.y = y;
    d = 0;
  }


  int hashCode() {
    return (x * 7) + (y * 3);
  }

  boolean equals(Node o) {
    return x == o.x && y == o.y;
  }


  int compareTo(Node o) {
    Integer i = IX(x, y);
    Integer io = IX(o.x, o.y);
    return i.compareTo(io);
  }
}
