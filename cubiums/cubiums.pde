class C {
  PVector pos;
  PVector size;
  PVector vel, acc;
  PVector target = null;
  PVector start = null;
  C (float x, float y, float z) {
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
    size = new PVector(20, 20, 20);
    start = pos.copy();
  }

  void update() {
    if (target != null) {
      float dist = PVector.dist(pos, target);
      if (dist < 1) {
        pos = target.copy();
        start = pos.copy();
        target = null;
      } else {
        float ddist = PVector.dist(start, target);

        float p = map(dist, 0, ddist, 0, PI);

        PVector pp = PVector.sub(target, pos);
        pp.normalize();
        pp.mult(p*0.01);
        acc = pp.copy();
      }
    }

    vel.add(acc);
    acc.mult(0);
    vel.mult(0.97);
    pos.add(vel);
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(size.x, size.y, size.z);
    popMatrix();

    if (target != null ) {
      pushMatrix();
      translate(target.x, target.y, target.z);
      box(size.x / 2, size.y / 2, size.z / 2);
      popMatrix();
    }
  }
}

ArrayList<C> cubes = new ArrayList<C>();

void setup() {
  size(400, 400, P3D);
  for (int i = 0; i < 10; i += 1) { 
    float x = random(50, width - 100);
    float y = random(50, height - 100);
    float z = random(-200, 200);
    cubes.add(new C(x,y,z));
  }
}

void draw() {
  background(0);
  for (C c : cubes) {
    int i = (int) (random(1000));
    if (i < 3) {
      if (c.target == null) {
        c.target = new PVector(random(50, width-100), random(50, height-100), random(-100, 100));
      }
    }

    c.update();
    c.draw();
  }
}