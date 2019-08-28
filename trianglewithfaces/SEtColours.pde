import java.awt.Rectangle;

void setColour(Tri t ) {
  Rectangle bounds = t.area.getBounds();
  int x = (int) bounds.getX();
  int y = (int) bounds.getY();
  int w = (int) bounds.getWidth();
  int h = (int) bounds.getHeight();
  
  
  float r = 0;
  float g = 0;
  float b = 0;
  int count = w * h;
  for (int xx = x; xx < x + w; xx += 1) {
    for (int yy = y; yy < y + h; yy += 1) {
      r += red(bg.get(xx,yy));
      g += green(bg.get(xx,yy));
      b += blue(bg.get(xx,yy));
    }
  }
  
  r /= count;
  g /= count;
  b /= count;
  
  t.col = color(r,g,b);
  
}
