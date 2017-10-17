PVector c;
void setup() {
  size(300,300);
  c = new PVector(width / 2, height / 2);
}

void draw() {
  background(0);
  stroke(255);
  fill(255);
  PVector m = new PVector(mouseX, mouseY);
  PVector mm = PVector.sub(c, m);
  line(c.x, c.y, m.x, m.y);
  float h =mm.heading();
  text(degrees(h), 10,10);
  PVector p = PVector.fromAngle(h);
  p.mult(20);
  line(c.x, c.y - 50, c.x + p.x, c.y + p.y);
  
}