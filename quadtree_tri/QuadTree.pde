import java.awt.Rectangle;
import java.awt.geom.Area;
import java.awt.Polygon;

class QuadTree {
  PVector pos;
  PVector dims;
  Rectangle rect;

  ArrayList <QuadTree> children = new ArrayList<QuadTree>();
  ArrayList <PVector> points = new ArrayList<PVector>();


  QuadTree(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    rect = new Rectangle((int)x, (int)y, (int)w, (int)h);
  }

  boolean addPoint(float x, float y) {
    if (x >= pos.x && x < pos.x + dims.x && y >= pos.y && y < pos.y + dims.y) {
      if (points.size() < 4) {
        points.add(new PVector(x, y));
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
          if (children.get(i).addPoint(x, y)) {
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

  void addPoint(PVector p) {
    addPoint(p.x, p.y);
  }


  ArrayList<PVector> getPoints(Rectangle ro) {
    ArrayList<PVector> returnList = new ArrayList<PVector>();

    if (ro.intersects(rect)) {
      for (PVector p : points) {

        if (ro.contains((int)p.x, (int)p.y)) {
          returnList.add(p);
        }
      }

      for (QuadTree q : children) {
        ArrayList<PVector> lst = q.getPoints(ro);
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
    
    for (PVector p : points) {
      point(p.x, p.y);
    }
    
    for (QuadTree c : children) {
      c.draw();
    }
    
  }
}

ArrayList<PVector> getPoints(float x, float y, float w, float h) {
  //ArrayList<PVector> returnList = new ArrayList<PVector>();
  Rectangle rect = new Rectangle((int)x, (int)y, (int)w, (int)h);
  return quad.getPoints(rect);
}
