enum TT {
  DIRT, 
    GRASS, 
    SKY, 
    ROOM, 
    STAIRWELL
}
enum DIR {
    DIR_UP, 
    DIR_DOWN, 
    DIR_LEFT, 
    DIR_RIGHT,
    DIR_UPLEFT,
    DIR_UPRGHT,
    DIR_DNLEFT,
    DIR_DNRGHT,
}

void setTileNeighbours() {
  //draw tiles
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile tile = tiles[x][y];
      tile.setNeighbour(DIR.DIR_LEFT, x-1, y);
      tile.setNeighbour(DIR.DIR_RIGHT, x+1, y);
      tile.setNeighbour(DIR.DIR_UP, x, y-1);
      tile.setNeighbour(DIR.DIR_DOWN, x, y+1);
      
      tile.setNeighbour(DIR.DIR_UPLEFT,x-1,y-1);
      tile.setNeighbour(DIR.DIR_UPRGHT,x+1,y-1);
      tile.setNeighbour(DIR.DIR_DNLEFT,x-1,y+1);
      tile.setNeighbour(DIR.DIR_DNRGHT,x+1,y+1);
    }
  }
}



class Tile {
  HashMap<DIR, Tile> neighbours = new HashMap<DIR, Tile>();
  ArrayList<Tile> neighbourList = new ArrayList<Tile>();
  PVector pos;
  int x, y;
  TT type;
  NodeMap nodeMap;
  ArrayList<Node> nodeList = new ArrayList<Node>();
  Node[][] nodes;
  
  boolean hasJob = false;
  
  //final int NODE_A;
  //final int NODE_D;
  Tile(int x, int y, TT type) {
    this.x = x;
    this.y = y;
    pos = new PVector(x * TILE_W, y * TILE_H);
    this.type = type;
    nodeMap = nodemaps.get(type);
    //NODE_A = nodeMap.map.length;
    //NODE_D = nodeMap.map[0].length;
    makeNodes();
  }

  Node getRandomNode() {
    if (nodeList.size() == 0) {
      return null;
    }
    return nodeList.get(floor(random(nodeList.size())));
  }

  String toString() {
    return "[" + type + "](" + x + "," + y + ")";
  }

  String toString(boolean showNeighbours) {
    if (showNeighbours) {
      String output = toString();
      output += "\nneighbours:";
      if (neighbours.containsKey(DIR.DIR_UP)) {
        output += "\n\t" + neighbours.get(DIR.DIR_UP).toString();
      }

      if (neighbours.containsKey(DIR.DIR_DOWN)) {
        output += "\n\t" + neighbours.get(DIR.DIR_DOWN).toString();
      }

      if (neighbours.containsKey(DIR.DIR_LEFT)) {
        output += "\n\t" + neighbours.get(DIR.DIR_LEFT).toString();
      }

      if (neighbours.containsKey(DIR.DIR_RIGHT)) {
        output += "\n\t" + neighbours.get(DIR.DIR_RIGHT).toString();
      }


      return output;
    } else {
      return toString();
    }
  }

  void setNeighbour(DIR direction, int xx, int yy) {
    if (xx == x && yy == y) return;
    Tile t = getTileAtIndex(xx, yy);

    if (t != null) {
      neighbourList.add(t);
      neighbours.put(direction, t);
    }
  }

  boolean onScreen(float x1, float y1, float x2, float y2) {
    return pos.x >= x1 && pos.x <= x2 && pos.y >= y1 && pos.y <= y2;
  }

  void makeNodes() {
    nodes = new Node[NODES_ACROSS][NODES_DOWN];
    //nodesDir = new int[NODES_ACROSS][NODES_DOWN];
    for (int x = 0; x < NODES_ACROSS; x += 1) {
      for (int y = 0; y < NODES_DOWN; y += 1) {
        String n = nodeMap.map[y * NODES_ACROSS + x];
        if (!n.equals(NO_CONNECT)) {
          nodes[x][y] = new Node(this, x, y);
          nodeList.add(nodes[x][y]);
          //nodesDir[x][y] = n;
        } else {
          nodes[x][y] = null;
          //nodesDir[x][y] = 0;
        }
      }
    }
  }
  boolean nodeOOB(int x, int y) {
    return x < 0 || x > NODES_ACROSS - 1 || y < 0 || y > NODES_DOWN - 1;
  }


  Node getLocalNodeAt(int x, int y) {
    if (!nodeOOB(x, y)) {
      return nodes[x][y];
    } else {
      return null;
    }
  }


  boolean In(String searchFor, String searchIn) {
    return searchIn.toUpperCase().lastIndexOf(searchFor.toUpperCase()) >= 0;
  }

  void setNodeNeighbours() {
    for (int x = 0; x < NODES_ACROSS; x += 1) {
      for (int y = 0; y < NODES_DOWN; y += 1) {
        Node n = nodes[x][y];
        if (n != null) {
          String d = nodeMap.map[y * NODES_ACROSS + x];
          if (In("L",d))
            addNodeNeighbour(n, x-1, y);

          if (In("R",d)) 
            addNodeNeighbour(n, x+1, y);

          if (In("U",d))
            addNodeNeighbour(n, x, y-1);
            
          if (In("D",d)) 
            addNodeNeighbour(n, x, y+1);
            
          if (In("1",d)) 
            addNodeNeighbour(n, x-1, y-1);
            
          if (In("2",d)) 
            addNodeNeighbour(n, x+1,y-1);
            
          if (In("3",d)) 
            addNodeNeighbour(n, x+1,y+1);            
            
          if (In("4",d)) 
            addNodeNeighbour(n, x-1, y+1);
            
            
            
          
          
        }
      }
    }
  }

  void addNodeNeighbour(Node n, int x, int y) {
    Node neighbourToAdd = null;
    if (n != null) {
      if (!nodeOOB(x, y)) {
        neighbourToAdd = getLocalNodeAt(x, y);
      } else {
        Tile nghbTile = null;
        int xToCheck = -1;
        int yToCheck = -1;

        if (x < 0                     && y < 0) {
          nghbTile = getNeighbour(DIR.DIR_UPLEFT);
          xToCheck = NODES_ACROSS-1;
          yToCheck = NODES_DOWN-1;
        } else if (x > NODES_ACROSS-1 && y > NODES_DOWN - 1) {
          nghbTile = getNeighbour(DIR.DIR_DNRGHT);
          xToCheck = 0;
          yToCheck = 0;          
        } else if (x < 0              && y > NODES_DOWN - 1) {
          nghbTile = getNeighbour(DIR.DIR_DNLEFT);
          xToCheck = NODES_ACROSS-1;
          yToCheck = 0;
        } else if (x > NODES_ACROSS-1 && y < 0) {
          nghbTile = getNeighbour(DIR.DIR_UPRGHT);
          xToCheck = 0;
          yToCheck = NODES_DOWN-1;          
        } else if (x < 0) {
          nghbTile = getNeighbour(DIR.DIR_LEFT);
          xToCheck = NODES_ACROSS -1;
          yToCheck = y;
        } else if (x > NODES_ACROSS-1) {
          nghbTile = getNeighbour(DIR.DIR_RIGHT);
          xToCheck = 0;
          yToCheck = y;
        } else if (y < 0) {
          nghbTile = getNeighbour(DIR.DIR_UP);
          xToCheck = x;
          yToCheck = NODES_DOWN-1;
        } else if (y > NODES_DOWN - 1) {
          nghbTile = getNeighbour(DIR.DIR_DOWN);
          xToCheck = x;
          yToCheck = 0;
        }

        if (nghbTile != null && xToCheck >= 0 && yToCheck >= 0) {
          neighbourToAdd = nghbTile.getLocalNodeAt(xToCheck, yToCheck);
        }
      }
      if (neighbourToAdd != null) {
        n.neighbours.add(neighbourToAdd);
      }
    }
  }

  Tile getNeighbour(DIR direction) {
    if (neighbours.containsKey(direction)) {
      return neighbours.get(direction);
    } else {
      return null;
    }
  }



  void update() {
  }


  void drawSelected() {
    this.draw();
    noFill();
    strokeWeight(3);
    stroke(255);
    rect(pos.x - playXOffset + GUI_W, pos.y - playYOffset, TILE_W, TILE_H);
    strokeWeight(1);
  }
  void draw() {
    stroke(255);
    switch (type) {
    case DIRT:
      fill(50, 20, 20);
      break;
    case GRASS:
      fill(10, 100, 30);
      break;
    case SKY:
      fill(10, 50, 200);
      break;
    case ROOM:
      fill(51);
      break;
    case STAIRWELL:
      fill(100);
      break;
    default:
      fill(255, 0, 0);
      break;
    }
    rect(pos.x - playXOffset + GUI_W, pos.y - playYOffset, TILE_W, TILE_H);
    
    if (hasJob) {
      stroke(255,128);
      fill(255,128);
      ellipse(pos.x - playXOffset + ( TILE_W / 2), pos.y - playYOffset + (TILE_H / 2), (TILE_H / 2), (TILE_H/2));
    }

    for (int x = 0; x < NODES_ACROSS; x += 1) {
      for (int y = 0; y < NODES_DOWN; y += 1) {
        Node n = nodes[x][y];
        if (n != null) {

          n.draw();
        }
      }
    }
  }
}

boolean OOB(int x, int y) {
  return !(x >= 0 && x < TILES_ACROSS && y >= 0 && y < TILES_DOWN);
}

Tile getTileAtIndex(int x, int y) {
  if (!OOB(x, y)) {
    return tiles[x][y];
  } else {
    return null;
  }
}


Tile getTileAtScreenCoord(float x, float y) {
  int xx = screenToWorldXI(x) / TILE_W;
  int yy = screenToWorldYI(y) / TILE_H;

  if (!OOB(xx, yy)) {
    return tiles[xx][yy];
  } else {
    return null;
  }
}
