color start, end;

void setup() {
  size(100, 100);
  start = color(255, 0, 0);
  end = color(255, 255, 0);
  noLoop();
}


void draw() {
  background(0);
  loadPixels();
  for (int x = 0; x < width; x += 1) {
    float px = x;
    px = floor(px * 25);
    
    px = (int)floor(px / 25);
    px /= width;
    println(px);
    
    for (int y = 0; y < height; y += 1) {
      color c = lerpColor(start, end,px);
      pixels[x + y * width] = c;
    }
  }
  updatePixels();
}
