class Circ {
  Circ parent;
  Circ child;

  PVector pos;
  float angle;
  float radius;
  float angle_inc;


  void addChild() {
    child = new Circ(this);
  }
  
  void addChild(float angle_inc, float radius) {
    child = new Circ(this, angle_inc, radius);
  }

  Circ(float x, float y, float radius) {
    pos = new PVector(x, y);
    this.radius = radius;
    angle = 0;
    angle_inc = radians(1);
  }

  Circ(Circ parent) {
    this.parent = parent;
    
    pos = new PVector(parent.pos.x + radius * cos(angle), parent.pos.y + radius * sin(angle));
    this.radius = parent.radius / 3;
    this.angle = 0;
    this.angle_inc = parent.angle_inc + radians(1.3);
  }
  
  Circ(Circ parent, float angle_inc, float radius) {
    this(parent);
    this.radius = radius;
    this.angle_inc = angle_inc;
  }

  void draw() {
    noFill();
    stroke(255);
    angle += angle_inc;
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
    if (child != null) {
      child.pos.set(pos.x + radius * cos(angle), pos.y + radius * sin(angle));
      child.draw();
    } else {
      ellipse(pos.x + radius * cos(angle), pos.y + radius * sin(angle), 3, 3);
    }
  }
}