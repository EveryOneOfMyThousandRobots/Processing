ArrayList<Particle> particles = new ArrayList<Particle>();
int ID = 0;


ArrayList<ParticleType> types = new ArrayList<ParticleType>();
final int NUM_TYPES = 3;
final int NUM_DOTS = 100;
QuadTree tree;

long time_now = System.nanoTime();
long time_last = System.nanoTime();
long time_delta = 0;
float dt = 0;
float dt_accum = 0;
float dt_display = 0;
void setup() {
  size(1280, 900);

  colorMode(HSB);

  for (int i = 0; i < NUM_TYPES; i += 1) {
    types.add(new ParticleType());
  }
  
  for (ParticleType type : types) {
    type.makeForces();
  }

  for (int i = 0; i < NUM_DOTS; i += 1) {
    particles.add( new Particle(random(width), random(height)));
  }
  M = new PVector(mouseX, mouseY);
  
  //frameRate(1);
}
PVector M;
float mbw = 100;
float mbh = 100;
final float BORDER = 10;
ArrayList<QuadTreePoint> mlist = new ArrayList<QuadTreePoint>();
void draw() {
  time_now = System.nanoTime();
  time_delta = time_now - time_last;
  time_last = time_now;
  dt = (time_delta / 1e9);
  
  background(0);
  M.set(mouseX, mouseY);

  tree = new QuadTree(0, 0, width, height);

  for (Particle p : particles) {
    tree.addPoint(p);
    p.update();
    p.draw();
  }
  
  fill(255);
  dt_accum += dt;
  if (dt_accum > 1) {
    dt_display = dt;
    dt_accum -= 1;
  }
  text(nfc(dt_display, 4), 10, 10);

 // tree.draw();

//  stroke(0, 255, 255);
//  noFill();
//  ellipse(M.x, M.y, mbw*2, mbh*2);
//  mlist.clear();
//  tree.getPointsInCicle(mlist, M.x, M.y, mbw);
//  stroke(0, 255, 0);
//  noFill();
//  for (QuadTreePoint qtp : mlist) {
//    ellipse(qtp.pos.x, qtp.pos.y, 5, 5);
//  }
}
