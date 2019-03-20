long delta = 0;
long lastTime = 0, timeNow = 0;
long deltaSum = 0;

Map map;
void setup() {
  size(800,800);
  map = new Map();
}


void draw() {
  timeNow = millis();
  delta = timeNow - lastTime;
  deltaSum += delta;
  lastTime = timeNow;
  
  if (deltaSum > 1000) {
    deltaSum -= 1000;
    map.generate();
  }
  background(0);
  //map.generate();
  map.draw();
}


//void mouseClicked() {
//  map.generate();
//}
