ArrayList<Node> nodes = new ArrayList<Node>();
ArrayList<Conn> connections = new ArrayList<Conn>();
int numNodes = 10;
void initNodes() {
  while (nodes.size() < numNodes) {
    nodes.add(new Node());
  }
}

void drawNodes() {
  for(Node n : nodes) {
    n.draw();
  }
}

void checkIntersects() {
  for (int i = 0; i < connections.size(); i += 1) {
    Conn A = connections.get(i);
    for (int j = i + 1; j < connections.size(); j += 1) {
      Conn B = connections.get(j);
      if (intersects(A.from.pos, A.to.pos, B.from.pos, B.to.pos)) {
        A.col = color(255,0,0);
        B.col = color(255,0,0);
        
      }
      
    }
  }
}

void drawLines(){
  for (Conn con : connections) {
    con.draw();
  }
}
class Conn {
  Node from = null;
  Node to = null;
  color col = color(0);
  Conn(Node from, Node to) {
    this.from = from;
    this.to = to;
  }
  
  void draw() {
    stroke(col);
    line(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
  }
}
int NODE_ID = 0;
class Node {
  PVector pos;
  final int nodeId;
  
  Node() {
    pos= new PVector(random(width), random(height));
    NODE_ID += 1;
    nodeId = NODE_ID;
  }
  
  
  void draw() {
    stroke(0);
    fill(255);
    ellipse(pos.x, pos.y, 10,10);
    
  }
  
}

void findConnections() {
  for (int i = 0; i < nodes.size(); i += 1) {
    Node from = nodes.get(i);
    for (int j = i+1; j < nodes.size(); j += 1) {
      Node to = nodes.get(j);
      connections.add(new Conn(from, to));
      
    }
  }
}