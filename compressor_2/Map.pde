class Map {
  float n;
  int i;
  int[] map;
  PGraphics pg;
  Map(int i) {
    this.i = i;
    this.n = (float) i / (float)NUM;
  }

  void generate() {
    noiseSeed(Long.hashCode(System.nanoTime()));
    int[] map = new int[SIZE];

    // float n = (float) i / (float)NUM;


    float fi = i;


    for (int x = 0; x < W; x += 1) {
      float fx = x*0.03;

      for (int y = 0; y < H; y += 1) {
        float fy = y*0.03;
        int idx = y * W + x;
        int c = 0;
        if (random(1) < n) {

          for (int s = 0; s < 3; s += 1) {

            float cc = (n * 255.0 * noise(fx+s, fy+s, fi+s));

            cc = floor(cc / COLOUR_FACTOR) * COLOUR_FACTOR;

            c += ((int)cc << (8 * s));
          }
        }

        map[idx] = 0xff000000 + c;
      }
    }


    pg = createGraphics(W, H);
    pg.beginDraw();
    pg.loadPixels();

    for (int x = 0; x < W; x += 1) {
      for (int y = 0; y < H; y += 1) {
        color c = map[y * W + x];
        pg.pixels[y * W + x] = c;
      }
    }

    pg.updatePixels();
    pg.endDraw();
  }
}
