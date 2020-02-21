//time funcs

long getTime() {
  return (long)(System.nanoTime() / 1e6);
}

//files functions

String getImageFile() {
  File path = new File(IMAGE_PATH);


  if (path.isDirectory()) {
    String[] files = path.list();

    int r = floor(random(files.length));

    return IMAGE_PATH + "\\" + files[r];
  }

  return null;
}


//------------------------EDGE DETECT-------------------------------------

void edgeDetect(NoiseManager nse, PGraphics input, String name, int frame) {

  float[][] yfilter = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
  float[][] xfilter = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};



  input.loadPixels();
  PGraphics ngX = createGraphics(input.width, input.height);
  PGraphics ngY = createGraphics(input.width, input.height);
  PGraphics ng  = createGraphics(input.width, input.height);
  ngX.beginDraw();
  ngX.loadPixels();

  ngY.beginDraw();
  ngY.loadPixels();


  for (int x = 1; x < input.width-1; x += 1) {
    for (int y = 1; y < input.height-1; y += 1) {

      float sumX = 0;
      float sumY = 0;
      for (int i = 0; i < 3; i += 1) {
        int xi = x + (i-1);
        for (int j = 0; j < 3; j += 1) {
          int yi = y + (j-1);

          sumX += brightness(input.pixels[yi * input.width + xi]) * xfilter[i][j];
          sumY += brightness(input.pixels[yi * input.width + xi]) * yfilter[i][j];
        }
      }
      sumX /= 9;
      sumY /= 9;
      sumX = map(sumX, -127, 128, 0, 255);
      sumY = map(sumY, -127, 128, 0, 255);
      ngX.pixels[ (y-1) * input.width + (x-1)] = color(sumX);
      ngY.pixels[ (y-1) * input.width + (x-1)] = color(sumX);
    }
  }

  ngX.updatePixels();
  ngY.updatePixels();
  ng.beginDraw();
  ng.loadPixels();

  for (int x = 1; x < input.width-1; x += 1) {
    for (int y = 1; y < input.height-1; y += 1) {
      
      float xc = brightness(ngX.get(x,y));
      float yc = brightness(ngY.get(x,y));
      
      float b = sqrt((xc * xc) + (yc * yc));
      
      ng.pixels[y * input.width + x] = color(b);
    }
  }


  ngX.endDraw();


  ngY.endDraw();
  ng.updatePixels();
  ng.endDraw();
  input.image(ng, 0, 0);
}

//----------------------CORRUPT DIMS----------------------------------------

void corruptDims(NoiseManager nse, PGraphics input, String name, int frame) {

  input.loadPixels();
  int offset = nse.snap(name + "_OFFSET_CPT", frame, 0, input.width/2, input.width / 16);
  //int yo = floor(nse.snapNoise(name + "_YO_CPT", frame, -4.0f, 4.0f, 1.0f));

  int offset_timer = nse.snap(name + "_OFFSET_TIMER", frame, input.pixels.length / 2, input.pixels.length, input.width) + input.width;
  int timer = 0;
  PGraphics ng = createGraphics(input.width, input.height);
  ng.beginDraw();
  ng.loadPixels();
  int offset_2 = nse.snap(name + "_OFFSET2_CPT", frame, 0, input.width/2, input.width / 16);
  for (int i = 0; i < input.pixels.length; i += 1) {
    timer += 1;

    if (timer >= offset_timer) {
      offset_2 = nse.snap(name + "_OFFSET2_CPT", i+frame, 0, input.width/2, input.width / 8);
      timer = 0;
    }

    int j = (i+offset+offset_2) % input.pixels.length;

    ng.pixels[i] = input.pixels[j];
  }
  //int nw = input.width + floor(random(-2,2));


  //for (int y = 0; y < ng.height; y += 1) {
  //  for (int x = 0; x < ng.width; x += 1) {
  //    int i = (y * nw + x) % input.pixels.length;

  //    ng.pixels[i] = input.pixels[y * ng.width + x];


  //  }
  //}
  ng.updatePixels();
  ng.endDraw();
  input.image(ng, 0, 0);
}

//----------------------PIXELATE----------------------------------------
void pixelate(NoiseManager nse, PGraphics input, String name, int frame) {
  final int CELLSIZE = nse.snap(name, frame, floor(sld_pixelate_min), floor(sld_pixelate_max), 1);


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



//-----------------------------------------------VHS---------------------------------------------------------

final float SQRT_TAU = sqrt(TAU);
final float ONE_OVER_SQRT_TAU = 1.0 / SQRT_TAU;
NoiseManager vhsNoise = new NoiseManager();
void VHS(String name, PGraphics input, int frame) {
  input.loadPixels();

  float ypos = vhsNoise.snap(name + "_vhs_ypos", frame, 0, input.height, 1);
  int h = vhsNoise.snap(name + "_vhs_height", frame, 0, 50, 10) + 10;

  float roff = vhsNoise.snap(name + "_vhs_r", frame, 0, input.width/32, 1) - (input.width / 16);
  float goff = vhsNoise.snap(name + "_vhs_g", frame, 0, input.width/32, 1) - (input.width / 16);
  float boff = vhsNoise.snap(name + "_vhs_b", frame, 0, input.width/32, 1) - (input.width / 16);
  float aoff = vhsNoise.snap(name + "_vhs_a", frame, 0, input.width/32, 1) - (input.width / 16);

  for (int y = (int)ypos - h; y < ypos + h; y += 1) {
    float dist = (float)abs(ypos - y) / (float)h;
    boolean doSomething = true;
    if (random(1) > pow(1-dist, 4)) {
      doSomething = false;
    }

    int xoff = floor((input.width/8) - ((input.width/8) * dist));
    float xo0 = ONE_OVER_SQRT_TAU * exp(- 0.8 * (dist));
    xoff = floor((input.width / 8) * xo0);// + random(input.width/64));
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
        int gc = overwriteChannel(input.pixels[gi], buffer[x], COL.G);
        int bc = overwriteChannel(input.pixels[bi], buffer[x], COL.B);

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
///------------------------------------------ MESS --------------------------------
void Mess(NoiseManager nse, PGraphics input, String name, int frame) {
  PGraphics ng = createGraphics(input.width, input.height);

  input.loadPixels();

  ng.beginDraw();
  ng.loadPixels();

  float a_r = nse.getNoise(name + "_a_r", frame);
  float b_r = nse.getNoise(name + "_b_r", frame);
  float c_r = nse.getNoise(name + "_c_r", frame);
  float d_r = nse.getNoise(name + "_d_r", frame);
  int a_num = nse.snap(name + "_a_snap", frame, 2, 8, 2);
  int b_num = nse.snap(name + "_a_snap", frame, 2, 8, 2);
  int c_num = nse.snap(name + "_a_snap", frame, 2, 8, 2);
  int d_num = nse.snap(name + "_a_snap", frame, 2, 8, 2);

  float a_b = nse.getNoise(name + "_a_b", frame);
  float b_b = nse.getNoise(name + "_b_b", frame);
  float c_b = nse.getNoise(name + "_c_b", frame);
  float d_b = nse.getNoise(name + "_d_b", frame);

  float a_g = nse.getNoise(name + "_a_g", frame);
  float b_g = nse.getNoise(name + "_b_g", frame);
  float c_g = nse.getNoise(name + "_c_g", frame);
  float d_g = nse.getNoise(name + "_d_g", frame);

  int xs = floor((float)input.width / 4.0);

  for (int y = 0; y < input.height; y += 1) {
    for (int x = 0; x < input.width; x += 1) {



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

      ng.pixels[y * ng.width + (x/4)]          = roundColour(color(arc, agc, abc, 255), a_num);
      ng.pixels[y * ng.width + (xs)+(x/4)]     = roundColour(color(brc, bgc, bbc, 255), b_num);
      ng.pixels[y * ng.width + (xs*2)+(x/4)]   = roundColour(color(crc, cgc, cbc, 255), c_num);
      ng.pixels[y * ng.width + (xs*3)+(x/4)]   = roundColour(color(drc, dgc, dbc, 255), d_num);
    }
  }

  ng.updatePixels();
  ng.endDraw();
  input.image(ng, 0, 0);
}
