final float G = 0.1;
int PLANET_ID = 0;
class Planet {
  PVector pos, vel, acc;
  float density, mass;
  float radius;
  float dRadius;
  boolean fixed = false, alive = true, chunk = false;
  final int id;
  {
    PLANET_ID += 1;
    id = PLANET_ID;
  }



  Planet(float x, float y, float size, float density) {
    pos = new PVector(x, y);
    this.radius = size;
    if (this.radius < 1) {
      this.radius = 1;
    }
    this.density = density;
    this.mass = density * ((4.0 / 3.0) * PI * pow(this.radius, 3));

    vel = PVector.random2D().mult(random(1, 3));
    acc = new PVector();
    dRadius = this.radius;//5 + this.radius * 0.01;
    
  }


  void applyForce(PVector force) {
    acc.add(force.copy().div(mass));
  }


  void update() {
    vel.add(acc);
    vel.limit(40);
    acc.mult(0);
    if (!fixed) {
      pos.add(vel);

      if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
        alive =false;
      }
    }
  }

  void attract(Planet p) {
    float dist = PVector.dist(p.pos, pos) * 1000;
    float F = (G * p.mass * mass) / pow(dist, 2);
    applyForce(PVector.sub(p.pos, pos).normalize().mult(F));
  }

  boolean collides(Planet p) {
    if (p.id == id) return false;
    if (p.alive && alive) {
      if (PVector.dist(p.pos, pos) < p.radius + radius) {
        return true;
      }
    }


    return false;
  }

  void explode() {
    if (chunk) {
      alive = false;
    } else {
      int chunks = floor(random(2, 10));
      alive = false;
      float angle = 0;
      for (int i = 0; i < chunks; i += 1) {
        angle = (TWO_PI / (float)chunks) * i;
        float x = pos.x + radius * cos(angle);
        float y = pos.y + radius * sin(angle);
        Planet p = new Planet(x, y, 0.2 * (radius / (float)chunks), density);
        p.vel = PVector.add(vel, PVector.random2D()).mult(0.5);
        p.chunk = true;
        tempBodies.add(p);
      }
    }
  }


  void draw() {
    ellipse(pos.x, pos.y, dRadius, dRadius);
  }
}
