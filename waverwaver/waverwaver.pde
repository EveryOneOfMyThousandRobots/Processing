float freq, angle, timeSpan;
float timeLast, timeNow, delta;
float x,y;
float px, py;
float secWidth;
float freqWidth;
float seconds = 1;
float ms;

PGraphics graph;

void setup() {
  size(600,600);
  secWidth = width / seconds; 
  background(255);
  freq = 3;
  freqWidth = secWidth / freq;
  ms = seconds * 1000.0;
  graph = createGraphics(width, height);
  y = height / 2;
  py = height / 2;
  px = 0;
  frameRate(1000);
}


void draw() {
  timeNow = millis();
  delta = timeNow - timeLast;
  timeLast = timeNow;
  
  background(255);
  stroke(0);
  fill(0);
  float speed = (width / ms) * delta;
  angle = TWO_PI * ((x % freqWidth) / freqWidth);
  
  py = y;
  y = (height / 2) + (sin(angle) * (height / 8));
  px = x;
  x += speed;
  if (x > width) {
    x -= width;
    px = 0;
    graph.clear();
  }
  graph.beginDraw();
  graph.line(px, py, x, y);
  
  graph.endDraw();
  //ellipse(x,y, 4,4);
  text(int(timeNow / 1000) + "sec", 10, 10);
  
  for (int i = 0; i < seconds; i += 1) {
    line(secWidth * i, 0, secWidth * i, height);
  }
  image(graph,0,0);
  
  
  
}