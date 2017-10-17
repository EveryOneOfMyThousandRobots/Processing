VerletPhysics2D world;
ArrayList<VerletParticle2D> particles = new ArrayList<VerletParticle2D>();
void setup() {
  size(600, 600, P2D);
  world = new VerletPhysics2D();
  GravityBehavior2D grav = new GravityBehavior2D(new Vec2D(0, 0.1));
  world.addBehavior(grav);
  world.setWorldBounds(new Rect(0, 0, width, height));


  RectConstraint rect = new RectConstraint(new Rect(20, height / 2, width - 40, 20));
  world.addConstraint(rect);

  ParticleBehavior2D b = new ParticleBehaviour2D(
  VerletParticle2D last = null;
  for (int x = 0; x < width; x += 20) {
    VerletParticle2D p = new VerletParticle2D(x, 0);
    
    particles.add(p);
    
    world.addParticle(p);  
    if (last != null) {
      VerletSpring2D s = new VerletSpring2D(p, last, 20, 0.5);
      
      world.addSpring(s);
    }
    last = p;
  }

  //VerletParticle2D p = new VerletParticle2D(width / 2, height / 2);
  //p.lock();
  //world.addParticle(p);
  //particles.add(p);
  
  VerletPhysics2D.addConstraintToAll(rect,world.particles);
}

void draw() {
  background(0);
  world.update();
  for (VerletParticle2D p : particles) {
    ellipse(p.x, p.y, 10, 10);
  }

  for (ParticleConstraint2D p : world.constraints) {
    if (p instanceof RectConstraint) {
      RectConstraint r = (RectConstraint) p;
      Rect box = r.getBox();
      rect(box.x, box.y, box.width, box.height);
    }
  }
}