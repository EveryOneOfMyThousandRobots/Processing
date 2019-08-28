final float NOISE_THRESHOLD = 0.4; 
class Map {
  PImage map;
  int w, h;
  float zoff = 0.1;
  Map(int w, int h) {
    map = createImage(w, h, ARGB);
    this.w = w;
    this.h = h;
    generate();
  }

  void generate() {
    zoff += 0.1;
    map.loadPixels();
    for (int x = 0; x < w; x += 1) {
      float xx = float(x) * 0.1;
      for (int y = 0; y < h; y += 1) {
        float yy = float(y) * 0.1;
        int i = x + y * w;

        map.pixels[i] = noise(xx, yy,zoff) > NOISE_THRESHOLD ? color(255) : color(0);
      }
    }
    map.updatePixels();
  }
}
