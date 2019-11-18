color[] colours = {color(0), color(255), color(255, 0, 0), color(0, 255, 0)};

class Tile {
  PImage img, imgBase;
  int x, y;
  color c;
  Tile(int x, int y) {
    this.x = x;
    this.y = y;
    img = createImage(TILE_SIZE, TILE_SIZE, ARGB);
    imgBase = createImage(TILE_SIZE, TILE_SIZE, ARGB);
    c = colours[floor(random(colours.length))];
    img.loadPixels();
    int p = 4;
    for (int xx = 0; xx < TILE_SIZE-2; xx += p) {
      for (int yy = 0; yy < TILE_SIZE-2; yy += p) {

        float r = red(c) + random(-COLOUR_DRIFT, COLOUR_DRIFT);
        float g = green(c) + random(-COLOUR_DRIFT, COLOUR_DRIFT);
        float b = blue(c) + random(-COLOUR_DRIFT, COLOUR_DRIFT);

        for (int xi = 0; xi <= p-1; xi += 1) {
          for (int yi = 0; yi <= p-1; yi += 1) {
            img.pixels[(yi + yy) * TILE_SIZE + (xi + xx)] = color(r, g, b);
          }
        }
      }
    }
    img.updatePixels();
    imgBase.copy(img, 0, 0, TILE_SIZE, TILE_SIZE, 0, 0, TILE_SIZE, TILE_SIZE);
  }


  void draw() {
    image(img, x * TILE_SIZE, y * TILE_SIZE);
    //stroke(0);
    //noFill();
    //rect(x * TILE_SIZE, y * TILE_SIZE, TILE_SIZE, TILE_SIZE);
  }

  PImage get(int px, int py, int w, int h, boolean getBase) {


    PImage uImg = getBase ? imgBase : img;
    PImage nImg = createImage(w, h, ARGB);
    nImg.copy(uImg, px, py, w, h, 0, 0, w, h);
    return nImg;
  }

  void northCombine(PImage imgB) {
    float fade = 1;
    img.loadPixels();
    imgB.loadPixels();
    for (int x = 0; x < TILE_SIZE; x += 1) {
      for (int y = 0; y < imgB.height; y += 1) {
        fade = map(float(y) / float(imgB.height), 0, 1, 0.8, 0);
        if (random(1) < fade) {
          img.pixels[y * TILE_SIZE + x] =imgB.get(x, y); //lerpColor(img.get(x, y), imgB.get(x, y), fade);
        }
      }
    }
    img.updatePixels();
  }

  void westCombine(PImage imgB) {
    float fade = 1;
    img.loadPixels();
    imgB.loadPixels();
    for (int y = 0; y < TILE_SIZE; y += 1) {
      for (int x = 0; x < imgB.width; x += 1) {

        fade = map(float(x) / float(imgB.width), 0, 1, 0.8, 0);
        if (random(1) < fade) {
        img.pixels[y * TILE_SIZE + x] = imgB.get(x, y);//lerpColor(img.get(x, y), imgB.get(x, y), fade);
        }
      }
    }
    img.updatePixels();
  }
}
