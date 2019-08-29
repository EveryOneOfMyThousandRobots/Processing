int biome_id = 0;
ArrayList<Biome> biomes; 
HashMap<Integer, Biome> lookup = new HashMap<Integer, Biome>();
class Biome {
  ArrayList<IntPair> toCheck = new ArrayList<IntPair>();
  ArrayList<IntPair> newNodes = new ArrayList<IntPair>();
  boolean ignoresStructures = false;
  boolean alive = true;
  final boolean withStartLimit;
  final int id;
  {
    biome_id += 1;
    id = biome_id;
  }


  color c;
  boolean first = true;

  int startX = -1, startY = -1;
  int startW = -1, startH = -1;
  Biome(color c, int x, int y, int w, int h) {
    withStartLimit = true;
    this.c = c;
    this.startX = x;
    this.startY = y;
    this.startW = w;
    this.startH = h;
    lookup.put(id, this);
  }
  Biome(color c) {
    withStartLimit = false;
    this.c = c;
    lookup.put(id, this);
    //cells = new boolean[width][height];
  }



  boolean checkNeighbours(int x, int y) {
    int n = 0;
    n += cn(x-1, y);
    n += cn(x+1, y);
    n += cn(x, y+1);
    n += cn(x, y-1);

    return n != 4;
  }



  int cn(int x, int y) {
    if (OOB(x, y)) return 1;
    if (biomeMap[x][y] != 0 || (!ignoresStructures && biomeMap[x][y] == -1)) {
      return 1;
    } else {
      return 0;
    }
  }

  void AddToCheck(int x, int y) {
    IntPair p = MakePair(x, y);
    if (!toCheck.contains(p)) {
      toCheck.add(p);
    }
  }

  void AddToNew(int x, int y) {
    IntPair p = MakePair(x, y);
    if (!newNodes.contains(p)) {
      newNodes.add(p);
    }
  }

  boolean setNeighbour(int x, int y) {
    if (OOB(x, y)) return false;

    int v = biomeMap[x][y];

    if (v != 0 || (ignoresStructures && v == -1)) {
      return false;
    }

    biomeMap[x][y] = id;

    AddToNew(x, y);

    return true;
  }

  void swapLists() {
    toCheck = newNodes;
    newNodes = new ArrayList<IntPair>();
  }

  void checkAlive() {
    if (toCheck.size() == 0) alive = false;
  }

  void update() {
    if (!alive) return;



    if (first) {
      int xFrom = 0;
      int xTo = MAP_WIDTH;
      int yFrom = 0;
      int yTo = MAP_HEIGHT;

      if (withStartLimit) {
        xFrom = startX;
        xTo = startX + startW;
        yFrom = startY;
        yTo = startY + startH;
      }


      boolean found = false;
      int attempts = 0;
      while (!found) {
        attempts += 1;
        if (attempts > 100) {
          alive = false;
          return;
        }
        int x = floor(random(xFrom, xTo));
        int y = floor(random(yFrom, yTo));
        if (OOB(x, y)) continue;
        TYPES t = getType(x, y);
        if (t == null) {
          int v = biomeMap[x][y];
          if (v == 0) {
            found = true;
            biomeMap[x][y] = id;


            AddToCheck(x, y);
          }
        }
      }
      first = false;
    } else {
      if (toCheck.size() > 0) {
        IntPair p = toCheck.get(floor(random(toCheck.size())));
        if (!checkNeighbours(p.x, p.y) || random(1) < 0.05) {
          toCheck.remove(p);
        } else {
          boolean found = false;

          if (random(1) < 0.5) {
            //check x
            if (random(1) > 0.5) {
              found = setNeighbour(p.x-1, p.y);
            } else {
              found = setNeighbour(p.x+1, p.y);
            }
          } else {
            //check y

            if (random(1) > 0.5) {
              found = setNeighbour(p.x, p.y-1);
            } else {
              found = setNeighbour(p.x, p.y+1);
            }
          }
        }
      }
    }
  }
}

void addBiomes() {
  while (biomes.size() < 10) {
    biomes.add(new Biome(getColour()));
  }

  for (int x = 0; x < width; x += BLOCK_WIDTH) {
    for (int y = 0; y < height; y += BLOCK_WIDTH) {
      biomes.add(new Biome(getColour(), x, y, BLOCK_WIDTH, BLOCK_WIDTH));
    }
  }

  base = biomes.get(floor(random(biomes.size())));
}


boolean cbActive = false;
int cbx = -1;
int cby = -1;
int cbiterations = -1;
int cbThreshhold = -1;
boolean cbChangeSet = false;
int cbStep = 0;

void cbReset() {
  cbActive = false;
  cbx = -1;
  cby = -1;
  cbiterations = -1;
  cbThreshhold = -1;
  cbChangeSet = false;
  cbStep = 0;
}


void SetBiomeCheck(int iterations, int threshhold, boolean changeSet) {
  cbx = 0;
  cby = 0;
  cbiterations = iterations;
  cbThreshhold = threshhold;
  cbChangeSet = changeSet;
  cbActive = true;
}

void checkBiomes() {
  if (!cbActive) return;

  for (int s = 0; s < MAP_WIDTH * 10; s += 1) {
    int x = cbx;
    int y = cby;
    cbx += 1;
    if (cbx > MAP_WIDTH-1) {
      cbx = 0;
      cby += 1;
      if (cby > MAP_HEIGHT-1) {
        cby = 0;
        cbiterations -= 1;
        if (cbiterations < 0) {
          cbActive = false;
          cbStep += 1;
        }
      }
    }
    //for (int i = 0; i < iterations; i += 1) {
    //  for (int x = 0; x < MAP_WIDTH; x += 1) {
    //    for (int y = 0; y < MAP_HEIGHT; y += 1) {

    if (typeMap[x][y] != null && typeMap[x][y] == TYPES.INTERIOR) continue;
    if (biomeMap[x][y] == -1) continue;
    if (!cbChangeSet && biomeMap[x][y] != 0) continue;

    HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
    for (int xx = -1; xx <= 1; xx += 1) {
      int xp = x + xx;
      for (int yy = -1; yy <= 1; yy += 1) {
        int yp = y + yy;
        if (xp == x && yp == y) continue;
        if (!OOB(xp, yp)) {
          int v = biomeMap[xp][yp];

          if (v > 0) {
            if (map.containsKey(v)) {
              map.put(v, map.get(v)+1);
            } else {
              map.put(v, 1);
            }
          }
        }
      }
    }

    int largest = -1;
    int idOfLargest = -1;

    for (int id : map.keySet()) {
      int v = map.get(id);
      if (v > largest) {
        largest = v;
        idOfLargest = id;
      }
    }

    if (idOfLargest > 0 && largest > cbThreshhold && random(1) > 0.1) {

      biomeMap[x][y] = idOfLargest;
    }
  }
  //    }
  //  }
  //}
}
void setMissedBiomes() {
  for (int x = 0; x < MAP_WIDTH; x += 1) {
    for (int y = 0; y < MAP_HEIGHT; y += 1) {
      if (typeMap[x][y] != null && typeMap[x][y] == TYPES.INTERIOR) continue;
      if (biomeMap[x][y] == -1) continue;
      if (biomeMap[x][y] != 0) continue;

      biomeMap[x][y] = base.id;
    }
  }
}
