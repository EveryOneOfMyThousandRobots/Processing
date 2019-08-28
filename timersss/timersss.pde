float timeLast = 0;
float timeNow = 0;
float timeDelta = 0;
ArrayList<Timer> timers = new ArrayList<Timer>();
void setup() {
   
  size(400,400);
  
  int y = TIMER_HEIGHT;
  while (y < height-TIMER_HEIGHT) {
    
    Timer t = new Timer(10, y , width-20, random(1,20));
    timers.add(t);
    y += (2 * TIMER_HEIGHT);
  }
}


void draw() {
  background(0);
  timeNow = millis(); //System.nanoTime() / 1000000;
  timeDelta = timeNow - timeLast;
  timeLast = timeNow;
  
  
  for (Timer t : timers) {
    t.update();
    t.draw();
  }
  
  
  
}
