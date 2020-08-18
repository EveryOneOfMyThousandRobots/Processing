class Node {
  ArrayList<Node> neighbours = new ArrayList<Node>(4);
  final int x, y, idx, na;
  int neighbourLimit = floor(random(1, 4));
  PVector pos;
  Node[][] nodes;

  int hashCode() {
    return Integer.hashCode(idx);
  }

  @Override 
    boolean equals(Object o) {
    if (o instanceof Node) {
      if (((Node)o).idx == idx) {
        return true;
      }
    }

    return false;
  }


  Node(int NA, int x, int y, Node[][] nodes) {
    this.nodes = nodes;
    this.x = x;
    this.y = y;
    this.na = NA;
    this.idx = y * NA + x;
  }

  float getPX(float NW) {
    return (NW / 2) + (x * NW);
  }

  float getPY(float NH) {
    return (NH / 2) + (y * NH);
  }

  void setNeighbours(boolean force) {

    if (random(1) < 0.125) {
      setNeighbour(x+1, y, force);
    }

    if (random(1) < 0.125) {
      setNeighbour(x, y+1, force);
    }


    if (random(1) < 0.125) {
      setNeighbour(x-1, y, force);
    }



    if (random(1) < 0.125) {
      setNeighbour(x, y-1, force);
    }
  }

  void setNeighbour(int nx, int ny, boolean force) {
    if (neighbours.size() < neighbourLimit || force) {
      if (!OOB(nx, ny)) {
        Node n = nodes[nx][ny];
        if (!n.equals(this)) {
          if (!neighbours.contains(n)) {
            neighbours.add(n);
          }

          if (!n.neighbours.contains(this)) {
            n.neighbours.add(this);
          }
        }
      }
    }
  }
}
