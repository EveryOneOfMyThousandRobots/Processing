float f(float x) {
  return pow(x,3);
}

float rangeLow, rangeHigh;
float step;
ArrayList<PVector> points = new ArrayList<PVector>();
float lowest, highest;
int zeroXPos, zeroYPos;

void setup() {
  size(800,800);  
  
  
  rangeLow = -6;
  rangeHigh = 6;
  zeroXPos = width - floor(width * (1 / ((rangeHigh - rangeLow) / rangeHigh))); 
  
  println(zeroXPos);
  
  step = 0.1;
  highest = Float.MIN_VALUE;
  lowest = Float.MAX_VALUE;
  for (float x = rangeLow; x < rangeHigh; x += step) {
    PVector p = new PVector(x, f(x));
    points.add(p);
    
    if (p.y > highest) {
      highest = p.y;
    }
    
    if (p.y < lowest) {
      lowest = p.y;
    }
  }
  
  zeroYPos = height - floor(height * (1 / ((highest - lowest) / highest)));
  
}

void draw() {
  background(0);
  //translate(width / 2, height / 2);
  stroke(255);
  line(0, height / 2, width, height / 2);
  line(zeroXPos, 0, zeroXPos, height);
  noFill();
  beginShape();
  for (PVector p : points) {
    float x = map(p.x, rangeLow, rangeHigh, 0, width);
    float y = map(p.y, lowest, highest, height, 0);
    vertex(x,y);
  }
  endShape();
  text(floor(highest), zeroXPos, 20);
  text(floor(lowest), zeroXPos, height - 20);
  text(rangeLow, 0, zeroYPos);
  text(rangeHigh, width - 50, zeroYPos);
}
