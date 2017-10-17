class PMap {
  PVector offset;
  PVector loc, dims;
  int[] pxs;
  float order;
  
  int hashCode() {
    return (int) order * 17;
  }

  PMap (float startX, float startY, float w, float h, int[] pix) {
    order = random(-1000, 1000);
    int xo = (int) random(-10, 10);
    int yo = 0; //(int) random(-10, 10);
    offset = new PVector(xo, yo);
    loc = new PVector(startX, startY);
    dims = new PVector(w, h);
    pxs = new int[(int)(w * h)];
    int yy = 0;
    int xx = 0;
    int ww = (int)w;
    for (float y = loc.y; y < loc.y + dims.y; y++) {
      yy = (int) (y - loc.y);
      xx = 0;
      for (float x = loc.x; x < loc.x + dims.x; x++) {
        xx = (int) (x - loc.x);
        if (x >= width || y >= height) continue;
        int pixel = pix[(int) (x + y * width)];
        pxs[xx + yy * ww] = pixel;
      }
    }
  }

  void update() {
  }

  void draw() {
    int ww = (int) dims.x;
    for (int yy = 0; yy < dims.y; yy++) {
      for (int xx = 0; xx < dims.x; xx++) {
        int dx = (int)(loc.x + offset.x + xx);
        int dy = (int) (loc.y + offset.y + yy);

        if (dx >= width || dx < 0 || dy >= height || dy < 0) {
          continue;
        } else {
          pixels[dx + dy * width] = pxs[xx + yy * ww];
        }
      }
    }
  }
}
import java.util.Comparator;

class ComparePMaps implements Comparator<PMap> {
  
  public boolean equals (PMap o) {
    if (hashCode() == o.hashCode()) {
      return true;
    }
    return false;
  }
  public  int  compare(PMap o1, PMap o2) {
   
    if (o1.order < o2.order) {
      return -1;
    } else if (o1.order > o2.order) {
      return 1;
    } else {
      return 0;
    }
  }
  
}