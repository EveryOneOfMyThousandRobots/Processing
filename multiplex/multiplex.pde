int yi = 0;
final int NUM_CELLS = 30;
boolean[] xb = new boolean[NUM_CELLS];
boolean[] yb = new boolean[NUM_CELLS];

float CELL_WIDTH, CELL_HEIGHT;

final float N_THRESH = 0.5;
void step() {
  float yf = (float)yi * 0.01;
  float zf = (float)frameCount * 0.001; 
  for (int x = 0; x < xb.length; x += 1) {
    float xf = (float)x * 0.01;
    
    
    xb[x] = noise(xf,yf,zf) > N_THRESH;
    
    
      
    
      
  }
  
  yb[yi] = noise(0,yf,zf) > N_THRESH;
}


void setup() {
  size(600,600);
  background(0);
  CELL_WIDTH = width / NUM_CELLS;
  CELL_HEIGHT = height / NUM_CELLS;
}


void draw() {
  noStroke();
  for (int x = 0; x < xb.length; x += 1) {
    if (xb[x] && yb[yi]) {
      fill(255);
    }else {
      fill(0);
    }
    rect(x * CELL_WIDTH, yi * CELL_HEIGHT, CELL_WIDTH, CELL_HEIGHT);
    
  }
  
  step();
  fill(0);
  rect(0,0,50,50);
  fill(255);
  text(yi, 10, 10);
  
  yi += 1;
  yi %= yb.length;
}
