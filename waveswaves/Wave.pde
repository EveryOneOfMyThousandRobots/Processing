class Wave {
  float freq;
  float width_over_freq;
  float amp;
  float angle;
  float x;
  float prevX;
  float y;
  float prevY;
  float speed;
  float h2;
  final float secs_to_cross_screen; 
  final float ms_to_cross_screen;


  Wave(float freq, float amp) {
    width_over_freq = width / freq;
    this.freq = freq;
    this.amp = amp;
    secs_to_cross_screen = 4.0;
    ms_to_cross_screen = secs_to_cross_screen * 1000.0;
    h2 = height / 2;
    
  }

  void update(float delta) {
    speed = (width / ms_to_cross_screen) * delta;
    prevX = x;
    x += speed;
    if (x > width) {
      x -= width;
      prevX = 0;
    }
    angle = TWO_PI * ((x % width_over_freq) / width_over_freq);

    prevY = y;

    y = (sin(angle) * amp);
  }

  void draw() {
    stroke(0);
    fill(0);
    line(prevX, h2 + prevY, x, h2 + y);
  }
}