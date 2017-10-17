class Particle {
  PVector pos, vel, acc;
  color col;
  boolean starter = false;
  float alpha = 255;

  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    col = color(random(128, 255), random(128, 255), random(128, 255));
  }



  void applyForce(PVector force) {
    acc.add(force);
  }

  void applyForce(float x, float y) {
    acc.add(x, y);
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    if (!starter) {
      vel.mult(0.94);
      if (alpha > 0) {
      alpha -= 3;
      
      }
    }
    acc.mult(0);
    
  }

  void draw() {
    stroke(col,alpha);
    strokeWeight(2);
    point(pos.x, pos.y);
  }
}