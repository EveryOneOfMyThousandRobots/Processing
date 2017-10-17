boolean k (double x, double y) {
  boolean ret = false;
  
  return (1 / 2) < floor( (floor(y/17) * (pow(2, -17 * floor(x)-(y%17) ))) % 2);
 
  
  
  
}

double start = 500;
void setup() {
  
  //frameRate();
  size(1060, 170);
  
  //noLoop();
}

void draw() {
  background(255);
  loadPixels();
  
  color[][] tiles = new color[106][17];
  
  
  for (int x = 0; x < 106; x += 1) {
    for (int y = 0; y < 17; y += 1) {
      
      tiles[x][y] = k(x,y + start) ? color(255) : color(0); 
      //tiles[x][y] = x % 2 == 0 ? color(255) : color(0);
   //   print(tiles[x][y] + " ");
    }
   
  }
  
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y += 1) {
      int xx = int(x / 106);
      int yy = int(y / 17);
      
      pixels[x + y * width] = tiles[xx][yy];
      
    }
  }
  updatePixels();
  
  start += 17;
}