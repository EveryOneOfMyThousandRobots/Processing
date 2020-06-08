int ID = 0;
ArrayList<Block> blocks = new ArrayList<Block>();

class Tile {
}

ArrayList<Agent> agents = new ArrayList<Agent>();
void setup() {
  size(640, 480);
  
  for (int i = 0; i < 100; i += 1) {
    agents.add(new Agent(random(width), random(height)));
  }
  
  
  for (int x = 0; x < width; x += 150) {
    for (int y = 0; y < height; y += 150) {
      blocks.add(new Block(x, y, 50,50));
    }
  }
  
}



void draw() {
  background(255);
  for (Agent a : agents) {
    a.flock(agents);
    a.update();
    a.draw();
  }
  
  for (Block block : blocks) {
    block.draw();
  }
  
}
