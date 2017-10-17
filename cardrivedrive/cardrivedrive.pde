final float ONE_DEGREE = radians(1);

class Car {
  PVector pos,dim,vel,acc;
  float drag;
  float angle, angleVel, angleDrag;
  float steering;
  Car() {
    pos = new PVector(width / 2, height / 2);
    dim = new PVector(50, 150);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    drag = 0.95;
    angleDrag = 0.99;
    
  }
  
  void setSteer(float st) {
    steering = st;
    if (steering < -1) {
      steering = -1;
      
    } else if(steering > 1) {
      steering = 1;
      
    }
    
    
  }
  
  void update() {
    vel.add(acc);
    acc.mult(0);
    
    pos.add(vel);
    
    angle += angleVel;
    angleVel *= angleDrag;
    PVector p = PVector.fromAngle(angle);
    pos = p.mult(pos.mag());
    
  }
  
  void draw() {
    stroke(255);
    fill(255);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    rect(0,0,dim.x, dim.y);
    popMatrix();
    
    
  }
}
Car c;
void setup() {
  size(500,500);
  c = new Car();
}

void draw() {
  background(0);
  c.update();
  c.draw();
}

void keyPressed() {
  if (keyCode == UP) {
    c.acc.y -= ONE_DEGREE;
  }
  if (keyCode == DOWN) {
    c.acc.y += ONE_DEGREE;
  }
  
  if (keyCode == LEFT) {
    c.angleVel -= ONE_DEGREE;
  }
  
  if (keyCode == RIGHT) {
    c.angleVel += ONE_DEGREE;
  }
  
  
  
}