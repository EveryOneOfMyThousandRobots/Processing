int[][] sand;
int[][] newSand;
PGraphics img;

final int COL_ZERO = #3A2449;
final int COL_ONE = #372772;
final int COL_TWO = #94C595;
final int COL_THREE = #A1E8AF;

void setup() {
  size(400, 400);
  img = createGraphics(height / 2, width / 2);
  sand = new int[img.width][img.height];
  newSand = new int[img.width][img.height];
  sand[floor(img.width / 2)][floor(img.height / 2)] = 100000;
  frameRate(10000);
  //for (int x = 0; x < img.width; x += 1) {
  //  for (int y = 0; y < img.height; y += 1) {
  //    if (random(1) < 0.001) {
  //      sand[x][y] = 10000;
  //    }
  //  }
  //}
  //frameRate(1);
}

void draw() { 
  background(0);
  render();
  for (int i = 0; i < 1000; i += 1) {
    topple();
  }
  image(img, 0, 0, width, height);
}


void render() {
  color col;
  img.beginDraw();
  img.loadPixels();
  for (int x = 0; x < img.width; x += 1) {
    for (int y = 0; y < img.height; y += 1) {
      int idx = x + y * img.width;
      int num = getSand(x, y);
      col = getColour(num);
      img.pixels[idx] = col;
    }
  }

  img.updatePixels();
  img.endDraw();
}


int getColour(int i) {
  switch (i) {
  case 0 :
    return COL_ZERO;
  case 1:
    return COL_ONE;

  case 2:
    return COL_TWO;

  default:
    return COL_THREE;

    //default:
    //return color(0);
  }
}

int getSand(float x, float y) {
  return getSand(floor(x), floor(y));
}

int getSand(int x, int y) {
  return sand[x][y];
}

void topple() {
  int[][] temp;
  for (int x = 0; x < img.width; x += 1) {
    for (int y = 0; y < img.height; y += 1) {
      int s = getSand(x, y);

      newSand[x][y] = s;
    }
  }
  for (int x = 0; x < img.width; x += 1) {
    for (int y = 0; y < img.height; y += 1) {
      int s = getSand(x, y);
      if (s > 4) {
        //newSand[x][y] = s;
        setNeighbours(x, y, newSand);
      }
    }
  }

  temp = sand;
  sand = newSand;
  newSand = temp;
}

void setNeighbours(int x, int y, int[][] ns) {
  ns[x][y] -= 4;
  if (x > 0) {
    ns[x-1][y] += 1;
  }

  if (x < img.width-1) {
    ns[x+1][y] += 1;
  }
  if (y < img.height-1) {
    ns[x][y+1] += 1;
  }

  if (y > 0) {
    ns[x][y-1] += 1;
  }
}
