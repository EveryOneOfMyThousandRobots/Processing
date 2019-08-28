ArrayList<P> points = new ArrayList<P>();
class P {
  int x, y;
  color c;
  P() {
    x = floor(random(width));
    y = floor(random(height));
    c = color(random(255), 128, 255);
  }
  void draw() {
    fill(c);
    stroke(0);
    ellipse(x, y, 5, 5);
  }
}
color[][] colours;
int xi = 0, yi = 0;
final int NUM_POINTS = 50;
void setup() {
  frameRate(1000);

  size(300, 300);

  colorMode(HSB);
  generate();
  background(255);
}

void generate() {
  colours = new color[width][height];
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      colours[x][y] = color(255);
    }
  }

  for (int i = 0; i < NUM_POINTS; i += 1) {
    points.add(new P());
  }
}


void draw() {




  P closest = null;
  float dist = 0;
  float shortest = 0;

  for (P p : points) {
    dist = qDist(xi, yi, p);

    if (closest == null || dist < shortest) {
      closest = p;
      shortest = dist;
    }
  }

  if (closest != null) {
    colours[xi][yi] = closest.c;
  }

  stroke(colours[xi][yi]);
  point(xi, yi);


  xi += 1;
  if (xi == width) {
    xi = 0;
    yi += 1;
    if (yi == height) {
      generate();
      xi = 0;
      yi = 0;
    }
  }


  //for (int x = 0; x < width; x += 1) {
  //for (int y = 0; y < height; y += 1) {

  //}
  //}


  for (P p : points) {
    p.draw();
  }
}

float qDist(int x, int y, P p) {
  return qDist(x, y, p.x, p.y);
}

float qDist(int x1, int y1, int x2, int y2) {
  return (pow(x1 - x2, 2) + pow(y1 - y2, 2));
}
