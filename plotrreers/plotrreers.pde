float xLow, xHigh;
float yLow, yHigh;
float xStep = 0.01;
ArrayList<FP> inputs = new ArrayList<FP>();
ArrayList<FP> outputs = new ArrayList<FP>();

float outxLow = 10000000;
float outxHigh = -10000000;
float outyLow = 10000000;
float outyHigh = -1000000;




class FP {
  float x, y;
  FP (float x, float y) {
    this.x = x;
    this.y = y;
  }
}

void setup() {
  size(800, 400);
  xLow = -5;
  xHigh = 5;
  yLow = -5;
  yHigh = 5;

  for (float x = xLow; x < xHigh; x += xStep) {
    for (float y = yLow; y < yHigh; y+= xStep) {
      FP input = new FP(x, y);
      inputs.add(input);
      outputs.add(f(input));
    }
  }

  for (FP f : outputs) {
    if (f.x < outxLow) outxLow = f.x;
    if (f.x > outxHigh) outxHigh = f.x;
    if (f.y < outyLow) outyLow = f.y;
    if (f.y > outyHigh) outyHigh = f.y;
  }
  
  for (FP f : outputs) {
    f.x = map(f.x, outxLow, outxHigh, width / 2, width);
    f.y = map(f.y, outyLow, outyHigh, height, 0);
    
  }
  
  


  noLoop();
}


FP f(FP input) {

  FP f = new FP(pow(input.x, 5) - input.x, pow(input.y, 3) + input.y);
  return f;
}

void draw() {
  background(0);
  colorMode(HSB);
  PVector cp = new PVector(width * 0.75, height / 2);
  float maxDist = PVector.dist(cp, new PVector(width, 0));
  for (FP f : outputs) {
    PVector fp = new PVector(f.x, f.y);
    PVector p = PVector.sub(cp, fp);
    p.normalize();
    float h = p.heading();
    //print(h + " ");
    float d = map(PVector.dist(cp,fp), 0, maxDist, 0, 255);
    stroke(map(h, -PI , PI, 0, 255), 255, d);
    point(f.x, f.y);
    
  }
}