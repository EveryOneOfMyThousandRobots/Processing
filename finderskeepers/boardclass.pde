class Arena {
  final float x, y;
  final float w, h;
  final int scale;
  PImage img;
  
  PVector start, end;

  ArrayList<Wall> walls = new ArrayList<Wall>();


  Arena (String fileName, int scale) {
    img = loadImage(fileName);

    this.x = 0;
    this.y = 0;
    this.w = img.width * scale;
    this.h = img.height * scale;
    this.scale = scale;
    load();
  }

  private void load () {
    img.loadPixels();
    for (int xx = 0; xx < img.width; xx += 1) {
      for (int yy = 0; yy < img.height; yy += 1) {
        int col = img.get(xx, yy);
        col = col & 0xffffff;
        if (col == 0x00ff00) {
          start = new PVector(xx * scale, yy * scale);
        }
        
        if (col == 0xff0000) {
          end = new PVector(xx * scale, yy * scale);
        }
        
        if (col == 0) {
          walls.add(new Wall(xx * scale, yy * scale, scale, scale));
        }
        
        
      }
    }
  }


  void draw() {
    rectMode(CORNER);
    fill(0,255,0);
    rect(start.x, start.y, scale, scale);
    
    fill(255,0,0);
    rect(end.x, end.y, scale, scale);
    
    for (Wall w : walls) {
      w.draw();
    }
    
  }
}

class Wall {
  PVector pos, dims;
  
  Wall(float x, float y, float w, float h) {
    pos = new PVector(x,y);
    dims = new PVector(w,h);
  }
  
  boolean collides(PVector o) {
    if (o.x >= pos.x && o.x <= pos.x + dims.x && o.y >= pos.y && o.y <= pos.y + dims.y) {
      return true;
    }
    return false;
  }
  
  void draw() {
    rectMode(CORNER);
    fill(0);
    rect(pos.x, pos.y, dims.x, dims.y);
  }
}