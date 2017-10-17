int cols, rows;
int scl = 20;
int w = 1200;
int h = 2000;

float[][] terrain;
float flying = 0;
void setup() {


  cols = w / scl;
  rows = h / scl;
  //frameRate(2);

  terrain = new float[cols][rows+1];
}

void settings() {
  size(600, 600, P3D);
}



void draw() {
  flying -= 0.15;
  float yoff = flying;
  for (int y = 0; y < rows+1; y += 1) {
    float xoff = 0;
    for (int x = 0; x < cols; x += 1) {
      terrain[x][y] = floor(floor(noise(xoff, yoff) * 100)/100)*100;
      xoff += 0.2;
    }
    yoff += 0.15;
  }
  background(0);
  stroke(255);
  noFill();
  translate(width / 2, (height / 2)+100);
  rotateX(PI/3);
  translate(- (w/2), -(h/2));
  for (int y = 0; y < rows; y += 1) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x += 1) {

      vertex(x * scl, y * scl, terrain[x][y]);
      vertex(x * scl, (y + 1) * scl, terrain[x][y+1]);
    }
    endShape();
  }
}