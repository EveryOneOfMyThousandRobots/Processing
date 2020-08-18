int[][] map;

int tileSize = 5;
int TA, TD;

void setup() {
  size(800, 800);
  TA = floor(width / tileSize);
  TD = floor(height / tileSize);
  makeNewMap();
}

void makeNewMap() {
  map = new int[TA][TD];
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      map[x][y] = 0;

      if (random(1) < 0.5) {
        map[x][y] = 1;
      }
    }
  }
}

void iterate() {
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      int m = map[x][y];

      int nn = countNeighbours(x, y);

      if (nn >= threshhold) {
        map[x][y] = 1;
      } else {
        map[x][y] = 0;
      }
    }
  }
}

int threshhold = 5;


boolean OOB(int x, int y) {
  return (x < 0 || x > TA - 1 || y < 0 || y > TD - 1);
}
int countNeighbours(int x, int y) {
  int count = 0;
  for (int xx = -1; xx < 2; xx += 1) {
    for (int yy = -1; yy < 2; yy += 1) {
      if (xx == x && yy == y) continue;
      if (!OOB(x + xx, y + yy)) {
        int m = map[x + xx][ y + yy];

        if ( m > 0 ) {
          count += 1;
        } 
        
      }
    }
  }

  return count;
}


void draw() {
  background(0);

  noStroke();
  fill(255);
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      int m = map[x][y];
      
      if(m > 0) {
        rect(x * tileSize, y * tileSize, tileSize, tileSize);
        
      }
    }
  }
}

void mouseReleased() {
  iterate();
}
