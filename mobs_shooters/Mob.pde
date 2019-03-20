class Mob {
  PVector pos, acc, vel;
  float rotate = 0;
  DNA dna;
  int numEyes;
  float viewDistance, fireRate;
  float facing;
  Eye[] eyes;
  float radius = MOB_RADIUS;
  PVector target = null;
  float targetChance;
  float maxSpeed, maxForce;
  PVector facingVector;

  Mob(float x, float y, DNA dna) {
    if (dna == null) {
      this.dna = new DNA();
      this.dna.init();
    } else {
      this.dna = new DNA(dna);
    }
    this.dna.mutate();
    this.pos = new PVector(x, y);
    this.acc = new PVector();
    this.vel = new PVector();
    init();
  }

  void init() {
    numEyes = floor(dna.getMapped("eyes", 1, 6));
    targetChance = dna.getMapped("targetChance", 0, 0.1);
    maxSpeed = dna.getMapped("maxSpeed", 1, 4);
    maxForce = dna.getMapped("maxForce", 1, 2);
    eyes = new Eye[numEyes];
    float a = 0;
    float vd = 0;
    for (int i = 0; i < eyes.length; i += 1) {
      a = dna.getMapped("eyeAngle"+i, 0, TWO_PI);
      vd = dna.getMapped("eyeViewDistance"+i, 0, 100);
      Eye e = new Eye(this, a, vd);
      eyes[i] = e;
    }
  }

  void update() {
    rotate += random(-0.01, 0.01);
    rotate *= 0.999;
    facing += rotate;
    facingVector = PVector.fromAngle(facing);
    facingVector.mult(radius * 2);
    vel.add(acc);
    acc.mult(0);
    pos.add(vel);
    vel.mult(0.9);
    seek();
  }

  void steer(PVector t) {
    PVector steer = PVector.sub(t, pos);
    steer.setMag(maxSpeed);
    steer = PVector.sub(steer, vel);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  void seek() {
    if (target == null) {
      if (random(1) < targetChance) {
        target = new PVector(random(width), random(height));
        return;
      }
    } else {
      if (target.dist(pos) < 2) {
        target = null;
      } else {
        steer(target);
      }
    }
  }

  void draw() {
    stroke(255);
    fill(128);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
    for (Eye e : eyes) {
      e.draw();
    }
    
    stroke(255);
    line(pos.x, pos.y, pos.x + facingVector.x, pos.y + facingVector.y);
  }
}
