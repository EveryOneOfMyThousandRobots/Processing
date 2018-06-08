class Wall {
  Collider col;
  PVector pos, dims;

  Wall(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    col = new Collider(x, y, w, h);
  }

  void draw() {
    stroke(255);
    fill(200);
    rect(pos.x, pos.y, dims.x, dims.y);
  }
  
  
 }
