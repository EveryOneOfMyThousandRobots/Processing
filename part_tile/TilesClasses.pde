class Tile {
  float x, y;
  float w, h;
  boolean displayMe = true;
  color c;
  Tile (float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    displayMe = displayMe();
  }

  boolean displayMe() {
    boolean returnValue = false;

    float xc = (cos(map(x, 0, width, 0, PI)));
    float yc = (sin(map(y, 0, height, PI, 0)));


    float chance = map(xc + yc, 0, 2, 0, 1000);
    float rando = random(1000);
    if (chance >= rando) {
      returnValue = true;
    }
   // println("(" + x + "," + y + ") (" + xc + "," + yc + ") c:" + chance + " r:" + rando);


    return returnValue;
  }



  void evaluate(PImage img) {
    float r = 0, g = 0, b = 0;
    float counter = 0;
    for (int yy = (int)y; yy < y + w; yy++) {
      for (int xx = (int)x; xx < x + h; xx++) {
        if (xx >= img.width || yy >= img.height) continue;
        int pixel = img.pixels[xx + yy * img.width]; 
        r += red(pixel);
        g += green(pixel);
        b += blue(pixel);
        counter++;
      }
    }
    r /= counter;
    g /= counter;
    b /= counter;
    c = color(r, g, b);
  }

  void draw() {
    if (displayMe) {
      if (withBorders) {
        stroke(0);
      } else {
        noStroke();
      }
      
     // 
      fill(c);
      rect(x, y, w, h);
    }
  }
}