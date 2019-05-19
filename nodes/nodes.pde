int tileSize = 20;
int[][] tiles;

void setup () {
  size(400, 400);


  int w = ceil(float(width) / float(tileSize));
  int h = ceil(float(height) / float(tileSize));
  tiles = new int[w][h];
  nodes = new Node[w][h];

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      tiles[x][y] = color(random(255));
      Node n = new Node(x, y);
      nodes[x][y] = n;
    }
  }
  
  findNodeNeighbours();
}

void draw() {
  background(0);
  drawTiles();
  drawNodes();
}

void drawTiles() {

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      fill(tiles[x][y]);
      rect(x * tileSize, y * tileSize, tileSize, tileSize);
    }
  }
}

void findNodeNeighbours() {
  for (int x = 0; x < nodes.length; x += 1) {
    for (int y = 0; y < nodes[x].length; y += 1) {

      Node n = nodes[x][y];
      n.findNeighbours();
    }
  }
}

void drawNodes() {
  for (int x = 0; x < nodes.length; x += 1) {
    for (int y = 0; y < nodes[x].length; y += 1) {

      Node n = nodes[x][y];
      n.draw();
    }
  }
}