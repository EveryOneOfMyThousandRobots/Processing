import java.util.TreeMap;
TreeMap<String, Integer> uniqueIds = new TreeMap<String, Integer>();
int getNextId(String idName) {
  idName = idName.toUpperCase().trim();

  int returnVal = 0;
  if (!uniqueIds.containsKey(idName)) {
    uniqueIds.put(idName, 1);
    returnVal = 1;
  } else {
    returnVal = uniqueIds.get(idName) + 1;
    uniqueIds.put(idName, returnVal);
  }

  return returnVal;
}

float heuristic(Node a, Node b) {
  //return abs(a.x - b.x) + abs(a.y - b.y) + pow(1 + a.cost, 5);
  //crow
  return PVector.dist(a.pos, b.pos) + pow(1 + a.cost, 2);
}

class CellCompare implements Comparator<Cell> {
  int compare(Cell c1, Cell c2) {
    return c1.compareTo(c2);
  }
}

CellCompare ccomp = new CellCompare();

float spare;
boolean isSpareReady = false;

float bellRandom(float min, float max) {
  return map(getGaussian(0,0.2), -1, 1, min, max);
}

float getGaussian(float mean, float stdDev) {
  if (isSpareReady) {
    isSpareReady = false;
    return spare * stdDev + mean;
  } else {
    float u, v, s;
    do {
      u = random(1) * 2 - 1;
      v = random(1) * 2 - 1;
      s = u * u + v * v;
    } while (s >= 1 || s == 0);
    float mul = sqrt(-2.0 * log(s) / s);
    spare = v * mul;
    isSpareReady = true;
    return mean + stdDev * u * mul;
  }
}