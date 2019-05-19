int NODE_ID = 0;
final int GRID_SIZE = floor(RESOURCE_SIZE);
Node[][] nodes;

void buildNodes() {
  nodes = new Node[GAME_WINDOW.width / GRID_SIZE][GAME_WINDOW.height / GRID_SIZE];

  for (int x = 0; x < nodes.length; x += 1) {
    for (int y = 0; y < nodes[x].length; y += 1) {
      nodes[x][y] = new Node(x, y);
    }
  }
}

void setCosts() {
  for (Resource r : resources.resources) {
    if (r.type.solid) {
      Node n = getNodeFromCoords(r.pos.x, r.pos.y);

      if (n != null) {
        n.cost = 100;
      }
    }
  }
}

Node getNodeFromCoords(float x, float y ) {
  int xx = floor(x / GRID_SIZE);
  int yy = floor(y / GRID_SIZE);

  return getNode(xx, yy);
}

Node getNodeFromCoords(PVector pos ) {
  return getNodeFromCoords(pos.x, pos.y);
}

Node getNode(int x, int y) {
  if (x < 0 || x > nodes.length-1 || y < 0 || y > nodes[0].length-1) {
    return null;
  }
  return nodes[x][y];
}

Node getRandomNode() {
  int x = floor(random(nodes.length));
  int y = floor(random(nodes[x].length));

  return getNode(x, y);
}

void setNeighbours() {
  for (int x = 0; x < nodes.length; x += 1) {
    for (int y = 0; y < nodes[x].length; y += 1) {
      nodes[x][y].setNeighbours();
    }
  }
}
class Node {
  final int id;
  PVector pos, cornerPos;
  ArrayList<Node> neighbours;
  float cost = 1;
  final int x, y;
  boolean wall = false;
  boolean exclusionZone = false;
  boolean chest = false;
  boolean robot_start = false;
  {
    NODE_ID += 1;
    id = NODE_ID;
  }

  Node(int x, int y) {
    this.x = x;
    this.y = y;
    neighbours = new ArrayList<Node>();
    pos = new PVector((x * GRID_SIZE) + (GRID_SIZE / 2), (y * GRID_SIZE) + (GRID_SIZE / 2));
    cornerPos = new PVector(x * GRID_SIZE, y * GRID_SIZE);
  }

  boolean equals(Node o) {
    return o.id == id;
  }

  int hashCode() {
    return id * 11;
  }

  void draw() {
    color c = color(map(cost, 1, Float.MAX_VALUE/2, 0, 255)); 
    stroke(c);
    fill(c);
    ellipse(pos.x, pos.y, 4, 4);
    //stroke(255,0,255);
    //for (Node n : neighbours) {
    //  line(pos.x, pos.y, n.pos.x, n.pos.y);
    //}
  }

  void setNeighbours() {
    if (wall) return;
    for (int xx = x-1; xx <= x+1; xx += 1) {

      for (int yy = y-1; yy <= y+1; yy += 1) {
        if (xx == x && yy == y) continue;
        Node n = getNode(xx, yy);
        if (n != null) {
          if (n.wall) continue;

          neighbours.add(n);
        }
      }
    }
  }
}
