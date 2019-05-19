int BALL_ID = 0;
class Ball {
  
  PVector pos, vel, acc;
  float facingAngle;
  
  float radius;
  final int id;
  
  {
    BALL_ID += 1;
    id = BALL_ID;
  }
  Ball(float x, float y, float r) {
    pos = new PVector(x,y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.radius = r;
    
  }
  Ball() {
    this(random(100,width-100), random(100,height-100), random(20,100));
    
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    
    facingAngle = vel.heading() + HALF_PI;
  }
  
  void draw() {
    noFill();
    stroke(255);
    
    circle(pos.x, pos.y, radius*2);
    
    line(pos.x, pos.y, pos.x + radius, pos.y);
    
  }
}
