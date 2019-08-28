class RXTX {
  color col;
  PVector pos;
  RXTX(float x, float y) {
    pos = new PVector(x,y);
    col = color(128);
  }
  
  void update() {
  }
  
  void draw() {
    rectMode(CENTER);
    noStroke();
    fill(col);
    rect(pos.x, pos.y,50,50);
  }
}
