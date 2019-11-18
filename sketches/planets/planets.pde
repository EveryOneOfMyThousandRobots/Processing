static int PARTICLE_ID = 1;
//static final float BIG_G = 6.674 * pow(10, -11);// 6.674×10−11
static final float BIG_G = 6.674 * pow(10, -10);// 6.674×10−11
ArrayList<Particle> particles = new ArrayList<Particle>();
void setup () {
  size(500, 500);
  println("Big G: " +BIG_G);
  background(0);
  
  float howMany = 200;
  float startSize = 4;

  for (int i = 0; i < howMany; i++) {
    float x = random(0, width);
    float y = random(0, height);
    float xd = random(-0.1, 0.1);
    float yd = random(-0.1, 0.1);
    float dens = random(0.1, 1);
    Vect v = new Vect(xd, yd);
    Particle p = new Particle(x, y, startSize, dens, v);
    particles.add(p);
  }
}

void draw() {
  fill(0,10);
  rect(0,0,width, height);
  for (Particle p1 : particles) {
    //println(p.particleId);
    if (!p1.alive) continue;
    p1.draw();
    for (int i = 0; i < particles.size (); i++) {
      Particle p2 = particles.get(i);
      if (p1.particleId != p2.particleId && p2.alive) {
        p1.update(p2);
      }
    }
    p1.update();
  }
}

