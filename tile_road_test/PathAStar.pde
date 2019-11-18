import java.util.*;
class Path {
  ArrayList<Node> open = new ArrayList<Node>();
  HashSet<Node> closed = new HashSet<Node>();

  HashMap<Node, Node> cameFrom = new HashMap<Node, Node>();
  Node[][] nodes;
  Node start, end;
  ArrayList<Tile> path;
  Path(Tile start, Tile end) {

    nodes = new Node[TA][TD];
    for (int x = 0; x < TA; x += 1) {
      for (int y = 0; y < TD; y += 1) {
        nodes[x][y] = new Node(x, y);
      }
    }

    for (int x = 0; x < TA; x += 1) {
      for (int y = 0; y < TD; y += 1) {
        Node n = nodes[x][y];

        n.neighbours[0] = getNode(x-1, y);
        n.neighbours[1] = getNode(x+1, y);
        n.neighbours[2] = getNode(x, y-1);
        n.neighbours[3] = getNode(x, y+1);
      }
    }



    this.start = getNode(start.x, start.y);
    this.end = getNode(end.x, end.y);
  }

  Node getNode(int x, int y) {
    if (!OOB(x, y)) {
      Node n = nodes[x][y];
      if (n.moveFactor == 0) {
        return null;
      }
      return n;
    } 
    return null;
  }

  boolean findPath() {
    open.add(start);
    while (!open.isEmpty()) {
      Node current = open.get(0);


      for (int i = 1; i < open.size(); i += 1) {
        Node o = open.get(i);
        if (o.fCost() < current.fCost() || (o.fCost() == current.fCost() && o.hCost < current.hCost)) {
          current = o;
        }
      }

      open.remove(current);
      closed.add(current);
      if (current == null) {
        return false;
      }
      if (current == end) {

        retracePath();
        return true;
      } else {
        for (int i = 0; i < current.neighbours.length; i += 1) {
          Node n = current.neighbours[i];
          if (n != null) {
            if (n.moveFactor <= 0 || closed.contains(n)) {
              continue;
            }

            int newMovementCost = current.gCost + qDist(current, n);

            if (newMovementCost < n.gCost || !open.contains(n)) {
              n.gCost = newMovementCost;
              n.hCost = qDist(n, end);
              n.parent = current;
              cameFrom.put(n, current);
              if (!open.contains(n)) {
                open.add(n);
              }
            }
          }
        }
      }
    }
    return false;
  }

  void retracePath() {
    ArrayList<Node> npath = new ArrayList<Node>();

    Node current = end;

    while (current != start) {
      npath.add(current);
      current = current.parent;
    }
    Collections.reverse(npath);
    path = new ArrayList<Tile>();
    for (int i = 0; i < npath.size(); i += 1) {
      path.add(getTile(npath.get(i).x, npath.get(i).y));
    }
  }
}


int qDist(Node a, Node b) {

  return abs(a.x - b.x) + abs(a.y - b.y);
}

class Node {
  Tile tile;
  Node parent;
  int gCost = Integer.MAX_VALUE, hCost = Integer.MAX_VALUE;
  float moveFactor = 1;

  float fCost() {
    return gCost + hCost;
  }
  int hashCode() {
    return hash.hashCode();
  }


  Node[] neighbours = new Node[4];

  boolean equals(Node o) {
    return o.hashCode() == hashCode();
  }
  final int x, y;
  final String hash;
  Node (int x, int y) {
    this.x = x;
    this.y = y;
    hash = x +"_"+y;
    this.tile = getTile(x, y);
    switch(tile.type) {
    case BUILDING:
      moveFactor = 0;
      break;
    case ROAD:
      moveFactor = 1;
      break;
    case GROUND:
      moveFactor = 0.5;
      break;
    }
  }

  void setNeighbours() {
  }
}
