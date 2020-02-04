void pixelate(NoiseManager nse, PGraphics input, String name, int frame) {
  final int CELLSIZE = nse.snap(name, frame, 2, 8, 2);


  int TA = ceil((float)input.width / (float)CELLSIZE);
  int TD = ceil((float)input.height / (float)CELLSIZE);

  float[][] r = new float[TA][TD];
  float[][] g = new float[TA][TD];
  float[][] b = new float[TA][TD];
  float[][] alpha = new float[TA][TD];
  input.loadPixels();
  for (int xt = 0; xt < TA; xt += 1) {
    int xtp = xt * CELLSIZE;
    for (int yt = 0; yt < TD; yt += 1) {
      int ytp = yt * CELLSIZE;
      float count = 0;
      for (int xp = 0; xp < CELLSIZE; xp += 1) {
        int xpp = xp + xtp;
        if (xpp > input.width - 1) continue;
        for (int yp = 0; yp < CELLSIZE; yp += 1) {
          int ypp = yp + ytp;
          if (ypp > input.height - 1) continue;
          int idx = ypp * input.width + xpp;
          float cr = getChannelByte(input.pixels[idx], COL.R) / 255.0;
          float cg = getChannelByte(input.pixels[idx], COL.G) / 255.0;
          float cb = getChannelByte(input.pixels[idx], COL.B) / 255.0;
          float ca = getChannelByte(input.pixels[idx], COL.A) / 255.0;

          r[xt][yt] += cr;
          g[xt][yt] += cg;
          b[xt][yt] += cb;
          alpha[xt][yt] += ca;
          count += 1;
        }
      }
      r[xt][yt] /= count;
      g[xt][yt] /= count;
      b[xt][yt] /= count;
      alpha[xt][yt] /= count;
      int c = color(r[xt][yt]*255, g[xt][yt]*255, b[xt][yt]*255, alpha[xt][yt]*255);

      input.fill(c);
      input.noStroke();
      input.rect(xt * CELLSIZE, yt * CELLSIZE, CELLSIZE, CELLSIZE);
    }
  }
}
