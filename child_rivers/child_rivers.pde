int[][] tiles;

ArrayList<PathPoint> toDraw = new ArrayList<PathPoint>();
ArrayList<PathPoint> toCheck = new ArrayList<PathPoint>();
ArrayList<Block> blocks = new ArrayList<Block>();

ArrayList<PathPoint> allPoints = new ArrayList<PathPoint>();
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 800;
final float MIN_LENGTH = 20;
final float MAX_LENGTH = 50;
final float START_WIDTH = 10;
final float BLOCK_SIZE = 30;
final float BLOCKS_ACROSS = WINDOW_WIDTH / BLOCK_SIZE;
final float BLOCKS_DOWN = WINDOW_HEIGHT / BLOCK_SIZE;
int P_ID = 0;

void settings() {
  size(WINDOW_WIDTH,WINDOW_HEIGHT);
}

PathPoint origin;
int updateCount = 0;

void setup() {
  
  newBlocks();
  origin = new PathPoint(width/2, height-1, -HALF_PI, null, true, START_WIDTH);
}

void draw() {
  updateCount = 0;
  background(255);

  for (int i = toCheck.size()-1; i >= 0; i -= 1) {
    PathPoint p = toCheck.get(i);
    p.update();

    toCheck.remove(i);
    toDraw.add(p);
  }

  for (int i = toDraw.size()-1; i >= 0; i -= 1) {
    PathPoint p = toDraw.get(i);
    p.draw();
  }
  
  for (Block b : blocks) {
    b.draw();
  }

  //for (int i = 0; i < path.size()-1; i += 1) {
  //  PathPoint A = path.get(i);
  //  PathPoint B = path.get(i+1);
  //  strokeWeight(2);
  //  stroke(255, 0, 0);
  //  line(A.pos.x, A.pos.y, B.pos.x, B.pos.y);
  //  strokeWeight(1);
  //}
}

void newBlocks() {
  for (int i = 0; i < 10; i += 1) {
    int x = floor(random(BLOCKS_ACROSS));
    int y = floor(random(BLOCKS_DOWN));
    int w = floor(random(1,5));
    int h = floor(random(1,5));
    blocks.add( new Block(x,y,w,h));
  }
  
  
}

void mouseClicked() {
  toCheck.clear();
  toDraw.clear();
  allPoints.clear();
  blocks.clear();
  newBlocks();
  origin = new PathPoint(width/2, height-1, -HALF_PI, null, true, START_WIDTH);
}
