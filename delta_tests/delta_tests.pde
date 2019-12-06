long lastFPSTime = 0;
long time_last = System.nanoTime();
int fps = 0;
final int TARGET_FPS = 60;
final int OPTIMAL_TIME = 1000000000 / TARGET_FPS;
PVector pos = new PVector();
void setup() {
  size(400, 400);
}



float displayDelta = 0;
int displayFPS = 0;
void draw() {
  background(0);
  long now = System.nanoTime();
  long updateLength = now - time_last;

  time_last = now;
  float delta = updateLength / (float)OPTIMAL_TIME;

  lastFPSTime += updateLength;

  fps += 1;

  if (lastFPSTime > 1000000000) {
    //println("fps: " + fps + "\nsecs: " + floor(millis()/1000));
    lastFPSTime = 0;
    displayFPS = fps;
    fps = 0;
    displayDelta = delta;
  }
  
  text("fps " + displayFPS, 10, 10);
  text("delta " + displayDelta, 10, 20);
  text("millis " + millis(), 10 ,30);
  
  
  //end
  long remaining = time_last - System.nanoTime() + OPTIMAL_TIME;
  println(remaining);
  if (remaining > 0) {
    try {
      Thread.sleep(remaining/1000000);
    }
    catch (Exception e) {
    };
  }
  //while (remaining > 0) {
  //  //remaining -= ;
  //}
}
