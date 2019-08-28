class Delay {
  float period, feedback;
  boolean red, green, blue, all;
  PImage output;
  boolean forwards = true;
  float randomRange = 0;

  Delay(float period, float feedback) {
    this(period, feedback, true, true, true);
  }

  Delay(float period, float feedback, boolean red, boolean green, boolean blue) {


    this.red = red;
    this.green = green;
    this.blue = blue;


    this.period = period;
    this.feedback = feedback;
  }

  void procReverse(PImage img) {
    output = img.copy();
    println("starting proc...");
    output.loadPixels();
    img.loadPixels();


    for (int i = img.pixels.length-1; i >= 0; i -= 1) {
      color hold = img.pixels[i];
      if (!red) {
        hold = color(0, getG(hold), getB(hold));
      }

      if (!green) {
        hold = color(getR(hold), 0, getB(hold));
      }

      if (!blue) {
        hold = color(getR(hold), getG(hold), 0);
      }

      for (int j = i - floor(period); j >= 0; j -= floor(period + random(-randomRange, randomRange))) {

        output.pixels[j] = delayAddAlt(output.pixels[j], hold);

        hold = color(getR(hold) * feedback, getG(hold) * feedback, getB(hold) * feedback);
        if (brightness(hold) < 1) {
          break;
        }
      }
    }
    output.updatePixels();
    //output = copy.copy();
    println("finishing proc...");
  }

  void process(PImage img) {
    output = img.copy();
    println("starting proc...");
    output.loadPixels();
    img.loadPixels();


    for (int i = 0; i < img.pixels.length; i += 1) {
      color hold = img.pixels[i];
      if (!red) {
        hold = color(0, getG(hold), getB(hold));
      }

      if (!green) {
        hold = color(getR(hold), 0, getB(hold));
      }

      if (!blue) {
        hold = color(getR(hold), getG(hold), 0);
      }

      for (int j = i + floor(period); j < img.pixels.length; j += floor(period + random(-randomRange, randomRange))) {

        output.pixels[j] = delayAdd(output.pixels[j], hold);

        hold = color(getR(hold) * feedback, getG(hold) * feedback, getB(hold) * feedback);
        if (brightness(hold) < 1) {
          break;
        }
      }
    }
    output.updatePixels();
    //output = copy.copy();
    println("finishing proc...");
  }

  color delayAdd(color a, color b) {
    float ar = red(a);
    float ag = green(a);
    float ab = blue(a);

    float br = red(b);
    float bg = green(b);
    float bb = blue(b);

    ar = constrain(ar + br, 0, 255);
    ag = constrain(ag + bg, 0, 255);
    ab = constrain(ab + bb, 0, 255);

    return color(ar, ag, ab);
  }

  color delayAddAlt(color a, color b) {
    float ar = red(a);
    float ag = green(a);
    float ab = blue(a);

    float br = red(b);
    float bg = green(b);
    float bb = blue(b);

    ar = ar + br % 255;
    ag = ag + bg % 255;
    ab = ab + bb % 255;

    return color(ar, ag, ab);
  }
}

float getR(int a) {
  return (a >> 16) & 255;
}

float getG(int a) {
  return (a >> 8) & 255;
}

float getB(int a) {
  return a & 255;
}
