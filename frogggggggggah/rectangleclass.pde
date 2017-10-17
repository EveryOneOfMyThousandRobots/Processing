class Rectangle {
  //private float left, right, top, bottom;
  float x, y;
  float w, h;


  Rectangle (float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

  }

  void setX(float x) {

    this.x = x;
  }
  void setY(float y) {

    this.y = y;
  }

  void setXY(float x, float y) {
    setX(x);
    setY(y);
  }


  //intersect
  boolean intersects(Rectangle o) {
   float left = x, right = x + w, top = y, bottom = y + h;
   float oleft = o.x, oright = o.x + o.w, otop = o.y, obottom = o.y + o.h;
    return !(left >= oright || 
      right <= oleft ||
      top >= obottom ||
      bottom <= otop);
  }

  //standard
  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getW() {
    return w;
  }

  float getH() {
    return h;
  }
}