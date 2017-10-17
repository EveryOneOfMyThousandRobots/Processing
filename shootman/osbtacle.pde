class Wall {
  PVector pos, dims;

  Wall(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
  }


  void draw() {
    stroke(255);
    fill(0, 0, 255);
    rect(pos.x, pos.y, dims.x, dims.y);
  }


  boolean collides(float x, float y) {
    if (x >= pos.x && x <= pos.x + dims.x && y >= pos.y && y <= pos.y + dims.y) {
      return true;
    } else {
      return false;
    }
  }

  boolean collides(float x, float y, float r) {
    if (x + r >= pos.x && x - r <= pos.x + dims.x && y + r >= pos.y && y - r <= pos.y + dims.y) {
      return true;
    } else {
      return false;
    }
  }
}