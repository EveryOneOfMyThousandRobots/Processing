class Wave {
  float angle = 0;
  float inc = 0;
  float incRange = random(0.00001, 0.5);
  float incNoiseAmt = random(0.1);
  Noisey incNoise = new Noisey(radians(-incRange), radians(incRange), radians(incNoiseAmt));
  float amp = 0;
  float ampRange = 5*(1/incRange);
  float ampNoiseAmt = random(0.01,0.1);
  Noisey ampNoise = new Noisey(-ampRange, ampRange, radians(ampNoiseAmt)); 





  Wave() {
    angle = random(TWO_PI);
  }

  void update() {
    inc = incNoise.getValue();
    amp = ampNoise.getValue();
    angle += inc;
  }

  float getValue() {
    return sin(angle) * amp;
  }
}
