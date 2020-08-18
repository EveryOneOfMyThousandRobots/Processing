class Node {

  final int x, y;
  PVector pos;

  int hashCode() {
    return y * TA + x;
  }
  
  @Override
  String toString() {
    return "Node " + hashCode() + " (" + x + "," + y + ")";
  }
  
  @Override
    boolean equals(Object o) {
    if (o instanceof Node) {
      if (o.hashCode() == hashCode()) {
        return true;
      }
    }
    return false;
  }

  ArrayList<Node> neighbours = new ArrayList<Node>();
  Node(int x, int y) {
    this.x = x;
    this.y = y;
    float nd = (float)NODE_DIST / 2.0;
    pos = new PVector(nd + (x * NODE_DIST), nd + (y * NODE_DIST));
  }

  void setNeighbours() {
    setNeighbour(x-1, y);
    setNeighbour(x+1, y);
    setNeighbour(x, y-1);
    setNeighbour(x, y+1);
  }

  void draw() {
    stroke(255, 64);
    noFill();
    ellipse(pos.x, pos.y, NODE_DIST / 2, NODE_DIST / 2);

    for (Node n : neighbours) {
      line(pos.x, pos.y, n.pos.x, n.pos.y);
    }
  }

  void setNeighbour(int xx, int yy) {
    if (!OOB(xx, yy)) {
      Node n = nodes[xx][yy];
      if (!equals(n) && !neighbours.contains(n)) {
        neighbours.add(n);
      }
    }
  }
}
