float[][] map;
float[][] nextMap;
int TA, TD, TS;
void setup() {
  size(400, 400);
  TS = width / 50;
  TA = width / TS;
  TD = height / TS;

  map = new float[TA][TD];
  nextMap = new float[TA][TD];
}


void draw() {
  background(0);
  nextMap = new float[TA][TD];
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      nextMap[x][y] = map[x][y];
    }
  }

  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      float v = map[x][y] / 2;
      map[x][y] /= 2;
      v /= 8;
      for (int xx = -1; xx <= 1; xx += 1) {
        int xp = x + xx;
        if (xp < 0 || xp > TA-1) continue;
        for (int yy = -1; yy <= 1; yy += 1) {
          int yp = y + yy;
          if (yp < 0 || yp > TD-1) continue;

          nextMap[xp][yp] += (v / 8.0);

        }
      }
    }
  }
  noStroke();
  for (int x = 0; x < TA; x += 1) {
    for (int y = 0; y < TD; y += 1) {
      map[x][y] *= 0.5;
      map[x][y] = constrain(map[x][y],0,1);
      fill(map(map[x][y], 0, 1, 0, 255));
      rect(x * TS, y * TS, TS, TS);
    }
  }

  map = nextMap;
  map[TA/2][TD/2] = 1;
}

void mouseDragged() {
  int x = mouseX / TS;
  int y = mouseY / TS;
  map[x][y] = 1;
}
