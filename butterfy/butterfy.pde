void setup () {
  size(400, 400);
  background(51);
  noLoop();
}

void draw() {

  translate(width / 2, height / 2);
  float r = 100;
  float xoff = 0;
  
  stroke(255);
  strokeWeight(2);
  fill(100,128);
  beginShape();
  for ( float a = -PI/2; a < PI/2; a += 0.01) {
    float n = noise(xoff);
    r = r- map(n, 0, 1, -1,1);
    float x = r * cos(a);
    float y = r * sin(a);
    xoff += 0.01;
    vertex(x, y);
    
  }
  endShape();
}