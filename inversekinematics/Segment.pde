class Segment {
  PVector a;
  float angle=0;
  float len;
  PVector b;
  PVector target;
  Segment parent = null;
  Segment child = null;

  Segment(float x, float y, float angle, float len) {
    a = new PVector(x, y);
    this.angle = angle;
    this.len = len;
    b = new PVector(0, 0);
    target = new PVector();
    calcB();
  }
  Segment(Segment parent, float angle, float len) {
    this.parent = parent;
    a = parent.b.copy();
    this.len = len;
    this.angle = angle;
    b = new PVector(0, 0);
    target = new PVector(0, 0);
    calcB();
    
    //this.parent =parent;
    //target = new PVector();
    //a = new PVector();
    //this.len = len;
    //b = new PVector(0, 0);
    //follow(parent.a.x, parent.a.y);
    
    //this.angle = angle;
    
    
    
  }

  void calcB() {
    float dx = len * cos(angle);
    float dy = len * sin(angle);

    b.set(a.x + dx, a.y + dy);
  }
  
  void follow() {
    follow(child.a.x, child.a.y);
  }

  void follow(float x, float y) {
    target.set(x, y);
    PVector dir = PVector.sub(target, a);
    angle = dir.heading();
    dir.setMag(len);
    dir.mult(-1);
    a = PVector.add(target, dir);
    //b.set(target);
  }

  void update() {


    calcB();
  }

  void draw() {
    stroke(255);
    strokeWeight(4);
    line(a.x, a.y, b.x, b.y);
  }
}