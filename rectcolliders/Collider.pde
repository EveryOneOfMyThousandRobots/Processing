class Collider {
  private PVector pos;
  private PVector bounds;
  Rectangle rect;
  
  boolean collides(Collider o) {
    return this.rect.intersects(o.rect);
    
  }
  
  Collider(float x, float y, float w, float h) {
    pos = new PVector(x,y);
    bounds = new PVector(w,h);
    rect = new Rectangle((int)x, (int)y, (int)w, (int)h);
    
    
  }
  
  PVector getPos() {
    return pos.copy();
  }
  
  PVector getBounds() {
    return bounds.copy();
  }
  
  void setPos(PVector p) {
    setPos(p.x, p.y);
  }
  
  void setBounds(PVector p) {
    setBounds(p.x, p.y);
  }
  
  void setPos(float x, float y) {
    pos.set(x,y);
    rect.x = (int)x;
    rect.y = (int)y;
  }
  
  void setBounds(float w, float h) {
    bounds.set(w,h);
    rect.width = (int)w;
    rect.height = (int)h;
    
  }
  
  
}
