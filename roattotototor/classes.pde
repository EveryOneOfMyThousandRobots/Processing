class Rotator {
  float cx, cy;
  float x, y;
  float r;
  float a;
  float ai;
  Rotator parent = null;

  Rotator(float cx, float cy, float r, float a, float ai, Rotator parent) {
    this.cx = cx;
    this.cy = cy;
    this.r = r;
    this.a = a;
    this.ai = ai;
    this.parent = parent;
    update();
  }

  void update() {
    if (parent != null) {
      cx = parent.x;
      cy = parent.y;
    }

    a += ai;
    x = cx + r * cos(a);
    y = cy + r * sin(a);
  }

  void draw() {
    //float x,y;



    ellipse(x, y, 3, 3);
  }
}