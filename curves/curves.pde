

ArrayList<Curve> curves = new ArrayList<Curve>();
void setup() {
  size(800, 800);
  int num = 8;
  float w = width / num;
  float h = height / num;


  for (float x = 0; x < num; x += 1) {
    float xpos = x * w;
    float xx = x+1;
    for (float y = 0; y < num; y += 1) {
      float ypos = y * h;
      float yy = y + 1;
      Curve c = new Curve(xpos, ypos, w, h, xx, yy);
      curves.add(c);
    }
  }

  //curves.add(new Curve(0,0,width, height, 1, 2));
}

void draw() {
  background(0);
  for (Curve c : curves) {
    c.update();
    c.draw();
    image(c.image, c.pos.x, c.pos.y);
  }
}

void mouseReleased() {
  for (Curve c : curves) {
    
    c.clear();
  }
}
