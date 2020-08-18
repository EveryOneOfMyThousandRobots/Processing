class Particle {
  final int id;
  {
    ID += 1;
    id = ID;
  }

  int hashCode() {
    return Integer.hashCode(id);
  }
  @Override
    boolean equals(Object o) {
    if (o instanceof Particle) {
      if (((Particle)o).id == id) {
        return true;
      }
    }
    return false;
  }


  PVector pos, vel;
  Type type;
  float facing;
  
  Particle(float x, float y, Type type) {
    this.type = type;
    pos = new PVector(x, y);

    facing = 0;
    vel = PVector.fromAngle(facing);
  }

  void update(ArrayList<Particle> list) {

    for (Particle p : list) {
      if (p.id == id) continue; //<>//
      Force f = type.forceMap.get(p.type);
      if (PVector.dist(pos, p.pos) < f.max_dist) {
        facing += f.getForce(pos, p.pos);
      }
    }
    
    facing += type.step * dt;

    if (pos.x < 10) {
      facing = 0;
    }
    
    if (pos.x > width-10) {
      facing = -PI;
    }
    
    if (pos.y < 10 ) {
      facing = HALF_PI;
    }
    
    if (pos.y > height-10) {
      facing = -HALF_PI;
    }
    vel.x = cos(facing);
    vel.y = sin(facing);
    pos.add(vel);
  }

  void draw() {
    stroke(type.c);
    fill(type.c);
    ellipse(pos.x, pos.y, 5, 5);
    noFill();
    for (Force f : type.forces) {
    //  stroke(f.to.c);
    //  ellipse(pos.x, pos.y, f.max_dist*2, f.max_dist*2);
    //  stroke(f.to.c, 128);
    //  ellipse(pos.x, pos.y, f.mid_dist*2, f.mid_dist*2);
      stroke(f.to.c, 64);
      ellipse(pos.x, pos.y, f.min_dist*2, f.min_dist*2);      
    }
  }
}
