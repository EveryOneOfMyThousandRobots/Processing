int[][] grid;
int start = 3;
int size = start * start;
PVector pos;
PVector dims;

void setup() {
  size(600, 600);
  pos = new PVector(10, 10);
  dims = new PVector(width - 20, height - 20);
  textFont(createFont("FixedSys", 10));
  grid = new int[size][size];
  int counter = 0;
  for (int y = 0; y < size; y += 1) {
    for (int x = 0; x < size; x += 1) {

      grid[x][y] = counter;
      counter += 1;
    }
  }
}

void draw() {
  background(255);
  drawGrid();
}

void drawGrid() {
  float cellSize = dims.x / size;
  strokeWeight(1);
  stroke(0);

  for (int x = 0; x <= size; x += 1) {
    if (x % start == 0 ) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    line(pos.x + x * cellSize, pos.y, pos.x + x * cellSize, pos.y + dims.y);
  }
  for (int y = 0; y <= size; y += 1) {
    if (y % start == 0 ) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    line(pos.x, pos.y + y * cellSize, pos.x + dims.x, pos.y + y * cellSize);
  }
  fill(0);
  for (int x = 0; x < size; x += 1) {
    float posx = cellSize + pos.x + (x * cellSize) - 25;
    for (int y = 0; y < size; y += 1) {
      float posy = cellSize + pos.y + (y * cellSize) - 5;
      text((x % start) + "," + (y % start), posx, posy);
    }
  }
  //noFill();
  //strokeWeight(3);
  //rect(0,0,width,height);
  //rect(0,0,start*cellSize, start * cellSize);
}