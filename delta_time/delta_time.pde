PVector GRAV = new PVector(0,2);
PVector vel = new PVector();
PVector acc = new PVector();
PVector pos;

void setup() {
  size(400,400);
  pos = new PVector(width / 2, height);
  time_prev = time_now = millis();
}
float dt = 0;

long time_prev, time_now, td;

void draw() {
  
  time_now = millis();
  td = time_now - time_prev;
  time_prev = time_now;
  dt = td;
  if (dt > 0.15) {
    dt = 0.15;
  }
  
  background(0);
  stroke(255);
  fill(255);
  ellipse(pos.x, pos.y, 5,5);
  
  vel.add(PVector.mult(acc, dt));
  acc.mult(0);
  pos.add(PVector.mult(vel,dt));
  
  if (pos.x < 0) {
    pos.x = width-1;
  }
  
  if(pos.x > width) {
    pos.x = 1;
  }
  
  if (pos.y > height) {
    pos.y = height;
    vel.y = 0;
  }
  
  vel.mult(0.99);
  
  
  acc.add(PVector.mult(GRAV,dt));
  
  if (keyPressed) {
    if (key == ' ') {
      acc.add(5,-5);
    }
  }
  
}
