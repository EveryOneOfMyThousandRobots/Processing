final int NUM_PARTICLES = 100;
float[] p_life = new float[NUM_PARTICLES];
PVector[] p_pos = new PVector[NUM_PARTICLES];
PVector[] p_vel = new PVector[NUM_PARTICLES];

PVector GRAV = new PVector(0,0.01);


void createParticles(float x, float y) {
  for (int p = 0; p < NUM_PARTICLES; p += 1) {
    p_life[p] = random(50, 200);
    p_pos[p] = new PVector(x, y);
    p_vel[p] = PVector.random2D().mult(random(-3,3));
  }
}

void updateParticles() {
  for (int p = 0; p < NUM_PARTICLES; p += 1) {
    float l = p_life[p];
    
    if (l <= 0) continue;
    
    l -= 1;
    p_vel[p].add(GRAV);
    p_pos[p].add(p_vel[p]);
    p_life[p] = l;
  }
}

void drawParticles() {
  stroke(255);
  for (int p = 0; p < NUM_PARTICLES; p += 1) {
    float l = p_life[p];
    
    if (l <= 0) continue;
    
    PVector pos = p_pos[p];
    point(pos.x, pos.y);
    
  }
}


void setup() {
  size(600,600);
  createParticles(width / 2,height/2);
}


void draw() {
  background(0);
  updateParticles();
  drawParticles();
}
