void calcImage() {

  kitten.loadPixels();
  for (int y = 0; y < kitten.height; y += 1) {
    for (int x = 0; x < kitten.width; x += 1) {

      //int index = x + y * kitten.width;
      color c = kitten.pixels[idx(x, y)];

      float r = red(c);
      float g = green(c);
      float b = blue(c);

      int newR = getClosest(r);//round((4 * r) / 255) * 255;
      int newG = getClosest(g); //round((4 * g) / 255) * 255;
      int newB = getClosest(b); //round((4 * b) / 255) * 255;
      kitten.pixels[idx(x, y)] = color(newR, newG, newB);

      errR = r - newR;
      errG = g - newG;
      errB = b - newB;

      setPix(x + 1, y, 7.0 / 16.0);
      setPix(x - 1, y + 1, 3.0 / 16.0);
      setPix(x, y + 1, 5.0 / 16.0);
      setPix(x + 1, y + 1, 1.0 / 16.0);
      //kitten.pixels[idx(x - 1, y + 1)] = 0;
      //kitten.pixels[idx(x, y + 1)] = 0;
      //kitten.pixels[idx(x + 1, y + 1)] = 0;
    }
  }
  kitten.updatePixels();
  
  
}


void setPix(int x, int y, float factor) {

  if (x < 0 || y < 0 || x > kitten.width-1 || y > kitten.height-1) {
    return;
  } else {
    int index = idx(x, y);
    color c = kitten.pixels[index];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    r = r + (errR * factor);
    g = g + (errR * factor);
    b = b + (errR * factor);
    c = color(r, g, b);
    if (brightness(c) < brightnessThreshold) {
      c = color(0);
    }
    kitten.pixels[index] = c;
  }
}