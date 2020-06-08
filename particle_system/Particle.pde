 //<>//

class Particle extends QuadTreePoint {



  PVector vel, acc;
  ArrayList<QuadTreePoint> nearby = new ArrayList<QuadTreePoint>();
  ParticleType type;
  Particle(float x, float y) {
    super(x, y);

    type = types.get(floor(random(types.size())));

    vel = PVector.random2D();
    acc = new PVector();
  }

  void update() {
    nearby.clear();
    tree.getPointsInCicle(nearby, pos.x, pos.y, MAX_DIST);
    for (ParticleForce force : type.forces) {
      for (QuadTreePoint qtp : nearby) {

        Particle p = (Particle) qtp;
        if (p.id == id) continue;
        if (p.type.equals(force.otherType)) {
          steer(p.pos, force);
        }
      }
    }
    acc.add(PVector.random2D().mult(random(0.1)));


    if (pos.x < BORDER) {
      applyForce(10, 0);
    }

    if (pos.x > width - BORDER) {
      applyForce(-10, 0);
    }

    if (pos.y < BORDER) {
      applyForce(0, 10);
    }

    if (pos.y > height - BORDER) {
      applyForce(0, -10);
    }


    vel.add(acc);
    vel.limit(4);
    vel.mult(0.99);

    pos.add(vel);
    acc.mult(0);
  }

  void steer(PVector p, ParticleForce force) {
    float d = PVector.dist(p, pos);
    PVector steer = new PVector();
    if (d < force.minDist) {
      steer.add(PVector.sub(pos, p).mult(1 / d));
     // steer.limit(4);
      applyForce(steer);
      return;
    } else if (d < force.mid) {
      steer.add(PVector.sub(p, pos).mult(d));
    } else if (d < force.maxDist) {
      steer.add(PVector.sub(p, pos).mult(1/d));
    }
    steer.limit(abs(force.maxForce));
    if (force.maxForce < 0) {
      steer.mult(-1);
    }
    steer.setMag(abs(force.maxForce));
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void applyForce(float x, float y) {
    acc.add(x, y);
  }

  void draw() {
    stroke(type.c);
    fill(type.c);
    ellipse(pos.x, pos.y, 3, 3);
  }
}

class QuadTreePoint {
  final int id;
  {
    ID += 1;
    id = ID;
  }
  public PVector pos;


  QuadTreePoint(float x, float y) {
    pos = new PVector(x, y);
  }
  @Override
    boolean equals(Object o) {
    if (o instanceof QuadTreePoint) {
      QuadTreePoint qtp = (QuadTreePoint) o;
      if (qtp.id == id) return true;
    }
    return false;
  }
  int hashCode() {
    return Integer.hashCode(id);
  }
}
