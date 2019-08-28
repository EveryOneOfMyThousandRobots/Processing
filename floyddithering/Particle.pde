ArrayList<Particle> particles = new ArrayList<Particle>();

void particlesProcess() {
  for (int i = 0; i < particles.size(); i += 1) {
    Particle me = particles.get(i);
    for (int j = 0; j < particles.size(); j += 1) {
      if (i == j) continue;
      Particle other = particles.get(j);

      PVector dir = PVector.sub(me.pos, other.pos);
      dir.normalize();
      float dist = PVector.dist(me.pos, other.pos);
      dir.div(dist * dist);
      me.applyForce(dir);
    }
  }
  //PVector pixelPos = new PVector();
   
  for (Particle p : particles) {
     for (Tile t : tiles) {
       float dist = constrain(PVector.dist(p.pos, t.cpos), 1, width);
       PVector dir = PVector.sub(t.cpos, p.pos);
       dir.normalize();
       dir.mult(t.val);
       dir.div(dist * dist);
       p.applyForce(dir);
     }
    //for (int y = 0; y < kitten.height; y += 1) {
    //  for (int x = 0; x < kitten.width; x += 1) {
    //    pixelPos.set(x,y);
    //    float dist = PVector.dist(pixelPos, p.pos);
        
    //    float b = brightness(kitten.pixels[idx(x,y)]) / 255;
    //    pixelPos = PVector.sub(pixelPos, p.pos);
    //    pixelPos.normalize();
    //    pixelPos.mult(b);
    //    pixelPos.div(dist * dist);
    //    p.applyForce(pixelPos);
        
    //  }
    //}
    p.update();
  }
}

void particlesDraw() {
  for (Particle p : particles) {
    p.draw();
  }
}

class Particle {
  PVector pos, acc, vel;
  float mass = random(10,100);
  Particle(float x, float y) {
    pos = new PVector(x, y);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
  }

  void draw() {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, 4, 4);
  }

  void update() {
    vel.add(acc);
    acc.mult(0);
    pos.add(vel);
    vel.mult(0.99);
    vel.limit(4);
  }

  void applyForce(PVector force) {
    acc.add(force.copy().div(mass));
    acc.limit(4);
  }
}