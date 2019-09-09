class Path {
  HashMap<Node, Float> gScore = new HashMap<Node, Float>();
  HashMap<Node, Float> fScore = new HashMap<Node, Float>();
  HashMap<Node, Float> hScore = new HashMap<Node, Float>();
  HashMap<Node, Node> cameFrom = new HashMap<Node, Node>();
  ArrayList<Node> open = new ArrayList<Node>();
  ArrayList<Node> closed = new ArrayList<Node>();
  ArrayList<Node> path = new ArrayList<Node>();
  Node start, end;
  Path(Node start, Node end) {
    this.start = start;
    this.end = end;
    open.add(start);
    gScore.put(start, 0.0f);
    fScore.put(start,0.0f);
  }

  float g(Node n) {
    if (gScore.containsKey(n)) {
      return gScore.get(n);
    } else {
      return Float.POSITIVE_INFINITY;
    }
  }

  float f(Node n) {
    if (fScore.containsKey(n)) {
      return fScore.get(n);
    } else {
      return Float.POSITIVE_INFINITY;
    }
  }
  
  Node lowestF() {
    Node low = null;
    float lowestF = 0;
    for (Node n : open) {
      if (low == null || f(n) < lowestF) {
        low = n;
        lowestF = f(n);
      }
    }
    
    
    return low;
  }


  boolean findPath() {
    
    while (!open.isEmpty()) {
      Node current = lowestF();
      if (current.equals(end)) {
        reconstruct(current);
        return true;
      }
      
      open.remove(current);

      closed.add(current);
      
      
      for (Node n : current.neighbours) {
        if (closed.contains(n)) continue;
        
        float tg = g(current) + hDist(current,n);
        if (tg < g(n)) {
          cameFrom.put(n,current);
          gScore.put(n,tg);
          fScore.put(n, g(n)+hDist(n,end));
          if (!open.contains(n)) {
            open.add(n);
          }
        }
      }
    }


    return false;
  }
  
  float hDist(Node a, Node b) {
    return PVector.dist(a.pos, b.pos);
  }
  
  void reconstruct(Node current) {
    path.clear();
    path.add(current);
    while (cameFrom.containsKey(current)) {
      current = cameFrom.get(current);
      path.add(0,current);
    }
    
  }
}
