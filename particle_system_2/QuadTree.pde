boolean pointInRect(float x, float y, float rx, float ry, float rw, float rh) {
  return (x >= rx && x < rx + rw && y >= ry && y < ry + rh);
}

class QuadTree {
  PVector pos, dims;

  QuadTree[] children = null;
  ArrayList<QuadTreePoint> points = new ArrayList<QuadTreePoint>();



  QuadTree(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
  }

  boolean inside(float x, float y) {
    return (x >= pos.x && x < pos.x + dims.x && y >= pos.y && y < pos.y + dims.y);
  }
  boolean inside(QuadTreePoint p) {
    return inside(p.pos.x, p.pos.y);
  }
  
  
  void getPointsInCicle(ArrayList<QuadTreePoint> list, float x, float y, float r) {
    
    float xx = x -r; 
    float yy = y - r;
    
    getPointsInRect(list,xx,yy,r*2,r*2);
    
    for (int i = list.size()-1; i >= 0; i -= 1) {
      QuadTreePoint qtp = list.get(i);
      float xs = (qtp.pos.x - x) * (qtp.pos.x - x);
      float ys = (qtp.pos.y - y) * (qtp.pos.y - y);
      
      if (abs(xs) + abs(ys) < (r*r)) {
        
      } else{
        list.remove(i);
      }
      
    }
    
  }
  
  void getPointsInRect(ArrayList<QuadTreePoint> list, float x, float y, float w, float h) {
    
    for (QuadTreePoint qtp : points) {
      if (pointInRect(qtp.pos.x, qtp.pos.y, x, y, w, h)) {
        list.add(qtp);
      }
    }
    
    if (children != null) {
      for (QuadTree child : children) {
        child.getPointsInRect(list,x,y,w,h);
      }
    }
    
  }


  void draw() {
    stroke(255, 128);
    noFill();
    rect(pos.x, pos.y, dims.x, dims.y);
    if (children != null) {
      for (QuadTree child : children ) {
        child.draw();
      }
    }
  }

  boolean addPoint(QuadTreePoint p) {
    if (inside(p)) {
      if (points.size() < LIMIT) {
        points.add(p);
        return true;
      } else {
        if (children == null) {
          children = new QuadTree[4];
          float wh = dims.x / 2;
          float hh = dims.y / 2;
          children[0] = new QuadTree(pos.x, pos.y, wh, hh);
          children[1] = new QuadTree(pos.x+wh, pos.y, wh, hh);
          children[2] = new QuadTree(pos.x, pos.y+hh, wh, hh);
          children[3] = new QuadTree(pos.x+wh, pos.y+hh, wh, hh);
        }

        for (QuadTree child : children) {
          if (child.addPoint(p)) {
            return true;
          }
        }
      }
    }

    return false;
  }
}

final int LIMIT = 4;
