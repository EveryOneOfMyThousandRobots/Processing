int particle_id = 0;
class Particle {
  PVector pos, newPos;
  PVector acc, vel;
  int id;
  {
    particle_id += 1;
    id = particle_id;
  }
  Particle(float x, float y) {
    pos = new PVector(x, y);
    newPos = pos.copy();
    acc = new PVector(0, 0);
    vel = PVector.random2D();
  }

  void applyForce(PVector force) {
    acc.add(force);
    acc.limit(4);
  }

  void update() {
    newPos.set(pos);
    vel.add(acc);
    acc.mult(0);
    newPos.add(vel);
    if (newPos.x >= width || newPos.x < 0) {
      vel.x *= -1;
    }

    if (newPos.y >= height || newPos.y < 0) {
      vel.y *= -1;
    }
    
    pos.add(vel);
  }
}
