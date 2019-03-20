class HeatMap {
  //PImage image;
  float xo, yo, zo;
  float xf, yf, zi;
  float w, h;
  PImage img;

  HeatMap(int w, int h, float xf, float yf, float zi) {
    this.w = w;
    this.h = h;
    this.zi = zi;
    this.xf = xf;
    this.yf =yf;
    img = createImage(w, h, RGB);
    make();
  }

  void make() {
    img.loadPixels();
    zo += zi;
    for (int xx = 0; xx < w; xx += 1) {
      xo = ((float)xx) * xf; 
      for (int yy = 0; yy < h; yy += 1) {
        yo = ((float)yy) * yf;
        img.pixels[xx + yy * floor(w)] = color(pow(noise(xo,yo,zo),3) * 255.0);
      }
    }
    img.updatePixels();
  }
}
