final int GREEN = 0x00ff00;
final int WHITE = 0xffffff;
final int BLUE = 0x0000ff;
final int RED = 0xff0000;
final int CYAN = 0x00ffff;
final int BLACK = 0x000000;

class Map {

  float highestTraffic = 10;

  void checkTraffic() {
    highestTraffic = 0;
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        Node n = nodes[ix][iy];
        if (n.traffic > highestTraffic) {
          highestTraffic = n.traffic;
        }
      }
    }
    if (highestTraffic == 0) highestTraffic = 1;
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        Node n = nodes[ix][iy];
        n.cost = pow(2 + (n.traffic / highestTraffic), 10);
      }
    }
  }
  Node getRandomEmpty() {
    Node n = null;
    while (n == null) {
      int xx = floor(random(COLS));
      int yy = floor(random(ROWS));
      n = nodes[xx][yy];
      if (n.type == NodeType.WALL) {
        n = null;
      }
    }

    return n;
  }

  Map() {
    nodes = new Node[imgWidth][imgHeight];
    lvlImage.loadPixels();
    for (int ix = 0; ix < lvlImage.width; ix += 1) {
      for (int iy = 0; iy < lvlImage.height; iy += 1) {
        int pix = lvlImage.get(ix, iy) & 0xffffff;
        NodeType type = NodeType.ANY; //default to any

        if (pix == GREEN) {
          type = NodeType.E;
        } else if (pix == BLUE) {
          type = NodeType.W;
        } else if (pix == WHITE) {
          type = NodeType.N;
        } else if (pix == CYAN) {
          type = NodeType.S;
        } else if (pix == BLACK) {
          type = NodeType.WALL;
        }


        Node n = new Node(ix, iy, type, pix);
        nodes[ix][iy] = n;
      }
    }
    checkLines();
  }

  void checkLines() {
    //rectMode(CORNER);
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        nodes[ix][iy].checkLines();
      }
    }
  }

  NodeType getNodeTypeAtPos(PVector pos) {
    int xx = floor(pos.x / RES);
    int yy = floor(pos.y / RES);
    return nodes[xx][yy].type;
  }
  int getIdAtPos(PVector pos) {
    int xx = floor(pos.x / RES);
    int yy = floor(pos.y / RES);
    return nodes[xx][yy].id;
  }

  void draw() {
    rectMode(CORNER);
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        nodes[ix][iy].draw();
      }
    }
  }

  void clearOccupied() {
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        Node n = nodes[ix][iy];
        n.occupiedCarId = -1;
        n.traffic = lerp(n.traffic, 0, 0.01);
        if (n.traffic < 0) n.traffic = 0;
      }
    }
  }

  Node getNodeAtPos(PVector pos) {
    return getNodeAtPos(pos.x, pos.y);
  }

  Node getNodeAtPos(float x, float y) {
    int xx = floor(x / RES);
    int yy = floor(y / RES);
    return nodes[xx][yy];
  }

  boolean isOccupied(PVector pos) {
    //int xx = floor(pos.x / RES);
    //int yy = floor(pos.y / RES);
    return getNodeAtPos(pos).occupiedCarId > -1;
  }

  int isOccupiedBy(PVector pos) {
    //int xx = floor(pos.x / RES);
    //int yy = floor(pos.y / RES);
    return getNodeAtPos(pos).occupiedCarId;
  }

  void setOccupied(Car car) {
    //int xx = floor(car.pos.x / RES);
    //int yy = floor(car.pos.y / RES);
    Node n = getNodeAtPos(car.pos);
    n.occupiedCarId = car.id;
    if (n.type == NodeType.ANY) {
      ArrayList<Node> junction = new ArrayList<Node>();
      n.getJunction(junction);
      for (Node nn : junction) {
        nn.occupiedCarId = car.id;
        nn.traffic += 1;
        if (nn.traffic > 100) {
          nn.traffic = 100;
        }
      }
    } else {
      n.traffic += 1;
      if (n.traffic > 100) {
        n.traffic = 100;
      }
    }
  }

  String toString() {
    String output = "";
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        output += "\n[" + ix + "][" + iy + "]: " + nodes[ix][iy];
      }
    }
    return output;
  }

  void setOccupied() {
    for (Car car : cars) {
      setOccupied(car);
    }
  }

  void findNeighbours() {
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        nodes[ix][iy].findNeighbours();
      }
    }
  }
}