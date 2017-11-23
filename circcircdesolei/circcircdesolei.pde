Circ c;
void setup() {
  size(800,800);
  c = new Circ(width / 2, height / 2, width / 8);
  c.addChild(radians(4), c.radius * 0.8);
  c.child.addChild(radians(8), c.child.radius * 0.8);
  c.child.child.addChild(radians(12), c.child.child.radius * 0.8);
  background(0);
}

void draw() {
  //background(0);
  c.draw();
}