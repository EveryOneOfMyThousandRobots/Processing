PImage map;
Map noiseMap = new Map(50, 50);
final int RES = 10;
Path m;
void settings() {

  map = noiseMap.map;
  size(map.width * RES, map.height * RES);
}
Tile[][] tiles;
Node[][] nodes;
void setup () {
  tiles = new Tile[map.width][map.height];

  map.loadPixels();
  for (int x = 0; x < map.width; x += 1) {
    for (int y = 0; y < map.height; y += 1) {
      color c = map.get(x, y);

      tiles[x][y] = new Tile(x, y, x * RES, y * RES, c == color(0));
    }
  }
  nodes = makeNodes();
  //noLoop();
  m = new Path(getRandomNode(), getRandomNode());
  m.go();
}

Node getRandomNode() {
  int x = -1;
  int y = -1;
  Node n = null;
  while (n == null) {
    x = floor(random(0, nodes.length));
    y = floor(random(0, nodes[0].length));

    n = nodes[x][y];
    if (n.tile.isWall) {
      n = null;
    }
  }

  return n;
}

void draw() {
  background(0);
  //image(map, 0, 0, width, height);
  for (Tile[] ta : tiles) {
    for (Tile t : ta) {
      t.draw();
    }
  }

  for (Node[] na : nodes) {
    for (Node n : na) {
      n.draw();
    }
  }
  m.draw();
  //noiseMap.generate();
}

void mouseClicked() {
  m = new Path(getRandomNode(), getRandomNode());
  m.go();
}
