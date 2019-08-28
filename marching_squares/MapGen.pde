class MapGen {
  //0 - 100
  private int[][] map;
  private int[][] holdMap;
  int fillPercent;
  int w, h;
  String seed;
  boolean useRandomSeed = false;
  int smoothing;

  String toString() {
    return "seed: " + seed + "\nfill:" + fillPercent + " s:" + smoothing + " sh:" + seed.hashCode();
  }

  MapGen(String seed, int fillPercent, int w, int h, int smoothing, boolean useRandom) {
    this.fillPercent = fillPercent;
    this.w = w;
    this.h = h;
    this.seed = seed;
    this.smoothing = smoothing;

    this.useRandomSeed = useRandom;

    if (useRandomSeed) {


      setRandomSeed();
    }
  }

  void setRandomSeed() {
    if (useRandomSeed) {
      seed = new Date().getTime() + "_" + millis() + "_" + random(0, 1000000) + "_" + mouseX + "_" + mouseY;
    }
  }

  void generate() {
    setRandomSeed();
    map = new int[w][h];
    holdMap = new int[w][h];
    randomSeed(seed.hashCode());
    noiseSeed(seed.hashCode());

    for (int x = 0; x < map.length; x += 1) {
      float xf = float(x) * 0.1;
      for (int y = 0; y < map[x].length; y += 1) {
        float yf = float(y) * 0.1;
        if (x == 0 || x == w -1 || y == 0 || y == h - 1) {
          map[x][y] = 1;
        } else {
          
          //map[x][y] = floor(random(0, 100)) < fillPercent ? 1 : 0;
          float f = noise(xf, yf);
          map[x][y] = floor(f * 100.0) < fillPercent ? 1 : 0;
        }
      }
    }
    smoothMap();
  }

  void smoothMap() {
    //for (int x = 0; x < map.length; x += 1) {
    //  for (int y = 0; y < map[x].length; y += 1) {
    //    holdMap[x][y] = map[x][y];
    //  }
    //}


    for (int i = 0; i < smoothing; i += 1) {
      for (int x = 0; x < map.length; x += 1) {
        for (int y = 0; y < map[x].length; y += 1) {
          int neighbourWalls = getCountOfWalls(x, y);

          if (neighbourWalls > threshhold) {
            map[x][y] = 1;
          } else if (neighbourWalls < threshhold) {
            map[x][y] = 0;
          }
        }
      }
    }
  }

  int getCountOfWalls(final int x, final int y) {

    int wallCount = 0;

    for (int nx = x - 1; nx <= x + 1; nx += 1) {

      for (int ny = y - 1; ny <= y + 1; ny += 1) {
        if (nx == x && ny == y) continue;
        if (nx < 0 || nx > w-1 || ny < 0 || ny > h-1) {
          wallCount += 1;
        } else {
          wallCount += map[nx][ny];
        }
      }
    }


    return wallCount;
  }

  void draw() {
    noStroke();
    for (int x = 0; x < map.length; x += 1) {
      for (int y = 0; y < map[x].length; y += 1) {

        color c = map[x][y] == 1 ? color(255, 64) : color(0, 0);

        fill(c);
        rect(x * res, y * res, res, res);
      }
    }
  }
}
