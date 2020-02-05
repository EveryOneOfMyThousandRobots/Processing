

void colourReduce(PGraphics gr) {
  gr.beginDraw();
  gr.loadPixels();
  
  
  for (int x = 0; x < gr.width; x += 1) {
    for (int y = 0; y < gr.height; y += 1) {
      int c = gr.pixels[y * gr.width + x];
      
      int r = cr(gr(c));
      int g = cr(gg(c));
      int b = cr(gb(c));
      int a = ga(c);
      
      gr.pixels[y * gr.width + x] = color(r,g,b,a);
      
    }
  }
  gr.updatePixels();
  
  
  gr.endDraw();
}


final float NUM_COLOURS = 2;


int cr(int c) {
  
  float fc = floor(c / (255.0 / NUM_COLOURS)) * (255.0/NUM_COLOURS);
  
  
  
  
  
  return floor(fc);
}


int ga(int c) {
  return (c >> 24) & 0xff;
}

int gr(int c) {
  return (c >> 16) & 0xff;
}

int gg(int c) {
  return (c >> 8) & 0xff;
}

int gb(int c) {
  return c  & 0xff;
}
