PGraphics trace;
PVector tracePrev = null;

long getTimeMs() {
  return System.nanoTime() / (long)1e6;
}
Circ circ;
long time_last = getTimeMs();
long time_now = getTimeMs();
long time_delta = 0;
float deltaTime = 0;
float idealTime = 1000.0 / 60.0;
void setup() {
  size(600, 600);

  circ = new Circ(null, 0.1, 1);
  circ.addChild(-0.1, 1);
  circ.addChild(0.1, 0.5);
  circ.addChild(-0.1, 0.5);

  circ.addChild(0.1, 0.25);
  circ.addChild(-0.1, 0.25);
  circ.addChild(0.2, 0.1);
  circ.addChild(-0.3, 0.1);

  //circ.addChild(1.0/6.0, width/32);
  //circ.addChild(3.0/5.0, width/64);
  //circ.addChild(7.0/8.0, width/128);

  trace = createGraphics(width, height);
}


void draw() {
  time_now = getTimeMs();
  time_delta = time_now - time_last;
  deltaTime = time_delta / idealTime;
  time_last = time_now;

  background(51);
  image(trace, 0, 0);
  circ.update();
  circ.draw();
}
