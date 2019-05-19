int period = floor(random(100,500));
int chunk = floor(random(50,100));

float factor = 0.999;

PImage img;
PImage processed;
void settings() {
  img = loadImage("parrot.png");
  size(img.width, img.height);
}

void setup() {
}

void draw() {
  background(0);
  proc();
  
  image(processed, 0, 0);
  
  
}

void proc() {
  processed = img.copy();
  
  processed.loadPixels();
  color[] cnk = new color[chunk];
  for (int i = 0; i < chunk; i += 1) {
    cnk[i] = processed.pixels[i];
  }
  
  for (int i = chunk+1; i < processed.pixels.length; i += period) {
    for (int j = 0; j < cnk.length; j += 1) {
      cnk[j] = color(red(cnk[j]),green(cnk[j]), blue(cnk[j]), alpha(cnk[j])*factor);
    }
    int ci = 0;
    for (int j = i; j < i + chunk; j += 1) {
      if (j >= processed.pixels.length) break;
      
      color c1 = processed.pixels[j];
      color c2 = cnk[ci];
      float f = map(alpha(cnk[ci]), 0, 255, 0, 1);
      float r = red(c1) + (0.0 + red(c2) * f);
      float g = green(c1) + (0.0 +green(c2) * f);
      float b = blue(c1) + (0.0 + blue(c2) * f);
      processed.pixels[j] = color(r,g,b);
      
      ci += 1;
    }
  }
  
  processed.updatePixels();
  
  
}
