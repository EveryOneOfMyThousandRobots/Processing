import processing.sound.*;

Pulse pulse;

double time = 0;
double time_last = 0;
double ns = 1000000000 / 30;


class W {
  float a, r, f;
  
  
  W(float r, float f) {
    a = 0;
    this.r = r;
    this.f = f;
  }
  
  void update() {
    
   // double t = System.nanoTime();
    double delta = (time - time_last) / ns;
    a += f * delta;
    if (a >= TWO_PI) {
      a -= TWO_PI;
    }
  }
}

ArrayList<W> waves = new ArrayList<W>();

float x = 0;
void setup() {
  size(400,400);
  time = System.nanoTime();
  time_last = time;
  waves.add(new W(height / 8, 440));
  waves.add(new W(height / 8, 880));
  pulse = new Pulse(this);
}

void draw() {
  pulse.stop();
  noStroke();
  fill(255,255,255,2);
  rect(0,0,width,height);
  time = System.nanoTime();
  float y = height / 2;
  
  for (W w : waves) {
    w.update();
    y += w.r * sin(w.a);
  }
  pulse.width(0.5);
  pulse.freq(y);
  pulse.play();
  
  stroke(0);
  fill(0);
  ellipse(x, y, 2, 2);
  x += 2;
  if (x >= width) {
    x = 0;
  }
  
  time_last = time;
  
}