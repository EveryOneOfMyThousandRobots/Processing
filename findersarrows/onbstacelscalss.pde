class Obstacle {
  PVector pos, dims;

  Obstacle(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
  }

  void draw() {
    stroke(255);
    fill(255, 0, 100);
    rect(pos.x, pos.y, dims.x, dims.y);
  }

  boolean intersects(PVector o_pos, float w, float h) {
    float left = pos.x, right = pos.x + dims.x, top = pos.y, bottom = pos.y + dims.y;
    float oleft = o_pos.x, oright = o_pos.x + w, otop = o_pos.y, obottom = o_pos.y + h;
    return !(left >= oright || 
      right <= oleft ||
      top >= obottom ||
      bottom <= otop);
  }
}