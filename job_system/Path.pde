class Path {
  Node start, goal;
  HashSet<Node> closedSet = new HashSet<Node>();
  HashSet<Node> openSet = new HashSet<Node>();
  HashMap<Node, Node> cameFrom = new HashMap<Node, Node>();
  HashMap<Node, Float> gScore = new HashMap<Node, Float>();
  HashMap<Node, Float> fScore = new HashMap<Node, Float>();
  ArrayList<Node> path = new ArrayList<Node>();
  int pathIndex = -1;
  Node getNextNode() {
    pathIndex += 1;
    return getCurrentNode();
  }

  Node getCurrentNode() {
    if (pathIndex > path.size() - 1) return null;
    return path.get(pathIndex);
  }

  //HashSet<Node> closedSet = new HashSet<Node>();
  boolean foundPath = false;

  float getF(Node n) {
    if (fScore.containsKey(n)) {
      return fScore.get(n);
    } else {
      return Float.MAX_VALUE-1;
    }
  }

  float getG(Node n) {
    if (gScore.containsKey(n)) {
      return gScore.get(n);
    } else {
      return Float.MAX_VALUE-1;
    }
  }

  void recontruct(Node current) {
    path.add(current);

    while (cameFrom.containsKey(current)) {
      current = cameFrom.get(current);
      path.add(current);
    }

    ArrayList<Node> ptemp = new ArrayList<Node>();
    for (int i = path.size() - 1; i >= 0; i -= 1) {
      ptemp.add(path.get(i));
    }

    path = ptemp;
  }

  void findPath() {
    openSet.add(start);
    gScore.put(start, 0f);
    fScore.put(start, heuristic(start, goal));
    Node current = null;

    while (!openSet.isEmpty()) {

      current = null;
      float lowestF = 0 ;//Float.MAX_VALUE;
      for (Node n : openSet) {
        if (current == null) {
          current = n;
          lowestF = getF(n);
        } else if (getF(n) < lowestF) {
          current = n;
          lowestF = getF(n);
        }
      }

      if (current != null) {
        if (current.equals(goal)) {
          //reconstructpath
          foundPath = true;

          recontruct(current);
          //openSet.clear();
          //break;
          return;
        } else {
          openSet.remove(current);
          closedSet.add(current);
          Collections.sort(current.neighbours, rnc);
          for (Node nbor : current.neighbours) {
            if (closedSet.contains(nbor)) continue;

            float tg = getG(current) + PVector.dist(current.pos, nbor.pos);
            if (!openSet.contains(nbor)) {
              openSet.add(nbor);
            } else if (tg >= getG(nbor)) {
              continue;
            }

            cameFrom.put(nbor, current);
            gScore.put(nbor, tg);
            fScore.put(nbor, tg + heuristic(nbor, goal));
          }
        }
      }
    }
  }


  Path(Node start, Node goal) {
    this.start = start;
    this.goal = goal;
    findPath();
  }

  void draw() {
    if (DRAW_PATHS) {
      GAME_WINDOW.stroke(255, 0, 0, 64);
      GAME_WINDOW.noFill();
      GAME_WINDOW.beginShape();
      for (Node n : path) {
        GAME_WINDOW.vertex(n.pos.x, n.pos.y);
      }
      GAME_WINDOW.endShape();

      GAME_WINDOW.noStroke();
      GAME_WINDOW.fill(255, 60);
      for (Node n : openSet) {
        GAME_WINDOW.ellipse(n.pos.x, n.pos.y, 3, 3);
      }
      GAME_WINDOW.fill(255, 0, 0, 60);
      for (Node n : closedSet) {
        GAME_WINDOW.ellipse(n.pos.x, n.pos.y, 3, 3);
      }
    }
  }
}

float heuristic(Node a, Node b) {
  return PVector.dist(a.pos, b.pos) + a.cost;
}
