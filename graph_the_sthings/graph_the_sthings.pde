float f(float x) {
  return sin(x);
}


float mapX(float x) {
  return map(x, 0, width, -TWO_PI,TWO_PI);
}

void setup() {
  size(800,800);
}


void draw() {
  background(0);
  
  stroke(255);
  noFill();
  beginShape();
  for (int x = 0; x < width; x += 1) {
    float y = f(mapX(x));
    y = map(y, -1, 1, height,0);
    vertex(x,y);
    
  }
  endShape();
  
  stroke(255);
  line(0, height/2, width, height/2);
  line(width/2,0,width/2, height);
}
