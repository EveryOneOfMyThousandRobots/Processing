ArrayList<Wave> waves = new ArrayList<Wave>();
void setup() {
  size(600, 400);
  //Wave(float freq, float amp, int seconds, float interval, float x, float y, float w, float h) {
  float w2 = width / 2;
  float h2 = height / 2;
  //waves.add(new Wave(1, height / 4, 4, 0.01, 0, 0, width, height));
  waves.add( new Wave(1, height/8, 4, 0.01, 0, 0, w2,h2));
  waves.add( new Wave(2, height/8, 4, 0.01, w2, 0, w2,h2));
  waves.add( new Wave(3, height/8, 4, 0.01, 0, h2, w2,h2));
  waves.add( new Wave(4, height/8, 4, 0.01, w2,h2,w2,h2));
  //wave.calcWave();
  //noLoop();
}

void draw() {
  background(255);


  for (Wave wave : waves) {
    wave.draw();
  }
  fill(0);
  text(int(millis() / 1000.0), 10, 10);
}