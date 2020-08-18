ArrayList<P> prts = new ArrayList<P>();
int PID = 0;
class P {
  final int id;
  final int id_hash;
  {
    PID += 1;
    id = PID;
    id_hash = Integer.hashCode(id);
  }

  int hashCode() {
    return id_hash;
  }


  @Override
    boolean equals(Object o) {
    if (o instanceof P) {
      if (((P)o).id == this.id) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  PVector pos, vel, acc;
  color c;


  P(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    acc = new PVector();
    c = color(random(255),255,255);
  }
  P(float x, float y, float xv, float yv) {
    pos = new PVector(x, y);
    vel = new PVector(xv, yv);
    acc = new PVector();
    c = color(random(255),255,255);
  }


  void kill() {
    if (prts.contains(this)) {
      prts.remove(this);
    }
  }


  void draw() {
    img.stroke(c);
    img.fill(c);
    img.point(pos.x, pos.y);
  }

  void applyForce(PVector p) {
    acc.add(p);
  }

  void update() {
    vel.add(acc);
    vel.mult(0.99);
    vel.limit(10);
    acc.mult(0);
    pos.add(vel);
  }
}
