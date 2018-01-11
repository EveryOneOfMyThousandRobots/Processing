class Grid {
  int tilesAcross;
  int tilesDown;
  int tileSize;
  PVector[][] map;
  float zz = 0;

  Grid (int tileSize) {
    this.tileSize = tileSize;
    tilesAcross = (width + tileSize*2) / tileSize;
    tilesDown = (height + tileSize*2) / tileSize;
    if (tilesAcross * tileSize < width) {
      tilesAcross += 1;
    }

    if (tilesDown * tileSize < height) {
      tilesDown += 1;
    }

    map = new PVector[tilesAcross][tilesDown];
    setVectors();
  }

  void setVectors() {
    zz += 0.01;
    for (int x = 0; x < map.length; x += 1) {
      float xx = x * 0.05;
      for (int y = 0; y < map[x].length; y += 1) {
        float yy = y * 0.05;
        map[x][y] = PVector.fromAngle(map(noise(xx, yy, zz), 0, 1, 0, TWO_PI));
        map[x][y].mult(random(0.5,1.5));
      }
    }
  }

  void draw() {
    stroke(255);
    noFill();
    for (int x = 0; x < map.length; x += 1) {
      
      for (int y = 0; y < map[x].length; y += 1) {
        
        PVector p = map[x][y].copy().mult(tileSize);
        float xx = x * tileSize;
        float yy = y * tileSize;
        p.add(xx,yy);
        line(xx, yy, p.x, p.y);
        
      }
    }
  }

  PVector getForce(float x, float y) {
    int xx = floor(x / tileSize);
    int yy = floor(y / tileSize);

    if (xx >= 0 && xx <= map.length-1 && yy >= 0 && yy <= map[0].length -1) {
      return map[xx][yy];
    } else {
      return null;
    }
  }
}