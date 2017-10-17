class Chunk {
  DNA dna;
  int x, y, w, h, xoff, yoff;
  int[] chunkpixels;
  float error = 0;
  float fitness = 0;
  Chunk(int x, int y, int w, int h, int xoff, int yoff) {
    dna = new DNA();


    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.xoff = xoff;
    this.yoff = yoff;

    chunkpixels = new int[w * h];
    setPixels();
  }

  void setPixels() {
    for (int i = 0; i < chunkpixels.length; i += 1) {
      float r = map(dna.get("color_r_"+i), 0, 1, 0, 255);
      float g = map(dna.get("color_g_"+i), 0, 1, 0, 255);
      float b = map(dna.get("color_b_"+i), 0, 1, 0, 255);
      chunkpixels[i] = color(r, g, b);
    }
  }

  void mutate() {
    dna.mutate();
    setPixels();
  }
  
  Chunk cross(Chunk partner) {
    Chunk chunk = new Chunk(x, y, w, h, xoff, yoff);
    chunk.dna = dna.cross(partner.dna);
    chunk.mutate();
    chunk.setPixels();
    
    return chunk;
  }

  void attempt() {
    for (int xx = x + xoff; xx < x + xoff + w; xx += 1) {
      for (int yy = y + yoff; yy < y + yoff + h; yy += 1) {
        int cpi = (xx - xoff) + (yy - yoff) * w;
        //float r = map(dna.get("color_r_"+cpi), 0, 1, 0, 255);
        //float g = map(dna.get("color_g_"+cpi), 0, 1, 0, 255);
        //float b = map(dna.get("color_b_"+cpi), 0, 1, 0, 255);
        pixels[xx + yy * width] = chunkpixels[cpi];
      }
    }
  }

  void check() {
    error = 0;
    fitness = 0;
    for (int xx = x + xoff; xx < x + xoff + w; xx += 1) {
      for (int yy = y + yoff; yy < y + yoff + h; yy += 1) {
        int cpi = (xx - xoff) + (yy - yoff) * w;
        int opi = (xx - xoff) + (yy - yoff) * width;

        int guess = chunkpixels[cpi];
        int correct = pixels[opi];

        float correct_r = red(correct);
        float correct_g = green(correct);
        float correct_b = blue(correct);

        float guess_r = red(guess);
        float guess_g = green(guess);
        float guess_b = blue(guess);

        error += abs( ( correct_r - guess_r) + (correct_g - guess_g) + (correct_b - guess_b));
      }
      error /= w * h;
      error += 0.01;
      fitness = 1 / error;
      
      fitness = pow(fitness, 4);
    }
  }
}