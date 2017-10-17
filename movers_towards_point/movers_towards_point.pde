class P {
  PVector pos, vel, acc, trg;
  P(float x, float y, float tx, float ty) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    trg = new PVector(tx, ty);

    PVector pf = PVector.sub(trg, pos);
    PVector ppf = new PVector(-pf.y, pf.x);
    ppf.normalize();
    ppf.mult(4);
    force(ppf);
  }

  void force(PVector force) {
    acc.add(force);
  }

  void update() {
    PVector tf = PVector.sub(trg, pos);
    tf.normalize();

    tf.mult(1 / tf.magSq());
    force(tf);

    vel.add(acc);
    pos.add(vel);
    vel.mult(0.98);
    acc.mult(0);
  }

  void draw() {
    stroke(255);
    ellipse(pos.x, pos.y,  2, 2);
    ellipse(trg.x, trg.y, 2, 2);
  }
}

ArrayList<P> points = new ArrayList<P>();

void setup() {
  size(400, 400);
  for (int i = 0; i < 10; i++ ) {
    P p = new P(width / 2, height /2, random(width), random(height));
    points.add(p);
  }
}

void draw() {
  background(0);
  for (P p : points) {
    p.update();
    p.draw();
  }
}