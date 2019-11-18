class Block {
  PVector pos, dims;
  float s,r ;
  Block (float x, float y, float strength) {
    pos = new PVector(x,y);
    this.s = strength;
    r = map(s,0,1,10,100);
  }
  
  void draw() {
    stroke(255,0,0,64);
    strokeWeight(2);
    noFill();
    ellipse(pos.x, pos.y, r, r);
    strokeWeight(1);
  }
  
  
}
