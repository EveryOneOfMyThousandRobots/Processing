ArrayList<PVector> allPoints = new ArrayList<PVector>();
ArrayList<PVector> rdpPoints = new ArrayList<PVector>();

float eps = 10;

PFont font;
void setup() {
  size(600, 400);
  font = createFont("Consolas", 12);
  textFont(font);
  surface.setLocation(720, 100);
  for (int x = 0; x < width; x += 1) {
    float xv = map(x, 0, width, 0, 5);
    float yv = exp(-xv) * cos(TWO_PI*xv);
    float y = map(yv, -1, 1, height, 0);
    allPoints.add(new PVector(x, y));
  }
}

int addPoint(int start, int end) {
  int ni = findFurthestIndex(allPoints, start, end);
  if (ni > 0) {
    rdpPoints.add(getP(ni));
    addPoint(start, ni);
    addPoint(ni, end);
  } 



  return -1;
}

PVector getP(int i) {
  return allPoints.get(i);
}
float clamp(float f, float min, float max) {
  if (f < min) return min;
  if (f > max) return max;
  return f;
}

void generate() {
  rdpPoints.clear();
  int si = 0;
  int ei = allPoints.size()-1;

  rdpPoints.add(allPoints.get(si));


  addPoint(si, ei);

  rdpPoints.add(allPoints.get(ei));
}
void mouseReleased() {
  if (mouseButton == LEFT) {
    eps = clamp(eps + 1, 1, width);
    generate();
  } else if (mouseButton == RIGHT) {
    eps = clamp(eps - 1, 1, width);
    generate();
  }
}
void draw() {
  background(0);
  stroke(255, 128);
  noFill();
  beginShape();
  for (PVector p : allPoints) {
    vertex(p.x, p.y);
  }
  endShape();

  stroke(255, 0, 255);
  noFill();
  beginShape();
  for (PVector p : rdpPoints) {
    vertex(p.x, p.y);
  }
  endShape();
  text(nfc(eps, 2), 10, 10);
}
