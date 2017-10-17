

class Firework {
  Particle start;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  boolean exploded = false;
  
  
  Firework() {
    start = new Particle(random(fromX, toX), height);
    start.applyForce(random(-1,1), random(-9, -3));
    start.starter = true;
  }

  void explode() {
    for (int i = 0; i < 100; i += 1) {
      Particle p = new Particle(start.pos.x, start.pos.y);
      p.vel = PVector.random2D();
      p.vel.add(random(-1,1), random(-1,1));
      p.col = start.col;
      particles.add(p);
    }
  }

  void update() {
    if (!exploded) {
      start.applyForce(gravity);
      start.update();
      if (start.vel.y >= 0) {
        exploded = true;
        explode();
      }
    } else {
      for (int i = particles.size()-1; i >= 0; i -= 1) {
        Particle p = particles.get(i);
        p.applyForce(gravity);
        p.update();
        if (p.pos.y > height || p.alpha <= 0) {
          particles.remove(i);
        }
      }
    }
  }

  void draw() {
    if (!exploded) {
      start.draw();
    } else {
      for (Particle p : particles) {
        p.draw();
      }
    }
  }
}