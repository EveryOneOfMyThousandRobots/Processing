PVector pos, vel, acc;
float timeLast, timeNow;
float delta;
float ups, ups_display;
float ups_ms = 0;
float millisPerTick = 1000.0 / 30.0;
float freq = 4.0;
float width_over_freq = 0;
float angle = 0;
float amp;
float timesPerSecond = 2;

void setup() {
  size(400,400);
  pos = new PVector(0, height / 2);
  vel = new PVector(1,0);
  acc = new PVector(0,0);
  amp = height / 8;
  //frameRate(12);
  background(255);
  width_over_freq = width / freq;
  
}

void draw() {
  //background(255);
  noStroke();
  fill(255,25);
  rect(0,0,width, height);
  fill(255);
  rect(0,0,width,50);
  stroke(0);
  fill(0);
  timeNow = millis();
  delta = (timeNow - timeLast);// / millisPerTick;
  ups_ms += (timeNow - timeLast);
  //float dist = width * delta;
  //float time = 1000.0 * delta;
  float speed = (width / (timesPerSecond * 1000.0)) * delta;
  pos.add(PVector.mult(vel, speed));
  angle = TWO_PI * ((pos.x % width_over_freq) / width_over_freq);
  float y = sin(angle);
  
  
  
  
  
  
  ellipse(pos.x, pos.y + (y * amp), 3,3);
  pos.x = pos.x % width;
  //text(delta,10,10);
  
  
  timeLast = timeNow;
  ups += 1;
  if (ups_ms > 1000) {
    ups_ms = 0;
    ups_display = ups;
    ups = 0;
  }
  text(int(ups_display) + " s: " + int(millis() / 1000.0), 10, 30);
  
}