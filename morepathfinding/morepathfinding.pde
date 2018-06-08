float searchDist = 50;
int numNodes = 200;
QuadTree quad;
Finder finder;
ArrayList<Node> nodes = new ArrayList<Node>();
void setup() {
  size(500, 500);



  quad = new QuadTree(0, 0, width, height);
  for (int i = 0; i < numNodes; i += 1) {
    Node n = new Node(random(width), random(height));
    nodes.add(n);
    quad.addPoint(n);
  }

  for (int i = 0; i < nodes.size(); i += 1) {
    Node n = nodes.get(i);
    int counter = 0;
    while (n.neighbours.size() < 5) {
      ArrayList<Node> neighbours = getNodesInDist(n.pos.x, n.pos.y, searchDist + (counter * 5));



      if (neighbours.size() > 1) {
        n.addAllNeighbours(neighbours);
        //break;
      }
      counter += 1;
    }
  }

  checkIntersects();

  Node start = nodes.get(floor(random(nodes.size())));
  Node end = nodes.get(floor(random(nodes.size())));
  finder = new Finder(start, end);
  finder.findPath();
}

void draw() {
  background(0);

  for (Node n : nodes) {
    n.draw();
  }
  //quad.draw();
  finder.draw();
}

void checkIntersects() {
  boolean removed = false;
  for (int i = 0; i < nodes.size(); i += 1) {
    Node n = nodes.get(i);
    for (int k = n.neighbours.size()-1; k >= 0; k -= 1) {
      removed = false;
      Node nb = n.neighbours.get(k);
      for (int j = i+1; j < nodes.size(); j += 1) {
        Node n2 = nodes.get(j);



        for (int m = n2.neighbours.size()-1; m >= 0; m -= 1) {
          Node nb2 = n2.neighbours.get(m);


          if (nb.id == nb2.id) continue;
          if (linesIntersect(n.pos, nb.pos, n2.pos, nb2.pos)) {
            n.neighbours.remove(k);
            removed = true;
          }
          if (removed) break;
        }
        if (removed) break;
      }
    }
  }
}
