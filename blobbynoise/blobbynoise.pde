float totalFrames = 120;
float counter = 0;
boolean record = false;
float noiseMax = 2;
float phase = 0;
void setup() {
  size(600, 600);
  //noLoop();
}
float xo, yo, zo, za, angle;
float p;
void draw () {
  if (record) {
    counter += 1;
  } else {
    counter = frameCount % totalFrames;
  }
  p = counter / totalFrames;
  render(p);

  if (record) {
    if (counter > totalFrames) {
      exit();
    } else {
      saveFrame("output/f####.png");
    }
  }
}


void render(float percent) {

  angle = TWO_PI * percent;

  background(0);
  float x, y, r = 0;
  stroke(255);
  noFill();

  translate(width / 2, height / 2);
  beginShape();
  for (float a = 0; a < TWO_PI; a += radians(0.1)) {
    xo = map(cos(a), -1, 1, 0, noiseMax);
    yo = map(sin(a), -1, 1, 0, noiseMax); 
    r = map(noise(xo, yo, zo), 0, 1, width / 8, width / 3); 
    x = r * cos(a);
    y = r * sin(a);


    vertex(x, y);
  }
  phase=0;// = TWO_PI * percent * 0.1;
  endShape(CLOSE);
  zo = map(abs(percent-0.5), -0.5, 0.5, 0, 1);
}
