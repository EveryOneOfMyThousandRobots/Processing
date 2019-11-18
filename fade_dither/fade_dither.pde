PFont font_front; //<>//
PFont font_back;
PFont font_small;
float ox = 0;
float oy = 0;
float nx, ny;
float nza = 0;
float nzx = 0;
float nzy = 0;
float nzr = 1;


final float TOTAL_FRAMES = 5;
float currentFrame = 0;

void setup() {
  //frameRate(1);

  font_front = createFont("Nouveau IBM", 48);
  font_back = createFont("Nouveau IBM", 40);
  font_small = createFont("Nouveau IBM", 14);

  size(600, 400, P3D);
  noSmooth();

  randomSeed(1234);
  noiseSeed(1234);
  initNoisers();
  //surface.setLocation(-900, 0);

  img = createGraphics(width, height, P3D);
  img.noSmooth();
  //imgPost = createGraphics(width, height);
  ma = new float[SIZE][SIZE];
  float n = 1.0 / 16.0;
  for (int x = 0; x < SIZE; x += 1) {
    for (int y = 0; y < SIZE; y += 1) {

      ma[x][y] = m[x][y] * n;
    }
  }
  makeLetters();
}


boolean drawBg = true;
boolean pixelate = false;
boolean drawText = false;
boolean procSmash = false;
boolean procProcess = true;

void draw() {
  currentFrame += 1;

  background(0);
  img.beginDraw();
  if (drawBg) {
    drawBG();
  }

  //img = pixelate(img, 20);
  if (drawText) {
    //img.beginDraw();
    drawText(img, "CONTRIVED   ", 0, height/4);
    drawText(img, "      AND   ", 0, height/2);
    drawText(img, "INSUFFERABLE", 0, height*0.75);
    //img.endDraw();
  }


  //println("before smash");
  if (procSmash) {
    for (int i = 0; i < 5; i += 1) {
      img = smash(img);
    }
  }

  if (pixelate) {
    img = pixelate(img, 5);
  }
  img.endDraw();
  if (procProcess) {
    PGraphics ni = process(img);
    image(ni,0,0);
  } else {
    image(img, 0, 0);
  }
  //img.save("out/img####.png");
  //println("after  smash");

  saveFrame("out/####.png");
  if (currentFrame >= TOTAL_FRAMES) {
    exit();
  }
}

float[][] m = {
  {0, 8, 2, 10}, 
  {12, 4, 14, 6}, 
  {3, 11, 1, 9}, 
  {15, 7, 13, 5}
};
