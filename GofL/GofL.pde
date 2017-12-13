int[][] grid;
int[][] nextGrid;
int cols;
int rows;
float res = 4;
//float tile_width, tile_height;

void copyGrid() {
  for (int i = 0; i < grid.length; i += 1) {
    for (int j = 0; j < grid[i].length; j += 1) {
      grid[i][j] = nextGrid[i][j];
    }
  }
}


void setup() {
  size(500, 500);
  cols = floor(width / res);
  rows = floor(height / res);
  grid = new int[cols][rows];
  nextGrid = new int[cols][rows];
  frameRate(20);



  for (int i = 0; i < grid.length; i += 1) {
    for (int j = 0; j < grid[i].length; j += 1) {
      grid[i][j] = floor(random(2));
      //if (random(1) < 0.1) {
      //  grid[i][j] = 1;
      //} else {
      //  grid[i][j] = 0;
      //}

      nextGrid[i][j] = -1;
    }
  }
}

void draw() {
  background(250,0,0);
  //stroke(0);
  noStroke();

  for (int i = 0; i < grid.length; i += 1) {
    for (int j = 0; j < grid[i].length; j += 1) {
      int g = grid[i][j];
      float x = i * res;
      float y = j * res;
      if (g == 0) {
        fill(255);
      } else {
        fill(0);
      }

      rect(x, y, res, res);
    }
  }

  for (int i = 0; i < grid.length; i += 1) {
    for (int j = 0; j < grid[i].length; j += 1) {
      int g = grid[i][j];
      int neighbours = 0;
      for (int ii = -1; ii <= 1; ii += 1) {
        for (int jj = -1; jj <= 1; jj += 1) {

          if (ii == 0 && jj == 0) continue;

          int x = (i + ii + cols)%cols;
          int y = (j + jj + rows)%rows;



          //if (ii < 0 || jj < 0) continue;
          //if (ii > grid.length - 1 || jj > grid[i].length - 1) continue;
          int gg = grid[x][y];

          neighbours += gg;
        }
      }
      if (g == 0 && neighbours == 3) {
        nextGrid[i][j] = 1;
      } else if (g == 1 && (neighbours < 2 || neighbours > 3)) {
        nextGrid[i][j] = 0;
      } else {
        nextGrid[i][j] = g;
      }
    }
  }
  copyGrid();
}