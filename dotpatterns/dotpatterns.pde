class Sheet {
  float x, y;
  float w, h;
  float a;
  float ai;
  float px, py;
  int howManyPoints = 0;
  ArrayList<PVector> points = new ArrayList<PVector>();

  Sheet (float x, float y, float w, float h, float a, float ai, float px, float py, int howManyPoints) {
    this.howManyPoints = howManyPoints;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.a = a;
    this.ai = ai;
    this.px = px;
    this.py = py;
    generate();
    
  }
  
  String toString() {
    return howManyPoints + " (" + x + "," + y + ") " + points.size();
  }

  void update() {
    a += ai;
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    translate(px,py);
    rotate(a);
    translate(-px, -py);
    for (PVector p : points) {
      point(p.x, p.y);
    }
    popMatrix();
  }

  private void generate() {
    for (int i = 0; i < howManyPoints; i++) {
      points.add(new PVector(random(x, x + w), random(y, y+h)));
    }
  }
}
ArrayList<Sheet> sheets = new ArrayList<Sheet>();
void setup() {
  size(1280, 720);
  int howMany = (int) ((width * height) * 0.05);
  Sheet s1 = new Sheet(0, 0, width, height, 0, 0, width / 2, height / 2, howMany);
  Sheet s2 = new Sheet(0, 0, width, height, 0, 0.01, width / 2, height / 2, howMany);
  s2.points = (ArrayList<PVector>)s1.points.clone();
  sheets.add(s1);
  sheets.add(s2);
}

void draw() {
  background(255);
  for (Sheet s : sheets) {
    s.update();
    s.draw();
  }
}