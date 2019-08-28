class Wave {
  float angle, inc, amp;
  
  float inc_max, inc_min;


  Wave(float inc, float amp) {
    this.inc = inc;
    inc_max = inc + random(inc);
    inc_max = inc - random(inc);
    
    this.amp = amp;
  }

  void update() {
    angle += random(inc_min,inc_max);
    angle %= TWO_PI;
  }

  float wsin() {
    return sin(angle) * amp;
  }

  float wcos() {
    return cos(angle) * amp;
  }
}
ArrayList<Wave> waves = new ArrayList<Wave>();
float globalMax, globalMin;
int px, py;
void setup() {
  frameRate(10000);
  size(600, 400);

  waves.add(new Wave(radians(0.1), 1));
  waves.add(new Wave(radians(0.01), 2));
  for (float a = 1; a < 20; a += 1) {
    waves.add(new Wave(radians(a), 0.1/a));
    waves.add(new Wave(radians(0.01 * (a)), 0.2/a));
  }
  for (Wave w : waves) {
    globalMax += w.amp;
  }

  px = 0;
  py = height / 2;

  globalMin = -globalMax;
  println("from " + globalMax + " to " + globalMin);
  background(0);
}

int x = 0;
void draw() {
  fill(0, 5);
  rect(0, 0, width, height);
  noFill();
  stroke(255);

  float y = 0;
  for (Wave w : waves) {
    for (int i = 0; i < 10; i += 1) {
      w.update();
    }
    y += w.wsin() / globalMax;
  }
  float cy = map(y, -1, 1, height, 0);
  point(x, cy);
  x += 1;
  x %= width;
}
