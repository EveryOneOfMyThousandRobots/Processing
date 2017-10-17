int TILE_ID = 0;
PImage img;
class Tile {
  PVector pos;
  int tileId;
  color c;
  PVector target = null;
  PVector vel = new PVector(0,0);

  float rr, gg, bb, ii;
  {
    tileId= TILE_ID;
    TILE_ID += 1;

    c = color(random(0, 255), random(0, 255), random(0, 255));
  }

  Tile (float x, float y) {
    pos = new PVector(x, y);
  }


  void draw() {
    update();
    float r = w/4;
    float d = w/2;
    float rr = red(c);
    float g = green(c);
    float b = blue(c);
    float l = (rr + g + b) / 3;
    

    noStroke();
    fill(rr, 0, 0, 64);
    ellipse(pos.x + r, pos.y + r, d, d);
    fill(0, g, 0, 64);
    ellipse(pos.x + (r * 3), pos.y + r, d, d);
    fill(0, 0, b, 64);
    ellipse(pos.x + r, pos.y + (r * 3), d, d);
    fill(l, 64);
    ellipse(pos.x + (r * 3), pos.y + (r * 3), d, d);
  }
  
  void assignTarget(PVector t) {
    target = t.copy();
    vel = target.sub(pos);
    vel.normalize();
  }
  
  void update() {
    pos.add(vel);
  }
}
int a = 30;
int d = 30;
int w;
int h;

ArrayList<Tile> tiles = new ArrayList<Tile>();

void drawTiles() {
  for (Tile t : tiles) {
    t.draw();
  }
}

void settings() {
  img = loadImage("smarties.jpg");
  size(img.width, img.height);
}
void setup() {


  w = width / a;
  h = height /d;

  for (int x = 0; x < width; x += w) {
    for (int y = 0; y < height; y += h) {
      //float r = map(x, 0, width, 0, 255);
      //float g = map(y, 0, height, 0, 255);
      //float b = map(x + y, 0, height + width, 0, 255);
      //color c = color(r, g, b);
      Tile t = new Tile(x, y);
      // t.c = c;
      tiles.add(t);
    }
  }

  for (Tile t : tiles) {
    for (float x = t.pos.x; x < t.pos.x + w; x += 1) {
      for (float y = t.pos.y; y < t.pos.y + h; y += 1) {
        color c = img.get((int)x, (int)y);
        t.rr += red(c);
        t.bb += blue(c);
        t.gg += green(c);
        t.ii += 1;
      }
    }
    t.c = color(t.rr / t.ii, t.gg / t.ii, t.bb / t.ii);
  }





}

Tile getRandomTile() {
  return tiles.get((int)random(0, tiles.size()));
}

void draw() {
  background(0);
  drawTiles();

  
  int r = (int) random(0,1000);
  if (r <= 20) {
    Tile from = getRandomTile();
    Tile to = getRandomTile();
    if (from.target == null && from.tileId != to.tileId && to.target == null && (from.pos.x == to.pos.x || from.pos.y == to.pos.y)) {
      
      from.assignTarget(to.pos);
     
    }
  }
  

}