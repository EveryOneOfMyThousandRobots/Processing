class Explosion {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  Explosion(PVector pos, PVector vel) {
    int count = floor(random(20,100));
    for (int i = 0; i < count; i += 1) {
      particles.add(new Particle(pos, vel));
    }
  }
  
  void update() {
    for (int i = particles.size()-1; i >= 0; i -= 1) {
      Particle p = particles.get(i);
      p.update();
      if (!p.alive) {
        particles.remove(i);
      }
    }
  }
  
  void draw() {
    for (Particle p : particles) {
      p.draw();
    }
  }
}


class Particle{ 
  PVector pos, vel;
  float lifeTime;
  float timer;
  boolean alive = true;
  
  
  Particle(PVector pos, PVector startingVel) {
    this.pos = pos.copy();
    this.vel = startingVel.copy();
    this.vel.mult(random(3, 5));
    this.vel.add( PVector.random2D().mult(random(1,5)));
    lifeTime = random(10,200);
    timer = floor(lifeTime);
  }
  
  
  void draw() {
    pushMatrix();
    float r = 255;
    float g = map(timer, 0, lifeTime, 255,0);
    float b = 0x12;
    float a = map(timer, 0, lifeTime, 0, 255);
    stroke(r,g,b, a);
    //strokeWeight(map(timer, 0, lifeTime, 0.01, 2));
    
    point(pos.x, pos.y);
    popMatrix();
  }
  
  void update() {
    timer -=1 ;
    
    
    if (timer <= 0) {
      alive = false;
    } else {
      pos.add(vel);
      if (isPointOOB(pos)) {
        alive = false;
      }
    }
    
    
  }
}