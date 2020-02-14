long getTime() {
  return (long) (System.nanoTime() / 1E6);
}

final int FPS = 30;

long dt_now = getTime();
long dt_last = getTime();
long dt = 0;
float deltaTime = 0;

float desired_frame = 1000.0 / (float) FPS;
PVector pos;
void setup() {
  size(400, 400);
  pos = new PVector(width / 2, height / 2);
}


void draw() {
  background(0);
  dt_now = getTime();
  dt = dt_now - dt_last;
  dt_last = dt_now;
  deltaTime = (float) dt / 1000;

  pos.x += width * deltaTime;


  if (pos.x > width) {
    pos.x = 0;
  }
  pos.y = height / 2 + sin(radians(pos.x)) * (height / 2);

  stroke(255);
  fill(255);
  ellipse(pos.x, pos.y, 10, 10);

  text(deltaTime + "\n" + desired_frame + "\n" + dt_now + "\n" + dt, 10, 10);
}
