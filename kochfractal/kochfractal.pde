ArrayList<Koch> lines = new ArrayList<Koch>();
PVector zoomPoint = null;

final int NUM_POINTS = 4;

void setup() {
  size(1000, 700);
  background(255);
  float cx = width / 2;
  float cy = height / 2;
  float r = width /4;
  float angle = TWO_PI / float(NUM_POINTS);
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (float i = 0; i < NUM_POINTS; i += 1) {
    float x = cx + r * cos(angle * i);
    float y = cy + r * sin(angle * i);

    points.add(new PVector(x, y));
    if (zoomPoint == null) {
      zoomPoint = new PVector(x,y);
    }
  }

  for (int i = 0; i < points.size()-1; i += 1) {

    PVector start = points.get(i);
    PVector end = points.get(i+1);

    lines.add(new Koch(start, end));
  }
  PVector start = points.get(points.size()-1);
  PVector end = points.get(0);

  lines.add(new Koch(start, end));

  for (Koch k : lines ) {
    println(k);
  }
}

void generate() {
  ArrayList<Koch> next = new ArrayList<Koch>();
  for (Koch line : lines) {
    PVector a = line.kochA();
    PVector b = line.kochB();
    PVector c = line.kochC();
    PVector d = line.kochD();
    PVector e = line.kochE();

    Koch aa = new Koch(a,b);
    Koch bb = new Koch(b,c);
    Koch cc = new Koch(c,d);
    Koch dd = new Koch(d,e);
    
    if (!OOB(aa)) next.add(aa);
    if (!OOB(bb)) next.add(bb);
    if (!OOB(cc)) next.add(cc);
    if (!OOB(dd)) next.add(dd);
    
  }
  lines = next;
}

void mouseClicked() {
  generate();
}

void draw() {
  background(255);
  for (Koch line : lines) {
    line.draw();
  }
}