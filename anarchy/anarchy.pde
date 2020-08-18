float f(float x) {
  return 2 + sqrt(-pow(x-2, 2)+1);
}

float g(float x) {
  return 2 - sqrt(-pow(x-2, 2)+1);
}

float h(float x) {
  return (3*x)-3;
}

float i(float x) {
  return -(3*x)+9;
}

float j(float x) {
  return (0.2 * x) + 1.7;
}

void setup() {
  size(800, 800);

  noLoop();
}


float XMIN = -1;
float XMAX = 4;
float YMIN = -1;
float YMAX = 4;
float XSTEP = 0.01;

void plot() {
  noFill();
  stroke(color(255));
  beginShape();
  for (float x = XMIN; x < XMAX; x += XSTEP) {

    plot(x, f(x));
  }
  endShape();


  stroke(color(255,0,0));
  beginShape();
  for (float x = XMIN; x < XMAX; x += XSTEP) {
    plot(x, g(x));
  }
  endShape();

  stroke(color(0,255,0));
  beginShape();
  for (float x = XMIN; x < XMAX; x += XSTEP) {
    plot(x, h(x));
  }
  endShape();

  stroke(color(0,0,255));
  beginShape();
  for (float x = XMIN; x < XMAX; x += XSTEP) {
    plot(x, i(x));
  }
  endShape();

  stroke(color(255,255,0));
  beginShape();
  for (float x = XMIN; x < XMAX; x += XSTEP) {
    plot(x, j(x));
  }
  endShape();
}

void plot(float x, float y) {
  float xp = map(x, XMIN, XMAX, 0, width);
  float yp = map(constrain(y, YMIN, YMAX), YMIN, YMAX, height, 0);

  vertex(xp, yp);
}



void draw() {
  background(0);
  stroke(255);
  plot();
}
