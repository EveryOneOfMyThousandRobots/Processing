long time() {
  return System.nanoTime();
}


void setup() {
  size(600, 600, P3D);
  shape0 = new Shape();
  shape1 = new Shape();
  
}

long time_last = time();
long time_now = time();
long time_delta = 0;
float dt = 0;

Shape shape0;
Shape shape1;
void draw() {
  time_now = time();
  time_delta = time_now - time_last;
  time_last = time_now;
  dt = (float)time_delta / 1e9;

  background(0);
  shape0.update(dt);
 // shape1.update(dt);
  translate(width / 2, height / 2, -50);
  shape0.draw();
 // shape1.draw();
}






final int F_TL = 0;
final int F_TR = 1;
final int F_BR = 2;
final int F_BL = 3;

final int B_BR = 4;
final int B_BL = 5;
final int B_TR = 6;
final int B_TL = 7;
