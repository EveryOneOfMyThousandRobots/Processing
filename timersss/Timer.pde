final int TIMER_HEIGHT = 20;
class Timer {
  PVector pos, dims;
  
  float time;
  float val;
  Timer(float x, float y, float w, float time) {
    pos = new PVector(x,y);
    dims = new PVector(w, TIMER_HEIGHT);
    
    this.time =time;

  }
  
  void update() {
    val += timeDelta / 1000;
    if (val > time) {
      val -= time;
    }
    
  }
  
  void draw() {
    noFill();
    stroke(255);
    rect(pos.x, pos.y, dims.x, dims.y, 7);
    
    fill(255);
    noStroke();
    rect(pos.x, pos.y, map(val, 0, time, 0, dims.x), dims.y, 7);
    //fill(0);
    //text(nfc(val,2), pos.x, pos.y + 10);
  }
}
