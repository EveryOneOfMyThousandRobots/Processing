class Particle {
  PVector pos,vel,acc;
  
  float lifespan;
  float lifeRemaining;
  
  Particle(PVector pos) {
    this.pos = pos.copy();
    acc = new PVector(0, 0.005);
    vel = new PVector(random(-1,1) , random(-1,1));
    lifespan = random(255,1000);
    lifeRemaining = lifespan;
  }
  
  void update() {
    
    vel.add(acc);
    acc.mult(0);
    pos.add(vel);
    
    lifeRemaining -= 2;
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void draw() {
    float t = map(lifeRemaining, 0, lifespan, 0, 255);
    stroke(0, t);
    fill(175, t);
    ellipse(pos.x, pos.y, 8,8);
  }
  
  
  boolean isDead() {
    return lifeRemaining < 0;
      
  }
}