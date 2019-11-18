Particle[][] grid;
Particle[][] newGrid;
class Particle {
  int x, y;
  boolean fixed = false;

  Particle(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    Particle below = getParticle(x, y+1);
    Particle left = getParticle(x-1, y+1);
    Particle right = getParticle(x+1, y+1);

    if (fixed) {
       newGrid[x][y] = this;
    } else {
      if (below == null && !OOB(x, y+1)) {
        move(x, y+1);
      } else if (left == null && !OOB(x-1, y+1)) {
        move(x-1, y+1);
      } else if (right == null && !OOB(x+1, y+1)) {
        move(x+1, y+1);
      } else {
        newGrid[x][y] = this;
      }
    }
  }

  void move(int nx, int ny) {
    grid[x][y] = null;
    x = nx;
    y = ny;
    newGrid[x][y] = this;
  }
}

boolean OOB(int x, int y) {
  return (x < 0 || x > width-1 || y < 0 || y > height-1);
}
Particle getParticle(int x, int y) {
  if (OOB(x, y)) {
    return null;
  } else {
    return grid[x][y];
  }
}

void setup() {
  size(200, 200);
  //frameRate(5);
  grid = new Particle[width][height];
  newGrid = new Particle[width][height];
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      if (random(1) < 0.01 || y == 0) {
        grid[x][y] = new Particle(x, y);
        if (random(1) < 0.5 && y != 0) {
          grid[x][y].fixed = true;
        }
      }
    }
  }
}


void draw() {
  background(0);
  stroke(255);
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      Particle p = getParticle(x, y);
      if (p != null) {
        point(p.x, p.y);
        p.update();
      }
    }
  }

  grid = newGrid;
  newGrid = new Particle[width][height];
}
