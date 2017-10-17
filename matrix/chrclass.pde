class Chr {
  String value;
  
  int interval;
  int timer;
  
  Chr() {
    
    value = getRndChar();
    interval = floor(random(5,30));
    timer = 0;
  }
  
  void update() {
    timer += 1;
    if (timer > interval) {
      timer = 0;
      if (random(1) < 0.5) {
        value = getRndChar();
      }
    }
    
  }
  
  void draw(float x, float y) {
    noStroke();
    fill(0,255,100);
    text(value, x,y);
  }
  
  
  
}