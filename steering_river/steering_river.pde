
ArrayList<Block> blocks;
ArrayList<Agent> agents;

Map map;
void setup() {
  noSmooth();
  size(800, 800);
  map = new Map(10);
  agents = new ArrayList<Agent>();
  blocks = new ArrayList<Block>();
  for (int x = width / 4; x < width; x += width /4) {
    agents.add(new Agent(x,height+40,-HALF_PI));
  }
  //agents.add(new Agent(1,height/2,0));

  trail = createGraphics(width, height);
  trail.beginDraw();
  trail.background(255);
  trail.endDraw();

  for (int i = 0; i < 30; i += 1) {
    float x = random(50, width-50);
    float y = random(50, height-50);
    blocks.add(new Block(x, y, random(1)));
  }
}

boolean noMoreUpdates = false;
void draw() {
  background(255);
  //image(trail, 0, 0);
  boolean allFinished = true;
  if (!noMoreUpdates) {
    for (int i = agents.size() - 1; i >= 0; i -= 1) {

      Agent agent = agents.get(i);


      agent.update();
      agent.seek();
      
      if (OOB(agent.pos.x, agent.pos.y)) {

        //agent.scanPosList();
        agent.finished = true;
      }

      if (!agent.finished) {
        allFinished = false;
      }
      
      agent.draw();
    }
  }

  if (allFinished || noMoreUpdates) {
    map.draw();
    noMoreUpdates = true;
  }



  //for (Block block : blocks) {
  //  block.draw();
  //}
}

boolean OOB(float x, float y) {
  return x < -50 || x > width + 50 || y < -50 || y > height + 50;
}
