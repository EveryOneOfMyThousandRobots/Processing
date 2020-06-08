int OBJECT_ID = 0;

class Agent {
  final int id;
  final int id_hash;
  {
    OBJECT_ID += 1;
    id = OBJECT_ID;
    id_hash = Integer.hashCode(id);
  }


  PVector pos, acc, vel;

  Agent(float x, float y) {
    pos = new PVector(x, y);
    acc = new PVector();
    vel = new PVector();
  }


  void applyForce(PVector f) {
    acc.add(f);
  }

  void update() {
    vel.add(acc);
    vel.limit(4);
    pos.add(vel);
    acc.mult(0);
    vel.mult(0.99);
  }

  void draw() {
    stroke(255);
    fill(255);
    ellipse(pos.x, pos.y, 5, 5);
  }

  @Override
    boolean equals(Object o) {
    if (o instanceof Agent) {
      if (((Agent)o).id == id) {
        return true;
      }
    }

    return false;
  }
}
