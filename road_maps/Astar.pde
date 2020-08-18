class PathFinder {

  Node start, end;
  ArrayList<Node> path = new ArrayList<Node>();
  ArrayList<Node> open = new ArrayList<Node>();
  ArrayList<Node> closed = new ArrayList<Node>();

  HashMap<Node, Node> cameFrom = new HashMap<Node, Node>();
  HashMap<Node, Float> gScore = new HashMap<Node, Float>();
  HashMap<Node, Float> fScore = new HashMap<Node, Float>();

  float G(Node n) {
    if (gScore.containsKey(n)) {
      return gScore.get(n);
    } else {
      return Float.MAX_VALUE;
    }
  }

  float F(Node n) {
    if (fScore.containsKey(n)) {
      return fScore.get(n);
    } else {
      return Float.MAX_VALUE;
    }
  }
  
  
  


  PathFinder(Node start, Node end) {
    this.start = start;
    this.end = end;
    open.add(start);
    gScore.put(start, 0.0);
    fScore.put(start, h(start));
  }

  void reconstruct(Node current) {
    path.clear();
    
    path.add(current);
    while (cameFrom.containsKey(current)) {
      current = cameFrom.get(current);
      path.add(0,current);
    }
    
  }


  boolean findPath() {
    while (!open.isEmpty()) {
      Node current = null;
      float lowestF = Float.MAX_VALUE;
      for (Node n : open) {

        float f = F(n);
        if (current == null || f < lowestF) {
          current = n;
        }
      }
      println("current = " + current);


      if (current != null) {
        if (current.equals(end)) {
          println("found end");
          reconstruct(current);
          return true;
        }
        
        
        open.remove(current);


        for (Node nn : current.neighbours) {
          
          float tg = G(current) + PVector.dist(current.pos, nn.pos);
          println("\tn = " + nn + " tg = " + tg + " g(nn) = " + G(nn));
          if (tg < G(nn)) {
            println("changin path " + nn + " --> " + current);
            cameFrom.put(nn, current);
            gScore.put(nn, tg);
            fScore.put(nn, tg + h(nn));
            if (!open.contains(nn)) {
              open.add(nn);
            }
          }
          
        }
      }
    }

    return false;
  }

  float h(Node n) {
    return PVector.dist(end.pos, n.pos);//dist(n.x, n.y, end.x, end.y);
  }
}
