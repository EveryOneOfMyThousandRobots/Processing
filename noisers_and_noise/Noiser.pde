final float MIN_RAD = 0.01;
final float MAX_RAD = 0.03;
float snap = 100;

class NoiseComponent {
  float xc, yc;
  float a, r;
  float x, y, z;
  float v;
  float as;

  NoiseComponent() {
    xc = random(0, 10);
    yc = random(0, 10);
    z = random(0, 10);
    r = random(MIN_RAD, MAX_RAD);
    as = random(TWO_PI);
    
  }

  void update() {

    float amt = (float)frame / (float) TOTAL_FRAMES;
    a = as + (TWO_PI * amt);

    x = xc + r * cos(a);
    y = yc + r * sin(a);



    v = noise(x, y, z);
    
  }
}

class Noiser {
  float v = 0;
  NoiseComponent[] components;

  Noiser(int numComponents) {
    components = new NoiseComponent[numComponents];
    
    for (int i = 0; i < components.length; i += 1) {
      components[i] = new NoiseComponent();
    }

  }

  void update() {
    v = 0;
    for (NoiseComponent n : components) {
      n.update();
      v += n.v;
    }
    v %= 1.0;


    if (v >= 0.25 && v <= 0.75) {
    }
  }
}
