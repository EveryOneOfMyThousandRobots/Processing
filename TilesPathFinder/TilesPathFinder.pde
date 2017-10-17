

float tileWidth = 10;
float tileHeight = 10;
int tilesAcross, tilesDown;
ArrayList<Tile> tiles = new ArrayList<Tile>();
Path p;
void setup() {
  size(400, 400);
  for (int y = 0; y < height; y += tileHeight) {
    for (int x = 0; x < width; x += tileWidth) {
      Tile t = new Tile(x, y, tileWidth, tileHeight, random(0, 1));
      tiles.add(t);
    }
  }
  tilesAcross = (int) (width / tileWidth);
  tilesDown = (int) (height / tileHeight);
  p = new Path(tileWidth / 2, tileHeight / 2, width - (tileWidth / 2), height - (tileHeight / 2));
  frameRate(1);
}

void draw() {
  background(0);
  for (Tile t : tiles) {
    t.draw();
  }
  p.update();
  p.draw();
}

void mouseClicked() {
  Tile t = getTile(mouseX, mouseY);
  if (t != null) {
    println("(" + t.pos.x + "," + t.pos.y + ") c: " + t.cost);
  }
}