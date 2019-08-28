int NODE_ID = 0;
class Node {
  final int id;
  {
    NODE_ID += 1;
    id = NODE_ID;
  }
  
  int hashCode() {
    return id;
  }
  
  boolean equals(Node o) {
    return (this.id == o.id);
  }
  
  String toString() {
    return "Node (" + id + ") (" + int(pos.x) + "," + int(pos.y) + ") n:" + neighbours.size();
  }
  
  void draw() {
    stroke(255);
    noFill();
    ellipse(pos.x, pos.y, 4, 4);
    
    for (Node n : neighbours) {
      line(pos.x, pos.y, n.pos.x, n.pos.y);
    }
    
  }
  
  
  
  PVector pos;
  private ArrayList<Node> neighbours = new ArrayList<Node>();

  Node(float x, float y) {
    pos = new PVector(x,y);
  }
  
  void addAllNeighbours(ArrayList<Node> nodes) {
    for (Node n : nodes) {
      addNeighbour(n);
    }
  }
  
  void addNeighbour(Node n ) {
    if (n.equals(this)) return;
    //if (neighbours.size() > 3) return;
    if (!neighbours.contains(n)) {
      neighbours.add(n);
    }
    //n.addNeighbour(this);
  }
}
