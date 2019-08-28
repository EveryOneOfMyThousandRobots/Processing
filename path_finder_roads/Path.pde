

class Path {
  HashSet<Node> closed = new HashSet<Node>();
  HashSet<Node> open = new HashSet<Node>();
  HashMap<Node, Node> cameFrom = new HashMap<Node, Node>();
  HashMap<Node, Float> gScore = new HashMap<Node, Float>();
  HashMap<Node, Float> fScore = new HashMap<Node, Float>();
  ArrayList<Node> path = new ArrayList<Node>();
  float opacity = 200;
  float size = 10;
  Node start, goal;
  Path(Node start, Node goal) {
    this.start = start;
    this.goal = goal;
    open.add(start);
    gScore.put(start,0.0);
    
  }
  
  void reconstructPath(Node current) {
    path.clear();
    path.add(current);
    while (cameFrom.containsKey(current)) {
      current = cameFrom.get(current);
      path.add(current);
    }
    
  }
  
  
  void draw() {
    noStroke();
    fill(0,0,255,opacity);
    for (Node n : open) {
      circle(n.pos.x, n.pos.y, size);
    }
    
    fill(255,0,0, opacity);
    for (Node n : closed) {
      circle(n.pos.x, n.pos.y, size);
    }
    
    fill(255,255,0,opacity);
    for (Node n : path) {
      circle(n.pos.x, n.pos.y,size);
      
    }
  }

  float nodeDist(Node a, Node b) {
    return PVector.dist(a.pos, b.pos);
  }

  void go() {
    while (!open.isEmpty()) {
      Node current = null; //<>//
      float f = Float.MAX_VALUE;    
      for (Node n : open) {
        if (current == null) {
          current = n;
          f = getF(current);
        }
        float temp = getF(n);
        if (temp < f) {
          f = temp;
          current = n;
        }
      }
      if (current != null) {
        if (current.equals(goal)) {
          reconstructPath(current);
          break;
        } else {
          open.remove(current);
          closed.add(current);
          for (Node n : current.neighbours) {
            if (closed.contains(n)) {
              continue;
            } else {
              float tg = getG(current) + nodeDist(current,n);
              
              if (!open.contains(n)) {
                open.add(n);
              } else if (tg >= getG(n)) {
                continue;
              }
              cameFrom.put(n,current);
              gScore.put(n, tg);
              fScore.put(n, getG(n) + nodeDist(n,goal));
            }
          }
        }
      }
    }
  }


  float getF(Node n) {
    
    if (!fScore.containsKey(n)) {
      fScore.put(n, Float.MAX_VALUE);
      return fScore.get(n);
    } else {
      //println(n);
      return fScore.get(n); //<>//
    }
  }

  float getG(Node n) {
    if (!gScore.containsKey(n)) {
      gScore.put(n, Float.MAX_VALUE-1);
      return Float.MAX_VALUE-1;
    } else {
      
      return gScore.get(n);
    }
  }
}

float h(Node a, Node b) {
  return a.pos.dist(b.pos);
}
