int ACROSS, DOWN;
ArrayList<Tile> tiles = new ArrayList<Tile>();
void setup() {
  size(400,400);
  
  for (int x = 0; x < width; x += TILE_SIZE) {
    for (int y = 0; y < height; y += TILE_SIZE) {
      tiles.add(new Tile(x,y));
    }
  }
  
  
}


void draw() {
  background(0);
  for (Tile t : tiles) {
    t.draw();
  }
}

final int TILE_SIZE = 50;
final int SPACING = 20;
final int SPACING_HALF = 10;
class Tile {
  PVector pos;
  PVector dims;
  boolean top, left, bottom, right;

  Tile (float x, float y) {
    pos = new PVector(x, y);
    dims = new PVector(TILE_SIZE, TILE_SIZE);
    top = floor(random(100)) % 2 == 0;
    bottom = floor(random(100)) % 2 == 0;
    left = floor(random(100)) % 2 == 0;
    right = floor(random(100)) % 2 == 0;
  }

  void draw() {
    stroke(255);
    fill(51);
    rect(pos.x, pos.y, dims.x, dims.y);

    //stroke(0);
    noStroke();
    if (top) {
      //noStroke();
      fill(255);
      rect(pos.x + SPACING_HALF, pos.y, dims.x - SPACING, SPACING_HALF);
    }

    if (bottom) {
      //noStroke();
      fill(255);
      rect(pos.x + SPACING_HALF, pos.y + dims.y - SPACING_HALF, dims.x - SPACING, SPACING);
    }

    if (left) {
      //noStroke();
      fill(255);
      rect(pos.x, pos.y + SPACING_HALF, SPACING_HALF, dims.y - SPACING);
    }

    if (right) {
      //noStroke();
      fill(255);
      rect(pos.x + dims.x - SPACING_HALF, pos.y + SPACING_HALF, SPACING_HALF, dims.y - SPACING);
    }
  }
}
