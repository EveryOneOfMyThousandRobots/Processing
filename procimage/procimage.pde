PImage img;
ArrayList<Tile> tiles = new ArrayList<Tile>();

float tw, th;


void settings() {
  img = loadImage("micro.jpg");
  size(img.width, img.height);
  tw = img.width / 30;
  th = img.height / 20;
}
void setup() {
  
  for (int x = 0; x < width; x += tw) {
    for (int y = 0; y < height; y += th) {
      tiles.add(new Tile(x,y,tw,th));
    }
  }
  noLoop();
}

void draw() {
  background(0);
  image(img, 0, 0);
  for (Tile t : tiles) {
    t.draw();
  }
}
