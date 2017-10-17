import java.util.Comparator;
import java.util.Collections;
ArrayList<Node> nodes = new ArrayList<Node>();
int NODE_ID = 0;
class Node implements Comparable<Node> {
  int id;
  PVector pos;

  ArrayList<Node> neighbours = new ArrayList<Node>();
  TreeMap

  Node(float x, float y) {
    pos = new PVector(x, y);
    NODE_ID += 1;
    id = NODE_ID;
  }

  void findNeighbours(ArrayList<Node> nodes) {
    //neighbours = new ArrayList
    neighbours.clear();
    for (Node node : nodes) {
      neighbours.add(node);
    }
    NodeComparator nc = new NodeComparator();
    nc.setParent(this);
    neighbours.sort(nc);

    //int count = neighbours.size();
    //int r1 = floor(random(1, neighbours.size()/2));

    for (int i = neighbours.size()-1; i >= 3; i -= 1) {
      neighbours.remove(i);
    }

    //for (
  }

  public int compareTo(Node node) {
    float comparison = PVector.dist(node.pos, pos);

    return int(comparison);
  }

  void draw() {
    stroke(0);
    fill(128, 100);
    ellipse(pos.x, pos.y, 10, 10);
    stroke(255, 0, 0);
    for (Node node : neighbours) {
      line(pos.x, pos.y, node.pos.x, node.pos.y);
    }
  }
}

class NodeComparator implements Comparator<Node> {
  Node parent;
  
  void setParent(Node parent) {
    this.parent = parent;
  }

  public int compare(Node n1, Node n2) {
    return parent.compareTo(n1);
  }
}
//Comparator<Node> NodeComparator = new Comparator<Node>() {

//  Node parent;
//  //public void setParent(Node parent) {
//  //  this.parent = parent;
//  //}
//  public int compare(Node n1, Node n2) {
//    return parent.compareTo(n2);
//  }

//};


void setup() {
  size(600, 600);
  for (int i = 0; i < 10; i += 1) {
    Node n = new Node(random(width), random(height));
    nodes.add(n);
  }

  for (Node n : nodes) {
    n.findNeighbours(nodes);
  }
}

void draw() {
  background(255);
  for (Node n : nodes) {
    n.draw();
  }
}