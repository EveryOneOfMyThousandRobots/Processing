PGraphics pixelate(PGraphics input, int cellSize) { //<>//

  //input.beginDraw();
  input.loadPixels();
  for (int x = 0; x < input.width; x += cellSize) {
    for (int y = 0; y < input.height; y += cellSize) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      float count = 0;
      for (int xx = 0; xx < cellSize; xx += 1) {
        for (int yy = 0; yy < cellSize; yy += 1) {

          int xp = x + xx;
          int yp = y + yy;
          if (xp > input.width - 1 || yp > input.height - 1) break;




          int index = yp * input.width + xp;
          int colour = input.pixels[index];

          sumR += (colour >> 16) & 255;
          sumG += (colour >> 8) & 255;
          sumB += (colour) & 255;
          count += 1;
        }
      }

      if (count > 0) {
        sumR /= count;
        sumG /= count;
        sumB /= count;
        input.noStroke();
        input.fill(color(sumR, sumG, sumB));
        input.rect(x, y, cellSize, cellSize);
      }
    }
  }
  //input.updatePixels();
  //input.endDraw();


  return input;
}


class Noiser {
  float cx, cy;
  float x, y;
  float r;
  float angle = 0;
  float n  =0;
  Noiser() {
    cx = random(0, 100);
    cy = random(0, 100);
    r = random(1, 10);
  }

  void update() {
    angle = TWO_PI * (frameCount / TOTAL_FRAMES);
    x = cx + r * cos(angle);
    y = cy + r * sin(angle);
    n = noise(x, y);
  }

  boolean Bool() {
    return n >= 0.5;
  }

  float Float() {
    return n;
  }

  int Int(int min, int max) {
    return floor(map(n, 0, 1, min, max));
  }
}
Noiser smashOn; 
Noiser smashXS; 
Noiser smashXE; 
Noiser smashYS; 
Noiser smashYE; 
Noiser smashXO; 

void initNoisers() {
  smashOn = new Noiser();
  smashXS = new Noiser();
  smashXE = new Noiser();
  smashYS = new Noiser();
  smashYE = new Noiser();
  smashXO = new Noiser();
  Bg = new Noiser();
}
PGraphics smash(PGraphics input) {

  smashOn.update();
  if (smashOn.Bool()) {

    smashXS.update();
    smashXE.update();
    smashYS.update();
    smashYE.update();
    smashXO.update();


    //input.beginDraw();

    input.loadPixels();

    int xs = smashXS.Int(0, input.width);
    int xe = smashXE.Int(xs + 1, input.width);
    int w = xe - xs;

    int xo = smashXO.Int(0, input.width);

    int ys = smashYS.Int(0, input.height);
    int ye = smashYE.Int(ys+1, input.height);
    int h = ye - ys;

    // println("start(" + xs + "," + ys + ") end(" + xe + "," + ye + ") dim(" + w + "," + h + ") offset(" + xo + ")");


    int[][] buffer = new int[w][h];
    int xi = 0, yi = 0;
    for (int xx = xs; xx < xe; xx += 1) {

      yi = 0;
      for (int yy = ys; yy < ye; yy += 1) {


        buffer[xi][yi] = input.pixels[yy * input.width + xx];
        yi += 1;
      }
      xi += 1;
    }

    for (int xx = 0; xx < w; xx += 1) {
      for (int yy = 0; yy < h; yy += 1) {
        int nx = (xs + xx + xo) % input.width;
        int ny = (ys + yy) % input.height;
        input.pixels[ny * g.width + nx] = buffer[xx][yy];
      }
    }



    input.updatePixels();
    //input.endDraw();
  }


  return input;
}
