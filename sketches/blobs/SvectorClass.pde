class SVector {
  float x;
  float y;

  SVector (float x, float y) {
    this.x = x;
    this.y = y;
  }

  void add(SVector v) {
    x+= v.x;
    y+= v.y;
  }
  
  void sub(SVector v) {
    x -= v.x;
    y -= v.y;
  }
  
  void mult(float n) {
    x *= n;
    y *= n;
  }
  
  void div(float n) {
    x /= n;
    y /= n;
  }
  
  float mag() {
    return sqrt(x * x + y * y);
  }
  
  void normalise() {
    float m = mag();
    if (m != 0) {
      div(m);
    }
  }
  
  
}
