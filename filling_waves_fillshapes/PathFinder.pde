class PathFinder {

  HashSet<Tuple> nodes = new HashSet<Tuple>();


  int[][] flowField;

  PathFinder(Node start, Node end, Node[][] globalNodes) {
    flowField = new int[TA][TD];
    for (int x = 0; x < TA; x += 1) {
      for (int y = 0; y < TD; y += 1) {
        flowField[x][y] = globalNodes[x][y].d;
      }
    }


    nodes.add(tup(end,1));

    while (!nodes.isEmpty()) {
      HashSet<Tuple> newNodes = new HashSet<Tuple>();
      for (Tuple n : nodes) {
        int x = n.x;
        int y = n.y;
        int d = n.d;
        flowField[x][y] = d;
        
        
        
        add(newNodes,x+1,y,d+1);
        add(newNodes,x-1,y,d+1);
        add(newNodes,x,y+1,d+1);
        add(newNodes,x,y-1,d+1);
      }
      
      //printArray(nodes);
      nodes.clear();
      nodes = newNodes;
      
    }
  }


  void add(HashSet<Tuple> list, int x, int y, int d) {
    if (!OOB(x, y) && flowField[x][y] == 0) {
      Tuple t = tup(x, y, d);
      
      if (!list.contains(t)) {
        //println("adding " + t + " " + list.size());
        list.add(t);
      }
    }
  }
}
