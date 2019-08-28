PImage src;
PImage dst;
void settings() {
  src = loadImage("sunflower.jpg");
  size(src.width*4, src.height*2);
}

int i = -1;


void setup() {
  //noLoop();
  dst = src.copy();//createImage(src.width, src.height, RGB);

  frameRate(10000);
  src.loadPixels();
  dst.loadPixels();
  //selection sorting


  dst.updatePixels();
}


void draw() {
  background(0);
  image(src, 0, 0, src.width*2, src.height*2);
  image(dst, width/2, 0, dst.width*2, dst.height*2);

  dst.loadPixels();
  for (int k = 0; k < 100; k += 1) {
    i += 1;
    if (i >= dst.pixels.length-1) stop();

    //for (int i = 0; i < dst.pixels.length; i += 1) {
    float highest = -1;
    int selected = i;
    for (int j = i; j < dst.pixels.length; j += 1) {
      color p = dst.pixels[j];
      float b = red(p);
      if (b > highest) {
        highest = b;
        selected = j;
      }
      //}
    }
    color t = dst.pixels[i];
    dst.pixels[i] = dst.pixels[selected];
    dst.pixels[selected] = t;
  }
  dst.updatePixels();
}
