enum COL_MODE {
  COL_RED, 
    COL_GREEN, 
    COL_BLUE, 
    COL_ALPHA,
    COL_ALL
}

final int MIN_HEIGHT = 30;
final int MAX_HEIGHT = 300;
void proc(String pp, COL_MODE mode) {

  String prefix = null;
  switch (mode) {
  case COL_ALL:
    prefix = "*_";
    break;
  case COL_RED:
    prefix = "r_";
    break;
  case COL_GREEN:
    prefix = "g_";
    break;
  case COL_BLUE:
    prefix = "b_";
    break;
  case COL_ALPHA:
    prefix = "a_";
    break;
  }
  prefix = pp + prefix;

  int r_sx = 0;//noiseValueI("r_sx", 0, width);
  int r_sy = noiseValueSnap(prefix + "sy", 0, height, snap);
  int r_ex = width;//r_sx - 1;//noiseValueI("r_ex", 0, width);
  //int r_ey = noiseValueSnap(prefix + "ey", 0, height, snap);

  int r_oox = noiseValueSnap(prefix + "oox", 0, width, snap);
  int r_oex = noiseValueSnap(prefix + "oex", 0, width, snap);
  int r_ooy = noiseValueSnap(prefix + "ooy", 0, height, snap);
  int r_oey = noiseValueSnap(prefix + "oey", 0, height, snap);
  int w = abs(max(r_ex, r_sx) - min(r_ex, r_sx));
  //int h = abs(max(r_ey, r_sy) - min(r_ey, r_sy));
  int h = noiseValueSnap(prefix + "h", MIN_HEIGHT,MAX_HEIGHT,30)+MIN_HEIGHT;

  int[][] r_buffer = new int[w][h];

  gr.beginDraw();
  gr.loadPixels();

  for (int x = 0; x < w; x += 1) {
    int gx = (x + r_sx) % width;
    for (int y = 0; y < h; y += 1) {
      int gy = (y + r_sy) % height;
      int col = gr.pixels[gy * width + gx];

      if (mode == COL_MODE.COL_ALPHA) {
        r_buffer[x][y] = noiseImg.pixels[gy * width + gx];
      } else {
        r_buffer[x][y] = col; //(col >> 16) & 0xff;
      }
    }
  }

  for (int x = 0; x < w; x += 1) {

    int gx = 0;
    if (x % 2 == 0) {
      gx = (x + r_oex) % width;
    } else {
      gx = (x + r_oox) % width;
    }

    for (int y = 0; y < h; y += 1) {
      int gy = 0;
      if (y % 2 == 0) {
        gy = (y + r_oey) % height;
      } else {
        gy = (y + r_ooy) % height;
      }


      int p = gr.pixels[gy * width + gx]; 

      p = overwriteChannel(p, r_buffer[x][y], mode);

      gr.pixels[gy * width + gx] = p;
    }
  }

  gr.updatePixels();
  gr.endDraw();
}
