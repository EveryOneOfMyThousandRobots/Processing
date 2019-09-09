enum NodeType {
  WALL(1, 0xff000000), 
    BAY(0.5, 0xffcccc00), 
    PATH(0, 0xffaaaaaa),
    PICKUP(0,0xff00ff00),
    DROPOFF(0,0xffff0000)
    ;



  final float movementCost;
  final color col;
  private NodeType(float movementCost, color col) {
    this.movementCost = movementCost;
    this.col = col;
  }
}


void setNodeNeighbours() {
  for (int x = 0; x < NODES_ACROSS; x += 1) {
    for (int y = 0; y < NODES_DOWN; y += 1) {
      Node n = nodes[x][y];

      n.setNeighbours();
    }
  }
}

int taxiDist(int x1, int y1, int x2, int y2) {
  return abs(x1 - x2) + abs(y1 - y2);
}

boolean nOOB(int x, int y) {
  return (x < 0 || x > NODES_ACROSS-1 || y < 0 || y > NODES_DOWN-1);
}

Node getNode(int x, int y) {
  if (nOOB(x, y)) return null;

  return nodes[x][y];
}

Node getRandomNode() {
  Node n = null;

  while (n == null) {
    n = getNode(floor(random(NODES_ACROSS)), floor(random(NODES_DOWN)));
    if (n.type != NodeType.PATH) {
      n = null;
    }
  }


  return n;
}


boolean nodeBlocked(int x, int y) {
  Node n = getNode(x,y);
  if (n == null) return true;
  
  return n.type == NodeType.WALL;
}
class Node {
  final int x, y;
  PVector pos;
  PVector mPos;
  final NodeType type;
  ArrayList<Node> neighbours = new ArrayList<Node>();

  Node(int x, int y, NodeType type) {
    this.x = x;
    this.y = y;
    this.type = type;
    pos = new PVector(x * NODE_SIZE, y * NODE_SIZE);
    mPos = pos.copy();
    mPos.x += (NODE_SIZE/2);
    mPos.y += (NODE_SIZE/2);
  }

  void setNeighbours() {
    if (type == NodeType.WALL) return;
    for (int xx = x - 1; xx <= x + 1; xx += 1) {
      for (int yy = y - 1; yy <= y + 1; yy += 1) {
        if (xx == x && yy == y) continue;
        Node neighbour = getNode(xx, yy);
        if (neighbour != null) {
          int td = taxiDist(x, y, xx, yy);
          if (td == 2) {
            int xd = xx - x;
            int yd = yy - y;
            if (nodeBlocked(x,y+yd) || nodeBlocked(x+xd,y)) {
              
            } else {
              addNeighbour(xx,yy);
            }
          } else {

            addNeighbour(xx, yy);
          }
        }
      }
    }
  }
  
  

  void addNeighbour(int x, int y) {
    Node n = getNode(x, y);
    if (n != null) {
      if (n.type == NodeType.WALL) return;
      neighbours.add(n);
    }
  }

  void draw() {
    stroke(200);
    fill(type.col);
    rect(pos.x, pos.y, NODE_SIZE, NODE_SIZE);
    //stroke(255,0,0,32);
    //for (Node n : neighbours) {
    //  line(mPos.x, mPos.y, n.mPos.x, n.mPos.y);
    //}
  }

  int hashCode() {
    return str(y * NODES_ACROSS + x).hashCode();
  }


  @Override
    boolean equals(Object o) {
    if (!(o instanceof Node)) {
      return false;
    } else {
      Node n = (Node) o;
      return n.x == x && n.y == y;
    }
  }
}
