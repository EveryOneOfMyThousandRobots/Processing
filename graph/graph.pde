float dx,dy;
float x = 0;
float y = 0;

float x_start = -1;
float x_end = 1;

void setup() {
  
  size(300,300);
  noLoop();
  
  
}

void draw() {
  background(0);
  stroke(255);
  dx = 0.01;
  float px, py;
  for (x = x_start; x < x_end; x += dx) {
    y = f(x);
    px = map(x, x_start, x_end, 0, width);
    py = map(y, -1, 1, height, 0);
    point(px,py);
    
  }
  
  
}


float f(float x) {
  return pow(x,2);
}
