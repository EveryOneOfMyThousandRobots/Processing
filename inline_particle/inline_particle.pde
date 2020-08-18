PVector GRAVITY = new PVector(0,100);



long time() {
  return System.nanoTime();
}

long timeNow = time();
long timeLast = time();
long timeDelta = 0;
float delta = 0;
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Block> blocks = new ArrayList<Block>();
void setup() {
  
  size(800,800);
  for (int i = 0; i < 100; i += 1) {
    PVector vel = PVector.random2D().mult(random(300));
    particles.add( new Particle(random(width), random(height), vel.x, vel.y));
  }
  
  blocks.add( new Block(0,height-10,width, 10));
  blocks.add( new Block(0,10,10,height));
  blocks.add( new Block(width-10,10,10,height));
  
}


void draw() {
  background(0);
  timeNow = time();
  timeDelta = timeNow - timeLast;
  delta = (float)timeDelta / 1e9;
  timeLast = timeNow;
  
  for (Block b : blocks) {
    BlockDraw(b);
  }
  
  for (Particle p :particles) {
    
    ParticleUpdate(p,delta, blocks);
    
    ParticleDraw(p);
  }
}
