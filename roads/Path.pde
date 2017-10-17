class Path {
  Node[][] pathNodes;
  Node start, end;
  Node lastChecked;
  ArrayList<Node> openSet, closedSet, path;



  Path (int fromX, int fromY, int toX, int toY) {
    pathNodes = new Node[nodes.length][nodes[0].length];
    for (int ix = 0; ix < nodes.length; ix += 1) {
      for (int iy = 0; iy < nodes[ix].length; iy += 1) {
        pathNodes[ix][iy] = nodes[ix][iy].copy();
      }
    }

    //for (int ix = 0; ix < pathNodes.length; ix += 1) {
    //  for (int iy = 0; iy < pathNodes[ix].length; iy += 1) {
    //    pathNodes[ix][iy].findNeighbours();
    //  }
    //}

    start = pathNodes[fromX][fromY];
    end = pathNodes[toX][toY];

    openSet = new  ArrayList<Node>();
    closedSet = new  ArrayList<Node>();
    path = new  ArrayList<Node>();
    openSet.add(start);
  }

  void printPath() {
    for (Node node : path) {

      println(node);
    }
  }

  void draw(color col) {
    //stroke(0);


    //fill(255);
    //for (Node node : openSet) {

    //  ellipse(node.targetPos.x, node.targetPos.y, 5, 5);
    //}

    //fill(100, 255, 255);
    //for (Node node : closedSet) {

    //  ellipse(node.targetPos.x, node.targetPos.y, 5, 5);
    //}
    //stroke(255);
    //fill(GREEN);
    //ellipse(start.targetPos.x, start.targetPos.y, 10, 10);

    //fill(RED);
    //ellipse(end.targetPos.x, end.targetPos.y, 10, 10);
    float lx, ly;
    lx = path.get(0).targetPos.x;
    ly = path.get(0).targetPos.y;
    fill(255);
    stroke(255);
    for (int i = 1; i < path.size(); i += 1) {
      Node n = path.get(i);
      line(lx, ly, n.targetPos.x, n.targetPos.y);
      lx = n.targetPos.x;
      ly = n.targetPos.y;
      //ellipse(node.targetPos.x, node.targetPos.y, 5, 5);
    }
  }

  void findPath() {
    while (!openSet.isEmpty()) {
      //println("openSet : " + openSet.size());
      int winner = 0;
      for (int i = 0; i < openSet.size(); i += 1) {
        if (openSet.get(i).f < openSet.get(winner).f) {
          winner = i;
        }
      }

      Node current = openSet.get(winner);
      lastChecked = current;
      //println("current: " + current);

      path.clear();
      Node temp = current;
      path.add(temp);
      while (temp.previous != null) {

        path.add(temp.previous);
        temp = temp.previous;
      }
      if (current.id == end.id) {

        //println("DONE!" + path);
        //finished
        return;
      }

      openSet.remove(current);
      closedSet.add(current);
      current.findNeighbours();
      ArrayList<Node> neighbours = current.neighbours;

      for (int i = 0; i < neighbours.size(); i += 1) {
        Node neighbour = neighbours.get(i);

        if (!closedSet.contains(neighbour) && neighbour.type != NodeType.WALL) {
          float tempG = current.g + heuristic(neighbour, current);

          if (!openSet.contains(neighbour)) {
            openSet.add(neighbour);
          } else if (tempG > neighbour.g) {
            continue;
          }

          neighbour.g = tempG;
          neighbour.h = heuristic(neighbour, end);
          neighbour.f = neighbour.g + neighbour.h;
          neighbour.previous = current;
        }
      }
    }
    println("NO SOLUTION");
    return;
  }
}