PImage inputImg;
PImage outputImg;


float NUM_COLOURS = 2;
float COLOURS_FACTOR = NUM_COLOURS - 1;
void settings() {
  inputImg = loadImage("001.jpg");
  size(inputImg.width*2, inputImg.height);
}

void setup() {
  background(0);
  
  //noLoop();
  
}
float angle = 0;
float errorR, errorG, errorB;
final float AMT_7_16 = 7.0 / 16.0;
final float AMT_5_16 = 5.0 / 16.0;
final float AMT_3_16 = 3.0 / 16.0;
final float AMT_1_16 = 1.0 / 16.0;
void draw() {
  background(0);
  angle = (angle + radians(1)) % TWO_PI;
  NUM_COLOURS = floor(map(sin(angle), -1, 1, 2, 16)); 
  COLOURS_FACTOR = NUM_COLOURS - 1;
  image(inputImg, 0, 0);
  outputImg = inputImg.copy();
  //inputImg.loadPixels();
  outputImg.loadPixels();
  for (int y = 0; y < inputImg.height; y += 1) {
    for (int x = 0; x < inputImg.width; x += 1) {

      int i = gi(x, y);
      color c = outputImg.pixels[i];
      float r = rr(c);
      float g = gg(c);
      float b = bb(c);

      int nr = (int)(round((COLOURS_FACTOR * r) / 255.0) * (255/COLOURS_FACTOR));
      int ng = (int)(round((COLOURS_FACTOR * g) / 255.0) * (255/COLOURS_FACTOR));
      int nb = (int)(round((COLOURS_FACTOR * b) / 255.0) * (255/COLOURS_FACTOR));

      errorR = (r - nr);
      errorG = (g - ng);
      errorB = (b - nb);

      outputImg.pixels[i] = color(nr, ng, nb);
      
      pushError(x+1,    y,      AMT_7_16);
      pushError(x-1,    y+1,    AMT_3_16);
      pushError(x,      y+1,    AMT_5_16);
      pushError(x+1,    y+1,    AMT_1_16);
    }
  }
  outputImg.updatePixels();
  image(outputImg, outputImg.width, 0);
  fill(255);
  text(NUM_COLOURS + "\n" + nfc(angle, 2), 10, 10);
}

void pushError(int x, int y, float amount) {
  int i = gi(x,y);
  if (i != -1) {
    color c = outputImg.pixels[i];
    float r = rr(c);
    float g = gg(c);
    float b = bb(c);
    
    r += (errorR * amount);
    g += (errorG * amount);
    b += (errorB * amount);
    outputImg.pixels[i] = color(r,g,b);
  }
}

/*
      pixel[x + 1][y    ] := pixel[x + 1][y    ] + quant_error * 7 / 16
      pixel[x - 1][y + 1] := pixel[x - 1][y + 1] + quant_error * 3 / 16
      pixel[x    ][y + 1] := pixel[x    ][y + 1] + quant_error * 5 / 16
      pixel[x + 1][y + 1] := pixel[x + 1][y + 1] + quant_error * 1 / 16
      */

color closestColour() {

  return color(0);
}


int gi(float x, float y) {
  int i = floor(x) + floor(y) * inputImg.width;
  if (i < 0 || i >= (inputImg.width * inputImg.height)) return -1;
  return i;
}


float rr(int c) {
  return (c >> 16) & 255;
}

float gg(int c) {
  return (c >> 8) & 255;
}

float bb(int c) {
  return c & 255;
}
