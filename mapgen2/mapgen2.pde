int tileSize = 5;


ArrayList<int[][]> maps = new ArrayList<int[][]>();
int[][] final_map;
int[][] redMap;
int[][] orangeMap;
int[][] grayMap;
color[] col;

int w, h;
int numMaps = 6;
float alpha;
void setup() {
  size(600, 600);
  col = new color[numMaps];
  col[0] = color(0xff0054FF);
  col[1] = color(0xffFFD000);
  col[2] = color(0xff6B4C00);
  col[3] = color(0xff6B9700);
  col[4] = color(0xff90967F);
  col[5] = color(0xffFFFFFF);

  w = width / tileSize;
  h = height / tileSize;
  final_map = new int[w][h];
  for (int i = 0; i < numMaps-1; i += 1) {
    addMap();
  }
  int fp = 31;
  float fac = 0.01;
  redMap = makeMap(fp,fac);
  redMap = smoothMap(redMap,4,5);
  orangeMap = makeMap(fp,fac);
  orangeMap = smoothMap(orangeMap,4,5);
  grayMap= makeMap(fp,fac);
  grayMap = smoothMap(grayMap,4,5);
  setFinalMap();
  
}
float factor = 10;
void addMap() {
  int[][] tempmap = makeMap(53 - (maps.size()*2), 1 / factor);
  tempmap = smoothMap(tempmap, 5, 4);
  maps.add(tempmap);
  factor *= 1.5;
}

void draw() {
  background(0);

  for (int x = 0; x < w; x += 1) {
    for (int y = 0; y < h; y += 1) {

      fill(col[final_map[x][y]]);
      rect(x * tileSize, y * tileSize, tileSize, tileSize);
      if (redMap[x][y] == 1) {
        fill(255,0,0);
        rect(x * tileSize, y * tileSize, tileSize, tileSize);
      }
      
      if (orangeMap[x][y] == 1) {
        fill(255,128,0);
        rect(x * tileSize, y * tileSize, tileSize, tileSize);
      }
      
      if (grayMap[x][y] == 1) {
        fill(255,0,255);
        rect(x * tileSize, y * tileSize, tileSize, tileSize);
      }
    }
  }
  noLoop();
}

int[][] smoothMap(int[][] map, int iterations, int threshhold) {
  for (int i = 0; i < iterations; i += 1) {
    for (int x = 0; x < w; x += 1) {
      for (int y = 0; y < h; y += 1) {
        int walls = getWallCount(map, x, y);
        if (walls > threshhold) {
          map[x][y] = 1;
        } else if (walls < threshhold) {
          map[x][y] = 0;
        }
      }
    }
  }

  return map;
}

int getWallCount(int[][] map, int x, int y) {
  int walls = 0;
  for (int nx = x - 1; nx <= x + 1; nx += 1) {
    for (int ny = y - 1; ny <= y + 1; ny += 1) {
      if (nx == x && ny == y) continue;
      if (nx < 0 || nx > w - 1 || ny < 0 || ny > h - 1) {
        walls += 1;
      } else {
        walls += map[nx][ny];
      }
    }
  }

  return walls;
}

int[][] makeMap(int fillPercent, float f) {
  int[][] map = new int[w][h];
  float zz = random(-100, 100);
  for (int x = 0; x < w; x += 1) {
    float xx = x * f;
    for (int y = 0; y < h; y += 1) {
      float yy = y * f;
      int r = floor(noise(xx, yy, zz)*100);
      map[x][y] = (r <= fillPercent) ? 1 : 0;
    }
  }



  return map;
}

void setFinalMap() {
  for (int i = 0; i < maps.size(); i += 1) {
    for (int x = 0; x < w; x += 1) {
      for (int y = 0; y < h; y += 1) {
        final_map[x][y] += maps.get(i)[x][y];
      }
    }
  }
}


void gen() {
}

//void mouseClicked() {
//  for (int[][] map2 : maps) {
//    map2 = smoothMap(map2, 1, 4);
//  }
//  map = new int[w][h];

//  for (int i = 0; i < maps.size(); i += 1) {
//    for (int x = 0; x < w; x += 1) {
//      for (int y = 0; y < h; y += 1) {
//        map[x][y] += maps.get(i)[x][y];
//      }
//    }
//  }
//  //addMap();
//}
