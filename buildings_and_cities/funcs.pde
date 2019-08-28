boolean BuildingFits(int tlx, int tly, int brx, int bry) {
  boolean fits = true;
  for (int x = tlx; x <= brx; x += 1) {
    for (int y = tly; y <= bry; y += 1) {
      if (OOB(x, y)) {
        fits = false;
        break;
      } else {
        TYPES t = typeMap[x][y];
        if (t != null && t == TYPES.WALL) {
        } else if (t != null) {
          fits = false;
          break;
        }
      }
    }
    if (!fits) {
      break;
    }
  }


  return fits;
}

boolean OOB(int x, int y) {
  return (x < 0 || x > MAP_WIDTH-1 || y < 0 || y > MAP_HEIGHT-1);
}

boolean xChance2(float x) {
  float xx = x / MAP_WIDTH;
  return random(1) < (xx/2);
}
boolean xChance(float x) {
  float xx = x / MAP_WIDTH;
  return random(1) < (xx);
}
float sorandom() {
  return (random(1) + random(1) + random(1)) / 3.0;
}
