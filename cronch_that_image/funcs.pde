
float colour_drift = 0.1;
color getAverage(PImage img, float x, float y, float w, float h) {

  double ar = 0, ag = 0, ab = 0;
  double counter = 0;
  img.loadPixels();
  for (float xx = x; xx < x + w; xx += 1) {
    if (xx < 0 || xx > width-1) break;
    for (float yy = y; yy < y + h; yy += 1) {
      if (yy < 0 || yy > height-1) break;
      counter += 1;
      color c = img.get(floor(xx), floor(yy));
      ar += getV(CHANNEL.RED, c);
      ag += getV(CHANNEL.GREEN, c);
      ab += getV(CHANNEL.BLUE, c);
    }
  }

  ar *= (1.0d / counter) * (1.0 + (random(-colour_drift, colour_drift)));
  ag *= (1.0d / counter) * (1.0 + (random(-colour_drift, colour_drift)));
  ab *= (1.0d / counter) * (1.0 + (random(-colour_drift, colour_drift)));

  return color((int)ar, (int)ag, (int)ab);


  //return color(0);
}

double getRandomStdi(PImage img, float x, float y, float w, float h, CHANNEL channel) {
  ArrayList<Integer> colours = new ArrayList<Integer>();
  ArrayList<Double> subset = new ArrayList<Double>();
  double stdi = 0;
  double mu = 0;
  //double counter = 0;
  for (float xx = x; xx < x + w; xx += 1) {
    if (xx < 0 || xx > width-1) break;
    for (float yy = y; yy < y + h; yy += 1) {
      if (yy < 0 || yy > height-1) break;

      colours.add( Integer.valueOf(img.get(floor(xx), floor(yy))));
    }
  }

  int target = floor(colours.size() * sampleFactor);
  if (target < 1) {
    target = 1;
  }

  while (subset.size() < target && !colours.isEmpty()) {
    int i = floor(random(colours.size()));

    subset.add( getV(channel, colours.get(i)) );
    colours.remove(i);
  }

  for (double i : subset) {
    mu += i;
  }
  mu *= (1.0 / subset.size());

  for (double i : subset) {
    double s = pow((float)(i - mu), 2);
    //s *= s;
    stdi += s;
  }

  stdi *= (1.0 / subset.size());
  stdi = (double) sqrt((float)stdi);


  return stdi;
}

double getStdi (PImage img, float x, float y, float w, float h, CHANNEL channel) {

  double stdi = 0;
  double mu = 0;
  double counter = 0;
  img.loadPixels();

  for (float xx = x; xx < x + w; xx += 1) {
    if (xx < 0 || xx > width-1) break;
    for (float yy = y; yy < y + h; yy += 1) {
      if (yy < 0 || yy > height-1) break;
      counter += 1;
      mu += getV(channel, img.get(floor(xx), floor(yy)));
    }
  }

  mu *= (1.0d / counter);
  //println("mu = " + mu + " counter = " + counter);

  for (float xx = x; xx < x + w; xx += 1) {
    if (xx < 0 || xx > width-1) break;
    for (float yy = y; yy < y + h; yy += 1) {
      if (yy < 0 || yy > height-1) break;
      double s = getV(channel, img.get(floor(xx), floor(yy))) - mu;
      s *= s;
      stdi += s;
    }
  }

  stdi *= (1.0d / counter);
  stdi = (double)sqrt((float)stdi);
  return stdi;
}

Tile getRandom(SImage img, Tile me) {

  return img.tiles.get(floor(random(img.tiles.size())));

}


double getV(CHANNEL channel, int c) {
  double v = 0;
  switch (channel) {
  case ALL:
    v = sbb(c);
    break;
  case RED:
    v = sr(c);
    break;
  case GREEN:
    v = sg(c);
    break;
  case BLUE:
    v = sb(c);
    break;
  }

  return v;
}

double sbb(int c) {
  return ((double)(sr(c) + sg(c) + sb(c))) / 3.0d;
}

int sr(int c) {
  return (c >> 16) & 255;
}

int sg(int c) {
  return (c >> 8) & 255;
}

int sb(int c) {
  return c & 255;
}
