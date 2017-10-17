class Particle {
  PVector pos, vel, acc, prev;
  color col;
  
  {
    prev = new PVector();
    vel = new PVector();
    acc = new PVector();
    col = color(random(255), 255,255);
  }
  Particle(float x, float y) {
    pos = new PVector(x, y);
    
  }

  Particle() {
    pos = new PVector(random(width), random(height));

  }
  
  void applyForce(PVector force) {
    acc.add(force.copy());
    
  }

  void attracted(PVector target) {
    PVector force = PVector.sub(target, pos);
    float dd = force.magSq();
    dd = constrain(dd, 1,50);
    float strength = G / dd;
    force.setMag(strength);
    applyForce(force);
  }

  void draw() {
    stroke(col);
    line(prev.x, prev.y, pos.x, pos.y);
  }

  void update() {
    vel.add(acc);
    prev.set(pos);
    pos.add(vel);
    acc.mult(0);
  }
}