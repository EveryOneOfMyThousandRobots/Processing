
final float RAD = 40;
final float WH = RAD * 2;
ArrayList<Circ> circs = new ArrayList<Circ>();
float I_INC = 0.2;

void settings() {
  size(floor(RAD*16),floor(RAD*16));
}
void setup() {
  colorMode(HSB);
  
  float i = 1;
  ArrayList<Circ> top = new ArrayList<Circ>();
  ArrayList<Circ> down = new ArrayList<Circ>();
  for (int x = (int)WH; x < width; x += WH) {
    Circ c = new Circ(null, null, x, 0, radians(i));
    c.top = true;
    circs.add(c);
    top.add(c);
    i += I_INC;
  }
  i = 1;
  for (int y = (int)WH; y < height; y += WH) {
    Circ c = new Circ(null, null, 0, y, radians(i));
    c.down = false;
    circs.add(c);
    down.add(c);
    i += I_INC;
  }
  //float x = WH;
  //float y = WH;
  for (Circ t : top ) {
    //x = WH;
    //y = WH;
    for (Circ d : down) {
      Circ c = new Circ(t,d,t.pos.x,d.pos.y,0);
      circs.add(c);
    }
  }
}

void draw() {
  background(0);
  for (Circ c : circs) {
    c.update();
    c.draw();
  }
  //saveFrame("data/frames/f####.png");
}
