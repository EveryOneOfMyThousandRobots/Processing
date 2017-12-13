class C {
  PVector pos, vel, acc;
  PVector pulseStart;
  PVector target = null;
  
  float maxR;
  float currentR;
  boolean pulsing = false;
  
  void force(PVector f) {
    acc.add(f);
  }
  
  void randomForce() {
    force(PVector.random2D());
  }
  
  C () {
    pos = new PVector(width / 2, height / 2);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    maxR = width / 4;
  }
  
  void update() {
    if (target == null) {
      if (!pulsing) {
        pulsing = true;
        currentR = 0;
        pulseStart = pos.copy();
      }
      
      currentR += 1;
      
      if (currentR >= maxR) {
        pulsing = false;
        randomForce();
      }
      
      
      
      
    } else {
    
    
    }
    
    vel.add(acc);
    acc.mult(0);
    vel.limit(4);
    pos.add(vel);
    vel.mult(0.99);
  }
  
  void draw() {
    stroke(0);
    fill(128);
    ellipse(pos.x, pos.y, 5,5);
    
    if (pulsing && currentR > 5) {
      stroke(255,0,0);
      noFill();
      ellipse(pulseStart.x, pulseStart.y, currentR, currentR);
    }
  }
}

C c;
void setup() {
  size(400,400);
  c = new C();
}

void draw() {
  background(0);
  c.update();
  c.draw();
}