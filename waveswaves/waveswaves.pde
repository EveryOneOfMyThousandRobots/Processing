ArrayList<Wave> waves = new ArrayList<Wave>();
float timeLast, timeNow, delta;
Wave sumWave;
void setup() {
  size(720, 360);
  waves.add(new Wave(10, width/16));
  waves.add(new Wave(11, width / 16));
  waves.add(new Wave(12, width / 16));
  waves.add(new Wave(13, width / 16));
  sumWave = new Wave(3, width / 8);
  background(255);
}



void draw() {
  noStroke();
  fill(255, 10);
  rect(0, 0, width, height);
  timeNow = millis();
  delta = timeNow - timeLast;
  timeLast = timeNow;
  sumWave.update(delta);
  sumWave.y = 0;
  for (Wave wave : waves) {
    wave.update(delta);
    //wave.draw();
    sumWave.y += wave.y;
  }
  sumWave.draw();
  
}