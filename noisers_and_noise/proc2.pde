void proc2 (String prefix) {
  String pre = prefix + "p2_";
  int sx = 0;
  //int ex = width;
  int sy = noiseValueSnap(pre  + "y", 0, height, height/10);
  int h = noiseValueSnap(pre + "h", height/20, height/20, 5) + height/10;

  gr.beginDraw();
  gr.loadPixels();
  int w = gr.width;
  int[][] r_buffer = new int[w][h];

  for (int x = 0; x < w; x += 1) {
    int gx = (x + sx) % gr.width;
    for (int y = 0; y < h; y += 1) {
      int gy = (y + sy) % gr.height;
      int col = gr.pixels[gy * gr.width + gx];

      r_buffer[x][y] = col; //(col >> 16) & 0xff;
      
    }
  }
  
  for (int y = 0; y < h; y += 1) {
    int gy = (y + sy) % gr.height;
    int xo = y + noiseValueSnap(pre + "xo_" + y, 1,10, 1);
    for (int x = 0; x < w; x += 1) {
      int xx = (x + xo) % gr.width;
      gr.pixels[gy * gr.width + xx] = r_buffer[x][y]; 
    }
  }
  
  gr.updatePixels();
  gr.endDraw();
}
