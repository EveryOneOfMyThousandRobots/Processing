PeasyCam cam;

Particle[][] particles;
ArrayList<Spring> springs;
VerletPhysics3D physics;
final float DIST = 10;


final int COLS = 40;
final int ROWS = 40;
void setup() {
  size(600, 600, P3D);
  particles = new Particle[COLS][ROWS];
  springs = new ArrayList<Spring>();

  physics = new VerletPhysics3D();
  Vec3D grav = new Vec3D(0, 1, 0);
  GravityBehavior3D gb = new GravityBehavior3D(grav);
  physics.addBehavior(gb);
  float x = -width /4;
  float z = 10;

  for (int i = 0; i < particles.length; i += 1) {
    z = -100;
    for (int j = 0; j < particles[i].length; j += 1) {
      Particle p = new Particle(x, -100, z);
      particles[i][j] = p;
      physics.addParticle(p);
      z += DIST;
    }
    x += DIST;
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

      if (i < ilimit-1 && j < jlimit-1) {
        Particle c = particles[i+1][j+1];
        Spring s2 = new Spring(a, c);
        physics.addSpring(s2);
        springs.add(s2);
      }
    }
  }

  particles[0][0].lock();
  particles[0][ROWS-1].lock();
  particles[COLS-1][0].lock();
  particles[COLS-1][ROWS-1].lock();

  cam = new PeasyCam(this, 800);
  cam.lookAt(width / 2, height / 2, 0);
}

void draw() {
  translate(width / 2, height / 2);
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