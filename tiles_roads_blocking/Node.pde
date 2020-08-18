

class Node {
  PVector pos;
  final int ix, iy;
  
  Node(int x, int y) {
    pos = new PVector(x * NODE_DIST, y * NODE_DIST);
    ix = x;
    iy = y;
  }
  
  void draw() {
    stroke(255);
    fill(0,200,255);
    ellipse(pos.x, pos.y, 3,3);
  }
}

class Edge {
  Node from, to;
}
