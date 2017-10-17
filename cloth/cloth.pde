Particle[][] particles;
ArrayList<Spring> springs;
VerletPhysics2D physics;
float w = 10;

final int COLS = 40;
final int ROWS = 40;
void setup() {
  size(600, 600);
  particles = new Particle[COLS][ROWS];
  springs = new ArrayList<Spring>();

  physics = new VerletPhysics2D();
  Vec2D grav = new Vec2D(0, 0.1);
  GravityBehavior2D gb = new GravityBehavior2D(grav);
  physics.addBehavior(gb);
  float x = 100;
  float y = 10;

  for (int i = 0; i < particles.length; i += 1) {
    y = 10;
    for (int j = 0; j < particles[i].length; j += 1) {
      Particle p = new Particle(x, y);
      particles[i][j] = p;
      physics.addParticle(p);
      y += w;
    }
    x += w;
  }
  int ilimit = particles.length;
  int jlimit = particles[0].length;
  for (int i = 0; i < ilimit; i += 1) {

    for (int j = 0; j < jlimit; j += 1) {
      Particle a = particles[i][j];
      if (j < jlimit-1) {
        Particle b = particles[i][j+1];

        Spring s = new Spring(a, b);
        physics.addSpring(s);
        springs.add(s);
      }
      if (i < ilimit-1) {
        Particle c = particles[i+1][j];
        Spring s2 = new Spring(a, c);
        physics.addSpring(s2);
        springs.add(s2);
      }
    }
  }

  particles[0][0].lock();
  particles[COLS-1][0].lock();
  particles[COLS-1][ROWS-1].lock();
}

void draw() {
  background(51);
  physics.update();  
  for ( Particle[] pa : particles) {
    for (Particle p : pa) {
      p.draw();
    }
  }

  for (Spring s : springs) {
    s.draw();
  }
}