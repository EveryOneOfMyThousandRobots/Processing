int GLOBAL_ID = 0;
class Bin {
  PVector pos;
  final int id;
  {
    GLOBAL_ID += 1;
    id = GLOBAL_ID;
  }
  Bin(float x, float y) {
    pos = new PVector(x,y);
  }
  
  boolean equals(Bin o) {
    return o.id == id;
  }
  
  void draw() {
    rectMode(CENTER);
    stroke(0);
    fill(255);
    rect(pos.x, pos.y, BIN_SIZE, BIN_SIZE);
    
    
  }
  
}
ArrayList<Bin> bins = new ArrayList<Bin>();
