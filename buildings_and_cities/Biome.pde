int biome_id = 0;
ArrayList<Biome> biomes; 
HashMap<Integer, Biome> lookup = new HashMap<Integer, Biome>();
class Biome {
  ArrayList<IntPair> toCheck = new ArrayList<IntPair>();
  ArrayList<IntPair> newNodes = new ArrayList<IntPair>();
  boolean ignoresStructures = false;
  final int id;
  {
    biome_id += 1;
    id = biome_id;
  }


  color c;
  boolean first = true;

  Biome(color c) {
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

  void update() {
    //println(toCheck.size());
    if (first) {
      boolean found = false;
      while (!found) {
        int x = floor(random(MAP_WIDTH));
        int y = floor(random(MAP_HEIGHT));
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
