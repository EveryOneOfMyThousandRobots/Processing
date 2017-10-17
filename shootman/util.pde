boolean outOfBounds(float x, float y) {
  if (x < 0 || x >= width || y < 0 || y >= height) {
    return true;
  } else {
    return false;
  }
}

boolean outOfBounds(PVector p) {
  return outOfBounds(p.x, p.y);
}

boolean outOfBounds(PVector p, float r) {
  return outOfBounds(p.x, p.y, r);
}

boolean outOfBounds(float x, float y, float r) {
  if (x - r < 0 || x + r >= width || y - r < 0 || y + r >= height ) {
    return true;
  } else {
    return false;
  }
}

float sigmoid(float x) {
  return 1 / (1 + pow(exp(1), -x));
}

float[] getTile(boolean even) {
  float[] a = new float[2];

  boolean ok = false;
  
  int ax=0, ay=0;
  while (!ok) {
    ax = (int)random(1, tilesAcross-2);
    while ((even && ax % 2 == 0) || (!even && ax % 2 == 1)) {
      ax = (int)random(1, tilesAcross-2);
    }
    ay = (int)random(1, tilesDown-2);
    while ((even && ax % 2 == 0) || (!even && ax % 2 == 1)) {
      ay = (int)random(1, tilesDown-2);
    }
    if ((ax >= 8 && ax <= 11 && ay >= 8 && ay <= 11)) {
    } else {
      ok = true;
    }
  }
  a[0] = ax * tileWidth;
  a[1] = ay * tileHeight;
  return a;
}