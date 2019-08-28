class DistortionMap {
  int[][] xShift;
  int[][] yShift;
  int w, h;
  float z = 0.1;
  PImage img, output;

  DistortionMap(PImage img) {
    this.w = img.width;
    this.h = img.height;
    this.img = img;
    this.output = img.copy();//createImage(w, h, ARGB);
    xShift = new int[w][h];
    yShift = new int[w][h];
  } 

  void corrupt() {
    img.loadPixels();
    output.loadPixels();

    for (int x = 0; x < w; x += 1) {
      
      for (int y = 0; y < h; y += 1) {
        int xs = xShift[x][y];  
        int ys = yShift[x][y];
        int i = x + y * w;
        
        int nx = (x + xs) % w;
        int ny = (y + ys) % h;
        int ni = nx + ny * w;
        
        output.pixels[ni] = img.pixels[i]; 
      }
    }


    output.updatePixels();
  }

  void generate() {
    int range = floor(noise(1,1,z)*50);
    z += 0.01;
    for (int x = 0; x < w; x += 1) {
      //z += 0.01;
      float xf1 = float(x) * 0.1;
      float xf2 = float(x+10) * 0.1;
      for (int y = 0; y < h; y += 1) {
        float yf1 = float(y) * 0.1;
        float yf2 = float(y+10) * 0.1;
        float r1 = noise(xf1,yf1, z);
        float r2 = noise(xf2,yf2, z);
        if (r2 < 0.5) continue;
        if (r1 < 0.5) {
          int n = floor(map(r1, 0, 1, -range, range));
          while (n < 0) {
            n += w;
          }
          xShift[x][y] = n;
          yShift[x][y] = 0;
        } else {
          int n = floor(map(r1, 0, 1, -range, range));
          while (n < 0) {
            n += h;
          }
          xShift[x][y] = 0;
          yShift[x][y] = n;
        }
      }
    }
  }
}
