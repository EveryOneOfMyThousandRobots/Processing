

PImage img;
PGraphics gr;
PGraphics noiseImg;
int frame = 0;
boolean record = false;
PFont font;
final int TOTAL_FRAMES = 60;
void settings() {
  img = loadImage("candi.png");
  size(img.width, img.height);
}
String[] prepre = {"a_", "b_", "c_"};
void setup() {
  font = createFont("Nouveau IBM", 12);
  textFont(font);
  //randomSeed(12384);
  //noiseSeed(46564);
  gr = createGraphics(width, height);
  gr.beginDraw();
  gr.image(img, 0, 0);
  gr.endDraw();

  noiseImg = createGraphics(width, height);
  String[] prefixes = {"*_", "r_", "g_", "b_", "a_"};

  for (int c = 0; c < 255; c += 5) {
    println(c + " = " + cr(c));
  }


  for (String pp : prepre) {
    for (String p : prefixes) {
      noiseMake(pp+p+"sx");
      noiseMake(pp+p+"sy");
      noiseMake(pp+p+"w");
      noiseMake(pp+p+"h");

      noiseMake(pp+p+"ex");
      noiseMake(pp+p+"ey");

      noiseMake(pp+p+"oox");
      noiseMake(pp+p+"ooy");
      noiseMake(pp+p+"oex");
      noiseMake(pp+p+"oey");
    }
  }
}
final int NOISE_STEP = 4;
void drawNoiseBg() {
  noiseImg.beginDraw();
  noiseImg.loadPixels();
  for (int x = 0; x < width; x += NOISE_STEP) {
    for (int y = 0; y < height; y += NOISE_STEP) {
      float n0 = noise((float)x * 0.01, (float)y * 0.01, 1 + (0.1 * (float)frame / (float)TOTAL_FRAMES));
      float n1 = noise((float)x * 0.01, (float)y * 0.01, 2 + (0.1 * (float)frame / (float)TOTAL_FRAMES));
      float n2 = noise((float)x * 0.01, (float)y * 0.01, 3 + (0.1 * (float)frame / (float)TOTAL_FRAMES));

      float n = (n0 + n1 + n2) % 1;

      color c = n < 0.5 ? color(200, 0) : color(200, 255);

      for (int xx = 0; xx < NOISE_STEP; xx += 1) {
        int xp = x + xx;
        if (xp > width -1) continue;
        for (int yy = 0; yy < NOISE_STEP; yy += 1) {
          int yp = y + yy;
          if (yp > height - 1) continue;

          noiseImg.pixels[yp * width + xp] = c;
        }
      }
    }
  }
  noiseImg.updatePixels();
  noiseImg.endDraw();
}


void draw() {
  frame += 1;
  background(0);
  drawNoiseBg();
  noiseUpdateAll();
  gr.beginDraw();
  gr.image(img, 0, 0);
  gr.endDraw();  
  noiseImg.beginDraw();
  noiseImg.loadPixels();
  for (String pp : prepre) {
    proc(pp, COL_MODE.COL_RED);
    //proc(pp, COL_MODE.COL_GREEN);
    proc(pp, COL_MODE.COL_BLUE);
    //proc(pp, COL_MODE.COL_ALL);
    proc2(pp);
  }
  //proc("a_", COL_MODE.COL_ALPHA);


  noiseImg.endDraw();

  //image(noiseImg, 0,0);
  colourReduce(gr);
  image(gr, 0, 0);

  if (frame >= TOTAL_FRAMES) {
    if (record)
      exit();

    frame = 0;
  }
  if (record)
    saveFrame("out/img####.jpg");

  fill(255);
  text(frame, 10, 10);
}
