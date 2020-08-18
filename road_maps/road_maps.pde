

boolean OOB(int x, int y) {
  return (x < 0 || x > TA - 1 || y < 0 || y > TD-1);
}

Node[][] nodes;
final int NODE_DIST = 100;
int TA, TD;
void setup() {
  size(800, 800);
  TA = width / NODE_DIST;
  TD = height / NODE_DIST;

  nodes = new Node[TA][TD];

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      nodes[x][y] = new Node(x, y);
    }
  }

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      nodes[x][y].setNeighbours();
    }
  }
}

Node pathStart, pathEnd;
PathFinder path;

Node getRandomNode() {
  int xx = floor(random(TA));
  int yy = floor(random(TD));

  return nodes[xx][yy];
}
void mouseReleased() {
  pathStart = getRandomNode();
  pathEnd = null;
  while(pathEnd == null) {
    pathEnd = getRandomNode();
    if (pathEnd.equals(pathStart)) {
      pathEnd = null;
    }
    
  }
  println("finding new path from " + pathStart + " to " + pathEnd);
  path = new PathFinder(pathStart, pathEnd);
  if (!path.findPath()) {
    println("could not find path");
    path = null;
  } else {
    println("path length = " + path.path.size());
  }
}

void draw() {
  background(0);

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      nodes[x][y].draw();
    }
  }
  
  if (path != null && pathStart != null && pathEnd != null) {
    
    noFill();
    PVector prev = null;
    for (Node n : path.path) {
      stroke(255,0,0);
      ellipse(n.pos.x, n.pos.y, 5, 5);
      
      if (prev != null) {
        stroke(255,128);
        strokeWeight(2);
        line(prev.x, prev.y, n.pos.x, n.pos.y);
        strokeWeight(1);
      }
      prev = n.pos;
    }
  }
}
