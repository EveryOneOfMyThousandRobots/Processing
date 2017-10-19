enum NodeType {
  ANY, N, S, E, W, WALL;
}

class Node {
  float f, g, h, cost;
  int id = getId("NODE");
  int ix, iy;
  PVector pos;
  NodeType type;
  ArrayList<Node> neighbours = new ArrayList<Node>();
  Node previous = null;
  int colour;
  PVector targetPos;
  int occupiedCarId = -1;
  float traffic = 0;
  boolean endLine;

  String toString() {
    return id + " (" + ix + "," + iy + ") (" + pos.x + "," + pos.y + ")" + 
      ", t:"+type + ", n:" + neighbours.size() + " p:" + (previous != null ? previous.id : 0) + 
      "targetPos: (" + targetPos.x + "," + targetPos.y + "), cost: " + cost;
  }

  Node copy() {
    Node n = new Node(this.ix, this.iy, this.type, this.colour);
    n.id = this.id;
    n.cost = this.cost;
    n.traffic = this.traffic;
    return n;
  }

  int hashCode() {
    return 31 + (id * 17);
  }

  boolean equals(Node o) {
    if (this.id == o.id) {
      return true;
    } else {
      return false;
    }
  }

  void getJunction(ArrayList<Node> junctionNodes) {

    if (type == NodeType.ANY) {
      if (!junctionNodes.contains(this)) {
        junctionNodes.add(this);

        getNeighbour(0, -1).getJunction(junctionNodes);
        getNeighbour(0, 1).getJunction(junctionNodes);
        getNeighbour(-1, 0).getJunction(junctionNodes);
        getNeighbour(1, 0).getJunction(junctionNodes);
      }
    }
  }

  Node (int ix, int iy, NodeType type, int colour) {
    this.ix = ix;
    this.iy = iy;
    pos = new PVector(ix * RES, iy * RES);
    targetPos = pos.copy();
    targetPos.x += float(RES) / 2.0;
    targetPos.y += float(RES) / 2.0;
    this.type = type;
    this.colour = 0xff000000 + (0xffffff & colour);
  }

  Node getNeighbour(int ixa, int iya) {
    ixa = ix + ixa;
    iya = iy + iya;
    if (ixa >= 0 && ixa < COLS && iya >= 0 && iya < ROWS) {
      return nodes[ixa][iya];
    } else {
      return null;
    }
  }

  void checkLines() {
    Node n = null;
    endLine = false;
    switch (type) {
    case WALL:
      break;
    case ANY:
      break;
    case N:
      n = getNeighbour(0, -1);
      break;
    case S:
      n = getNeighbour(0, 1);
      break;
    case E:
      n = getNeighbour(1, 0);
      break;
    case W:
      n = getNeighbour(-1, 0);
      break;
    default:
    }

    if (n != null && n.type != type) {
      endLine = true;
    }
  }

  void addNeighbourIfType(int ixa, int iya, ArrayList<Node> nodelist, NodeType... nTypes) {
    ixa = ix + ixa;
    iya = iy + iya;
    if (ixa >= 0 && ixa < COLS && iya >= 0 && iya < ROWS) {
      Node n = nodes[ixa][iya];
      for (NodeType nt : nTypes) {
        if (n.type == nt) {
          if (!nodelist.contains(n)) {
            nodelist.add(n);
          }
          break;
        }
      }
    }
  }


  void addNeighbourIfType(int ixa, int iya, NodeType... nTypes) {
    addNeighbourIfType(ixa, iya, neighbours, nTypes );
    //ixa = ix + ixa;
    //iya = iy + iya;
    //if (ixa >= 0 && ixa < COLS && iya >= 0 && iya < ROWS) {
    //  Node n = nodes[ixa][iya];
    //  if (n.type == nType) {
    //    neighbours.add(n);
    //  }
    //}
  }
  void addNeighbour(int ixa, int iya) {
    ixa = ix + ixa;
    iya = iy + iya;
    if (ixa >= 0 && ixa < COLS && iya >= 0 && iya < ROWS) {
      Node n = nodes[ixa][iya];

      neighbours.add(n);
    }
  }

  void draw() {
    stroke(255);

    pushMatrix();
    translate(pos.x, pos.y);

    switch (type) {
    case WALL:
      image(wall, 0, 0);

      break;
    case ANY:
      image(blankRoad, 0, 0);

      break;
    case N:
      image(northRoad, 0, 0);
      if (endLine) {

        line(0, 0, RES, 0);
      }
      break;
    case S:

      rotate(PI);
      image(northRoad, -RES, -RES);
      if (endLine) {
        line(-RES-1, -RES-1, -1, -RES-1);
      }
      break;
    case E:
      rotate(HALF_PI);
      image(northRoad, 0, -RES);
      if (endLine) {
        line(0, -RES, RES, -RES);
      }
      break;
    case W:
      rotate(-HALF_PI);
      image(northRoad, -RES, 0);
      if (endLine) {
        line(-RES, 0, 0, 0);
      }
      break;
    default:
    }

    popMatrix();
    noStroke();
    float alpha = map(traffic, 0, map.highestTraffic, 0, 128);
    fill(255, 0, 0, alpha);
    rect(pos.x, pos.y, RES, RES);
    //rect(pos.x, pos.y, RES, RES);
  }

  void findNeighbours() {
    neighbours.clear();
    switch (type) {
    case WALL:
      break;
    case ANY:
      addNeighbourIfType(0, -1, NodeType.ANY, NodeType.N, NodeType.E, NodeType.W);
      addNeighbourIfType(0, 1, NodeType.ANY, NodeType.S, NodeType.E, NodeType.W);
      addNeighbourIfType(-1, 0, NodeType.ANY, NodeType.S, NodeType.N, NodeType.W);
      addNeighbourIfType(1, 0, NodeType.ANY, NodeType.S, NodeType.N, NodeType.E);
      break;
    case N:
      addNeighbour(0, -1);
      addNeighbourIfType(-1, 0, NodeType.W);
      addNeighbourIfType(1, 0, NodeType.E);
      break;
    case S:
      addNeighbour(0, 1);
      addNeighbourIfType(-1, 0, NodeType.W);
      addNeighbourIfType(1, 0, NodeType.E);
      break;
    case E:
      addNeighbour(1, 0);
      addNeighbourIfType(0, -1, NodeType.N);
      addNeighbourIfType(0, 1, NodeType.S);
      break;
    case W:
      addNeighbour(-1, 0);
      addNeighbourIfType(0, -1, NodeType.N);
      addNeighbourIfType(0, 1, NodeType.S);
      break;
    default:
    }
  }
}