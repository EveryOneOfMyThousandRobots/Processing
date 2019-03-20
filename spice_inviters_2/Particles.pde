class Particle {
  PVector pos, vel;
  int lifeTime;
  final int initialLifetime;
  
  Particle(float x, float y){
    vel = PVector.fromAngle(random(TWO_PI));
    vel.setMag(random(1,4));
    pos = new PVector(x,y);
    lifeTime = floor(random(100,400));
    initialLifetime = lifeTime;
  }
  void draw() {
    stroke(map(lifeTime, initialLifetime, 0, 255,0));
    point(pos.x, pos.y);
  }
  
  void update() {
    pos.add(vel);
    lifeTime -= 1;
    
  }
}

class Explosion {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  boolean finished = false;
  
  Explosion(float x, float y, int numParticles) {
    for (int i = 0; i < numParticles; i += 1) {
      float r = random(4);
      float a = random(TWO_PI);
      float xx = x + r * cos(a);
      float yy = y + r * sin(a);
      particles.add(new Particle(xx,yy));
    }
  }
  
  void update() {
    for (int i = particles.size() - 1; i >= 0; i -= 1) {
      Particle p = particles.get(i);
      p.update();
      if (p.lifeTime <= 0) {
        particles.remove(i);
      }
    }
    
    if (particles.size() == 0 ){
      finished = true;
    }
  }
  
  void draw() {
    for (Particle p : particles) {
      p.draw();
    }
  }
 
  
}
ArrayList<Explosion> explosions = new ArrayList<Explosion>();
void createExplosion(float x, float y, int numParticles) {
  explosions.add(new Explosion(x,y,numParticles));
  
}
