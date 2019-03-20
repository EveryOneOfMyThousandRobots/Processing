class Map {
  PGraphics map;
  int tileSize;
  float zoffset = 0;
  
  Map () {
    map = createGraphics(width, height);
    generate();
  }
  void generate() {
    zoffset += 0.01;
    tileSize = ceil(width / 80);
    
    map.beginDraw();
    map.background(0);
    map.stroke(0);
    map.fill(255);
    for (int x = 0; x < width; x += tileSize) {
      for (int y = 0; y < height; y += tileSize) {
        float xx = float(x) / tileSize / 8.00;
        float yy = float(y) / tileSize / 8.00;
        
        float v = noise(xx,yy, zoffset) * 3;
        if (v < 1) {
          map.fill(0,0,0);
        } else if (v >= 1 && v < 2) {
          map.fill(128,128,128);
        } else {
          map.fill(255,255,255);
        }
        map.rect(x,y,tileSize, tileSize);
      }
    }
    map.endDraw();
    
  }
  
  void draw() {
    image(map, 0,0);
  }
}
