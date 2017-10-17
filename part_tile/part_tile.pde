ArrayList<Tile> tiles = new ArrayList<Tile>();
float tileWidth = 12;
float tileHeight = 12;
float tilesAcross = 0;
float tilesDown = 0;
PImage beetle;
boolean imageLoaded = false;
boolean imageSaved = true;
boolean withBorders = false;
void setup() {
  beetle = loadImage("face.jpg");

  size(668, 668);
}

void draw() {
  background(0);
  if (!imageLoaded) {
    imageLoaded = true;
    tiles.clear();
    
    beetle.loadPixels();
    for (float y = 0; y < height; y += tileHeight) {
      for (float x = 0; x < width; x += tileWidth) {
        Tile t = new Tile(x, y, tileWidth, tileHeight);
        t.evaluate(beetle);
        tiles.add(t);
      }
    }
  }
  image(beetle, 0, 0);
  for (Tile t : tiles) {
    t.draw();
  }
  if (!imageSaved) {
    saveFrame("output/out####.jpg");
    imageSaved = true;
  }
}

void mouseClicked() {
  imageLoaded = false;
  imageSaved = false;
}