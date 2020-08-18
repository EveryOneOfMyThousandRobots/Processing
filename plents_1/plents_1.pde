int PID = 0;
PGraphics bg;

final float C = 100;
final float CSq = C * C;

PVector relAdd(PVector a, PVector b) {



  float x = (a.x + b.x) / (1.0 + ((a.x * b.x) / CSq));
  float y = (a.y + b.y) / (1.0 + ((a.y * b.y) / CSq));


  return new PVector(x, y).limit(C);
}

float MAX_DIST = 0;


final int RES = 2;
class Planet {
  final int id;
  {
    PID += 1;
    id = PID;
  }
  PVector pPos, pos, vel, acc;


  @Override 
    boolean equals(Object o) {
    if (o instanceof Planet) {
      Planet p = (Planet)o;
      return p.id == id;
    }

    return false;
  }


  float mass, radius;
  boolean fixed = false;

  Planet(float x, float y, float vx, float vy, float mass, float radius, boolean fixed) {

    pos = new PVector(x, y);
    pPos = pos.copy();
    vel = new PVector(vx, vy);
    acc = new PVector();
    this.mass = mass;
    this.radius = radius;
    this.fixed = fixed;
  }

  void draw() {
    bg.stroke(255);
    bg.fill(255);
    if (fixed) {
      bg.ellipse(pos.x / RES, pos.y / RES, radius * RES, radius * RES);
    } else {
      float x0 = map(pos.x, -MAX_DIST, MAX_DIST, 0, width);
      float y0 = map(pos.y, -MAX_DIST, MAX_DIST, 0, height);

      float x1 = map(pPos.x, -MAX_DIST, MAX_DIST, 0, width);
      float y1 = map(pPos.y, -MAX_DIST, MAX_DIST, 0, height);
      bg.line(x0 / RES, y0 / RES, x1 / RES, y1 / RES);
    }
  }

  void update() {
    pPos.set(pos);
    //vel.add(acc);
    vel = relAdd(vel, acc);
    acc.mult(0);
    pos.add(vel);

    if (!fixed) {
      PVector f = new PVector();
      for (Planet p : planets) {
        if (!equals(p)) {

          PVector AB = PVector.sub(p.pos, pos);
          float d = AB.magSq();
          AB.normalize();
          AB.mult(mass * p.mass);
          AB.div(d);
          f.add(AB);
        }
      }

      applyForce(f);
    }
  }

  void applyForce(PVector force) {
    PVector f = force.copy().div(mass);

    acc.add(f);
  }
}

ArrayList<Planet> planets = new ArrayList<Planet>();



void setup() {
  size(800, 800);
  planets.add( new Planet(width / 2, height / 2, 0, 0, 1000, 1, true));
  float xx = width  / 2;
  float xs = (width / 2) / 11; 
  for (int i = 0; i < 10; i += 1) {
    float xp = xx + (xs / 2) + (xs * i);
    planets.add(new Planet(xp, height / 2, 0, -1*(i), random(10,100), 0.25, false));
  }

  bg = createGraphics(width / RES, height / RES);
  MAX_DIST = width;
  noSmooth();
}


void draw() {
  background(0);
  bg.beginDraw();
  bg.fill(0, 10);
  bg.noStroke();
  bg.rect(0, 0, bg.width, bg.height);
  //bg.background(0);
  float max_dist = -1;
  for (int i = planets.size()-1; i >= 0; i -= 1) {
    Planet p = planets.get(i);
    p.update();
    p.draw();
    if (!p.fixed) {
      float dist = PVector.dist(planets.get(0).pos, p.pos);
      if (dist > width * 8) {
        planets.remove(i);
      } else {
        if (dist > max_dist) {
          max_dist = dist;
        }
      }
    }
  }
  MAX_DIST = max_dist;


  bg.endDraw();
  image(bg, 0, 0, width, height);
}
