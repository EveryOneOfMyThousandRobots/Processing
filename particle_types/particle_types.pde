
Type[] types;
HashMap<Integer, Type> typeMap = new HashMap<Integer, Type>();
int ID = 0;
ArrayList<Particle> particles = new ArrayList<Particle>();

long gt() {
  return System.nanoTime();
}
long time_now = gt();
long time_last = gt();
long time_delta = 0;
float dt = 0;

final int NUM_TYPES = 4;
final int NUM_PARTICLES = 100;
void setup() {
  size(800,800);
  colorMode(HSB);
  types = new Type[NUM_TYPES];
  
  for (int i = 0; i < NUM_TYPES; i += 1) {
    Type t = new Type();
    types[i] = t;
  }
  
  for (Type t : types) {
    t.makeForces(types);
  }
  
  for (int i = 0; i < NUM_PARTICLES; i += 1) {
    Type t = types[floor(random(types.length))];
    particles.add(new Particle(random(width) , random(height), t));
  }
  
}

void draw() {
  time_now = gt();
  time_delta = time_now - time_last;
  time_last = time_now;
  dt = (float)time_delta / 1e9;
  background(0);
  
  for (Particle p : particles) {
    p.update(particles);
    p.draw();
  }
}
