final int NUM_PARTICLES = 200;
PVector GRAVITY = new PVector(0, 0.01);
PGraphics trails;

ArrayList<Mover> movers = new ArrayList<Mover>();
void setup() {
  size(600,600);
  trails = createGraphics(width, height);
  for (int i = 0; i < NUM_PARTICLES; i += 1) {
    PVector r = PVector.random2D();
    r.mult(random(2));
    color c = color(random(128,255), random(128,255), random(128,255));
    
    movers.add(new Particle(width / 2, height / 2, r.x, r.y, c));
  }
  
}

void draw() {
  background(0);
  trails.beginDraw();
  trails.noStroke();
  trails.fill(0,20);
  trails.rect(0,0,width,height);
  trails.endDraw();
  image(trails, 0, 0);
  
  for (int i = movers.size() - 1; i >= 0; i -= 1) {
    Mover m = movers.get(i);
    m.applyForce(GRAVITY);
    m.update();
    m.draw();
    if (!m.alive) {
      movers.remove(i);
    }
    
  }
}
