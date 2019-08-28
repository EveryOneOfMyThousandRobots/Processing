int NODE_ID = 0;
int goBackAmount = 5;
class Node implements Comparable<Node> {
  final int id;
  {
    NODE_ID += 1;
    id = NODE_ID;
  }
  Node parent;
  ArrayList<Node> children = new ArrayList<Node>();
  PVector pos;
  float angle;
  Node(Node parent, float x, float y, float angle) {
    this.parent = parent;
    this.pos = new PVector(x, y);
    this.angle = angle;
    toCheck.add(this);
    allNodes.add(this);
  }

  int hashCode() {
    return id;
  }


  @Override
    boolean equals(Object o) {
    if (!(o instanceof Node)) {
      return false;
    } else {
      Node otherNode = (Node) o;
      return otherNode.id == id;
    }
  }

  int compareTo(Node n) {
    return Integer.compare(id, n.id);
  }

  void draw() {
    stroke(0, 128);
    for (Node n : children) {

      line(pos.x, pos.y, n.pos.x, n.pos.y);
      stroke(255, 0, 0, 128);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  void removeForward() {
    removeLinks();
    if (children.size() > 0) {
      for (int i = children.size()-1; i >= 0; i -= 1) {
        Node n = children.get(i);
        n.removeForward();
        n.parent = null;
        if (i <= children.size()-1) {
          children.remove(i);
        }
        
      }
    }
  }
  
  void removeLinks() {
    if (parent != null && parent.children.contains(this)) {
      parent.children.remove(this);
    }
    if (allNodes.contains(this)) {
      allNodes.remove(this);
    }
    if (toCheck.contains(this)) {
      toCheck.remove(this);
    }
    
    if (toDraw.contains(this)) {
      toDraw.remove(this);
    }
  }

  void goBack(int i) {

    
    
    removeForward();
    if (parent == null || i <= 0) {
      if (!toCheck.contains(this)) {
        toCheck.add(this);
        
      }
      
      if (!allNodes.contains(this)) {
        allNodes.add(this);
      }
    } else {

      parent.goBack(i-1);
    }
  }


  void drawRetrace() {
    if (parent != null) {
      stroke(255, 0, 0);
      line(pos.x, pos.y, parent.pos.x, parent.pos.y);
      parent.drawRetrace();
    }
  }


  void check() {
    float sa = angle - random(PI);
    sa = constrain(sa, radians(-190), radians(-90));

    float ea = angle + random(PI);
    ea = constrain(ea, radians(-90), radians(10));

    float na = random(sa, ea);
    float len = random(MIN_LEN, MAX_LEN);
    float xx = pos.x + len * cos(angle);
    float yy = pos.y + len * sin(angle);
    boolean collided = false;
    if (!OOB_ext(xx, yy)) {

      for (Block b : blocks) {

        if (b.intersects(pos.x, pos.y, xx, yy)) {
          collided = true;
          goBackAmount += 1;
          goBack(goBackAmount);
          break;
        }
      }

      if (!collided) {
        for (int i = allNodes.size() - 1; i >= 0; i -= 1) {
          Node n = allNodes.get(i);

          if (id == n.id) continue;

          for (int j = n.children.size()-1; j >= 0; j -= 1) {
            Node nc = n.children.get(j);
            if (id == nc.id) continue;
            if (linesIntersect(pos.x, pos.y, xx, yy, nc.pos.x, nc.pos.y, n.pos.x, n.pos.y)) {
              intersections.add(intersectionPoint(pos.x, pos.y, xx, yy, nc.pos.x, nc.pos.y, n.pos.x, n.pos.y));
              collided = true;
              goBackAmount += 1;
              goBack(goBackAmount);
              break;
            }
          }
          if (collided) break;
        }
      }


      if (!collided) {
        goBackAmount -= 1; 
        if (goBackAmount < 5) goBackAmount = 5; 
        children.add(new Node(this, xx, yy, na));
      }
    } else {
      ends.add(this);
    }
  }
}
