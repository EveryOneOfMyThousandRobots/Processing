

class PathFinder {
  ArrayList<Node> openSet = new ArrayList<Node>();
  ArrayList<Node> closedSet = new ArrayList<Node>();
  HashMap<Node, Float> gScore = new HashMap<Node, Float>();
  HashMap<Node, Float> fScore = new HashMap<Node, Float>();
  HashMap<Node, Node> cameFrom = new HashMap<Node, Node>();
  Node start, end;
  boolean foundPath = false;
  ArrayList<Node> path = new ArrayList<Node>();

  PathFinder(Node start, Node end) {
    this.start = start;
    this.end = end;
    openSet.add(start);
    for (int x = 0; x < NODES_ACROSS; x += 1) {
      for (int y = 0; y < NODES_DOWN; y += 1) {
        int idx = x + y * NODES_ACROSS;
        gScore.put(nodes.get(idx), Float.MAX_VALUE-1);
        fScore.put(nodes.get(idx), Float.MAX_VALUE-1);
      }
    }

    gScore.put(start, 0f);
    fScore.put(start, h(start, end));
    print("\nfinding Path");
    findPath();
  }

  void draw() {
    stroke(0, 0, 255);
    noFill();
    //strokeWeight(5);
    for (Node n : openSet) {
      ellipse(n.pos.x, n.pos.y, 10, 10);
    }

    stroke(255, 0, 0);

    for (Node n : closedSet) {
      ellipse(n.pos.x, n.pos.y, 10, 10);
    }

    if (foundPath) {
      //strokeWeight(2);
      stroke(0, 255, 0);
      for (Node n : path) {
        ellipse(n.pos.x, n.pos.y, 10, 10);
      }
    }
    //strokeWeight(1);
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

  void findPath() {
    int steps = 0;
    Node current = null;
    while (!openSet.isEmpty()) {
      current  = null;
      steps += 1;
      //print("\n current : " + current + " step " + steps + " open(" + openSet.size() + ") closed(" + closedSet.size() + ") ");
      float lowest = 0 ;//Float.MAX_VALUE;
      for (Node o : openSet) {
        float f = fScore.get(o);
        if (current == null || f < lowest) {
          lowest = f;
          current = o;
        }
      }



      if (current != null) {

        if (current.equals(end)) {
          println("found a path!");
          foundPath = true;
          constructPath();
          return;
        }
        //print("\nbefore Remove " + openSet.size());
        openSet.remove(current);
        //print("\nafter  Remove " + openSet.size());
        closedSet.add(current);

        for (Node neighbour : current.neighbours) {
          if (closedSet.contains(neighbour)) continue;

          float tentativeGScore = gScore.get(current) + PVector.dist(current.pos, neighbour.pos);
          if (!openSet.contains(neighbour)) {
            openSet.add(neighbour);
          } else if (tentativeGScore >= gScore.get(neighbour)) {
            continue;
          }
          cameFrom.put(neighbour, current);
          gScore.put(neighbour, tentativeGScore);
          fScore.put(neighbour, gScore.get(neighbour) + h(neighbour, end));
        }
      } else {
        println("current is null");
      }
    }
  }
}


float h(Node a, Node b) {
  return PVector.dist(a.pos, b.pos) + b.cost;
}
