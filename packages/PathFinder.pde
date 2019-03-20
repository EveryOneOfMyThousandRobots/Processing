class PathFinder {
  ArrayList<Node> closed = new ArrayList<Node>();
  ArrayList<Node> open = new ArrayList<Node>();
  HashMap<Node, Float> gScore = new HashMap<Node, Float>();
  HashMap<Node, Float> fScore = new HashMap<Node, Float>();
  HashMap<Node, Node> cameFrom = new HashMap<Node, Node>();
  Node start, end;
  boolean foundPath = false;
  ArrayList<Node> path = new ArrayList<Node>();

  PathFinder(Node start, Node end) {
    this.start = start;
    this.end = end;

    open.add(start);

    for (Node n : nodes) {
      gScore.put(n, Float.MAX_VALUE-1);
      fScore.put(n, Float.MAX_VALUE-1);
    }
    gScore.put(start, 0f);
    fScore.put(start, h(start, end));

    findPath();
  }

  void findPath() {
    Node current = null;
    while (!open.isEmpty()) {
      current = null;

      float lowest = 0;

      for (Node o : open) {
        float f = fScore.get(o);
        if (current == null || f < lowest) {
          lowest = f;
          current = o;
        }
      }
      //print(current);
      if (current != null) {
        if (current.equals(end)) {
          foundPath = true;
          //println("found path");
          constructPath();
          return;
        }
        //print("\nbefore Remove " + open.size());
        open.remove(current);
        //print("\nafter Remove " + open.size());
        closed.add(current);
        //println("num nbrs = " + current.neighbours.size());
        for (Node nbr : current.neighbours) {
          if (closed.contains(nbr)) {
            continue;
          }

          float tgs = gScore.get(current) + PVector.dist(current.pos, nbr.pos);
          //println(current + " >" + nbr + " t:" + tgs);

          if (!open.contains(nbr) ) {
            open.add(nbr);
          } else if (tgs >= gScore.get(nbr)) {
            continue;
          }

          cameFrom.put(nbr, current);
          gScore.put(nbr, tgs);
          fScore.put(nbr, gScore.get(nbr) + h(nbr, end));
        }
      }
    }
  }


  void constructPath() {
    Node current = end;
    path.clear();
    path.add(current);
    while (cameFrom.keySet().contains(current)) {
      current = cameFrom.get(current);
      path.add(current);
    }
    ArrayList<Node> reversePath = new ArrayList<Node>();
    for (int i = path.size()-1; i >= 0; i -= 1) {
      reversePath.add(path.get(i));
    }
    path = reversePath;
  }

  void draw() {
    noFill();
    stroke(128, 0, 128);
    ellipse(start.pos.x, start.pos.y, 30, 30);

    stroke(0, 128, 128);
    ellipse(end.pos.x, end.pos.y, 30, 30);
    stroke(0, 0, 255);

    //strokeWeight(5);
    for (Node n : open) {
      ellipse(n.pos.x, n.pos.y, 10, 10);
    }

    stroke(255, 0, 0);

    for (Node n : closed) {
      ellipse(n.pos.x, n.pos.y, 10, 10);
    }

    if (foundPath) {
      strokeWeight(2);
      stroke(0, 255, 0);
      for (Node n : path) {
        ellipse(n.pos.x, n.pos.y, 10, 10);
      }
    }
    strokeWeight(1);
  }
}

float h(Node a, Node b) {
  //float f = Float.MAX_VALUE;

  for (Conn c : connections) {
    if (c.from.id == a.id && c.to.id == b.id) {
      return c.cost;
    }
  }

  return PVector.dist(a.pos, b.pos);
}
