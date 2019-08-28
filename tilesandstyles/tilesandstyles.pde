ArrayList<Tile> tiles = new ArrayList<Tile>();
float TILE_WIDTH, TILE_HEIGHT;
void setup() {
  size(400, 400);
  TILE_WIDTH = TILE_HEIGHT = width / 20;

  for (float x = 0; x < width; x += TILE_WIDTH) {
    for (float y = 0; y < height; y += TILE_HEIGHT) {
      tiles.add(new Tile(x,y,TILE_WIDTH, TILE_HEIGHT));
    }
  }
}

void draw() {
  background(255);
  for (Tile t : tiles) {
    t.update();
    t.draw();
  }
  
}
float zoff = 0;
class Tile {
  PVector pos, dims;
  float angle, angle_inc, sin_x;

  Tile (float x, float y, float w, float h) {
    zoff += 0.1;
    angle = map(noise(x * 0.01, y * 0.01, zoff), 0, 1, 0, TWO_PI);
    angle_inc = radians(noise(x * 0.1, y * 0.1, zoff));
    pos = new PVector(x, y);
    dims = new PVector(w, h);
  }

  void update() {
    angle = (angle + angle_inc) % TWO_PI;
    sin_x = sin(angle);
  }

  void draw() {
    noStroke();
    fill(map(sin_x, -1, 1, 0, 255));
    rect(pos.x, pos.y, dims.x, dims.y);
  }
}
