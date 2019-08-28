ArrayList<SF> flakes = new ArrayList<SF>();

void setup() {
  size(800, 800);
  for (int i = 0; i < 10; i += 1) {
    flakes.add(new SF(random(width), -100));
  }
  //noLoop();
}

void draw() {
  background(0);
  //translate(width / 2, height / 2);
  for (SF sf : flakes) {
    //image(sf.img, 0,0);
    sf.draw();
    sf.update();
    //println(sf);
  }

  int removed = 0;
  for (int i = flakes.size() - 1; i >= 0; i -= 1) {
    SF s = flakes.get(i);
    if (s.pos.y > height + s.size) {
      flakes.remove(i);
      removed += 1;
    }
  }

  for (int i = 0; i < removed; i += 1) {
    flakes.add(new SF(random(width), -100));
  }
}
