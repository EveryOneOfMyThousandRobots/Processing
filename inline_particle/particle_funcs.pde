class Particle {
  PVector pos, vel;
  Particle(float x, float y, float vx, float vy) {
    pos = new PVector(x, y);
    vel = new PVector(vx, vy);
  }
}

void ParticleUpdate(Particle p, float dt, ArrayList<Block> blocks) {



  addForce(p.vel, GRAVITY);
  PVector np = PVector.add(p.pos, PVector.mult(p.vel, dt));
  for (Block b : blocks) {
    if (BlockPointCollide(b,np)) {
      p.vel.mult(-0.6);
      break;
    }
    
  }
  p.pos.add(PVector.mult(p.vel, dt));
}

void addForce(PVector vel, PVector force) {
  vel.add(force);
  vel.limit(1000);
}

void ParticleDraw(Particle p) {
  stroke(255, 0, 0);
  fill(255, 0, 0);
  ellipse(p.pos.x, p.pos.y, 3, 3);
}
