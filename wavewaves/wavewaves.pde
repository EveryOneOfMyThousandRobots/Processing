float cx, cy;
float f1;
float f2;
float r;
float a;
float a1;
float a2;
float x, y, lx, ly;

class Wave {
  float a, amp, r, f;

  Wave(float amp, float f ) {
    this.amp = amp;
    this.f = f;
    a = 0;
  }
  void update() {
    a += f;
    if (a > TWO_PI) {
      a -= TWO_PI;
    }
  }


}

ArrayList<Wave> waves = new ArrayList<Wave>();

void setup() {
  size(500, 500);
  cx = width / 2;
  cy = height / 2;
  r = width / 4;
  a = 0;
  a1 = 0;
  f1 = 0.1;
  a2 = PI;
  f2 = 0.7;
  lx = cx;
  ly = cy;
  background(0);
  stroke(255);
  float amp = width / 8;
  waves.add(new Wave(amp *2,    0.1));
  waves.add(new Wave(amp,       0.9));
  //waves.add(new Wave(0, 4));
  //waves.add(new Wave(0, 8));
}

void draw() {

  r = 0;
  //r = (width / 8);// + ((width / 8) * sin(a1)) + ((width / 8) * sin(a2)); 
  for (Wave wave : waves) {
    r += wave.amp * sin(wave.a);
    wave.update();
  }
  x = cx + r * cos(a);
  y = cy + r * sin(a);
  
  line(lx, ly, x,y);
  lx = x;
  ly = y;

  

  a += radians(1);
  if (a > TWO_PI) {
    a -= TWO_PI;
  }
  
  a1 += f1;
  a2 += f2;

}