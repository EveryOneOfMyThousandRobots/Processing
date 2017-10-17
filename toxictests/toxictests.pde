VerletPhysics2D world;
VerletParticle2D head, tail;
GravityBehavior2D grav;

int DIM = 10;
int REST_LENGTH = 20;
float STRENGTH = 0.125;
float INNER_STRENGTH = 0.2;

void setup() {
  size(400, 400, P2D);
  world = new VerletPhysics2D();
  grav = new GravityBehavior2D( new Vec2D(0, 1));
  world.behaviors.add(grav);

  world.setWorldBounds(new Rect(0, 0, width, height));

  for (int y = 0, idx = 0; y < DIM; y += 1) {
    for (int x = 0; x < DIM; x += 1) {
      VerletParticle2D p = new VerletParticle2D(x * REST_LENGTH, y * REST_LENGTH);
      world.addParticle(p);

      if (x > 0) {
        VerletSpring2D s = new VerletSpring2D(p, world.particles.get(idx-1), REST_LENGTH, STRENGTH);
        world.addSpring(s);
      }

      if (y > 0) {
        VerletSpring2D s = new VerletSpring2D(p, world.particles.get(idx-DIM), REST_LENGTH, STRENGTH);
        world.addSpring(s);
      }
      idx += 1;
    }
  }
  
  VerletParticle2D p = world.particles.get(0);
  VerletParticle2D q = world.particles.get(world.particles.size()-1);
  float len = sqrt(sq(REST_LENGTH * (DIM-1))*2);
  VerletSpring2D s = new VerletSpring2D(p,q,len, INNER_STRENGTH);
  world.addSpring(s);
  p = world.particles.get(DIM-1);
  q = world.particles.get(world.particles.size()-DIM);
  s = new VerletSpring2D(p,q,len, INNER_STRENGTH);
  world.addSpring(s);
  head = world.particles.get((DIM-1)/2);
  head.lock();
}

void draw() {
  background(0);
  stroke(255);
  head.set(mouseX, mouseY);
  world.update();
  for (VerletSpring2D s : world.springs) {
    line(s.a.x, s.a.y, s.b.x, s.b.y);
  }
}