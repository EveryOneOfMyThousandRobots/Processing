enum TYPE {
  AIR, 
    SAND, 
    WATER, 
    INVALID,
}

HashMap<TYPE, Float> densityMap = new HashMap<TYPE, Float>();
HashMap<TYPE, Integer> directions = new HashMap<TYPE, Integer>();

final int D_UP = 1 << 0;
final int D_DOWN = 1 << 1;
final int D_LEFT = 1 << 2;
final int D_RIGHT = 1 << 3;
final int D_DOWNLEFT = 1 << 4;
final int D_DOWNRIGHT = 1 << 5;


boolean dir(TYPE type, int d) {
  
  int v = directions.get(type);
  
  return ((v & d) != 0);
  
  
}

TYPE[][] map;
int[][] updateMap;

final int W = 100;
final int H = 100;
int TW, TH;
int updateCounter = 0;

void setup () {
  size(400, 400);
  int air = 0b0000000;
  int sand = 0b0110010;
  int water = 0b0111110;


  directions.put(TYPE.AIR, air);
  directions.put(TYPE.SAND, sand);
  directions.put(TYPE.WATER, water);


  densityMap.put(TYPE.AIR, 1f);
  densityMap.put(TYPE.SAND, 2f);
  densityMap.put(TYPE.WATER, 1.5f);


  map = new TYPE[W][H];
  updateMap = new int[W][H];

  TW = width / W;
  TH = height / H;

  for (int x = 0; x < W; x += 1) {
    for (int y = 0; y < H; y += 1) {
      map[x][y] = TYPE.AIR;
    }
  }

  for (int x = 0; x < W; x += 1) {
    for (int y = 90; y < H; y += 1) {
      map[x][y] = TYPE.SAND;
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    addTypeAtCursor(TYPE.SAND);
  } else if (mouseButton == RIGHT) {
    setTypeAtCursor(TYPE.AIR);
  } else if (mouseButton == CENTER) {
    addTypeAtCursor(TYPE.WATER);
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    addTypeAtCursor(TYPE.SAND);
  } else  if (mouseButton == RIGHT) {
    setTypeAtCursor(TYPE.AIR);
  } else if (mouseButton == CENTER) {
    addTypeAtCursor(TYPE.WATER);
  }
}

void setTypeAtCursor(TYPE type) {
  int xx = floor((float)mouseX / (float)TW);
  int yy = floor((float)mouseY / (float)TH);


  for (float a = 0; a < TWO_PI; a += radians(1)) {
    for (float r = 1; r < 4; r += 1) {
      int xf = floor ((float)xx + r * cos(a));
      int yf = floor ((float)yy + r * sin(a));

      if (!OOB(xf, yf)) {

        map[xf][yf] = type;
      }
    }
  }
}

void addTypeAtCursor(TYPE type) {
  int xx = floor((float)mouseX / (float)TW);
  int yy = floor((float)mouseY / (float)TH);


  for (float a = 0; a < TWO_PI; a += radians(1)) {
    for (float r = 1; r < 4; r += 1) {
      int xf = floor ((float)xx + r * cos(a));
      int yf = floor ((float)yy + r * sin(a));

      if (!OOB(xf, yf)) {
        if (map[xf][yf] == TYPE.AIR) {
          map[xf][yf] = type;
        }
      }
    }
  }
}


boolean OOB(int x, int y) {
  return (x < 0 || x > W-1 || y < 0 || y > H-1);
}

void draw() {
  background(0);
  updateCounter = 1 - updateCounter;
  updateMapNew();
  drawMap();
}

TYPE getType(int x, int y) {
  if (OOB(x, y)) {
    return TYPE.INVALID;
  } else {
    return map[x][y];
  }
}

void setMap(int x, int y, TYPE type) {
  if (!OOB(x, y)) {
    map[x][y] = type;
  }
}


void updateMapNew() {
  int c = 0;
  for (int x = 0; x < W; x += 1) {

    for (int y = H-1; y >= 0; y -= 1) {
      c = (c + floor(random(3))) % 10;

      TYPE curr = getType(x,y);
      
      if (dir(curr,D_DOWN) && checkDirection(x,y,x,y+1)) {
        swap(x,y,x,y+1);
      } else if (c % 2 == 0) {
        if (dir(curr,D_LEFT) && checkDirection(x,y,x-1,y)) {
          swap(x,y,x-1,y);
        } else if (dir(curr, D_RIGHT) && checkDirection(x,y,x+1,y)) {
          swap(x,y,x+1,y);
        } else if (dir(curr, D_DOWNLEFT) && checkDirection(x,y,x-1,y+1)) {
          swap(x,y,x-1,y+1);
        } else if (dir(curr, D_DOWNLEFT) && checkDirection(x,y,x+1,y+1)) {
          swap(x,y,x+1,y+1);
        }
      } else {
        if (dir(curr,D_RIGHT) && checkDirection(x,y,x+1,y)) {
          swap(x,y,x+1,y);
        } else if (dir(curr, D_LEFT) && checkDirection(x,y,x-1,y)) {
          swap(x,y,x-1,y);
        } else if (dir(curr, D_DOWNRIGHT) && checkDirection(x,y,x+1,y+1)) {
          swap(x,y,x+1,y+1);
        } else if (dir(curr, D_DOWNLEFT) && checkDirection(x,y,x-1,y+1)) {
          swap(x,y,x-1,y+1);
        }
      }
      
      

    }
  }
}

void swap(int x0, int y0, int x1, int y1) {
  TYPE t0 = getType(x0, y0);

  TYPE t1 = getType(x1, y1);
  
  
  map[x0][y0] = t1;
  map[x1][y1] = t0;
}


boolean checkDirection(int x0, int y0, int x1, int y1) {

  TYPE t0 = getType(x0, y0);
  if (t0 == TYPE.INVALID) return false;
  float d0 = densityMap.get(t0);
  TYPE t1 = getType(x1, y1);
  if (t1 == TYPE.INVALID) return false;
  float d1 = densityMap.get(t1);


  if (t0 != t1 && d0 > d1) {
    return true;
  } else {
    return false;
  }
}

void updateMap() {
  int c = 0;
  for (int x = 0; x < W; x += 1) {

    for (int y = H-1; y >= 0; y -= 1) {
      c = (c + floor(random(3))) % 10;

      TYPE me = getType(x, y);

      if (me == TYPE.SAND || me == TYPE.WATER) {

        TYPE below = getType(x, y+1);
        TYPE left = getType(x-1, y);
        TYPE right = getType(x+1, y);
        TYPE bLeft = getType(x-1, y+1);
        TYPE bRight = getType(x+1, y+1);

        if (below == TYPE.AIR) {
          setMap(x, y+1, me);
          setMap(x, y, TYPE.AIR);
        } else if (c % 2 == 0) {
          if (bLeft == TYPE.AIR) {
            setMap(x-1, y+1, me);
            setMap(x, y, TYPE.AIR);
          } else if (bRight == TYPE.AIR) {
            setMap(x+1, y+1, me);
            setMap(x, y, TYPE.AIR);
          } else if (me == TYPE.WATER) {
            if (left == TYPE.AIR) {
              setMap(x-1, y, TYPE.WATER);
              setMap(x, y, TYPE.AIR);
            } else if (right == TYPE.AIR) {
              setMap(x+1, y, TYPE.WATER);
              setMap(x, y, TYPE.AIR);
            }
          }
        } else if (c % 2 != 0) {
          if (bRight == TYPE.AIR) {
            setMap(x+1, y+1, me);
            setMap(x, y, TYPE.AIR);
          } else     if (bLeft == TYPE.AIR) {
            setMap(x-1, y+1, me);
            setMap(x, y, TYPE.AIR);
          } else if (me == TYPE.WATER) {
            if (right == TYPE.AIR) {
              setMap(x+1, y, TYPE.WATER);
              setMap(x, y, TYPE.AIR);
            } else if (left == TYPE.AIR) {
              setMap(x-1, y, TYPE.WATER);
              setMap(x, y, TYPE.AIR);
            }
          }
        }
      }
    }
  }
}

void drawMap() {
  for (int x = 0; x < W; x += 1) {
    for (int y = 0; y < H; y += 1) {
      TYPE t = map[x][y];
      noStroke();
      fill(255, 255, 0);
      switch(t) {
      case AIR:
        break;
      case SAND:
        rect(x * TW, y * TH, TW, TH);
        break;
      case WATER:
        fill(0, 0, 255);
        rect(x * TW, y * TH, TW, TH);
        break;        
      case INVALID:
        break;
      }
    }
  }
}
