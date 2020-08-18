int[][] grid;
int[] types;
color[] typeColours;
final int WW = 800;
final int WH = 800;
final int CELL_SIZE = 4;
final int CA = WW / CELL_SIZE;
final int CD = WH / CELL_SIZE;
final int NUM_TYPES = 4;
final int THRESH = 5;
void settings() {
  size(WW, WH);
}

void setup() {

  colorMode(HSB);
  generate();
}

void draw() {
  background(0);

  for (int x = 0; x < CA; x += 1) {
    for (int y = 0; y < CD; y += 1) {
      int g = grid[x][y];

      if (g == -1) continue;

      
      noStroke();
      fill(typeColours[g]);
      rect(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE);
    }
  }
  step();
}

void mouseReleased() {
 generate();
}

PVector countNeighbours(int x, int y) {
  HashMap<Integer, Integer> map = new HashMap<Integer,Integer>();
  
  for (int xx = -1; xx < 2; xx += 1) {
    int px = x + xx;
    for (int yy = -1; yy < 2; yy += 1) {
      if (xx == 0 && yy == 0) continue;
      int py = y + yy;
      if (!OOB(px, py)) {
        int g = grid[px][py];
        if (g != -1) {
          addToMap(map, g);
        }
      }
    }
  }
  
  int max_i = -1;
  int max = -1;
  
  for (Integer i : map.keySet()) {
    int n = map.get(i);
    if (max_i == -1 || n > max) {
      max_i = i;
      max = n;
      
    }
    
  }

  return new PVector(max_i, max);
}

void addToMap(HashMap<Integer, Integer> map, int i) {
  if (map.containsKey(i)) {
     int j = map.get(i);   
     j += 1;
     map.put(i,j);
  } else {
    map.put(i, 1);
  }
}

void step() {
  for (int x = 0; x < CA; x += 1) {
    for (int y = 0; y < CD; y += 1) {
      int g = grid[x][y];
      if (g != -1) continue;


      PVector c = countNeighbours(x, y);
      
      if (c.x != -1 && (int)c.y >= THRESH) {
        grid[x][y] = (int)c.x;
      }

      //if (c >= THRESH) {


      //  int r = floor(random(4));
      //  int nx = x;
      //  int ny = y;
      //  switch(r) {
      //  case 0:
      //    nx -= 1;
      //    break;
      //  case 1:
      //    nx += 1;
      //    break;
      //  case 2:
      //    ny -= 1;
      //    break;
      //  case 3:
      //    ny += 1;
      //    break;
      //  }

      //  if (!OOB(nx, ny)) {
      //    if (nx == x && ny == y) {
      //      continue;
      //    } else {
      //      if (random(1) < 0.5) {
      //        if (grid[nx][ny] == -1) {
      //          grid[nx][ny] = g;
      //        }
      //      }
      //    }
      //  }
      //} else if (c <= 2){
      //  grid[x][y] = -1;
      //}
    }
  }
}

boolean OOB(int x, int y) {
  return (x < 0 || x > CA - 1 || y < 0 || y > CD - 1);
}

void generate() {
  noiseSeed(str(millis()).hashCode());
  grid = new int[CA][CD];
  types = new int[NUM_TYPES];
  typeColours = new color[NUM_TYPES];

  for (int x = 0; x < CA; x += 1) {
    for (int y = 0; y < CD; y += 1) {
      grid[x][y] = -1;
    }
  }

  for (int i = 0; i < types.length; i += 1) {
    types[i] = i;
    typeColours[i] = color(random(255), 255, 255);

    for (int x = 0; x < CA; x += 1) {
      float fx = (float)x * 0.1;
      for (int y = 0; y < CD; y += 1) {
        float fy = (float)y * 0.1;

        float n = noise(fx, fy, i*3);
        if (n > 0.5) {
          grid[x][y] = i;
        }
      }
    }
  }




  //for (int i = 0; i < types.length; i += 1) {
  //  types[i] = i;
  //  typeColours[i] = color(random(255), 255, 255);


  //  while (true) {
  //    int x = floor(random(CA));
  //    int y = floor(random(CD));

  //    int g = grid[x][y];
  //    if (g == -1) {
  //      grid[x][y] = i;
  //      break;
  //    }
  //  }
  //}
}
