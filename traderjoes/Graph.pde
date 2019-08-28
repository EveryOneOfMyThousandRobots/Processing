class Graph {
  ArrayList<TreeMap<Factory, Integer>> graph = new ArrayList<TreeMap<Factory, Integer>>();
  int maxSize = width / 2;
  int maxValue;

  void update() {

    TreeMap<Factory, Integer> graphEntry = new TreeMap<Factory, Integer>();

    for (Factory f : factories) {
      graphEntry.put(f, int(f.gold));
      
    }
    
    graph.add(graphEntry);

    if (graph.size() > maxSize) {

      while (graph.size() > maxSize) {
        graph.remove(0);
      }
    }
    maxValue = 0;
    for (TreeMap<Factory, Integer> ge : graph) {
      for (Factory f : ge.keySet()) {
        if (ge.get(f) > maxValue) {
          maxValue = ge.get(f);
        }
      }
    }
  }
  
  void draw() {
    int x = 0;
    int yTop = height - (height / 4);
    int yBottom = height;
    for (TreeMap<Factory, Integer> ge : graph) {
      x += 1;
      for (Factory f : ge.keySet()) {
        sideBar.stroke(f.col);
        sideBar.point(x, map(ge.get(f), 0, maxValue, yBottom, yTop));
      }
    }
  }
}
