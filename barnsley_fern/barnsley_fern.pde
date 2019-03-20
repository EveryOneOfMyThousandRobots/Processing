PVector p = new PVector();
float[][] F1 = {{0.00, 0.00}, {0.00, 0.16}};
float[][] F2 = {{0.85, 0.04}, {-0.04, 0.85}};
float[][] F3 = {{0.20, -0.26}, {0.23, 0.22}};
float[][] F4 = {{-0.15, 0.28}, {0.26, 0.24}};
float[][] C1 = {{0.00}, {0, 0}};
float[][] C2 = {{0.00}, {1.6}};
float[][] C3 = {{0.00}, {1.6}};
float[][] C4 = {{0.00}, {0.44}};

void setup() {
  size(600, 600);
  background(0);
  frameRate(1000000);
}


void draw() {
  //background(0);
  //translate(width / 2, height / 2);

  stroke(255);
  strokeWeight(2);
  for (int i = 0; i < 100; i += 1) {
    float x = map(p.x, -2.1820, 2.6558, 0, width);
    float y = map(p.y, 0, 9.9983, height, 0);
    point(x, y);
    float r = random(1);

    if (r <= 0.01) { //1 %
      p = f(p, F1, C1);
    } else if (r > 0.01 && r <= 0.07) {
      p = f(p, F3, C3);
    } else if (r > 0.07 && r < 0.15) {
      p = f(p, F4, C4);
    } else {
      p = f(p, F2, C2);
    }
  }

  //print(p);
}


PVector f(PVector pv, float[][] F, float[][] C) {

  float x = pv.x;
  float y = pv.y;

  pv.x = F[0][0] * x + F[0][1] * y + C[0][0];
  pv.y = F[1][0] * x + F[1][1] * y + C[1][0];


  return pv;
}
