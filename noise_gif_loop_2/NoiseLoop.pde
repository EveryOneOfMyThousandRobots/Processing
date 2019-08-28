class NoiseLoop {
  private float xc, yc, xoff, yoff, zoff;
  //private float angle = 0;
  private float min, max, range;
  //float v = 0;
  private float lastValue = 0;
  

  NoiseLoop(float range, float min, float max) {
    this.min = min;
    this.min = max;
    this.range = range;

    xc = random(10000);
    yc = random(10000);
    zoff = random(100);
  }

  float value(float angle) {
    xoff = xc + map(cos(angle), -1, 1, 0, range);
    yoff = yc + map(sin(angle), -1, 1, 0, range);
    lastValue = map(noise(xoff, yoff, zoff), 0, 1, min, max); 
    return lastValue;
  }


  String toString() {
    return "noiseLoop (" + nfc(xc, 1) + "," + nfc(yc, 1) + ") r:"+min+"->"+max + " range:" + range + " last:" + nfc(lastValue, 2);
  }
}
