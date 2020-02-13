float[][] dither_matrix = {
  {0, 8, 2, 10}, 
  {12, 4, 14, 6}, 
  {3, 11, 1, 9}, 
  {15, 7, 13, 5}
};

float[][] dither_matrix_factors;

 void dither(NoiseManager nse, PGraphics input_image, String name, int frame) {
    input_image.loadPixels();
    PGraphics ng = createGraphics(input_image.width, input_image.height);
    int numColours = nse.snap(name, frame, 4, 16, 1);
    ng.beginDraw();
    ng.loadPixels();
    for (int xm = 0; xm < input_image.width; xm += 4) {
      for (int ym = 0; ym < input_image.height; ym += 4) {

        for (int xx = 0; xx < 4; xx += 1) {
          for (int yy = 0; yy < 4; yy += 1) {
            int xp = xx + xm;
            int yp = yy + ym;
            int idx = yp * input_image.width + xp;
            if (xp > input_image.width - 1 || yp > input_image.height-1) {
              continue;
            } else {
              int oc = input_image.pixels[idx];
              int nc = roundColour(oc, numColours);
              float aa = (nc >> 24) & 0xff;
              float rr = (nc >> 16) & 0xff;
              float gg = (nc >> 8) & 0xff;
              float bb = (nc >> 0) & 0xff;
              float m = dither_matrix_factors[xx][yy] * 255;
              nc = color(0,0);
              if (rr > m) {
                nc += (int)rr << 16;
              }

              if (gg > m) {
                nc += (int)gg << 8;
              }

              if (bb > m) {
                nc += (int)bb;
              }
              
              if (aa > m) {
                nc += (int) aa << 24;
              }
              ng.pixels[idx] = nc;
            }
          }
        }
      }
    }
    ng.updatePixels();
    ng.endDraw();
    input_image.image(ng, 0, 0);
  }
