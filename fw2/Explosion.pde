class Particle {
  PVector pos, vel;
  float timer;
  float maxTimer;
  color c;
  color initC;
  boolean alive = true;
  
  Particle(float x, float y, color c, PVector initialV) {
    this.pos = new PVector(x,y);
    this.vel = initialV.copy().mult(0.5);
    this.timer = floor(random(25,500));
    maxTimer = timer;
    this.c = c;
    this.initC = c;
    
  }
  
  void draw() {
    stroke(c);
    point(pos.x, pos.y);
  }
  
  void update() {
    float cf = timer / maxTimer;
    c = color(red(initC) * cf, green(initC)*cf, blue(initC) * cf);
    timer -= 1;
    pos.add(vel);
    vel.add(GRAV);
    if (timer <= 0) {
      alive =false;
    }
  }
}

class Explosion {
  Particle[] particles;
  //PVector[] sparks;
  //PVector[] vels;
  //int[] times;
  int timer;
  color c;


  Explosion(float x, float y, int sparks, PVector initialV) {
    particles = new Particle[sparks];
    PVector iv = initialV.copy().mult(0.5);
    c = color(random(128,255), random(128,255), random(128,255));
    timer = floor(random(100,200));
    for (int i = 0; i < particles.length; i += 1) {
      particles[i] = new Particle(x,y,c,PVector.add(iv, PVector.random2D()).mult(random(1,3)));
      
    }
    //this.sparks = new PVector[sparks];
    //this.vels = new PVector[sparks];
    //this.times = new int[sparks];
    //
    //for (int i = 0; i < sparks; i += 1) {
    //  this.sparks[i] = new PVector(x, y);
    //  this.vels[i] = PVector.add(iv, PVector.random2D()).mult(random(1,2));
    //  times[i] = floor(random(25, 100));
    //  //this.sparks.add(new PVector(x,y));
    //  //this.vels.add(PVector.random2D());
    //}
    //
    
    
  }

  void draw() {
    stroke(c);
    for (int i = particles.length-1; i >= 0; i -= 1) {
      if (particles[i].alive) {
        particles[i].draw();
        //PVector p = sparks[i];
        //point(p.x, p.y);
      }
    }
  }


  void update() {
    timer -= 1;
    for (int i = particles.length-1; i >= 0; i -= 1) {
      if (particles[i].alive) {
        particles[i].update();
      } else {
        
      }
    }
  }
}
