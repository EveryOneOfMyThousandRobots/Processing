final float  G = 0.00005;
int OBJID;
class Obj {
  PVector vel, acc, pos, fric;
  float mu = 0.1;
  float normal = 1;
  int objId;
  boolean canMove = true;
  color c;

  float r, d, m;

  Obj (float x, float y, float r, float d) {
    objId = OBJID;
    OBJID += 1;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    pos = new PVector(x, y);
    this.r = r;
    this.d = d;
    c = color(random(255), random(255), random(255));


    m = (PI * r * r) * d;
  }

  PVector attract(Obj o) {
    PVector force = PVector.sub(o.pos, pos);
    float dist = force.mag();
    dist = constrain(dist, 5, 100);
    dist *= 100;
    force.normalize();
    float strength = (G * m * o.m) / (dist*dist);
    force.mult(strength);
    return force;
  }

  void force(PVector p) {
    acc.add(p.copy().div(m));
  }

  void draw() {
    fill(c);
    stroke(c);
    ellipse(pos.x, pos.y, r / 15, r / 15);
  }

  void update() {
    if (!canMove) return;
    vel.add(acc);
    fric = vel.copy();
    fric.mult(-1);
    fric.normalize();
    fric.mult(mu * normal);
    acc.mult(0);
    vel.x = constrain(vel.x, -100, 100);
    vel.y = constrain(vel.y, -100, 100);
    pos.add(vel);
  }
}
ArrayList<Obj> objs = new ArrayList<Obj>();

void setup() {
  size(800, 800);
  smooth();
  objs.add(new Obj(width / 2, height / 2, 500, 100000));
  objs.get(0).canMove = false;
  PVector sun = objs.get(0).pos.copy();

  for (int i = 0; i < 10; i += 1) {
    float x = (width / 2) + (((width / 2) / 10) * (i + 1));
    float y = height / 2;
    float r = random(2, 200);
    float d = random(500, 1000);
    Obj o = new Obj(x, y, r, d);
    PVector toSun = PVector.sub(sun, o.pos);
    o.vel = new PVector(toSun.y, -toSun.x);
    o.vel.normalize();
    o.vel.mult( random(1, 5));
    int ym = 1 ;
    if (((int) random(100)) <= 25) ym = -1;
    o.vel.y *= ym;
    o.mu = 0;

    objs.add(o);
  }
  background(0);
}

void draw() {
  noStroke();
  fill(0, 0, 0, 20);
  rect(0, 0, width, height);
  for (int x = 0; x < objs.size(); x += 1) {
    Obj o = objs.get(x);


    for (int y = 0; y < objs.size(); y += 1) {
      if (x == y) continue;
      Obj oo = objs.get(y);
      o.force((o.attract(oo)));
    }
    o.update();
    o.draw();
  }
}