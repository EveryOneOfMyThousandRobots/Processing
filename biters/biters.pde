PImage bg;
ArrayList<Biter> biters = new ArrayList<Biter>();
final int START_NUM_BITERS = 10;
void settings() {
  bg = loadImage("creatures.jpg");
  size(bg.width, bg.height);
}

void setup() {
  while (biters.size() < START_NUM_BITERS) {
    biters.add(new Biter());
  }
  
}


void draw() {
  background(0);
  image(bg, 0, 0);
  
  for (Biter b : biters) {
    b.move();
    b.update();
    b.draw();
  }
}
