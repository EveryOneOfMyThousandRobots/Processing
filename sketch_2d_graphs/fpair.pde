class FPair {
  final float x, y;
  float px, py;
  float angle;
  color c;
  boolean valid = true;

  FPair(float x, float y) {
    this.x = x;
    this.y = y;
    
    if (!Float.isFinite(this.x) || !Float.isFinite(this.y)) {
      valid = false;
    }
  }

  void calcPos(boolean out) {
    if (out) {
      px =  map(this.x, -maxX, maxX, width / 2, width);
      py = map(this.y, -maxY, maxY, height, 0);
    } else {
      px =  map(this.x, -inMaxX, inMaxX, 0, width / 2);
      py = map(this.y, -inMaxY, inMaxY, height, 0);
    }

    
  }

  void calcAngle() {
    PVector a = new PVector(px, py);
    PVector b = PVector.sub(a, centre);
    angle = b.heading();
    c = color(map(angle, -PI, PI, 0, 255), 255, map(b.mag(), 0, maxDist, 0, 255));
  }
}

FPair f(FPair xy) {
  FPair n = null;
  float x = (3 * xy.x) + pow(xy.x, 5);
  float y = (xy.x) + pow(xy.y, 3) +  exp(xy.x);// * sin(xy.x);

  n = new FPair(x,y);  

  return n;
}
