class Boid {
  final int id;
  {
    BOID_ID += 1;
    id = BOID_ID;
  }

  float maxForce = 0.5;
  float maxSpeed = 2;
  PVector pos, vel, acc;
  Boid(float x, float y) {
    this.pos = new PVector(x, y);
    vel = PVector.random2D();
    acc = new PVector();
  }

  void avoid(PVector target) {
    
    PVector desired = PVector.sub(pos, target);
    float dist = min(desired.mag(),MAX_DIST);
    desired.normalize();
    
    desired.mult(dist / MAX_DIST);
    PVector steer = PVector.sub(desired, vel);

    steer.limit(maxForce);

    applyForce(steer);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  PVector align() {
    PVector sum = new PVector(0, 0);

    for (Boid b : boids) {
      if (b.id == id) continue;


      sum.add(b.vel);
    }

    sum.div(boids.size()-1);
    sum.setMag(maxSpeed);
    PVector steer = PVector.sub(sum, vel);
    steer.limit(maxForce);

    return steer;
  }

  void update() {
    results.clear();
    quadTree.GetWithinRange(pos, MAX_DIST, results);
    for (Boid b : results) {
      if (b.id == id) continue;
      

      
        avoid(b.pos);
      
    }


    vel.add(acc);
    vel.setMag(maxSpeed);
    acc.mult(0);
    pos.add(vel);

    if (pos.x < 0) {
      pos.x = width-1;
    }
    if (pos.x > width) {
      pos.x = 0;
    }

    if (pos.y < 0) {
      pos.y = height-1;
    }
    if (pos.y > height) {
      pos.y = 0;
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading()-HALF_PI);

    stroke(255);
    fill(255, 128);
    beginShape();
    vertex(0, 10);
    vertex(5, 0);
    vertex(-5, 0);
    endShape(CLOSE);
    stroke(255, 0, 0);
    point(0, 0);
    popMatrix();
  }
}
