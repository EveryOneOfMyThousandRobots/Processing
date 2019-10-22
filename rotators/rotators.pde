float R;
float R_2;
ArrayList<Circ> top = new ArrayList<Circ>();
ArrayList<Circ> left = new ArrayList<Circ>();
ArrayList<Circ> middle = new ArrayList<Circ>();

final int MAX_POINTS = 200;
void setup() {
  size(800, 800);
  R = width / 8;
  R_2 = R / 2;
  float i = 0.5;
  float s = TWO_PI / 360;
  for (float x = R+R_2; x < width; x += R) {

    top.add(new Circ(x, R_2, i*s));
    i += 0.5 + log(i);
  }
  i = 0.5;
  for (float y = R+R_2; y < height; y += R) {
    left.add(new Circ(R_2, y, i*s));
    i += random(0.5,1.5);
  }

  for (Circ t : top) {
    for (Circ l : left) {
      middle.add(new Circ(t, l));
    }
  }
}


void draw() {
  background(51);
  for (Circ c : top) {
    c.update();
    c.draw();
  }

  for (Circ c : left) {
    c.update();
    c.draw();
  }

  for (Circ c : middle) {
    c.update();
    c.draw();
  }
}
