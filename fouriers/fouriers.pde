PVector wBoxPos, wBoxDims, wBoxMid;
float secWidth;
float timeLast = 0;
float timeNow = 0;
float delta = 0;

float wStep = 0;
float freq = 4;
float freqStep = 0;

float msPerTick = 1000.0 / 60;


void setup() {
  size(600,800);
  
  wBoxPos = new PVector(0,0);
  wBoxDims = new PVector(width, 200);
  wBoxMid = new PVector(wBoxPos.x + (wBoxDims.x / 2), wBoxPos.y + (wBoxDims.y / 2));
  secWidth = wBoxDims.x / 10;
  
  timeLast = millis();
  timeNow = millis();
  //frameRate(2);
  background(255);
}

void draw() {
  timeNow = millis();
  delta = (timeNow - timeLast) / msPerTick;
  wStep += (1000 / secWidth) * delta;
  wStep = wStep % width;
  //background(255);
  stroke(0);
  line(wBoxPos.x, wBoxMid.y, wBoxDims.x, wBoxMid.y);
  noFill();
  rect(wBoxPos.x, wBoxPos.y, wBoxDims.x, wBoxDims.y);
  
  for (float x = wBoxPos.x; x < wBoxDims.x; x += secWidth) {
    line(x, wBoxDims.y, x, wBoxPos.y);
    
  }
  
  wStep += delta;
  float y = sin(freqStep) * wBoxDims.y;
  ellipse(wStep, wBoxMid.y + y, 4, 4);
  
  freqStep += freq;
  timeLast = timeNow;
  fill(0);
  text(millis() / 1000, 10, 10);
  
}