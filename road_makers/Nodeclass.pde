class Node {

  int hashCode() {
    return (y * TA) + x;
  }

  @Override
    String toString() {
    return "Node(" + x + "," + y + ")";
  }



  @Override
    boolean equals(Object o) {
    if (o instanceof Node) {
      Node n = (Node)o;
      if (n.hashCode() == hashCode()) {
        return true;
      }
    }
    return false;
  }
  HashMap<Node, Float> connections = new HashMap<Node, Float>();

  final int x, y;
  PVector pos;
  Node (int x, int y) {
    this.x = x;
    this.y = y;
    float to = TS / 2;
    pos = new PVector(to + (x * TS), to + (y * TS));
  }

  void draw(color c) {
    noStroke();
    fill(c, 128);
    ellipse(pos.x, pos.y, 5, 5);
  }

  void draw() {
    noStroke();
    fill(255, 128);
    ellipse(pos.x, pos.y, 3, 3);

    for (Node n : connections.keySet()) {
      float w = map(connections.get(n), COST_MIN, COST_MAX, 20, 1);
      strokeWeight(w);
      stroke(255, 64);
      line(pos.x, pos.y, n.pos.x, n.pos.y);
    }
  }

  Set<Node> getNeighbourList() {
    return connections.keySet();
  }

  void makeConnection(int xx, int yy) {
    if (xx == x && yy == y) return;
    if (OOB(xx, yy)) return;

    Node n = getNode(xx, yy);
    if (n != null) {

      if (!connections.containsKey(n)) {
        connections.put(n, COST_MAX);
      }
      if (!n.connections.containsKey(this)) {
        n.connections.put(this, COST_MAX);
      }
    }
  }

  void breakConnection(Node n) {
    if (n != null) {

      if (connections.containsKey(n)) {
        connections.remove(n);
        
      }
      if (n.connections.containsKey(this)) {
        n.connections.remove(this);
      }
    }
  }

  void breakConnection(int xx, int yy) {
    if (xx == x && yy == y) return;
    if (OOB(xx, yy)) return;

    Node n = getNode(xx, yy);
    breakConnection(n);
  }
}
