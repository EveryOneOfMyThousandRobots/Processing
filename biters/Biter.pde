final int BORDER = 10;
class Biter {
  PVector nextPos, pos, vel, acc;
  float maxForce = 2;
  float maxSpeed = 4;
  float moveChance = random(1);
  float grabChance = random(0.1);
  float dropChance = random(0.1);
  PImage img = null;
  boolean holding;
  Biter() {
    pos = new PVector(random(width), random(height));
    nextPos = pos.copy();
    vel = new PVector();
    acc = new PVector();
    
    
  }
  
  void grab() {
    if (!holding && random(1) < grabChance) {
      
      img = bg.get((int)pos.x, (int)pos.y, 5, 5);
      holding = true;
    }
  }
  
  void drop() {
    if (holding && random(1) < dropChance) {
      PImage temp = bg.get((int)pos.x, (int)pos.y, 5, 5);
      bg.set((int)pos.x, (int)pos.y, img);
      img = temp;
      //holding =false;
    }
  }
  
  void move() {
    if (random(1) < moveChance) {
      applyForce(PVector.random2D().mult(random(maxForce)));
    }
    
    grab();
    drop();
    
  }
  
  void applyForce(PVector force) {
    acc.add(force);
    acc.limit(maxForce);
  }
  
  void update() {
    
    vel.add(acc);
    vel.limit(maxSpeed);
    vel.mult(0.99);
    acc.mult(0);
    nextPos.set(pos);
    nextPos.add(vel);
    
    if (nextPos.x <= BORDER || nextPos.x >= width-BORDER) {
      vel.x *= -1;
      vel.mult(0.9);
    }
    
    if (nextPos.y <= BORDER || nextPos.y >= height-BORDER) {
      vel.y *= -1;
      vel.mult(0.9);
    }
    
    
    
    pos.add(vel);
    
    
    
    
  }
  
  void draw() {
    stroke(255);
    fill(255);
    ellipse(pos.x, pos.y, 4, 4);
  }
}
