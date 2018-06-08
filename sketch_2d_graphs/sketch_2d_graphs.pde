ArrayList<FPair> input = new ArrayList<FPair>();
ArrayList<FPair> output = new ArrayList<FPair>();

float maxX, maxY;

float inMaxX = 5;
float inMaxY = 5;

float maxDist;


PVector centre;

void setup() {
  size(800, 400);
  colorMode(HSB);

  centre = new PVector((width / 2) + (width / 4), height / 2);
  maxDist = dist(centre.x, centre.y, width, 0);

  for (float xx = 0; xx < width / 2; xx += 1) {
    float x = map(xx, 0, width / 2, -inMaxX, inMaxX);
    for (float yy = 0; yy < height; yy += 1) {
      float y = map(yy, 0, height, inMaxY, -inMaxY);
      FPair in = new FPair(x, y);
      in.px = xx;
      in.py = yy;
      input.add(in);

      FPair out = f(in);
      out.px = xx + (width / 2);
      out.py = yy;
      output.add(out);
    }
  }

  for (FPair f : output) {
    if (f.valid) {
      float x = abs(f.x);
      float y = abs(f.y);

      if (x > maxX) {
        maxX = x;
      }
      if (y > maxY) {
        maxY = y;
      }
    }
  }

  //for (FPair f : input) {
  //  if (f.valid) {
  //    f.calcPos(false);
  //  }
  //}

  for (FPair f : output) {
    if (f.valid) {
      f.calcPos(true);
      f.calcAngle();
    }
  }
}

void draw() {
  noLoop();
  background(0);
  drawOut();
  drawIn();
  stroke(255);
  noFill();
  line(0, height / 2, width, height / 2);
  line(width / 4, 0, width / 4, height);
  line(width * 0.75, 0, width * 0.75, height);
  textAlign(LEFT);
  text(-inMaxX, 0, (height / 2) - 1);
  textAlign(RIGHT);
  text(inMaxX, (width / 2), (height / 2)- 1);
  
}
