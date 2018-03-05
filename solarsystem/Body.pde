int BODY_ID = 0;
final float GRAV = 6.67E-11;
class Body {
  int id;
  {
    BODY_ID += 1;
    id = BODY_ID;
  }
  //members
  final float density; 
  final float mass;
  final float radius;
  final float volume;
  PVector pos, vel, acc, grav;
  final boolean fixed;// = false;

  //constructor
  Body(float x, float y, float density, float radius, boolean fixed) {
    this.pos = new PVector(x, y);
    this.density = density;
    this.volume = (4.0 / 3.0) * PI * pow(radius, 3);
    this.mass = density * volume;

    this.radius = radius;
    this.fixed = fixed;

    vel = new PVector();
    acc = new PVector();
    grav = new PVector();
  }


  void draw() {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, radius * 2, radius* 2);
    stroke(255);
    trails.beginDraw();
    trails.stroke(255,128);
    trails.point(pos.x, pos.y);
    trails.endDraw();
  }

  void update() {

    vel.add(acc);
    acc.mult(0);
    if (!fixed) {
      pos.add(vel);
    }

    for (Body body : bodies) {
      if (this.id != body.id) {
        attract(body);
      }
    }
  }

  void applyForce(PVector force) {
    acc.add(PVector.div(force, mass));
  }

  void attract(Body body) {
    grav.set(PVector.sub(body.pos, pos));
    float dist = grav.mag();
    dist = constrain(dist, 1, width * 2);

    float f = (GRAV * this.mass * body.mass) / pow(dist, 2);
    grav.mult(f);
    applyForce(grav);
  }
}

ArrayList<Body> bodies = new ArrayList<Body>();