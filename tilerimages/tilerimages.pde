PImage img;
int tilesAcross = 16;
int tilesDown = 2;
int tileHeight = 0;
int tileWidth = 0;

void setup() {
  noLoop();
  tileHeight = height / tilesDown;
  tileWidth = width / tilesAcross;
  img.loadPixels();
  for (int y = 0; y < height; y += tileHeight) {
    for (int x = 0; x < width; x += tileWidth) {
      Tile t = new Tile(x,y, tileWidth, tileHeight, img.pixels, img);
      t.calc();
      tiles.add(t);
      
    }
  }
  
}

ArrayList<Tile> tiles = new ArrayList<Tile>();


void settings() {
  img = loadImage("shining.jpg");
  size(img.width, img.height);
  
}

void draw() {
  image(img, 0,0);
  for (Tile t : tiles) {
    //stroke(0);
    //float sr = 255 - red((int)t.avg);
    //float sg = 255 - green((int)t.avg);
    //float sb = 255 - blue((int)t.avg);
    //stroke(color(sr, sg, sb));
    noStroke();
    fill((int)t.avg);
    int h = t.h / 4;
    int y = t.y + (t.h / 2);
    rect(t.drawPos.x, t.drawPos.y, t.drawDim.x, t.drawDim.y, 3);
    
  }
}