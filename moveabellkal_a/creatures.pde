final int DIRECTION_U = 0;
final int DIRECTION_D = 1;
final int DIRECTION_L = 2;
final int DIRECTION_R = 3;

class Veh {
  float maxSpeed;
  float r = 5;
  float diam = r * 2;

  PVector pos, vel, acc;
  
  Veh(float x, float y) {
    pos = new PVector(x,y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    maxSpeed = random(1,5);
  }
  
  
  
  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
    vel.mult(0.99);
    
    if (pos.x < -diam) {
      pos.x = width + diam;
    } else if (pos.x > width + diam) {
      pos.x = -diam;
    }
    if (pos.y < -diam) {
      pos.y = height + diam;
    } else if (pos.y > height + diam) {
      pos.y = -diam;
    }
    
    if (random(1) < 0.01) {
      fire(floor(random(4)), random(1));
    }
    
  }
  
  void draw() {
    stroke(0);
    fill(128);
    ellipse(pos.x, pos.y, diam, diam);
  }

  void fire(int dir, float force) {
    PVector f = new PVector();
    float x = 0;
    float y = 0;
    switch (dir) {
    case DIRECTION_U:
      y = -1;
      break;
    case DIRECTION_D:
      y = 1;
      break;
    case DIRECTION_R:
      x = 1;
      break;
    case DIRECTION_L:
      x = -1;
      break;
    }
    
    f.x = x;
    f.y = y;
    f.setMag(force);
    f.limit(maxSpeed);
    
    applyForce(f);
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
}