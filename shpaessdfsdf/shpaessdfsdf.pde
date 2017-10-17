class Obj {
  int shape = 0;

  PVector pos;
  PVector centre;
  PVector size;
  PVector rot;
  PVector rot_i;
  float rad = width / 3;
  float a = 0.1;
  color c;

  Obj( float x, float y, float z, float cx, float cy, float cz, int shape, int size) {
    pos = new PVector(x, y, z);
    centre = new PVector(cx, cy, cz);
    rot = new PVector(0, 0, 0);
    rot_i = new PVector(0, 0, 0);
    this.size = new PVector(size, size, size);
    this.shape = shape;
    c = color(255);
  }

  void update() {
    pos.x = centre.x + rad * cos(a);
    pos.y = centre.y + rad * sin(a);
    pos.z = centre.z + rad * cos(a);

    rot.add(rot_i);

    a += 0.005;
  }

  void draw() {
    noStroke();
    fill(c);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);   
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    if (shape == 0) {

      box(size.x, size.y, size.z);
    } else {
      sphere(size.x);
    }
    popMatrix();
  }
}

ArrayList<Obj> shapes = new ArrayList<Obj>();

void setup() {
  size(500, 500, P3D);
  Obj bx = new Obj(width / 3, height / 2, 0, width / 2, height / 2, 0, 0, 5);
  bx.rot_i.x = 0.01;
  bx.c = color(255,0,0);

  Obj bx2 = new Obj(width / 4, height / 4, 0, width / 2, height / 2, 0, 0, 6);
  bx2.rot_i.y = 0.01;
  bx2.c = color(0,0,255);
  bx2.a = PI;
  bx2.rad = width / 3;
  

  Obj sp = new Obj(width / 2, height / 2, 0, width / 2, height / 2, 0, 1, 50);
  sp.rad = 0;
  sp.rot_i.z = 0.001;
  shapes.add(bx);
  shapes.add(bx2);
  shapes.add(sp);
}

void draw() {
  background(0);
  for (Obj o : shapes) {
    o.update();
    o.draw();
  }
}