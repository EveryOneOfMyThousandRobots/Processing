abstract class Shape {
  PVector pos;
  PVector rot;
  PVector rot_inc;

  Shape(float x, float y, float rx, float ry) {
    this.pos = new PVector(x, y);
    this.rot = new PVector(0, 0);
    this.rot_inc = new PVector(rx, ry);
  }

  abstract void draw();
  abstract void update();
}

class Planet extends Shape {
  float r;
  Planet(float x, float y, float rx, float ry, float r) {
    super(x, y, rx, ry);
    this.r = r;
  }
  void draw() {
    stroke(255);
    fill(255);
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }

  void update() {
    rot.add(rot_inc);
    if (rot.x > TWO_PI) {
      rot.x -= TWO_PI;
    }
    if (rot.y > TWO_PI) {
      rot.y -= TWO_PI;
    }
  }
}

class Box extends Shape {
  Planet p;
  PVector size;
  Box(float x, float y, float rx, float ry, Planet p, float w, float h) {
    super(x, y, rx, ry);
    this.p = p;
    this.size = new PVector(w, h);
  }
  void draw() {
    stroke(128,64,0);
    fill(255);
    rectMode(RADIUS);
    pushMatrix();
    
    translate(pos.x, pos.y);
    rotate(p.rot.x + rot.x);
    rect(0, 0, size.x, size.y);
    popMatrix();
  }

  void update() {
    pos.x = p.pos.x + (p.r * .9) * cos(p.rot.x + rot.x);
    pos.y = p.pos.y + (p.r * .9) * sin(p.rot.x + rot.x);
    rot.x += rot_inc.x;
  }
}

Planet p;
ArrayList<Box> boxes = new ArrayList<Box>();
void setup() {
  smooth();
  size(500, 500);
  background(0);
  p = new Planet(width / 2, height / 2, 0.01, 0, width / 8);
  for (float i = 0; i < TWO_PI; i += TWO_PI / 10) {
    float w = random(width / 128, width / 64);
    float h = random(w*4, width / 8);
    Box b = new Box(width / 2, height / 2, 0, 0, p, h,w);
    b.rot.x = i + random(-TWO_PI / 16, TWO_PI / 16);
    b.rot_inc.x = random(0, 0.005);
    boxes.add(b);
  }
  
}

void draw() {
  background(0);
  p.update();
  for (Box b : boxes) {
    b.update();
    b.draw();
  }
  p.draw();
  
}