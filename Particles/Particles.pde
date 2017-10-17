//ParticleSystem ps;
ArrayList<Particle> particles = new ArrayList<Particle>();
PVector grav = new PVector(0, 0.05);
void setup() {
  size(640, 480);
  //ps = new ParticleSystem();
  for (int i = 0; i < 100; i += 1) {
    PVector loc = new PVector(random(width), random(height));
    Particle p = new Particle(loc);
    particles.add(p);
  }
  // p.applyForce(new PVector(random(-1, 1), random(-1, 1)));
}

void draw() {
  background(255);

  PVector loc = new PVector(random(width), random(height));
  Particle p = new Particle(loc);
  particles.add(p);
  //ps.run();
  for (int i = particles.size() - 1; i >= 0; i -= 1) {

    p = particles.get(i);
    p.applyForce(grav);
    if (!p.isDead()) {
      p.update();
      p.draw();
    } else {
      particles.remove(i);
    }
  }
  fill(0);
  text(particles.size(), 10, 10);
}