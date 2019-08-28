class Wall {
  PVector ps, pe;
  
  
  Wall(float x1, float y1, float x2, float y2) {
    ps = new PVector(x1,y1);
    pe = new PVector(x2,y2);
    
  }
  
  void draw() {
    topDown.stroke(255);
    topDown.noFill();
    topDown.line(ps.x, ps.y, pe.x, pe.y);
    //rect(pos.x, pos.y, dims.x, dims.y);
  }
}
