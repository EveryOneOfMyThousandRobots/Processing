enum COL {
  R, G, B, ALL, A;
}

String[] effects = {"PIXELATE", "REPLACE", "DITHER", "CORRUPT", "MOVE_R", "MOVE_G", "MOVE_B", "MOVE_ALL", "MESS"};

final int TEXT_X = 20;
int TEXT_Y = 30;
final String VID_TEXT0 = "contrived & insufferable";
final String VID_TEXT1 = "an improv podcast";
final String VID_TEXT2 = "contrivedpod.com";
final String VID_TEXT3 = "@contrivedpod";
class FrameSet {

  NoiseManager nse = new NoiseManager();
  PImage base;
  final int numFrames;
  final int startFrame;
  Movie movie;
  String name;
  ArrayList<String> setEffects = new ArrayList<String>();

  FrameSet(Movie movie, String path, int numFrames, int startFrame) {
    name = str(this.hashCode()) + "_";
    base = loadImage(path);
    this.numFrames = numFrames;
    this.startFrame = startFrame;
    this.movie = movie;
    makeEffectsList();
    // generate();
  }


  void generateOneFrame(int frameNumber) {
    String s = "00000" + (frameNumber + startFrame);
    s = s.substring(s.length()-5);
    PGraphics g = createGraphics(movie.TARGET_WIDTH, movie.TARGET_HEIGHT);
    g.beginDraw();
    g.image(base, 0, 0, movie.TARGET_WIDTH, movie.TARGET_HEIGHT);

    drawText(g, VID_TEXT0, TEXT_X, TEXT_Y, false);


    for (int j = 0; j < setEffects.size(); j += 1) {
      String e = setEffects.get(j);
      switch (e) {
      case "MESS":
        Mess(nse, g, name+"mess_", frameNumber);
        break;
      case "PIXELATE":
        pixelate(nse, g, name+"pixel"+j, frameNumber);
        break;
      case "REPLACE":
        color c = getMostCommonColour(g, 16);
        replaceColour(g, 16, c, color(255, 0, 0), color(255, 255, 0));
        break;
      case "DITHER":
        dither(nse, g, name+"dither"+j, frameNumber);
        break;
      case"CORRUPT":
        corruptDims(nse, g, name+"corr"+j, frameNumber);
        break;
      case"MOVE_R":
        move(nse, g, COL.R, name+"mr"+j, frameNumber);
        break;
      case "MOVE_G":
        move(nse, g, COL.G, name+"mg"+j, frameNumber);
        break;
      case "MOVE_B":
        move(nse, g, COL.B, name+"mb"+j, frameNumber);
        break;
      case "MOVE_ALL":
        move(nse, g, COL.ALL, name+"ma"+j, frameNumber);
        break;
      case "VHS":
        g.image(vignette, 0, 0);
        g.fill(0);
        g.noStroke();      
        VHS("abc", g, frameNumber + startFrame);
        VHS("def", g, frameNumber + startFrame);
        VHS("ghi", g, frameNumber + startFrame);

      default:
      }
    }








    int h_6 = g.height / 6;
    g.rect(0, 0, g.width, h_6);
    g.rect(0, g.height - h_6, g.width, h_6);

    float amt = 1-(float)(frameNumber+startFrame) / (float)movie.lenFrames;
    amt /= 2;



    drawText(g, corruptString(VID_TEXT3, amt), TEXT_X, TEXT_Y+60, true);
    drawText(g, corruptString(VID_TEXT2, amt), TEXT_X, TEXT_Y+40, true);
    drawText(g, corruptString(VID_TEXT1, amt), TEXT_X, TEXT_Y+20, true);
    drawText(g, corruptString(VID_TEXT0, amt), TEXT_X, TEXT_Y, true);





    g.endDraw();
    movie.frames[frameNumber+startFrame] = g.copy();
    g = null;
    // g.save(movie.outputFolder + "\\" + s + ".jpg");
  }


  void makeEffectsList() {
    //int r = floor(random(pow(2, 11)));



    int n = floor(random(3, 8));

    while (setEffects.size() < n) {
      int nn = floor(random(effects.length));

      setEffects.add(effects[nn]);

      if (setEffects.size() > 3 && random(1) < 0.01) {
        break;
      }
    }
    Collections.shuffle(setEffects);
    setEffects.add("VHS");
  }

  void drawText(PGraphics input, String text, float x, float y, boolean bg) {
    input.textFont(ibmFont);

    float tw = input.textWidth(text);
    if (bg) {
      input.fill(0);

      input.rect(x-2, y-20, tw + 8, 22);
    }
    input.fill(255);
    input.text(text, x, y);
  }











  //int getSeed() {
  //  int i = 0;
  //  if (random(1)<PIXEL_CHANCE) {
  //    i += PIXELATE;
  //  } else {
  //    i += DITHER;
  //  }

  //  if (random(1) < 0.5) {
  //    i += CORRUPT;
  //  }

  //  if (random(1) < MOVE_R0_CHANCE) {
  //    i += MOVE_R0;
  //  }

  //  if (random(1) < MOVE_G0_CHANCE) {
  //    i += MOVE_G0;
  //  }

  //  if (random(1) < MOVE_B0_CHANCE) {
  //    i += MOVE_B0;
  //  }
  //  if (random(1) < MOVE_A0_CHANCE) {
  //    i += MOVE_A0;
  //  }

  //  if (random(1) < MOVE_R1_CHANCE) {
  //    i += MOVE_R1;
  //  }

  //  if (random(1) < MOVE_G1_CHANCE) {
  //    i += MOVE_G1;
  //  }

  //  if (random(1) < MOVE_B1_CHANCE) {
  //    i += MOVE_B1;
  //  }
  //  if (random(1) < MOVE_A1_CHANCE) {
  //    i += MOVE_A1;
  //  }





  //  return i;
  //}
}
