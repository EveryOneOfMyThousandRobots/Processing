
ArrayList<Wave> waves = new ArrayList<Wave>();
float x = 0;
float y = 0;
float px, py;
float displayAvg = 0;
float displayAvgTimer = 0;
float timeNow = 0;
float timeLast = 0;
float timeDelta = 0;
float[] values;
PGraphics bg;
int res, steps;

float globalMin, globalMax;
void setup() {
  size(600, 400);
  values = new float[width];
  bg = createGraphics(width, height);
  steps = 8;
  res = (height / 2) / steps;

  for (int i = 0; i < 10; i += 1) {
    waves.add(new Wave());
  }
  background(0);

  globalMax = 0;
  globalMin = 0;
  for (Wave wave : waves) {
    globalMax += wave.ampNoise.max;
  }
  globalMin = -globalMax;
  println("range from " + globalMin + " to " + globalMax);
}

void draw() {

  timeNow = millis();
  timeDelta = timeNow - timeLast;
  timeLast = timeNow;
  //noStroke();
  //fill(0, 1);
  //rect(0, 0, width, height);
  background(0);



  float y = 0; //width / 2;
  for (Wave wave : waves) {
    for (int i = 0; i < 100; i += 1) {
      wave.update();
    }
    y += wave.getValue() / globalMax;
  }
  values[floor(x)] = y;
  y = (y + 1) * 0.5;
  y = (height / 2)- (y * width / 4);
  bg.beginDraw();
  bg.stroke(255);
  bg.line(px, py, x, y);
  px = x;
  py = y;
  bg.endDraw();
  image(bg, 0, 0);
  x += 1;
  if (x >= width) {
    x = 0;
    bg.beginDraw();
    bg.background(0);
    bg.endDraw();
    px = 0;
  }
  stroke(255);
  line(0, height/2, width, height/2);



  float avg = 0;
  for (float f : values) {
    avg += f;
  }
  avg /= width;
  line(0, (height / 2) - avg, 50, (height / 2)-avg);

  stroke(255, 64);
  int cy = steps;
  for (int sy = 0; sy < height; sy += res) {

    line(0, sy, width, sy);
    text(cy, 10, sy-1);
    cy -= 1;
  }

  //if (displayAvgTimer <= 0) {
  //  displayAvgTimer += 1000;
  //  displayAvg = avg;
  //} else {
  //  displayAvgTimer -= timeDelta;
  //}
  //text(nfc(displayAvg, 3), 10, 10);
}
