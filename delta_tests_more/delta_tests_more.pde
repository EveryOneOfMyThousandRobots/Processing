long gt() {
  return System.nanoTime();
}
long time_now = gt();
long time_last = gt();
long time_delta = 0;
float dt = 0;
float dt_accum = 0;
float dt_display = 0;
int secondsCounter = 0;
PVector pos, vel;
void setup() {
  size(400,400);
  pos = new PVector(0, height / 2);
  vel = new PVector(width,0);
}



void draw() {
  
  time_now = gt();
  time_delta = time_now - time_last;
  time_last = time_now;
  
  dt = (float) time_delta / 1e9;
  background(0);
  
  dt_accum += dt;
  if (dt_accum >= 1.0) {
    dt_accum = 0;
    dt_display = dt;
    secondsCounter += 1;
  }
  
  fill(255);
  text(nfc(dt_display, 4) + "\nsec: " + secondsCounter, 10, 10);
  pos.x += vel.x * dt;
  float xx = map(pos.x, 0, width, 0, TWO_PI);
  pos.y = map(sin(xx), -1, 1, 0, height);
  
  stroke(255);
  ellipse(pos.x, pos.y, 5, 5);
  
  if (pos.x >= width) {
    
    pos.x = 0;
  }
  

}
