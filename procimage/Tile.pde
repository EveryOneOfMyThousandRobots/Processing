class Tile {
  int x, y;
  int w, h;
  color colour;
  
  
  Tile(float x, float y, float w, float h) {
    this.x = floor(x);
    this.y = floor(y);
    this.w = floor(w);
    this.h = floor(h);
    getColour();
  }
  
  void draw() {
    noStroke();
    fill(colour);
    rect(x,y,w,h);
  }
  
  void getColour() {
    img.loadPixels();
    float r = 0, g = 0, b = 0;
    float c = 0;
    for (int xx = x; xx < x + w; xx += 1) {
      if (xx >= img.width) continue;
      for (int yy = y; yy < y + h; yy += 1) {
        if (yy >= img.height) continue;
        c += 1;
        int idx = xx + yy * img.width;
        
        int col = img.pixels[xx + yy * img.width];
        
        r += (col >> 16) & 0xff;
        g += (col >> 8) & 0xff;
        b += col & 0xff;
        
        
      }
    }
    
    r /= (float)c;
    g /= (float)c;
    b /= (float)c;
    
    colour = color(r,g,b, 200);
    
  }
  
  
  
}
