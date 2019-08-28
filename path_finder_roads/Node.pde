import java.util.HashSet;
int NODE_ID = 0;

Node[][] makeNodes() {
  Node[][] nodes = new Node[tiles.length][tiles[0].length];

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      nodes[x][y] = new Node(nodes, x, y, tiles[x][y]);
    }
  }

  for (int x = 0; x < nodes.length; x += 1) {
    for (int y = 0; y < nodes[x].length; y += 1) {
      nodes[x][y].addNeighbours();
    }
  }

  return nodes;
}
class Node {
  final int id; 

  {
    NODE_ID += 1; 
    id = NODE_ID;
  }
  int x, y; 
  Tile tile; 
  HashSet<Node> neighbours = new HashSet<Node>(4); 
  Node[][] nodes; 
  PVector pos;

  Node(Node[][] nodes, int x, int y, Tile tile) {
    this.x = x; 
    this.y = y; 
    this.nodes = nodes; 
    this.tile = tile;
    pos = new PVector(tile.pos.x + (tile.dims.x / 2), tile.pos.y + (tile.dims.y / 2));
  }

  void addNeighbours() {
    addNeighbour(x-1, y); 
    addNeighbour(x, y-1); 
    addNeighbour(x+1, y); 
    addNeighbour(x, y+1);
  }

  void addNeighbour(int x, int y) {
    if (tile.isWall) return;
    Node n = getNode(x, y); 
    if (n != null) {
      if (!n.tile.isWall) {
        neighbours.add(n);
      }
    }
  }

  int hashCode() {
    return id;
  }

  boolean equals(Node n ) {
    return n.id == id;
  }
  
  String toString() {
    return "Node (" + id + ") (" + x + "," + y + ") (" + pos.x +","+ pos.y + ")";
  }

  Node getNode(int x, int y) {
    if (x < 0 || x > nodes.length-1 || y < 0 || y > nodes[0].length-1) {
      return null;
    } else {
      return nodes[x][y];
    }
  }
  
  void draw() {
    //noStroke();
    //fill(255,0,0);
    //ellipse(pos.x, pos.y, 4, 4);
    stroke(255,0,0);
    for (Node n : neighbours) {
      line(pos.x, pos.y, n.pos.x, n.pos.y); 
    }

  }
}
