class Obstacle {
  PVector pos, dims;
  
  Obstacle(float x, float y, float w, float h) {
    this.pos = new PVector(x,y);
    this.dims = new PVector(w,h);
  }
  
  boolean collides(float x, float y) {
    if (x >= pos.x && x <= pos.x + dims.x && y >= pos.y && y <= pos.y + dims.y) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean collides(float x, float y, float w, float h) {
    boolean xo = false, yo = false;
    if ((x >= pos.x && x <= pos.x + dims.x) || (pos.x >= x && pos.x <= x + w)) {
      xo = true;
    }
    
    if ((y >= pos.y && y <= pos.y + dims.y) || (pos.y >= y && pos.y <= y + h)) {
      yo = true;
    }
    
    
    
    
    
    return xo && yo;
  }
  
  void draw() {
    stroke(255);
    fill(255,0,0);
    rect(pos.x, pos.y, dims.x, dims.y);
  }
}