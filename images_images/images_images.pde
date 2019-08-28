PImage src;
PFont font;
HeatMap hMap;
FontMap map;
void setup() {
  size(800,800);
  hMap = new HeatMap(width,height,0.01,0.01,0.01);
  font = createFont("Consolas", 8);
  textFont(font);
  
  map = new FontMap();
  map.make();
}




void draw() {
  hMap.make();
  src = hMap.img;
  //noLoop();
  background(0);
  //image(src, 0, 0);
  //map.draw();
  //println(map.toString());
  PGraphics dst = createGraphics(src.width, src.height);
  src.loadPixels();
  dst.beginDraw();
  for (int x = 0; x < src.width; x += map.w) {
    for (int y = 0; y < src.height; y += map.h) {
      float avgb = 0;
      float count = 0;
      for (int xx = x; xx < x + map.w; xx += 1) {
        if (xx > width-1 ) continue;
        for (int yy = y; yy < y + map.h; yy += 1) {
          if (yy > height - 1) continue;
          avgb += brightness(src.get(xx,yy));
          count += 1;
        }
      }
      
      avgb /= count;
      //avgb /= 255;
      //avgb = pow(avgb,2);
      Info chosen = null;
      float diff = Float.MAX_VALUE;
      for (Info info : map.images) {
        float d = abs(avgb - info.avgBrightness);
        if (d < diff) {
          diff = d;
          chosen = info;
        }
      }
      
      if (chosen != null) {
        dst.image(chosen.g, x,y);
      }
      
    }
    
  }
  dst.endDraw();
  //image(src,0,0);
  image(dst,0,0);//src.height);
}
