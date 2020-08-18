class Type {
  Force[] forces;
  HashMap<Type, Force> forceMap = new HashMap<Type, Force>();
  final int id;
  float step = random(-QUARTER_PI,QUARTER_PI);
  {
    ID += 1;
    id = ID;
  }
  color c;
  Type() {
    c = color(random(255), 200,255);
  }

  int hashCode() {
    return Integer.hashCode(id);
  }
  @Override
    boolean equals(Object o) {
    if (o instanceof Type) {
      if (((Type)o).id == id) {
        return true;
      }
    }
    return false;
  }

  void makeForces(Type[] types) {
    forces = new Force[types.length];
    int i =0;
    for (Type type : types) {
      //if (type.equals(this)) continue;
      forces[i] = new Force(this, type);
      forceMap.put(type, forces[i]);

      i += 1;
    }
  }
}
final int MIN_DIST = 5;
final int MAX_DIST = 100;
class Force {
  Type from, to;
  float min_dist = MIN_DIST;
  float max_dist = random(min_dist+5, MAX_DIST);
  float mid_dist = random(min_dist, max_dist);

  float force = random(-1, 1);

  Force (Type from, Type to) {
    this.from = from;
    this.to = to;
  }


  float getForce(PVector A, PVector B) {

    float dist = PVector.dist(A, B);
    PVector S = PVector.sub(B,A);
    S.normalize();
    float r = 0;
    float n = 0;
    if (dist < min_dist) {
      S.mult(-1);
      if (dist <= 0) {
        
        r = S.heading() * dt;
      } else {
        n = (dist / min_dist);
        r = pow(S.heading() * n * dt, 2);
        println(r);
      }
    } else if (dist < mid_dist) {
      S.mult(force);
      n = (dist - min_dist) / (mid_dist - min_dist);
      r = S.heading() * n * dt;
    } else if (dist < max_dist) {
      S.mult(force);
      n = 1.0 - ((dist - mid_dist) / (max_dist - mid_dist));
      r = S.heading() * n * dt;
    }


    return r;
  }
}
