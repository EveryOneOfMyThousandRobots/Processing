

final int MAX_QUAD_SIZE = 4;
class QuadTree {
  QuadPoint[] points;
  PVector pos, dims;
  private int size = 0;
  QuadTree[] children = null;  
  QuadTree(float x, float y, float w, float h) {
    points = new QuadPoint[MAX_QUAD_SIZE];
    pos = new PVector(x, y);
    dims = new PVector(w, h);
  }


  boolean add(QuadPoint qp) {
    if (size >= MAX_QUAD_SIZE) {
      if (children == null) {
        children = new QuadTree[4];
        float w = dims.x / 2;
        float h = dims.y / 2;
        children[0] = new QuadTree(pos.x, pos.y, w, h);
        children[1] = new QuadTree(pos.x + w, pos.y, w, h);
        children[2] = new QuadTree(pos.x, pos.y + h, w, h);
        children[3] = new QuadTree(pos.x + w, pos.y + h, w, h);
      }

      for (int i = 0; i < children.length; i += 1) {
        if (children[i].add(qp)) {
          return true;
        }
      }
    } else {
      if (qp.pos.x >= pos.x && qp.pos.x < pos.x + dims.x && qp.pos.y >= pos.y && qp.pos.y < pos.y + dims.y) {
        points[size] = qp; 
        size += 1; 
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
  
  void get(ArrayList<QuadPoint> pnts, PVector rPos, PVector rDims) {
    
    
    
  }


  void draw() {
    for (int i = 0; i < size; i += 1) {
      points[i].draw();
    }
    stroke(255,128);
    noFill();
    rect(pos.x, pos.y, dims.x, dims.y);
    if (children != null) {
      for (int i = 0; i < children.length; i += 1) {
        children[i].draw();
      }
    }
  }
}
