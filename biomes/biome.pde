int biome_id = 0;
class IntPair {
  final int x, y;
  final private String h;
  IntPair(int x, int y) {
    this.x = x;
    this.y = y;
    h = x + "_" + y;
  }

  int hashCode() {
    return h.hashCode();
  }

  @Override 
    boolean equals(Object o ) {
    if (o instanceof IntPair) {
      IntPair op = (IntPair) o;

      return (x == op.x && y == op.y);
    } else {
      return false;
    }
  }
}
IntPair MakePair(int x, int y) {
  return new IntPair(x, y);
}
import java.util.HashSet;

class Biome {
  ArrayList<IntPair> toCheck = new ArrayList<IntPair>();
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
    if (map[x][y] != 0) {
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

  boolean setNeighbour(int x, int y) {
    if (OOB(x, y)) return false;

    int v = map[x][y];

    if (v != 0) {
      return false;
    }

    map[x][y] = id;

    AddToCheck(x, y);

    return true;
  }

  void update() {
    //println(toCheck.size());
    if (first) {
      boolean found = false;
      while (!found) {
        int x = floor(random(width));
        int y = floor(random(height));

        int v = map[x][y];
        if (v == 0) {
          found = true;
          map[x][y] = id;


          AddToCheck(x, y);
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
