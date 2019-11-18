float[][] m = {
  {0, 8, 2, 10}, 
  {12, 4, 14, 6}, 
  {3, 11, 1, 9}, 
  {15, 7, 13, 5}
};

float[][] ma;
final int SIZE = 4;

PGraphics dither(PGraphics input) {
 // PGraphics imgPost = createGraphics(input.width,input.height, P3D);
  //imgPost.noSmooth();
  //imgPost.beginDraw();
  //imgPost.background(0);
  input.beginDraw();
  input.loadPixels();
  //imgPost.loadPixels();
  for (int xm = 0; xm < input.width; xm += SIZE) {
    for (int ym = 0; ym < input.height; ym += SIZE) {
      
      for (int xx = 0; xx < SIZE; xx += 1) {
        for (int yy = 0; yy < SIZE; yy += 1) {
          int xp = xx + xm;
          int yp = yy + ym;
          int idx = yp * input.width + xp;
          if (xp > input.width - 1 || yp > input.height-1) {
            continue; 
          } else {
            int oc = input.pixels[idx];
            
            float r = (oc >> 16) & 255;
            float g = (oc >> 8) & 255;
            float b = (oc) & 255;
            r = rc(r);
            g = rc(g);
            b = rc(b);
            float m = ma[xx][yy] * 255;
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
            
            input.pixels[idx] = nc;
              
            
            
          }
        }
      }
      
    }
    
  }
  input.updatePixels();
  
  
  input.endDraw();
  return input;
}
