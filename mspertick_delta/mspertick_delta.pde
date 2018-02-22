float timeNow, timeLast, dist, time, speed;
float delta = 0;
float msPerTick = 1000.0 / 30;
float x = 0;
int secs = 0;
void setup() {
  size(500, 500);
  dist = width;
  time = msPerTick;
  speed = dist / time;
  frameRate(60);
  timeNow = millis();
  timeLast = millis();
}

void draw() {
  background(255);
  timeNow  = millis();

  delta = (timeNow - timeLast) / msPerTick;

  timeLast = timeNow;
  fill(0);
  //text(delta, 10, 10);
  while (delta > 1) {
    //dist = width - x;
    //time = 1000;// - timeNow;
    x += speed * delta;
    delta -= 1;
  }

  x = x % width;

  ellipse(x, height/ 2, 4, 4);
  if (frameCount % 30 == 0) {
    secs = floor(millis() / 1000.0);
  }
  
  text(secs, 10,10);
}