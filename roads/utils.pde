import java.util.TreeMap;
TreeMap <String, Integer> idMap = new TreeMap<String, Integer>();
int getId(String name) {
  int returnVal = 0;
  name = name.toUpperCase().trim();
  if (!idMap.containsKey(name)) {
    idMap.put(name, 1);
    returnVal = 1;
  } else {
    returnVal = idMap.get(name) + 1;

    idMap.put(name, returnVal);
  }

  return returnVal;
}

Node getNode(int ix, int iy) {  
  if (ix >= 0 && ix < COLS && iy >= 0 && iy < ROWS) {
    return nodes[ix][iy];
  }
  return null;
}

float heuristic(Node a, Node b) {
  float dist = PVector.dist(a.pos, b.pos) + b.cost;
  
  return dist;
}