final int GRID_SIZE = 25;
final int WINDOW_SIZE = GRID_SIZE * 20;
final float BLOCK_CHANCE = 0.1;
QuadTree tree;
ArrayList<Block> blocks = new ArrayList<Block>();
void settings() {
  size(WINDOW_SIZE, WINDOW_SIZE);
}


void setup() {
  tree = new QuadTree(0,0,width, height);
  for (int x = GRID_SIZE; x < width; x += GRID_SIZE) {
    for (int y = GRID_SIZE; y < height; y += GRID_SIZE) {
      if (x >= width - GRID_SIZE && y >= height - GRID_SIZE) continue;
      if (random(1) < BLOCK_CHANCE) {
        Block b = new Block(x, y);
        tree.add(b);
        blocks.add(b);
        
      }
    }
  }
}

void draw() {
  background(255);
  tree.draw();
  for (Block b : blocks) {
    b.draw();
  }
}
