//ArrayList<PVector> points = new ArrayList<PVector>();
Tile[][] tiles;
class Tile {
  PVector pos;
  int xi, yi;
  int count = 0;
  float totalCount = 0;
  Tile(float x, float y, int xi, int yi) {
    pos = new PVector(x, y);
    this.xi = xi;
    this.yi = yi;
  }

  //void calc() {
  //  //count = 0;

  //  //for (PVector p : points) {
  //  //  if (p.x >= pos.x && p.x < pos.x + gridSize && p.y >= pos.y && p.y < pos.y + gridSize) {
  //  //    count += 1;
  //  //  }
  //  //}
  //}

  void checkNeighbours() {
    float nc = 0;
    float sum = 0;
    for (int xx = -1; xx < 2; xx += 1) {
      for (int yy = -1; yy < 2; yy += 1) {
        if (xx == 0 && yy == 0) continue;
        int xp = xi + xx;
        int yp = yi + yy;
        if (!OOB(xp, yp)) {
          nc += 1;
          sum += tiles[xp][yp].count;
        }
      }
    }
    totalCount = count + (sum / nc);
  }

  void draw() {
    float m = map(totalCount, 0, maxCount, 200, 0);

    fill(m, 255, 255);
    stroke(255, 64);
    rect(pos.x, pos.y, gridSize, gridSize);
  }
}


boolean OOB(int x, int y) {
  return (x < 0 || x > tiles.length - 1 || y < 0 || y > tiles[0].length-1);
}

void setup() {

  size(400, 400);
  colorMode(HSB);
  tiles = new Tile[width / gridSize][height / gridSize];
  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      tiles[x][y] = new Tile(x * gridSize, y * gridSize, x, y);
    }
  }
}


void draw() {
  background(0);

  //for (PVector p : points) {
  //  stroke(255, 0, 0);
  //  fill(255, 0, 0);
  //  ellipse(p.x, p.y, 3, 3);
  //}

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile t = tiles[x][y];
      t.draw();
    }
  }


  addRandomPoints();
}


int gridSize = 25;
int maxCount = 50;
void calc() {
  maxCount = -1;
  //for (int x = 0; x < tiles.length; x += 1) {
  //  for (int y = 0; y < tiles[x].length; y += 1) {
  //    Tile t = tiles[x][y];
  //    //t.calc();
  //  }
  //}

  for (int x = 0; x < tiles.length; x += 1) {
    for (int y = 0; y < tiles[x].length; y += 1) {
      Tile t = tiles[x][y];
      t.checkNeighbours();
      if (t.totalCount > maxCount) {
        maxCount = ceil(t.totalCount);
      }
    }
  }
}
float z = 0;

void addRandomPoints() {
  z += 0.01;
  if (z > 1) {
    noiseSeed(System.nanoTime());
    randomSeed(System.nanoTime());
    z = 0;
  }

  for (int i = 0; i < 100; i += 1) {
    float x = random(1);
    float y = random(1);
    float n = noise(x, y, z);
    if (n > 0.6) {
      addPoint(x * width, y * height);
      //points.add(new PVector(x * width, y * height));
    }
  }
}
void keyPressed() {
  if (key == 'r') {
    addRandomPoints();
    calc();
  }
}


void addPoint(float x, float y) {
  int xx = floor((float)x / (float)gridSize);
  int yy = floor((float)y / (float)gridSize);

  if (!OOB(xx, yy)) {
    tiles[xx][yy].count += 1;
  }
}

void mouseReleased() {



  addPoint(mouseX, mouseY);
  calc();
}
