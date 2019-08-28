ArrayList<Slider> sliders = new ArrayList<Slider>();
final int SLIDER_HEIGHT = 20;
final int HOLDER_HEIGHT = SLIDER_HEIGHT;
final int HOLDER_WIDTH  = SLIDER_HEIGHT;
int SLIDER_WIDTH;
float r;
PGraphics bx;
void setup() {
  size(400, 400, P3D);
  SLIDER_WIDTH = width;
  r = width / 2;

  sliders.add(new Slider(0, height-SLIDER_HEIGHT, SLIDER_WIDTH, SLIDER_HEIGHT, 0, TWO_PI));
  sliders.add(new Slider(0, height-(SLIDER_HEIGHT*2), SLIDER_WIDTH, SLIDER_HEIGHT, 0, TWO_PI));
  bx = createGraphics(width,height, P3D);
  bx.beginDraw();
  bx.background(0);
  bx.endDraw();
}

 

 

void draw() {
  background(0);

  float a1 = sliders.get(0).getValue()+HALF_PI;
  float a2 = sliders.get(1).getValue();

  float px = r * sin(a1) * cos(a2);
  float py = r * sin(a1) * sin(a2);
  float pz = r * cos(a1);
  bx.beginDraw();
  bx.pushMatrix();
  bx.translate(width / 2, height / 2, -100);
  bx.translate(px, py, pz);
  
  bx.box(10);
  bx.popMatrix();
  bx.endDraw();
  image(bx, 0, 0);
  for (Slider s : sliders) {
    s.draw();
  }
}



void mouseClicked() {
  for (Slider s : sliders) {
    s.clicked(mouseX, mouseY);
  }
}

void mouseDragged() {
  for (Slider s : sliders) {
    s.clicked(mouseX, mouseY);
  }
}

class Slider {
  PVector pos, dims;
  float low, high;
  private float current = 0.5;

  float getValue() {
    return map(current, 0, 1, low, high);
  }

  Slider(float x, float y, float w, float h, float low, float high) {
    pos = new PVector(x, y);
    dims = new PVector(w, h);
    this.low = low;
    this.high = high;
  }

  void draw() {
    noStroke();
    fill(255, 64);
    float x = map(current, 0, 1, pos.x, pos.x + dims.x - HOLDER_WIDTH);

    rect(pos.x, pos.y, dims.x, dims.y);
    fill(255, 128);
    rect(x, pos.y, HOLDER_WIDTH, HOLDER_HEIGHT);
  }

  void clicked(float x, float y) {
    if (x > pos.x && x < pos.x + dims.x && y > pos.y && y <pos.y + dims.y) {
      current = map(x, pos.x, pos.x + dims.x, 0, 1);
    }
  }
}
