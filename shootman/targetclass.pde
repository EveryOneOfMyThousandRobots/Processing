class Target {
  PVector pos, dims;
  boolean hit = false;


  Target(float x, float y) {
    pos = new PVector(x, y);
    dims = new PVector(20, 20);
  }
  
  Target copy() {
    return new Target(pos.x, pos.y);
  }

  void draw() {
    fill(255, 0, 0);
    stroke(255,0,0);
    ellipse(pos.x, pos.y, dims.x, dims.y);
  }

  boolean collides(float x, float y) {
    if (x >= pos.x && x <= pos.x + dims.x && y >= pos.y && y <= pos.y + dims.y) {
      return true;
    } else {
      return false;
    }
  }
}