ArrayList<PVector> points = new ArrayList<PVector>();
float min_x = -TWO_PI;
float max_x = TWO_PI;
float step_x = 0.1;
float min_y = 1000000;
float max_y = -1000000;
void setup() {
  size(600, 600);
}

void calcPoints() {
  points.clear();
  min_y = 1000000;
  max_y = -1000000;
  min_x += step_x;
  max_x += step_x;
  float y = 0;
  for (float x = min_x; x < max_x; x += step_x) {
    //float x2 = pow(x,2);
    y = sin(x) + sin(x*2) + cos(x*3) + sin(x*4) + cos(x*5);// + (sin(pow(x,2)));
    points.add(new PVector(x, y));
    if (y < min_y) {
      min_y = y;
    }

    if (y > max_y) {
      max_y = y;
    }
  }
}

void draw() {
  calcPoints();
  background(0);
  stroke(255);
  noFill();
  //fill(255);
  line(width / 2, 0, width / 2, height);
  line(0, height / 2, width, height / 2);
  beginShape();
  for (PVector p : points) {
    float xx = map(p.x, min_x, max_x, 0, width);
    float yy = map(p.y, min_y, max_y, height, 0);
    vertex(xx, yy);
  }
  endShape();
}