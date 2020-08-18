int ID = 0;

float G = 0.006;

class Particle {
  final int id;
  {
    ID += 1;
    id = ID;
  }


  @Override
    boolean equals(Object o) {
    if (o instanceof Particle) {
      return ((Particle)o).id == id;
    } else {
      return false;
    }
  }

  PVector pos, vel, acc;
  float mass = random(100,1000);

  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D().mult(random(-1000,1000));
    acc = new PVector();
  }


  void draw() {
    stroke(255);
    ellipse(pos.x, pos.y,3,3);
  }



  void update(float delta) {

    PVector nacc = new PVector();
    for (Particle p : particles) {
      if (equals(p)) continue;

      PVector pv = PVector.sub(p.pos, pos);
      float magsq = pv.magSq();

      float d = (p.mass * mass) / magsq;
      pv.normalize();

      nacc.add(pv.mult(G * d));
    }
    acc.add(nacc);


    vel.add(acc);
    vel.limit(1000 * delta);
    acc.mult(0);

    pos.add( PVector.mult(vel, delta));

    if (pos.x > width) {
      pos.x = 0;
    } 

    if (pos.x < 0) {
      pos.x = width - 1;
    }

    if (pos.y > height) {
      pos.y = 0;
    } 

    if (pos.y < 0) {
      pos.y = height - 1;
    }
  }
}

long getTime() {
  return System.nanoTime();
}

long timeNow = getTime();
long timeLast = getTime();
long timeDelta = 0;
float dt = 0;

ArrayList<Particle> particles = new ArrayList<Particle>();
void setup() {
  size(600, 600);

  for (int i = 0; i < 500; i += 1) {
    particles.add(new Particle(random(width), random(height)));
  }
  background(0);
}


void draw() {
  fill(0,5);
  rect(0,0,width,height);
  timeNow = getTime();
  timeDelta = timeNow - timeLast;

  timeLast = timeNow;
  dt = (float)timeDelta / 1e9; 

  fill(255);
  text(dt, 10, 10);

  for (Particle p : particles) {
    p.update(dt);
    p.draw();
  }
}
