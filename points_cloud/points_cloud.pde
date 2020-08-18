class Tile {
  PVector pos;
  final int ix, iy;
  PVector point;
  Tile(int ix, int iy) {
    this.ix = ix;
    this.iy = iy;
    pos = new PVector(ix * TILE_SIZE, iy * TILE_SIZE);
    point = new PVector(random(pos.x, pos.x + TILE_SIZE), random(pos.y, pos.y + TILE_SIZE));
  }

  void draw() {
    noFill();
    stroke(255, 128);
    rect(pos.x, pos.y, pos.x + TILE_SIZE, pos.y + TILE_SIZE);
    fill(255, 128);
    ellipse(point.x, point.y, 5, 5);
  }
}


Tile[][] tiles;

final int TILE_SIZE = 50;
int TA, TD;

void setup() {
  size(800, 800);


  TA = width / TILE_SIZE;
  TD = height / TILE_SIZE;

  tiles = new Tile[TA][TD];
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      tiles[x][y] = new Tile(x, y);
    }
  }
}

boolean OOB(int x, int y) {
  return (x < 0 || x > TA-1 || y < 0 || y > TD - 1);
}


void draw() {
  background(51);

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      tiles[x][y].draw();
    }
  }
  
  loadPixels();
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      PVector closest = null;
      float shortest_dist = -1;
      int xi = x / TILE_SIZE;
      int yi = y / TILE_SIZE;
      for (int xx = -1; xx < 2; xx += 1) {
        for (int yy = -1; yy < 2; yy += 1) {
          int xp = xi + xx;
          int yp = yi + yy;
          
          if (!OOB(xp,yp)) {
            Tile t = tiles[xp][yp];
            PVector p = t.point;
            float dist = dist(p.x, p.y, x,y);
            if (closest == null || dist < shortest_dist) {
              closest = p;
              shortest_dist = dist;
            }
            
          }
        }
      }
      if (closest != null) {
        float d = 1 - (shortest_dist / (TILE_SIZE * 2));
        pixels[y * width + x] = color(255 * d);
        
      }
    }
  }
  updatePixels();
}
