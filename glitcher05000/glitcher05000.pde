PImage img;
PGraphics proc;


void settings() {
  img = loadImage("001.jpg");
  size(img.width, img.height);
}

void setup() {
  proc = createGraphics(img.width, img.height);

  proc.beginDraw();
  proc.copy(img, 0, 0, img.width, img.height, 0, 0, img.width, img.height);
  proc.endDraw();

  //for (int i = 0; i < 4; i += 1) {

  //}
}

int timer = 0;

void draw() {
  image(proc, 0, 0);

  if ( timer > 60) {
    int step = floor(random(3, 9));
    int w = floor(random(1, 7));
    int y = floor(random(0, height));
    int yoff = floor(random(0, height/2));
    int xe = floor(random(w,proc.width));
    for (int x = w; x < xe; x += w + step) {
      y += (noise(frameCount / 100, y) * 10)-5;
      for (int xx = x; xx < x + w; xx += 1) {
        copyPart(x, y, w, yoff, x, y+yoff);
      }
    }
    timer = 0;
  }
  timer += 1;
}


void copyPart(int sx, int sy, int w, int h, int dx, int dy) {

  proc.beginDraw();
  proc.loadPixels();
  int[][] buffer = new int[w][h];
  for (int xx = 0; xx < w; xx += 1) {
    int xp = (xx + sx) % proc.width;

    for (int yy = 0; yy < h; yy += 1) {
      int yp = (yy + sy) % proc.height;

      buffer[xx][yy] = proc.pixels[yp * proc.width + xp];
      //proc.pixels[yp * proc.width + xp] = color(0);
    }
  }

  for (int xx = 0; xx < w; xx += 1) {
    int xp = (dx + xx) % proc.width;
    for (int yy = 0; yy < h; yy += 1) {
      int yp = (dy + yy) % proc.height;
      proc.pixels[yp * proc.width + xp] = buffer[xx][yy];
    }
  }
  proc.updatePixels();

  proc.endDraw();
}
