float[][] dithermap = {
    { 0, 32,  8, 40,  2, 34, 10, 42},   /* 8x8 Bayer ordered dithering  */
    {48, 16, 56, 24, 50, 18, 58, 26},   /* pattern.  Each input pixel   */
    {12, 44,  4, 36, 14, 46,  6, 38},   /* is scaled to the 0..63 range */
    {60, 28, 52, 20, 62, 30, 54, 22},   /* before looking in this table */
    { 3, 35, 11, 43,  1, 33,  9, 41},   /* to determine the action.     */
    {51, 19, 59, 27, 49, 17, 57, 25},
    {15, 47,  7, 39, 13, 45,  5, 37},
    {63, 31, 55, 23, 61, 29, 53, 21} };


PImage bg;
PImage fg;
void settings() {
  float f = 1.0 / 64.0;
  bg = loadImage("smarties.jpg");
  size(bg.width, bg.height);
  //for (int xi = 0; xi < dithermap.length; xi += 1) {
  //  for (int yi = 0; yi < dithermap[xi].length; yi += 1) {
  //    dithermap[xi][yi] *= f;
  //  }
  //}
  printArray(dithermap[0]);
}

void setup() {
  fg = bg.copy();
}

void draw() {
  background(0);
  fg.loadPixels();
  for (int px = 0; px < fg.width; px += 1) {
    for (int py = 0; py < fg.height; py += 1) {
      int c = ((int)brightness(fg.pixels[px + py * fg.width])) >> 2;
      if (c > dithermap[px & 7][py & 7]) {
        fg.pixels[px + py * fg.width] = color(0);
      }
    }
  }
  fg.updatePixels();
  image(fg, 0,0 );
  noLoop();
}
