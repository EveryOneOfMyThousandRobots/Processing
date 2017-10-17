class Tile {
  int x, y;
  int w, h;
  double sumR = 0;
  double sumG = 0;
  double sumB = 0;
  double count = 0;
  double avg = 0;
  int[] pix;
  PImage imgRef;
  PVector drawPos, drawDim;
  Tile(int x, int y, int w, int h, int[] pix, PImage imgRef) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.pix = pix;
    this.imgRef = imgRef;
    drawPos = new PVector(0,0);
    drawDim = new PVector(0,0);
    
    drawPos.x = (x + (w / 4));
    drawDim.x = w / 2;
    drawDim.y = h / 2;
    drawPos.y = y + (h / 2) - (drawDim.y / 2);
  }

  void calc() {
    for (int yy = y; yy < y + h; yy += 1) {
      if (yy > height) continue;
      for (int xx = x; xx < x + w; xx += 1) {
        if (xx > width) continue;
        int p = imgRef.get(xx,yy);
        sumR += red(p);
        sumG += green(p);
        sumB += blue(p);
        count += 1;
      }
    }
    
    avg = color((int) (sumR / count), (int)(sumG / count), (int)(sumB / count));
  }
}