ArrayList<Node> toCheck = new ArrayList<Node>();
ArrayList<Node> allNodes = new ArrayList<Node>();
ArrayList<Node> ends = new ArrayList<Node>();
ArrayList<Block> blocks = new ArrayList<Block>();
ArrayList<Node> toDraw = new ArrayList<Node>();
ArrayList<PVector> intersections = new ArrayList<PVector>();


final int WW = 800;
final int WH = 800;
final int OUTSIDE_BORDER = 50;
final float MIN_LEN = 10;
final float MAX_LEN = 30;


final float BLOCK_SIZE = 30;
final float BLOCKS_ACROSS = WW / BLOCK_SIZE;
final float BLOCKS_DOWN = WH / BLOCK_SIZE;
void settings() {
  size(WW, WH);
}
void setup() {
  reset();
}
Node origin;
void reset() {
  intersections.clear();
  splits = 0;
  goBackAmount = 5;
  allNodes.clear();
  blocks.clear();
  toCheck.clear();
  toDraw.clear();
  ends.clear();
  newBlocks();

  origin = new Node(null, random(width), height-1, radians(random(-135, -45)));
}

int splits = 0;
void draw() {
  background(255);

  if (splits < 3 && random(1) < 0.1 && toDraw.size() > 5) {
    int r = floor(random(toDraw.size()));
    Node n = toDraw.get(r);
    toDraw.remove(n);
    toCheck.add(n);
    splits += 1;
  }


  for (int i = toCheck.size() - 1; i >= 0; i -= 1) {
    if (i > toCheck.size()-1) break;
    Node n = toCheck.get(i);
    n.check();
    if (toCheck.contains(n)) {
      toCheck.remove(n);
    }
    toDraw.add(n);
  }




  for (int i = allNodes.size() - 1; i >= 0; i -= 1) {
    Node n = allNodes.get(i);
    n.draw();
  }

  for (Node n : ends) {
    n.drawRetrace();
  }

  for (Block b : blocks) {
    b.draw();
  }

  for (PVector p : intersections) {
    stroke(255, 0, 255, 128);
    line(p.x - 5, p.y - 5, p.x + 5, p.y + 5);
    line(p.x + 5, p.y - 5, p.x - 5, p.y + 5);
  }
}
