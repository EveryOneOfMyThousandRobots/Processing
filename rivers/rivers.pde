int[][] tiles;
final int tileSize = 8;
final int W = 800;
final int H = 800;
final int TA = W / tileSize;
final int TD = H / tileSize;


ArrayList<Block> blocks = new ArrayList<Block>();



boolean chance(float n) {
  return random(1) < n;
}
River rivera;


void settings() {
  size(W, H);
}
void setup() {
  tiles = new int[TA][TD];
  rivera = new River(width / 2, height -1);
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      tiles[x][y] = 0;
    }
  }
  
  for (int i = 0; i < 10; i += 1) {
    int x = floor(random(TA)) * tileSize;
    int y = floor(random(TD)) * tileSize;
    int w = floor(random(5,20)) * tileSize;
    int h = tileSize;
    blocks.add (new Block(x,y, w, h));
  }
  
  blocks.add(new Block(0,height/2,width/2,tileSize));
  blocks.add(new Block((width/2)+tileSize, height/2, width/2,tileSize));
}

void addToTile(float x, float y) {

  int xx = floor(x) / tileSize;
  int yy = floor(y) / tileSize;
  if (xx >= 0 && xx <= TA-1 && yy >= 0 && yy < TD-1) {
    tiles[xx][yy] = 255;
  }
}

void draw() {
  background(0);
  rivera.update();
  noStroke();
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      int t = tiles[x][y];
      if (t > 0) {
        fill(constrain(t, 0, 255), 32);
        rect(x*tileSize, y * tileSize, tileSize, tileSize);
      }
    }
  }
  rivera.draw();
  
  for (Block b : blocks) {
    b.draw();
  }
  fill(255);
  text(nodeCount + "\n" + rivera.splits, 10, 10);
}

void mouseClicked() {
  rivera = new River(width / 2, height -1);
    for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      tiles[x][y] = 0;
    }
  }
}
