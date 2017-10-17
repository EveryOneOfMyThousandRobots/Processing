int MIN_SHAPES = 200;
int MAX_SHAPES = 300;

class Thing {
  ArrayList<Poly> pollies = new ArrayList<Poly>();
  DNA dna;
  int numShapes;
  float fitness;

  Thing(DNA dna) {
    if (dna == null) {
      this.dna = new DNA();
    } else {
      this.dna = dna;
    }

    numShapes = floor(this.dna.get("numShapes", MIN_SHAPES, MAX_SHAPES));
    for (int i = 0; i < numShapes; i += 1) {
      pollies.add( new Poly(this.dna, i));
    }
  }

  void draw() {
    fill(0);
    rect(sbx, sby, sbw, sbh);
    for (Poly p : pollies) {
      p.draw();
    }
    loadPixels();
  }

  void eval () {
    int imgw = testImage.width;
    float total = 0;
    for (int x = 0; x < testImage.width; x += 1) {
      int xx = x + imgw;
      for (int y = 0; y < testImage.height; y += 1) {

        int yy = y;

        //float guess_hue = squish(hue(pixels[xx + yy * width]));
        //float guess_sat = squish(saturation(pixels[xx + yy * width]));
        float guess_bri = (brightness(pixels[xx + yy * width]));

        //float img_hue = squish(hue(testImage.pixels[x + y * imgw]));
        //float img_sat = squish(saturation(testImage.pixels[x + y * imgw]));
        float img_bri = (brightness(testImage.pixels[x + y * imgw]));

        //total += abs((img_hue - guess_hue)) + abs((img_sat - guess_sat)) + abs((img_bri - guess_bri));
        total += abs((img_bri - guess_bri));
      }
    }
    total /= testImage.width * testImage.height;
    total = 1 + (1/ total);
    fitness = pow(total, 6);
  }
  Thing breed(Thing b) {


    DNA dna = this.dna.cross(b.dna);
    for (int i = 0; i < 5; i += 1) {
      dna.mutate();
    }
    return new Thing(dna);
  }
}

float squish(float f) {
  return floor(map(f, 0, 255, 0, 100));
}