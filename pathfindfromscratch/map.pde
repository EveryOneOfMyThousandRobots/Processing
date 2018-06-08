int nodeDist = 30;
float nodeVar = 5;
float searchDist = 35;
class Map {

  ArrayList<Node> nodes = new ArrayList<Node>();


  Map() {
    for (float x = nodeDist / 2; x < width; x += nodeDist) {
      for (float y = nodeDist / 2; y < width; y += nodeDist) {

        float xx = x + random(-nodeVar, nodeVar);
        float yy = y + random(-nodeVar, nodeVar);
        Node n = new Node(xx, yy, this);
        nodes.add(n);
      }
    }
  }

  void findNeighbours() {
    for (Node n : nodes) {
      n.findNeighbours();
    }
  }





  void draw() {
    for (Node n : nodes) {
      n.draw();
      if (n.traffic > 255) n.traffic = 255;
      n.traffic -= 0.01;
      if (n.traffic < 0) n.traffic = 0;
    }
  }
}
Map map;

int NODE_ID = 0;

class Node {
  final int id;
  {
    NODE_ID += 1;
    id = NODE_ID;
  }
  Map map;
  float traffic = 0;

  boolean equals(Node o) {
    if (o.id == this.id) return true;
    return false;
  }

  int hashCode() {

    return this.id;
  }

  PVector pos;
  ArrayList<Node> neighbours = new ArrayList<Node>();
  Node(float x, float y, Map map) {
    pos = new PVector(x, y);
    this.map = map;
  }

  String toString() {
    return "node (" + id + ")@(" + floor(pos.x) + "," + floor(pos.y) + ")";
  }

  void draw() {
    stroke(255);
    for (Node o : neighbours) {
      line(pos.x, pos.y, o.pos.x, o.pos.y);
    }
    fill(255);
    ellipse(pos.x, pos.y, 4, 4);
    fill(traffic, 0, 0 );
    ellipse(pos.x, pos.y, 4, 4);
  }

  void findNeighbours() {
    for (Node n : map.nodes) {
      if (n.id == this.id) continue;

      if (PVector.dist(n.pos, this.pos) <= searchDist) {
        neighbours.add(n);
      }
    }
  }
}
