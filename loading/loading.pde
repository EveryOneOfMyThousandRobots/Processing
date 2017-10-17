float a1, a2;
float ai1, ai2;
float cx, cy;
float r = 30;
float d = r * 2;

void setup() {
  size(400, 400);
  a1 = a2 = 0;
  ai1 = 0.1;
  ai2 = 0.12;
  cx = width / 2;
  cy = height / 2;
}

void draw() {
  background(0);
  float x1 = cx + r * cos(a1);
  float y1 = cx + r * sin(a1);

  float x2 = cx + r * cos(a2);
  float y2 = cx + r * sin(a2);



  stroke(255);
  noFill();

  //ellipse(x1, y1, 2, 2);
  //ellipse(x2, y2, 2, 2);
  if (a1 % TWO_PI <= a2 % TWO_PI) {
    arc(cx, cy, d, d, a1, a2);
  } else {
    arc(cx, cy, d, d, a2, a1);
  }

  //a1 = (a1 + ai1) % TWO_PI;
  //a2 = (a2 + ai2) % TWO_PI;

  a1 += ai1;
  a2 += ai2;
  
  text(a1, 10, 10);
  text(a2, 10, 20);
}