Chem[][] grid;
Chem[][] next;

float dA = 1;
float dB = 0.5;
float feed = .055;
float k = 0.062;



class Chem {
  float a, b;
  Chem(float a, float b) {
    this.a = a;
    this.b = b;
  }

  Chem() {
    this.a = random(1);
    this.b = random(1);
  }

  boolean equals(Chem o) {
    if (this.a == o.a && this.b == o.b) {
      return true;
    } else {
      return false;
    }
  }
}


void eval() {
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      float a = grid[x][y].a;
      float b = grid[x][y].b;
      next[x][y].a = a + (dA * laplaceA(x, y) - a * sq(b) + feed*(1-a));
      next[x][y].b = b + (dB * laplaceB(x, y) + a * sq(b) - (k + feed) * b);
      next[x][y].a = constrain(next[x][y].a, 0, 1);
      next[x][y].b = constrain(next[x][y].b, 0, 1);

      //grid[x][y] = new Chem(0, 0);
    }
  }
}

float laplaceA(int x, int y) {
  float sum = 0;

  for (int xx = -1; xx <= 1; xx += 1) {
    int gx = x + xx;
    for (int yy = -1; yy <= 1; yy += 1) {
      int gy = y + yy;
      if (gx >= 0 && gx < width && gy >= 0 && gy < height) {
        int posSum = abs(xx) + abs(yy);
        if (posSum == 1) {
          sum += grid[gx][gy].a * 0.2;
        } 
        if (posSum == 0 ) {
          sum += grid[gx][gy].a * -1;
        } else {
          sum += grid[gx][gy].a * 0.05;
        }
      }
    }
  }

  return sum;
}

float laplaceB(int x, int y) {
  float sum = 0;

  for (int xx = -1; xx <= 1; xx += 1) {
    for (int yy = -1; yy <= 1; yy += 1) {
      int gx = x + xx;
      int gy = y + yy;
      if (gx >= 0 && gx < width && gy >= 0 && gy < height) {
        int posSum = abs(xx) + abs(yy);
        if (posSum == 1) {
          sum += grid[gx][gy].b * 0.2;
        } 
        if (posSum == 0 ) {
          sum += grid[gx][gy].b * -1;
        } else {
          sum += grid[gx][gy].b * 0.05;
        }
      }
    }
  }

  return sum;
}

void swap() {
  Chem[][] temp = grid;
  grid = next;
  next = temp;
}



void setup() {
  size(400, 400, P2D);


  grid = new Chem[width][height];
  next = new Chem[width][height];

  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      grid[x][y] = new Chem(1, 0);
      next[x][y] = new Chem(0, 0);
    }
  }


  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      if (random(1) < 0.005) { 
        grid[x][y].a = 0;
        grid[x][y].b = 1;
      }
    }
  }
  //for (int x = (width / 2) - 5; x < (width / 2) + 5; x += 1) {
  //  for (int y = (height / 2) -5; y < (height / 2) + 5; y += 1) {
  //    grid[x][y].a = 0;
  //    grid[x][y].b = 1;
  //  }
  //}
}

void draw() {
  background(51);
  loadPixels();

  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      int index = x + y * width;
      float a = grid[x][y].a;
      float b = grid[x][y].b;
      pixels[index] = color((a-b)*255);
    }
  }
  updatePixels();
  eval();
  swap();
}