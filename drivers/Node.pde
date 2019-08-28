int NODE_ID = 0;
class Node {
  final int id;
  {
    NODE_ID += 1;
    id = NODE_ID;
  }
  PVector pos;
  float cost = 1;
  ArrayList<Node> neighbours = new ArrayList<Node>();

  Node(float x, float y) {
    pos = new PVector(x, y);
    cost = random(Float.MIN_VALUE, Float.MAX_VALUE);
  }
  void draw() {
    stroke(map(cost, Float.MIN_VALUE, Float.MAX_VALUE, 0, 255));
    strokeWeight(3);
    point(pos.x, pos.y);
    strokeWeight(1);
    //stroke(255,64);
    //for (Node n : neighbours) {
    //  line(pos.x, pos.y, n.pos.x, n.pos.y);
    //}
  }

  int hashCode() {
    return id;
  }

  boolean equals(Node n) {
    return n.id == this.id;
  }

  String toString() {
    return "Node (" + id + ") (" + pos.x +","+pos.y + ")";
  }

  void findNeighbours(int xi, int yi, ArrayList<Node> nodes) {
    print("\nfinding neighbours for " + id);
    for (int xxi = xi-1; xxi <= xi + 1; xxi += 1) {
      
      for (int yyi = yi-1; yyi <= yi + 1; yyi += 1) {
        if (yyi < 0 || yyi >= NODES_DOWN) continue;
        if (xxi < 0 || xxi >= NODES_ACROSS) continue;
        
        if (xxi == xi && yyi == yi) continue;
        
        int idx = xxi + yyi * NODES_ACROSS;
        if (random(1) < 0.5) {
          neighbours.add(nodes.get(idx));
        }
      }
    }
    print(" found + " + neighbours.size() + " neighbour(s)");
  }
}
