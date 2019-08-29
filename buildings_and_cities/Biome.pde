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
        int x = floor(random(xFrom,xTo));
        int y = floor(random(yFrom,yTo));
        if (OOB(x,y)) continue;
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
