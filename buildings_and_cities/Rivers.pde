void makeRiver() {
  river = new River(floor(random(MAP_WIDTH)), 0, HALF_PI);
  river.init();
}

River river;
class River {
  ArrayList<IntPair> path = new ArrayList<IntPair>();
  int startX, startY;
  int cX, cY;
  float angle;
  boolean done = false;

  int[][] vKernel = {
    {-1, -2, -1}, 
    {0, 0, 0}, 
    {1, 2, 1}
  };

  int[][] hKernel = {
    {-1, 0, -1}, 
    {-2, 0, 2}, 
    {-1, 0, 1}
  }; 
  float[][] edges;// = new float[MAP_WIDTH][MAP_HEIGHT];
  River(int x, int y, float angle) {
    this.startX = x;
    this.startY = y;
    this.cX = x;
    this.cY = y;
    this.angle = angle;
    edges = new float[MAP_WIDTH][MAP_HEIGHT];
  }

  float maxValue = 0;

  boolean rOOB(int x, int y) {
    return (x < 0 || x > MAP_WIDTH-1 || y < 0 || y > MAP_HEIGHT-1);
  }

  void init() {
    float[][] vEdges = new float[MAP_WIDTH][MAP_HEIGHT];
    float[][] hEdges = new float[MAP_WIDTH][MAP_HEIGHT];

    for (int x = 0; x < MAP_WIDTH; x += 1) {
      for (int y = 0; y < MAP_HEIGHT; y += 1) {
        float vSum = 0;
        float hSum = 0;
        float count = 0;
        for (int xx = -1; xx <= 1; xx += 1) {
          int xp = x + xx;
          int xk = xx + 1;
          for (int yy = -1; yy <= 1; yy += 1) {
            int yp = y + yy;
            int yk = yy + 1;
            if (!rOOB(xp, yp)) {
              float v = 0;

              int biomeId = biomeMap[xp][yp];
              if (biomeId > 0) {
                v = lookup.get(biomeId).c;
              } else {
                TYPES t = typeMap[xp][yp];
                if (t != null) {
                  v = 10e6;
                }
              }
              count += 1;
              vSum += vKernel[xk][yk] * v;
              hSum += hKernel[xk][yk] * v;
            }
          }
        }
        vEdges[x][y] = vSum / count;
        hEdges[x][y] = hSum / count;
      }
    }

    for (int x = 0; x < MAP_WIDTH; x += 1) {
      for (int y = 0; y < MAP_HEIGHT; y += 1) {
        float v = (vEdges[x][y] + hEdges[x][y]) / 2;
        edges[x][y] = v;
        if (v > maxValue) {
          maxValue = v;
        }
      }
    }

    for (int x = 0; x < MAP_WIDTH; x += 1) {
      for (int y = 0; y < MAP_HEIGHT; y += 1) {
        edges[x][y] /= maxValue;
        TYPES t = getType(x, y);
        if (t != null && t == TYPES.WALL) {
          edges[x][y] = 1;
        }

        if (x == 0 || y == 0 || x == MAP_WIDTH-1 || y == MAP_HEIGHT-1) {
          edges[x][y] = 0;
        }
      }
    }
  }

  void update() {
    if (done) return;
    path.add(MakePair(cX, cY));

    if (cY == MAP_HEIGHT-1) {
      done = true;
      return;
    }
    HashMap<IntPair, Float> neighbours = new HashMap<IntPair, Float>();

    for (int x = cX-1; x <= cX+1; x += 1) {
      for (int y = cY; y <= cY+1; y += 1) {

        if (x == cX && y == cY) {

          continue;
        }
        if (rOOB(x, y)) {

          continue;
        }

        if (x == 0 || x == MAP_WIDTH-1 ) continue;

        float v = edges[x][y];

        if (v == 1) continue;

        IntPair p = MakePair(x, y);
        if (path.contains(p)) continue;
        neighbours.put(p, v);
      }
    }
    if (neighbours.size() > 0) {
      IntPair lowest = null;
      float lowestValue = 0;

      for (IntPair p : neighbours.keySet()) {

        float f = neighbours.get(p);
        //println(p.x +"," + p.y + ":" + f);
        if (lowest == null || f < lowestValue) {
          lowest = p;
          lowestValue = f;
        }
      }

      if (lowest != null) {
        cX = lowest.x;
        cY = lowest.y;
      }
    }
  }

  void draw(PGraphics img) {




    //    for (int x = 0; x < MAP_WIDTH; x += 1) {
    //      for (int y = 0; y < MAP_HEIGHT; y += 1) {
    //        float v = edges[x][y];
    //        //if (v > 0.3) {
    //        img.stroke(v * 255);
    //        img.point(x, y);
    //        //}
    //      }
    //    }


    for (int i = 0; i < path.size(); i += 1) {
      IntPair p = path.get(i);
      PVector pv = new PVector(p.x, p.y);


      img.stroke(0, 0, 255);
      for (int xx = p.x-1; xx < p.x + 1; xx += 1) {
        for (int yy = p.y-1; yy < p.y + 1; yy += 1) {
          if (!rOOB(xx, yy)) {
            int xi = floor(xx);
            int yi = floor(yy);

            TYPES tt = getType(xi, yi);
            if (tt != null && tt == TYPES.WALL) break;

            img.point(xx, yy);
          }
        }
      }




      for (int j =i+1; j < i + 4 && j < path.size(); j += 1) {
        IntPair p2 = path.get(j);
        PVector pv2 = new PVector(p2.x, p2.y);

        PVector dir = PVector.sub(pv2, pv);
        dir.normalize();
        PVector dir_r = new PVector(dir.y, -dir.x);
        PVector dir_ro = dir_r.copy();
        dir_ro.mult(-1);

        for (float t = 0.2; t < 2; t += 0.2) {

          float x = pv2.x + (dir_r.x * t);
          float y = pv2.y + (dir_r.y * t);
          int xi = floor(x);
          int yi = floor(y);

          TYPES tt = getType(xi, yi);
          if (tt != null && tt == TYPES.WALL) break;

          img.point(x, y);
        }
        for (float t = 0.2; t < 2; t += 0.2) {
          float x = pv2.x + (dir_ro.x * t);
          float y = pv2.y + (dir_ro.y * t);
          int xi = floor(x);
          int yi = floor(y);

          TYPES tt = getType(xi, yi);
          if (tt != null && tt == TYPES.WALL) break;

          img.point(x, y);
        }
      }
    }
    for (int i = 0; i < path.size(); i += 1) {
      IntPair p = path.get(i);
      img.stroke(0, 0, 255);
      img.point(p.x, p.y);
    }
  }
}
