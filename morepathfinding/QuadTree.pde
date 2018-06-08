import java.awt.Rectangle;
import java.awt.geom.Area;
import java.awt.Polygon;

class QuadTree {
  PVector pos;
  PVector dims;
  Rectangle rect;

  ArrayList <QuadTree> children = new ArrayList<QuadTree>();
  ArrayList <Node> points = new ArrayList<Node>();


  QuadTree(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    rect = new Rectangle((int)x, (int)y, (int)w, (int)h);
  }

  boolean addPoint(Node n) {
    if (n.pos.x >= pos.x && n.pos.x < pos.x + dims.x && n.pos.y >= pos.y && n.pos.y < pos.y + dims.y) {
      if (points.size() < 4) {
        points.add(n);
        return true;
      } else {
        if (children.size() == 0) {
          float xx = pos.x;
          float yy = pos.y;
          float w = dims.x;
          float h = dims.y;
          float w2 = w/2;
          float h2 = h/2;
          children.add(new QuadTree(xx, yy, w2, h2));
          children.add(new QuadTree(xx+w2, yy, w2, h2));
          children.add(new QuadTree(xx, yy+h2, w2, h2));
          children.add(new QuadTree(xx+w2, yy+h2, w2, h2));
        }
        for (int i = 0; i < children.size(); i += 1) {
          if (children.get(i).addPoint(n)) {
            return true;
          }
        }
        return false;
      }
    } else {
      //not in bounds
      return false;
    }
  }

  //void addPoint(PVector p) {
  //  addPoint(p.x, p.y);
  //}


  ArrayList<Node> getPoints(Rectangle ro) {
    ArrayList<Node> returnList = new ArrayList<Node>();

    if (ro.intersects(rect)) {
      for (Node n : points) {

        if (ro.contains((int)n.pos.x, (int)n.pos.y)) {
          returnList.add(n);
        }
      }

      for (QuadTree q : children) {
        ArrayList<Node> lst = q.getPoints(ro);
        if (lst.size() > 0) {
          returnList.addAll(lst);
        }
      }
    }


    return returnList;
  }
  
  
  void draw() {
    stroke(255);
    noFill();
    
    rect(pos.x, pos.y, dims.x, dims.y);
    
    for (Node n : points) {
      point(n.pos.x, n.pos.y);
    }
    
    for (QuadTree c : children) {
      c.draw();
    }
    
  }
}

ArrayList<Node> getNodesInRect(float x, float y, float w, float h) {
  //ArrayList<PVector> returnList = new ArrayList<PVector>();
  Rectangle rect = new Rectangle((int)x, (int)y, (int)w, (int)h);
  return quad.getPoints(rect);
}

ArrayList<Node> getNodesInDist(float x, float y, float d) {
  ArrayList<Node> returnList = getNodesInRect(x-(d/2),y-(d/2),d,d);
  
  for (int i = returnList.size()-1; i >= 0 ; i -= 1) {
    Node n = returnList.get(i);
    if (dist(x,y,n.pos.x, n.pos.y) > d) {
      returnList.remove(i);
    }
  }
  
  
  
  return returnList;
}
