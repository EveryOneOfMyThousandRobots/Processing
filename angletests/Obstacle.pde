enum EDGE {
  TOP_BOTTOM, LEFT_RIGHT;
}

class Obstacle {
  PVector pos, dims;
  Obstacle() {
    float xStep = width / 20;
    float yStep = height / 20;
    pos = new PVector(random(width), random(height));
    pos.x = pos.x - (pos.x % xStep);
    pos.y = pos.y - (pos.y % yStep);
    dims = new PVector(20,20);
  }
  
  void draw() {
    stroke(0);
    fill(128);
    rect(pos.x, pos.y, dims.x, dims.y);
  }
  
  boolean collides(PVector check) {
    if (check.x >= pos.x && check.x <= pos.x + dims.x && check.y >= pos.y && check.y <= pos.y + dims.y) {
      //println("cx - px:" + (check.x - pos.x));
      //println("cy - py:" + (check.y - pos.y));
      return true;
    }
    return false;
  }
  
  EDGE whichEdge(PVector check) {
    EDGE edge = null;
    float xs = floor(check.x - pos.x);
    float ys = floor(check.y - pos.y);
    if (xs > 4 && xs < dims.x - 4) {
      edge = EDGE.TOP_BOTTOM;
    } else {
      edge = EDGE.LEFT_RIGHT;
    }
    //if (check.x
    
    return edge;
  }
}