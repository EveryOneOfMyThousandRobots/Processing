long time_last = System.nanoTime();
long time_now  = 0;
long time_delta = 0;
long time_last_fps_time = 0;
double delta = 0;
final double TARGET_FPS = 60;
final double TIME_FACTOR = 1000000000;
final double OPTIMAL_TIME = TIME_FACTOR / TARGET_FPS;


void setup(){
  size(400,400);
}


void draw() {
  background(0);
  time_now = System.nanoTime();
  time_delta = (time_now - time_last) / 1000000;
  delta = (float) (time_delta / OPTIMAL_TIME);
  
  time_last_fps_time += time_delta;
  
  if (time_last_fps_time >= TIME_FACTOR) {
    time_last_fps_time -= TIME_FACTOR;
  }
  
  
  text("now:       "+time_now, 10,10);
  text("last:      "+time_last, 10,20);
  text("delta:     "+time_delta, 10,30);
  text("delta:     "+(delta/TIME_FACTOR), 10,40);
  text("time accum:"+ (float)time_last_fps_time/1000.0, 10, 50);
  text("time:      " + (float)millis()/1000.0, 10, 60);
  
  time_last = time_now;
  
}
