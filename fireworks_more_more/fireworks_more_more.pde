PGraphics img;
final int IMG_WIDTH = 200;
final int IMG_HEIGHT = 200;
final int WINDOW_WIDTH = 800;
final int WINDOW_HEIGHT = 800;


void settings() {
  size(WINDOW_HEIGHT, WINDOW_WIDTH);
}




void setup() {
  noSmooth();
  img = createGraphics(IMG_WIDTH, IMG_HEIGHT);
  colorMode(HSB);
  img.colorMode(HSB);
  img.noSmooth();
  
}


PVector GRAVITY = new PVector(0, 0.01);

void draw() {
  background(0);
  img.beginDraw();
  img.background(0);
  for (P p : prts) {
    p.applyForce(GRAVITY);
    p.update();
    p.draw();
  }
  img.endDraw();
  image(img, 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
  
  for (int i = prts.size()-1; i >= 0; i -= 1) {
    P p = prts.get(i);
    if (p.pos.x < 0 || p.pos.x > IMG_WIDTH || p.pos.y > IMG_HEIGHT) {
      prts.remove(i);
    }
  }
}


void makeP(float x, float y) {
  float xx = x / (WINDOW_WIDTH / IMG_WIDTH);
  float yy = y / (WINDOW_HEIGHT / IMG_HEIGHT);

  P p = new P(xx, yy);
  prts.add(p);
}

void mouseReleased() {
  for (int i = 0; i < 10; i += 1) {
    makeP(mouseX, mouseY);
  }
}
