class Wave {

  float angle, inc, amp;

  Wave() {
  }

  void update(float deltaTime) {
  }
}

long last_time = System.nanoTime(); 
long now_time;
long delta_time;
float delta_time_accum = 0;
float display_delta_time;
float fDeltaTime;

void setup() {
  size(600, 400);
}

void draw() {
  now_time = System.nanoTime();
  delta_time = (int) ((now_time - last_time) / 1000000);
  last_time = now_time;
  fDeltaTime = (float)delta_time * (1f / 60f);
  
  
  delta_time_accum += fDeltaTime;
  
  background(0);
  if (delta_time_accum > 1) {
    display_delta_time = delta_time;
    delta_time_accum = 0;
  }
  
  fill(255);
  text(display_delta_time + " " + nfc(fDeltaTime, 2), 10,10);
}
