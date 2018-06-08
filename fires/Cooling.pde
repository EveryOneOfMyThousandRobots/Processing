float zoff = 0;
float L = 1;
float k = 8;
float x0 = 0.7;
float nf = 0.01;
void createCoolingMap() {
  zoff += 0.06;
  
  coolingMap = createImage(width, height, RGB);
  coolingMap.loadPixels();
  for (int x = 0; x < coolingMap.width; x += 1) {
    float xx = x * nf;
    for (int y = 0; y < coolingMap.height; y += 1) {
      float yy = (y + frameCount) * nf;
      float n = noise(xx,yy, zoff);
      int index = x + y * coolingMap.width;
      n = L / (1 + exp(-k * (n-x0)));
      //if (n < 0.2) n = 0;
      n *= 50;
      
      coolingMap.pixels[index] = color(n); 
    }
  }
  
  coolingMap.updatePixels();
  
  
}


void cool() {
  coolingMap.loadPixels();
  buffer1.loadPixels();
}
