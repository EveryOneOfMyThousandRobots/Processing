float[][] getRandomMatrix(float xp, float yp) {
  float[][] mat = new float[SIZE][SIZE];

  float n = 1.0 / 16.0;
  for (int x = 0; x < SIZE; x += 1) {
    float xx = xp + x;
    for (int y = 0; y < SIZE; y += 1) {
      //m[x][y] = 

      float yy = yp + y;
      float s = 0;
      if (x % 2 == 0 && y % 2 == 0) { 
        s = noise(xx * 0.01, yy * 0.01)*16;
      } else {
        s = 1;
      }
      mat[x][y] = s * n;
    }
  }


  return mat;
}

void process() {



  post.beginDraw();
  post.background(0);

  post.loadPixels();
  for (int xm = 0; xm < width; xm += SIZE) {
    for (int ym = 0; ym < height; ym += SIZE) {
      float[][] mat = getRandomMatrix(xm, ym);
      for (int xx = 0; xx < SIZE; xx += 1) {
        for (int yy = 0; yy < SIZE; yy += 1) {
          int xp = xx + xm;
          int yp = yy + ym;
          int idx = yp * width + xp;
          if (xp > width - 1 || yp > height-1) {
            continue;
          } else {
            int oc = pixels[idx];

            float r = (oc >> 16) & 255;
            float g = (oc >> 8) & 255;
            float b = (oc) & 255;
            r = rc(r);
            g = rc(g);
            b = rc(b);
            float m = mat[xx][yy] * 255;
            int nc = color(0);
            if (r > m) {
              nc += (int)r << 16;
            }

            if (g > m) {
              nc += (int)g << 8;
            }

            if (b > m) {
              nc += (int)b;
            }

            post.pixels[idx] = nc;
            //println(nc);
          }
        }
      }
    }
  }
  post.updatePixels();

  post.endDraw();
}
