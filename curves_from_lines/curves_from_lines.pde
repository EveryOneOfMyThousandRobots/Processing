int res = 32;

ArrayList<PVector> left = new ArrayList<PVector>();
ArrayList<PVector> bottom = new ArrayList<PVector>();
void setup() {
  size(400,400);
  
  float xStep = (float)width / (float)(res+1);
  float yStep = (float)height / (float) (res+1);
  
  for (float x = xStep; x < width; x += xStep) {
    bottom.add( new PVector(x,height));
  }
  
  for (float y = height - yStep; y >= 0; y -= yStep) {
    left.add( new PVector(0,y));
  }
  
  
  
}

int currentI = 0;


void draw() {
  background(0);
  stroke(255);
  currentI = (currentI + 1) % res;
  for (int i = 0; i <= currentI; i += 1) {
    PVector lp = left.get(i);
    PVector bp = bottom.get(res - i - 1);
    
    line(lp.x, lp.y, bp.x, bp.y);
  }
}
