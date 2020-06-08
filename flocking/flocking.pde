


Flock flock;
void setup() {
  size(800, 800);
  flock = new Flock(10);
}


void draw() {
  background(0);
  flock.update();
  flock.draw();
}
