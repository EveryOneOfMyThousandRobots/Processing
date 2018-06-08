PGraphics buffer1, buffer2;
PImage coolingMap;

void setup() {
  size(600, 400);
  buffer1 = createGraphics(width, height);//createImage(width, height, RGB);
  buffer2 = createGraphics(width, height);//createImage(width, height, RGB);
  setBottomLines();
  createCoolingMap();
  //frameRate(1);
}

void setBottomLines() {
  buffer1.beginDraw();
  buffer2.beginDraw();
  buffer1.loadPixels();
  buffer2.loadPixels();
  for (int x = 0; x < buffer1.width; x += 1) {
    for (int y = buffer1.height-3; y < buffer1.height; y+=1 ) {
      int index = x + y * buffer1.width;

      color c = color(random(250, 255));
      buffer1.pixels[index] = c;
      buffer2.pixels[index] = c;
    }
  }
  buffer1.updatePixels();
  buffer2.updatePixels();
  buffer1.endDraw();
  buffer2.endDraw();
}


void draw() {
  background(0);
  buffer1.beginDraw();
  buffer2.beginDraw();
  buffer1.loadPixels();
  buffer2.loadPixels();
  for (int x = 1; x < buffer1.width-1; x += 1) {
    for (int y = 1; y < buffer1.height-1; y += 1) {
      int upOneIndex = x + (y-1) * buffer2.width;
      int coolIndex = x + y * buffer2.width;
      int i1 = (x + 1) + y * buffer1.width;
      int i2 = (x - 1) + y * buffer1.width;
      int i3 = x + (y + 1) * buffer1.width;
      int i4 = x  + (y-1) * buffer1.width;
      float b1 = brightness(buffer1.pixels[i1]);
      float b2 = brightness(buffer1.pixels[i2]);
      float b3 = brightness(buffer1.pixels[i3]);
      float b4 = brightness(buffer1.pixels[i4]);

      float c = brightness(coolingMap.pixels[coolIndex]);

      float newColour = (b1 + b2 + b3 + b4) / 4;
      //newColour = sqrt(pow(newColour, 2) - pow(c,2));
      newColour -= c;
      if (newColour < 0) {
        newColour = 0;
      }

      buffer2.pixels[upOneIndex] = color(newColour);
    }
  }
  buffer2.updatePixels();
  buffer1.endDraw();
  buffer2.endDraw();

  image(buffer2, 0, 0);
  PGraphics tmp = buffer1;
  buffer1 = buffer2;
  buffer2 = tmp;
  //buffer1 = buffer2.copy();
  //image(coolingMap, 0,0 );
  setBottomLines();
  createCoolingMap();
}



void mouseDragged() {
  buffer1.beginDraw();
  buffer1.noStroke();
  buffer1.fill(255);
  buffer1.ellipse(mouseX, mouseY, 50,50);
  buffer1.endDraw();
}
