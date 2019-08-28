PImage resizeMe(PImage img, float w, float h) {

  PImage newImg = img.copy();

  if (newImg.width > w) {
    float wr = float(newImg.width) / w;

    newImg.resize(floor(float(newImg.width)/wr), floor(float(newImg.height)/wr));

    if (newImg.height > h) {
      float hr = float(newImg.height) / h;

      newImg.resize(floor(float(newImg.width)/hr), floor(float(newImg.height)/hr));
    }
  }

  if (newImg.height > h) {
    float wr = float(newImg.height) / h;

    newImg.resize(floor(float(newImg.width)/wr), floor(newImg.height/wr));

    if (newImg.width > w) {
      float hr = newImg.width / w;

      newImg.resize(floor(newImg.width/hr), floor(newImg.height/hr));
    }
  }


  return newImg;
}

PImage proc(PImage img) {
  PImage newImg = img.copy();

  newImg.loadPixels();
  for (int x = 0; x < newImg.width; x += 1) {
    for (int y = 0; y < newImg.height; y += 1) {
      color c = newImg.get(x, y);
      float h = getClosest(hue(c));
      float s = getClosest(saturation(c));
      float b = getClosest(brightness(c));

      newImg.set(x, y, color(h, s, b));
    }
  }
  newImg.updatePixels();


  return newImg;
}

float getClosest(float h) {
  h = constrain(h + random(-10,10), 0, 255);
  float n = NUM_COLOURS;
  h = floor(h / (255.0/n)) * (255.0/n);
  return floor(h);
}
