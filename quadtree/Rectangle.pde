class Rectangle {
  float x,y,w,h;
  float x1, x2;
  float y1, y2;
  Rectangle (float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    x1 = x;
    x2 = x + w;
    y1 = y;
    y2 = y + h;
  }
  
  boolean intersects(Rectangle B) {
    
    if (x1 < B.x2 && x2 > B.x1 && y1 > B.y2 && y2 < B.y1) {
      return false;
    }
    
    
    
    
    
    
    return true;
    
  }
  
  boolean contains(Particle p) {
    return contains(p.pos);
  }
  
  boolean contains(float px, float py) {
    if (px >= x && px < x + w && py >= y && py < y + h) {
      return true;
    } else {
      return false;
    }    
  }
  
  boolean contains(PVector p) {
    return contains(p.x, p.y);
  }
}
