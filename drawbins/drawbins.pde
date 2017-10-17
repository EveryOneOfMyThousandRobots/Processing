class  DrawMe {
  PVector pos, size;
  PVector dPos, dSize;
  color border;
  color fill;
  float borderSize;
  
  DrawMe (float x, float y, float w, float h, float b, color fill, color border) {
    pos = new PVector(x,y);
    size = new PVector(w,h);
    dPos = new PVector(x + (b / 2), y + (b/ 2));
    dSize = new PVector(w - b, h - b);
  
    this.border = border;
    this.fill = fill;
    this.borderSize = b;
    
    
  }
  
  void draw() {
    stroke(border);
    fill(fill);
    rect(dPos.x, dPos.y, dSize.x, dSize.y);
    
  }
  
  
}