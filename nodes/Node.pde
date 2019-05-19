int NODE_ID = 0;
class Node {

  PVector pos;
  int x,  y;
  int id;
  Node[] neighbours;
  {
    NODE_ID += 1;
    id = NODE_ID;
  }
  
  Node(int x, int y) {
    this.x = x;
    this.y = y;
    float xx = (x * tileSize) + (tileSize / 2);
    float yy = (y * tileSize) + (tileSize / 2);
    pos = new PVector(xx,yy);
    neighbours = new Node[8];
    
  }
  
  void draw() {
    stroke(255);
    fill(255);
    ellipse(pos.x, pos.y, 4, 4);
    for (int i = 0; i < neighbours.length; i += 1) {
      if (neighbours[i] != null) {
        line(pos.x, pos.y, neighbours[i].pos.x, neighbours[i].pos.y);
      }
    }
  }
  
  void findNeighbours() {
    //println("finding neighbours for " + id);
    int index = 0;
    for (int i = -1; i < 2; i += 1) {
      int xx = x + i;
      if (xx < 0 || xx > nodes.length - 1) continue;
      for (int j = -1; j < 2; j += 1) {
        int yy = y + j;
        
        if ((xx == x && yy == y) || yy < 0 || yy > nodes[0].length - 1) continue;
        
        neighbours[index] = nodes[xx][yy];
        index += 1;
        //println("\tadded " + nodes[xx][yy].id);
        
      }
    }
  }
}

Node[][] nodes;