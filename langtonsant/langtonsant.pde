int[][] grid;
int x, y;
int dir;

final int DIR_UP = 0;
final int DIR_RIGHT = 1;
final int DIR_DOWN = 2;
final int DIR_LEFT = 3;



void setup() {
  size(600, 600);

  grid = new int[width][height];

  x = width / 2;
  y = height / 2;
  dir = DIR_UP;
  frameRate(100);
}

void draw() {
  background(255);
  for (int i = 0; i < 100; i += 1) {
    int state = grid[x][y];
    if (state == 0) {
      dir = (dir + 1) % 4;
    } else {
      dir = (4 + (dir - 1)) % 4;
    }


    grid[x][y] = 1 - state;
    forward();
  }
  loadPixels();

  for (int xx = 0; xx < width; xx += 1) {
    for (int yy = 0; yy < height; yy += 1) {
      int p = grid[xx][yy];
      if (p == 1) {
        pixels[xx + yy * width] = color(0);
      }
    }
  }
  pixels[x + y * width] = color(255, 0, 0);
  updatePixels();

  fill(0);
  text(x + "," + y + " " + dir, 10, 10);
}

void forward() {
  switch (dir) {
  case DIR_UP:
    y -= 1;
    break;
  case DIR_RIGHT:
    x += 1;
    break;
  case DIR_DOWN:
    y += 1;
    break;
  case DIR_LEFT:
    x -= 1;
    break;
  default:
    break;
  }
  x = (width + x) % width;
  y = (height + y) % height;
}