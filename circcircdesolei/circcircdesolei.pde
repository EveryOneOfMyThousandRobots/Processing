Circ c;
void setup() {
  size(800,800);
  c = new Circ(width / 2, height / 2, width / 8);
  c.addChild(radians(3), c.radius * 0.5);
  c.child.addChild(radians(9), c.child.radius * 0.5);
  c.child.child.addChild(radians(12), c.child.child.radius * 0.5);
  background(0);
}

void draw() {
  //background(0);
  c.draw();
}