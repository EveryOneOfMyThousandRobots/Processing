PImage img;
class ColArray {
  int[] a = new int[256];


  void add(int pixel) {
    a[pixel] += 1;
  }
}

ColArray Red = new ColArray();
ColArray Green  = new ColArray();
ColArray Blue = new ColArray();

void setup () {
  colorMode(RGB, 255);
  noLoop();
}

void settings() {


  img = loadImage("pencils.jpeg");
  size(256, 256);
}

void draw() {
  background(0);
  //loadPixels();
  for (int x = 0; x < img.width; x += 1) {
    for (int y = 0; y < img.height; y += 1) {
      int pixel = img.get(x, y);

      Red.add((int)red(pixel));
      Green.add((int)red(pixel));
      Blue.add((int)red(pixel));
    }
  }

  int rm = 0;
  int gm = 0;
  int bm = 0;
  int om = 0;
  for (int x = 0; x < Red.a.length; x += 1) {
    if (Red.a[x] > rm) {
      rm = Red.a[x];
    }

    if (Green.a[x] > gm) {
      gm = Green.a[x];
    }

    if (Blue.a[x] > bm) {
      bm = Blue.a[x];
    }
    
    if (rm + gm + bm > om) {
      om = rm + gm + bm;
    }
  }

  for (int x = 0; x < Red.a.length; x += 1) {
    int rh = (int) (map (Red.a[x], 0, om, 0, 255));
    int gh = (int) (map (Green.a[x], 0, om, 0, 255));
    int bh = (int) (map (Blue.a[x], 0, om, 0, 255));
    stroke(color(255, 0, 0));
    line(x, height, x, height - rh);

    stroke(color(0, 255, 0));
    line(x, height - rh, x, height - rh - gh);

    stroke(color(0, 0, 255));
    line(x, height - rh - gh, x, height - rh - gh - bh);
  }
}