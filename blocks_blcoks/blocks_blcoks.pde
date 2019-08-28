color[][] blocks;

int size = 20;
int across, down;

void setup() {
  size(400, 400);

  across = width / size;
  down = height / size;
  color start = color(255, 0, 0);
  color end = color(255, 255, 0);
  blocks = new color[across][down];
  for (int x = 0; x < blocks.length; x += 1) {
    float px = x * size;
    for (int y = 0; y < blocks.length; y += 1) {
      float py = y * size;
      float r = (px + py) / (width + height);
      color c = lerpColor(start, end, r);
      blocks[x][y] = c;
    }
  }
}

void draw() {
  background(0);
  for (int x = 0; x < blocks.length; x += 1) {
    float px = x * size;
    for (int y = 0; y < blocks.length; y += 1) {
      float py = y * size;
      
      noStroke();
      fill(blocks[x][y]);
      rect(px, py, size, size);
    }
  }
}
