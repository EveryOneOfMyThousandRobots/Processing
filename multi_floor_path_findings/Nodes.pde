int Node_Id = 0;
class Node implements Comparable<Node> {
  final int x, y;
  final int id;
  {
    Node_Id += 1;
    id = Node_Id;
  }
  PVector pos;
  final Tile parentTile;
  ArrayList<Node> neighbours = new ArrayList<Node>();
  Node(Tile parentTile, int x, int y) {
    this.parentTile = parentTile;
    this.x = x;
    this.y = y;
  }

  int hashCode() {
    return ((Integer)id).hashCode();
  }
  void addNeighbour(Node n) {
    if (!neighbours.contains(n)) {
      neighbours.add(n);
    }
  }


  int compareTo(Node node) {
    if (id == node.id) {
      return 0;
    } else {
      return Integer.compare(id, node.id);
    }
  }
  @Override
    boolean equals(Object o) {
    if (!(o instanceof Node)) {
      return false;
    } else {
      return ((Node)o).id == id;
    }
  }



  void draw() {
    if (pos == null) {
      pos = new PVector();
      pos.x = parentTile.pos.x + GUI_W + (x * ((float)TILE_W / (float)NODES_ACROSS));
      pos.y = parentTile.pos.y + (y * ((float)TILE_H / (float)NODES_DOWN));
    }

    stroke(0);
    fill(255, 255, 0);
    ellipse(pos.x - playXOffset, pos.y - playYOffset, 3, 3);

    for (Node n : neighbours) {
      stroke(255, 0, 0, 64);
      if (n.pos != null) {
        line(n.pos.x, n.pos.y, pos.x, pos.y);
        //int px = floor(pos.x - playXOffset);
        //int py = floor(pos.y - playYOffset);
        //int nx = floor(n.pos.x - playXOffset);
        //int ny = floor(n.pos.y - playYOffset);
        //if (nx < px && py == ny) {
        //  //println("drawing left neighbour");
        //  line(px, py-1, nx, ny-1);
        //} else if (nx > px && py == ny) {
        //  //println("drawing right neighbour");
        //  line(px, py+1, nx, ny+1);
        //} else if (ny < py && px == nx) {
        //  //println("drawing up neighbour");
        //  line(px-1, py, nx-1, ny);
        //} else if (ny > py && px == nx) {
        //  //println("drawing down neighbour");
        //  line(px+1, py, nx+1, ny);
        //} else if (nx < px &&{
        //  //println("something else");
        //}
      }
    }
  }
}






HashMap<TT, NodeMap> nodemaps = new HashMap<TT, NodeMap>();

void makeNodeMaps() {

  nodemaps.put(TT.SKY, new NodeMap(TT.SKY));
  nodemaps.put(TT.STAIRWELL, new NodeMap(TT.STAIRWELL));
  nodemaps.put(TT.GRASS, new NodeMap(TT.GRASS));
  nodemaps.put(TT.DIRT, new NodeMap(TT.DIRT));
  nodemaps.put(TT.ROOM, new NodeMap(TT.ROOM));
}

/*
u = up
d = down
l = left
r = right
1 = up-left
2 = up-right
3 = down-right
4 = down-left
    1____U____2 
     \   |   /
      \  |  /
       \ | /
    L_________R
       / | \
      /  |  \
     /   |   \
    4____D____3
      
      
    


*/
//           "________"
final String NO_CONNECT = "________";
class NodeMap {
  String[] map;
  TT type;

  NodeMap(TT type) {
    this.type = type;


    switch (type) {
    case STAIRWELL:
      {
        String[] m = {
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, "23______", NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, "14______", NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, "23______", NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
          "LR______", "LR______", "LR______", "LR______", "LR______", "LR______", "LR14____", "LR______", "LR______", "LR______", "LR______", "LR______",
          
        };
        map = m;
      }
      break;
    case ROOM:  
    case GRASS:
      {
        String[] m = {
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
          "LR______", "LR______", "LR______", "LR______", "LR______", "LR______", "LR4_____", "LR______", "LR______", "LR______", "LR______", "LR______",
        };
        map = m;
      }
      break;
    case DIRT:
    case SKY:
      {
        String[] m = {
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT,  
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
          NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, NO_CONNECT, 
        };
        map = m;
      }

      break;
    }
  }
}

class Edge {
}
