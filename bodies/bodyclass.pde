

class Body {
  ArrayList<PVector> positions = new ArrayList<PVector>(100);
  PVector pos, vel, acc;
  float radius, mass;
  float density;
  float volume;
  boolean locked;// = false;
  int id;
  color col;
  boolean dead = false;
  ArrayList<Body> bodylist;
  {
    body_id += 1;
    id = body_id;
    col =  color(random(64, 255), random(64, 255), random(64, 255));
  }

  int hashCode() {
    return id*17;
  }

  Body(float x, float y, float z, float radius, float density, boolean locked, ArrayList<Body> list) {
    pos = new PVector(x, y, z);
    //pre = new PVector(x,y);
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
    this.radius = radius;
    this.density = density;
    volume = (4/3) * PI * radius * radius * radius;
    this.mass = this.density * volume;

    this.locked = locked;
    this.bodylist = list;
  }

  void attract() {
    for (int i = bodylist.size()-1; i >= 0; i -= 1 ) {
      Body b = bodylist.get(i);
      if (b.id != this.id) {
        attracted(b);
      }
      if (!bodylist.contains(this)) {
        break;
      }
      
    }
  }

  void destroy() {
    if (locked) return;
    //println("destroy");

    int chunks = floor(random(2, 5));

    for (int i = 0; i < chunks; i += 1) {
      Body b = new Body(this.pos.x, this.pos.y, this.pos.z, this.radius / chunks, this.density, false, bodylist);
      b.applyForce(vel);
      bodylist.add(b);
    }
    dead = true;
    //bodylist.remove(this);
  }
  void attracted(Body o) {
    float dist = PVector.dist(pos, o.pos);
    dist = constrain(dist, radius, width*4);
    if (dist < radius + o.radius) {
      this.destroy();
    } else {
      PVector p = PVector.sub(o.pos, pos);
      p.normalize();
      p.mult(bigG * ((mass * o.mass) / sq(dist)));
      applyForce(p);
    }
  }

  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acc.add(f);
  }

  String toString() {
    return id + " (" + pos.x + "," + pos.y + ") r:" + radius + ", d: " + density + ", m: " + mass + ", locked:" + locked;
  }

  void draw() {
    noStroke();
    fill(col);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(radius);
    
    //if (!locked) {
    //  ellipse(pos.x, pos.y, radius, radius);
    //} else {
    //  ellipse(pos.x, pos.y, radius, radius);
    //}

    //line(pos.x, pos.y, pre.x, pre.y);
    if (draw_line) {
      stroke(col, 100);
      if (positions.size() > 5) {
        for (int i = 0; i < positions.size() -1; i += 1) {
          PVector thispos = positions.get(i);
          PVector nextpos = positions.get(i+1);
          line(thispos.x, thispos.y, thispos.z, nextpos.x, nextpos.y, nextpos.z);
        }
      }
    }
    popMatrix();
    //PVector pp = PVector.mult(vel, 20).add(pos);
    //line(pos.x, pos.y, pp.x, pp.y);
  }


  void update() {

    if (!locked) {
      vel.add(acc);
      acc.mult(0);
      vel.limit(width * 2);

      if (draw_line) {
        if (positions.size() >= positions_limit) {
          positions.remove(0);
        }
        positions.add(pos.copy());
      }
      pos.add(vel);
    }
  }
}