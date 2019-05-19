boolean rectOverlap(PVector this_left, PVector this_right, PVector other_left, PVector other_right) {
  if (this_right.y < other_left.y || this_left.y > other_right.y) return false;
  
  if (this_right.x < other_left.x || this_left.x > other_right.x) return false;
  
  return true;
}


float quickDist(PVector a, PVector b) {
  
  return ((b.x - a.x) * (b.x - a.x)) + ((b.y - a.y) * (b.y - a.y));
}

class Clickable {
  PVector pos, dims;
  Clickable(float x, float y, float w, float h) {
    pos = new PVector(x,y);
    dims = new PVector(w,h);
    
  }
  
  boolean inside(float x, float y) {
    if (x >= pos.x && x < pos.x + dims.x && y >= pos.y && y < pos.y + dims.y) {
      return true;
    } else {
      return false;
    }
  }
}
