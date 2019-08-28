ArrayList<Tile> tiles = new ArrayList<Tile>();

void tilesDraw() {
  for (Tile t : tiles) {
    t.draw();
  
  }
}

class Tile {
  PVector pos, cpos;
  float w, h;
  float val;
  color c;

  Tile (float x, float y, float w, float h) {
    pos = new PVector(x, y);
    this.w = w;
    this.h = h;
    cpos = new PVector(x + (w/2), y + (h/2));
    val = 0;
    float count = 0;

    for (int yy = (int)y; yy < (int)(y + h); yy += 1) {
      if (yy > kitten.height-1) break;
      for (int xx = (int)x; xx < (int)(x + w); xx += 1) {
        if (xx > kitten.width-1) break;
        val += brightness(kitten.pixels[idx(xx,yy)]) / 255;
        count += 1;
        
        
      }
    }
    
    val /= count;
    c = color(val * 255);
  }
  
  void draw() {
    noStroke();
    fill(c);
    rect(pos.x, pos.y, w,h);
  }
}