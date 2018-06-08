int cols;// = 200;
int rows;// = 200;

float nx, ny, nz;

float[][] current;// = new float[cols][rows];
float[][] prev;// = new float[cols][rows];
float[][] temp;

float damping = 0.98;


void setup() {
  //frameRate(5);
  size(600, 400);
  cols = width;
  rows = height;
  current = new float[cols][rows];
  prev = new float[cols][rows];
  //for (int i = 0; i < cols; i += 1) {
  //  for (int j = 0; j < rows; j += 1) {
  //    if (random(1) < 0.1) {
  //      prev[i][j] = 100;
  //    }
  //    //current[i][j] = floor(random(0, 255));
  //    //prev[i][j] = current[i][j];
  //  }
  //}
}

void update() {
  nz += 0.01;
  for (int i = 1; i < cols-1; i += 1) {
    nx = float(i) * 0.01;
    
    for (int j = 1; j < rows-1; j += 1) {
      ny = float(j) * 0.01;  
      current[i][j] = (prev[i-1][j] + prev[i+1][j] + prev[i][j-1] + prev[i][j+1]) / 2 - current[i][j];
      
      if (random(1) < 0.01) {
        float r = (noise(nx, ny, nz))*20;
        current[i][j] += random(-r,r);
      }
    }
  }
}

void draw() {
  background(0);
  loadPixels();

  for (int i = 0; i < cols; i += 1) {
    for (int j = 0; j < rows; j += 1) {
      int idx = i + j * cols;

      pixels[idx] = color(128 + (current[i][j]));
      current[i][j] *= damping;
    }
  }
  temp = prev;
  prev = current;
  current = temp;

  updatePixels();
  update();
  droplets();
}

void droplets() {
  int r = floor(random(0, 3));
  
  for (int i = 0; i < r; i += 1) {
    int x = floor(random(width));
    int y = floor(random(height));
    current[x][y] = 255;
  }
  
}

void setPixelAtMouse() {
  if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
    current[mouseX][mouseY] = 255;
  }
}
void mousePressed() {
  setPixelAtMouse();
}
void mouseDragged() {
  //int index = mouseX + mouseY * cols;
  setPixelAtMouse();
}
