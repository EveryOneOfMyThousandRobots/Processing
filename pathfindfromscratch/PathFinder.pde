import java.util.Hashtable;

class Finder {
  Node start, end;
  
  private boolean foundPath = false;

  ArrayList<Node> closed = new ArrayList<Node>();
  ArrayList<Node> open = new ArrayList<Node>();
  ArrayList<Node> finalPath = new ArrayList<Node>();
  
  HashMap<Node, Node> path = new HashMap<Node, Node>();
  
  HashMap<Node, Float> gscore = new HashMap<Node, Float>();
  HashMap<Node, Float> fscore = new HashMap<Node, Float>();

  Finder(Node start, Node end) {
    this.start = start;
    this.end = end;
    open.add(start);
  }
  
  boolean isValid() {
    return foundPath;
  }
  
  private boolean pathStep() {
    if (open.isEmpty()) return false;
         // println("open.size == " + open.size());
      //printArray(open);
      Node current = null;
      float cf = 0;
      float tg = 0; //tentative g
      for (Node o : open) {
        float f = fscore.get(o);
        if (current == null || f < cf) {
          current = o;
          cf = f;
        }
      }



      if (current != null) {

        if (current.equals(end)) {
          //path.add(end);
          finalPath.clear();
          Node c = end;
          while (path.containsKey(c)) {
            finalPath.add(c);
            c = path.get(c);
          }
          finalPath.add(start);
          foundPath = true;
          ArrayList<Node> temp = new ArrayList<Node>();
          for (int i = finalPath.size()-1; i >= 0; i -= 1) {
            temp.add(finalPath.get(i));
          }
          finalPath = temp;
          open.clear();
          closed.clear();
          gscore.clear();
          fscore.clear();
          return true;
        }
        tg = gscore.get(current);
       // println("before remove " + open.size());
        open.remove(current);
      //  println("after remove" + open.size());
        closed.add(current);

        for (Node neighbour : current.neighbours) {
          if (closed.contains(neighbour)) {
            continue;
          } else if (!open.contains(neighbour)) {
            open.add(neighbour);
          }

          float g = tg + PVector.dist(current.pos, neighbour.pos);
          if (tg >= gscore.get(neighbour)) {
            continue;
          }

          //path.add(neighbour);
          path.put(neighbour, current);
          gscore.put(neighbour, g);
          fscore.put(neighbour, gscore.get(neighbour) + hscore(neighbour, end));
        }
      }
      return false;
    
  }

  void findPath() {
    for (int i = 0; i < map.nodes.size(); i += 1) {

      gscore.put(map.nodes.get(i), Float.MAX_VALUE);
      fscore.put(map.nodes.get(i), Float.MAX_VALUE);
    }


    gscore.put(start, 0.0);
    //path.add(start);

    while (!open.isEmpty()) {
      if (pathStep()) {
        break;
      }
    }
  }

  void draw() {
    strokeWeight(3);
    noFill();


    stroke(128, 128, 20);
    for (Node o : open) {
      ellipse(o.pos.x, o.pos.y, 7, 7);
    }
    stroke(0, 0, 255);
    for (Node o : closed) {
      ellipse(o.pos.x, o.pos.y, 7, 7);
    }

    stroke(255, 0, 0);
    ellipse(start.pos.x, start.pos.y, 6, 6);

    stroke(0, 255, 0);
    ellipse(end.pos.x, end.pos.y, 6, 6);
    stroke(255, 0, 0);
    strokeWeight(1);
    beginShape();
    
    for(Node c : finalPath) {
      vertex(c.pos.x, c.pos.y);
    }
    endShape();
  }
}

float hscore(Node from, Node to) {
  return PVector.dist(from.pos, to.pos) + from.traffic;
}
