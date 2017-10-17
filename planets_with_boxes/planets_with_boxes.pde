class Sphere {
  PVector pos;

  PVector rot;
  PVector rotinc;
  float r;

  {
    rot = new PVector(0, 0, 0);
    rotinc = new PVector(0, 0, 0.01);
    pos = new PVector(width / 2, height / 2, 0);
  }

  void draw() {
    noStroke();//stroke(255);
    fill(255,0,0);
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    sphere(100);
    popMatrix();
  }

  void update() {
    rot.add(rotinc);
  }
}

class Box extends Sphere {
  Sphere parent;
  Box(Sphere ss) {
    parent = ss;
  }

  void update() {
    pos.x = parent.pos.x + parent.r * cos(parent.rot.z);
    pos.z = parent.pos.z + parent.r * sin(parent.rot.z);
    rot.add(rotinc);
  }

  void draw() {
    noStroke();
    fill(255);
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    box(20, 20, 20);
    popMatrix();
  }
}

Sphere s;
Box b;
void setup() {
  size(500, 500, P3D);
  s = new Sphere();
  s.r = 100;
  b = new Box(s);
  b.rotinc = new PVector(0, -0.01, 0);
}

void draw() {
  background(0);
  s.update();

  s.draw();
  b.update();
  b.draw();
}