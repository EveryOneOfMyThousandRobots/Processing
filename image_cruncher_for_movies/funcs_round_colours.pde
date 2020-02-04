void roundColours(PGraphics g) {
  g.loadPixels();
  int r = floor(random(4, 16));
  for (int y = 0; y < g.height; y += 1) {
    for (int x = 0; x < g.width; x += 1) {
      int i = y * g.width + x;
      int c = g.pixels[i];
      c = roundColour(c, r);
      g.pixels[i] = c;
    }
  }

  g.updatePixels();
}

void Mess(NoiseManager nse, PGraphics input, String name, int frame) {
  PGraphics ng = createGraphics(input.width, input.height);

  input.loadPixels();

  ng.beginDraw();
  ng.loadPixels();

  float a_r = nse.getNoise(name + "_a_r", frame);
  float b_r = nse.getNoise(name + "_b_r", frame);
  float c_r = nse.getNoise(name + "_c_r", frame);
  float d_r = nse.getNoise(name + "_d_r", frame);
  int a_num = nse.snap(name + "_a_snap",frame,2,8,2);
  int b_num = nse.snap(name + "_a_snap",frame,2,8,2);
  int c_num = nse.snap(name + "_a_snap",frame,2,8,2);
  int d_num = nse.snap(name + "_a_snap",frame,2,8,2);

  float a_b = nse.getNoise(name + "_a_b", frame);
  float b_b = nse.getNoise(name + "_b_b", frame);
  float c_b = nse.getNoise(name + "_c_b", frame);
  float d_b = nse.getNoise(name + "_d_b", frame);

  float a_g = nse.getNoise(name + "_a_g", frame);
  float b_g = nse.getNoise(name + "_b_g", frame);
  float c_g = nse.getNoise(name + "_c_g", frame);
  float d_g = nse.getNoise(name + "_d_g", frame);

  for (int y = 0; y < input.height; y += 1) {
    for (int x = 0; x < input.width; x += 1) {
      
      int xs = floor((float)x / 4.0);

      int c = input.pixels[y * input.width + x];
      float r = getChannelByte(c, COL.R);
      float g = getChannelByte(c, COL.G);
      float b = getChannelByte(c, COL.B);


      float arc = r * a_r;
      float brc = r * b_r;
      float crc = r * c_r;
      float drc = r * d_r;

      float agc = g * a_g;
      float bgc = g * b_g;
      float cgc = g * c_g;
      float dgc = g * d_g;

      float abc = b * a_b;
      float bbc = b * b_b;
      float cbc = b * c_b;
      float dbc = b * d_b;

      ng.pixels[y * ng.width + (x%4)]          = roundColour(color(arc, agc, abc, 255), a_num);
      ng.pixels[y * ng.width + (xs)+(x%4)]     = roundColour(color(brc, bgc, bbc, 255), b_num);
      ng.pixels[y * ng.width + (xs*2)+(x%4)]   = roundColour(color(crc, cgc, cbc, 255), c_num);
      ng.pixels[y * ng.width + (xs*3)+(x%4)]   = roundColour(color(drc, dgc, dbc, 255), d_num);
    }
  }

  ng.updatePixels();
  ng.endDraw();
  input.image(ng, 0, 0);
}
