final float AI = radians(.5);
Range b, c, d, e, f, g, h, k;
final float NUM_STEPS = 10;
ArrayList<Range> ranges = new ArrayList<Range>();
void setup() {
  size(400, 400);
  background(0);
  b = new Range(0.1, 16, NUM_STEPS);
  c = new Range(0.1, 13, NUM_STEPS);
  d = new Range(0.1, 5, NUM_STEPS);
  e = new Range(0.1, 2, NUM_STEPS);
  f = new Range(0.1, 2, NUM_STEPS);
  g = new Range(0.1, 3, NUM_STEPS);
  h = new Range(0.1, 4, NUM_STEPS);
  k = new Range(2, 3, NUM_STEPS);
  ranges.add(b);
  ranges.add(c);
  ranges.add(d);
  ranges.add(e);
  ranges.add(f);
  ranges.add(g);
  ranges.add(h);
  ranges.add(k);
  frameRate(200);
}
float a = 0;
float x, y, px, py;
float r = 5;//width / 4;
int count = 0;



void draw() {
  fill(0, 5);
  rect(0, 0, width, height);
  //background(0);
  translate(width / 2, height / 2);
  a += AI;
  stroke(255);
  noFill();
  //beginShape();
  //for (float a = 0; a < TWO_PI; a += AI) {
  float x = r * (b.v * pow(sin(a), 3));
  float y = r * (-1 * (c.v * cos(a) - d.v * cos(e.v * a) - f.v * cos(g.v * a) - cos(h.v * a)));

  if (count > 0) {
    line(px, py, x, y);
  }
  px = x;
  py = y;

  count += 1;

  if (a > TWO_PI) { 
    println(a + " " + b.v + " " + b.inc + " " + b.start + "-" + b.end);
    a %= TWO_PI;
    for (Range r : ranges) {
      r.update();
    }
  }
  //vertex(x, y);
  //}
  //endShape(CLOSE);
}

class Range {
  float start, end;
  float inc;
  float steps;
  float v = 0;
  float dir = 1;
  float a = 0;

  Range(float start, float end, float steps) {
    this.start = start;
    this.end = end*2;
    this.steps = steps;
    inc = TWO_PI / steps;
    v = start;
  }

  void update() {
    a += inc;

    v = map(sin(a), -1, 1, start, end);
  }
}
