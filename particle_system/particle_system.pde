ArrayList<Particle> particles = new ArrayList<Particle>();
int ID = 0;
class ParticleType {
  final int id;
  {
    ID += 1;
    id = ID;
  }


  ArrayList<ParticleForce> forces = new ArrayList<ParticleForce>();
  color c = color(random(255), 255, 255);
  
  
  void makeForces() {
    for (ParticleType type : types) {
     
      
      forces.add( new ParticleForce(type));
    }
  }
}
final float MAX_DIST = 100;
class ParticleForce {
  ParticleType otherType;

  float minDist = 10;
  float maxDist = random(minDist, MAX_DIST);
  float mid = random(minDist, maxDist);
  
  float maxForce = random(-3,3);
  
  ParticleForce(ParticleType other) {
    otherType = other;
  }
}

ArrayList<ParticleType> types = new ArrayList<ParticleType>();
final int NUM_TYPES = 3;
final int NUM_DOTS = 100;
QuadTree tree;
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
  background(0);
  M.set(mouseX, mouseY);

  tree = new QuadTree(0, 0, width, height);

  for (Particle p : particles) {
    tree.addPoint(p);
    p.update();
    p.draw();
  }

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
