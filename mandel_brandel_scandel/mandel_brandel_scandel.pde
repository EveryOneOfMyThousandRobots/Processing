

void setup() {
  size(300, 300);
}
float ao = 0.73;
float bo = -0.101;
float amin = -1.0763749999999999880910;
float amax = -1.1763749999999999880910;

float bmin = 0.2576250000000000000000;
float bmax = 0.2951250000000000000000;

float acf = 0.99; //0.1;
float bcf = 0.99;

void draw() {
  background(0);

  loadPixels();
  for (int x = 0; x < width; x+= 1) {
    float a = map((float)x, 0, width, amin, amax);
    a -= ao;
    for (int y = 0; y < height; y += 1) {
      float b = map((float)y, 0, height, bmin, bmax);
      b += bo;
      f(x, y, a, b);
    }
  }

  updatePixels();
  //ao += 0.0001;
  amin *= acf;
  amax *= acf;
  bmin *= bcf;
  bmax *= bcf;
}

final int MAX_I = 1000;
void f(float px, float py, float a, float b) {
  float x0 = a;
  float y0 = b;
  float x = 0;
  float y = 0;
  float i = 0;

  while (x*x + y*y < 4 && i < MAX_I) {
    float xtemp = x*x - y*y + x0;

    y = 2 * x * y + y0;
    x = xtemp;
    i += 1;
  }
  if (i < MAX_I) {
    float log_zn = log(x*x+y*y)/2;
    float nu = log(log_zn / log(2)) / log(2);
    i += 1 - nu;
  }
  color c1 = color(map(floor(i),0, MAX_I+1,0,255));
  color c2 = color(map(floor(i+1),0, MAX_I+1,0,255));
  color c = lerpColor(c1,c2,i%1);
  int pi = floor(py) * width + floor(px);
  pixels[pi] = c;
}
