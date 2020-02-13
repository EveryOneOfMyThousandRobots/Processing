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

NoiseManager vhsNoise = new NoiseManager();
void VHS(String name, PGraphics input, int frame) {
  input.loadPixels();

  float ypos = vhsNoise.snap(name + "_vhs_ypos", frame, 0, input.height, 1);
  int h = vhsNoise.snap(name + "_vhs_height", frame, 0, 50, 10) + 10;

  float roff = vhsNoise.snap(name + "_vhs_r", frame, 0, input.width/16, 5);
  float goff = vhsNoise.snap(name + "_vhs_g", frame, 0, input.width/16, 5);
  float boff = vhsNoise.snap(name + "_vhs_b", frame, 0, input.width/16, 5);
  float aoff = vhsNoise.snap(name + "_vhs_a", frame, 0, input.width/16, 5);

  for (int y = (int)ypos - h; y < ypos + h; y += 1) {
    float dist = (float)abs(ypos - y) / (float)h;
    boolean doSomething = true;
    if (random(1) > pow(1-dist, 4)) {
      doSomething = false;
    }

    int xoff = floor((input.width/8) - ((input.width/8) * dist));
    float xo0 = 1.0 / sqrt(TAU);
    xo0 *= exp(- 0.5 * (dist));
    xoff = floor((input.width / 8) * xo0 + random(input.width/64));
    int yy = y;
    if (yy < 0 ) {
      yy = abs(yy);
      yy = yy % input.height;
      yy = input.height - yy;
    } else if (yy > input.height-1) {
      yy %= input.height;
    }


    int[] buffer = new int[input.width];
    for (int x = 0; x < input.width; x += 1) {
      buffer[x] = input.pixels[yy * input.width + x];
    }

    //int xoffSet = vhsNoise.snap("vhs_xoff_"+yy, frame, 0, input.width, 10);

    for (int x = 0; x < input.width; x += 1) {
      int xx = (x + xoff) % input.width;
      int xr = floor((x + xoff + roff) % input.width);
      int xg = floor((x + xoff + goff) % input.width);
      int xb = floor((x + xoff + boff) % input.width);
      int xa = floor((x + xoff + aoff) % input.width);

      int r = floor(random(100)) % 4;

      if (r == 0 && doSomething) {

        input.pixels[yy * input.width + xx] = color(random(128, 255));
      } else if (r == 1 && doSomething) {
        input.pixels[yy * input.width + xx] = color(0);
      } else {

        int ri = yy * input.width + xr;
        int gi = yy * input.width + xg;
        int bi = yy * input.width + xb;
        int ai = yy * input.width + xa;
        int rc = overwriteChannel(input.pixels[ri], buffer[x], COL.R);
        int gc = overwriteChannel(input.pixels[gi], buffer[x], COL.R);
        int bc = overwriteChannel(input.pixels[bi], buffer[x], COL.R);

        input.pixels[ri] = rc;
        input.pixels[gi] = gc;
        input.pixels[bi] = bc;

        int ac = buffer[x];
        input.pixels[ai] = ac;
      }
    }
  }



  input.updatePixels();
}

//--------------------------------------------- MOVE ---------------------


void move(NoiseManager nse, PGraphics input, COL mode, String name, int frame) {

  int x_start = 0;
  name += "_" + mode.toString();
  int x_snap = 50;
  int y_snap = 50;
  int y_start = nse.snap(name + "_YS", frame, 0, input.height, x_snap);


  int x_offset_odd = nse.snap(name + "_XOO", frame, 0, input.width, x_snap);
  int x_offset_even = nse.snap(name + "_XOE", frame, 0, input.width, x_snap);

  int y_offset_odd = nse.snap(name + "_YOO", frame, 0, input.height, y_snap);
  int y_offset_even = nse.snap(name + "_XOE", frame, 0, input.height, y_snap);
  int w = input.width;
  int h = 30 + nse.snap(name + "_H", frame, 0, input.height, y_snap);

  int[][] buffer = new int[input.width][h];

  input.loadPixels();

  for (int x = 0; x < w; x += 1) {
    int gx = (x + x_start) % input.width;
    for (int y = 0; y < h; y += 1) {
      int gy = (y + y_start) % input.height;
      int col = input.pixels[gy * input.width + gx];


      buffer[x][y] = col; //(col >> 16) & 0xff;
    }
  }

  for (int x = 0; x < w; x += 1) {

    int gx = 0;
    if (x % 2 == 0) {
      gx = (x + x_offset_even) % input.width;
    } else {
      gx = (x + x_offset_odd) % input.width;
    }

    for (int y = 0; y < h; y += 1) {
      int gy = 0;
      if (y % 2 == 0) {
        gy = (y + y_offset_even) % input.height;
      } else {
        gy = (y + y_offset_odd) % input.height;
      }


      int p = input.pixels[gy * input.width + gx]; 

      p = overwriteChannel(p, buffer[x][y], mode);

      input.pixels[gy * input.width + gx] = p;
    }
  }

  input.updatePixels();
}


///------------------------------------------ MESS --------------------------------


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
