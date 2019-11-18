

PGraphics chop(PGraphics input, float nx, float ny) {
  float t = time_accum / videoDuration;
  
  float xl = lerp(nx,nx+10,t);
  float yl = lerp(ny,ny+10,t);
  
  
  
  
  input.beginDraw();
  input.loadPixels();

  int xs = floor(width * noise(xl,yl,1));
  int xe = floor(width * noise(xl,yl,10));
  if (xe < xs) {
    xe += input.width;
  }

  int ys = floor(height * noise(xl,yl,20));
  int ye = floor(height * noise(xl,yl,30));

  if (ye < ys) {
    ye += input.height;
  }
  int[][] ar = new int[xe - xs][ye - ys];
  int arx = 0;
  int ary = 0;
  for (int x = xs; x < xe; x += 1) {


    int xx = x % input.width;
    for (int y = ys; y < ye; y += 1) {

      int yy = y % input.height;

      //int ai = ary * ar.length + arx;

      ar[arx][ary] = input.pixels[yy * input.width + xx];

      ary += 1;
    }
    arx += 1;
    ary = 0;
  }

  int xo = 50;
  int yo = 50;
  arx = 0;
  ary = 0;  
  for (int x = xs + xo; x < xe + xo; x += 1) {
    int xx = x % input.width;
    for (int y = ys + yo; y < ye + yo; y += 1) {
      int yy = y % input.height;
      input.pixels[yy * input.width + xx] = ar[arx][ary];

      ary += 1;
    }
    arx += 1;
    ary = 0;
  }




  input.updatePixels();
  return input;
}
