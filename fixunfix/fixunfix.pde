class PV extends PVector {

  PV(float x, float y) {
    super(x, y);
  }

  PV(float x, float y, float z) {
    super(x, y, z);
  }
  boolean fixed = false;  
  void fix() {
    fixed = true;
  }

  void unfix() {
    fixed = false;
  }
}

ArrayList<PV> vs = new ArrayList<PV>();

void setup() {

  size(500, 500);
  for (int i = 0; i < 100; i += 1) {
    PV p = new PV(random(height), random(width));

    if (random(1) < 0.5) {
      p.fix();
    }

    vs.add(p);
  }
}

void draw() {
  background(255);
  stroke(0);
  noFill();
  for (PV p : vs) {
    if (p.fixed) {
      fill(255,0,0);
    } else {
      noFill();
    }
    ellipse(p.x, p.y, 4, 4);
  }

  int r = floor(random(vs.size()));

  if (!vs.get(r).fixed) {
    vs.remove(r);
  }

  while (vs.size() < 100) {
    PV p = new PV(random(height), random(width));

    if (random(1) < 0.5) {
      p.fix();
    }

    vs.add(p);
  }
}