PVector m;
Crt c;
void setup() {
  size(800,800, P2D);
  c = new Crt();
  m = new PVector();
}

void draw() {
  background(255);
  c.update();
  c.draw();

}

void mouseClicked() {
  m.set(mouseX, mouseY);
  if (mouseButton == LEFT) {
  
  c.seek(m); }
  else {
    c.avoid(m);
  }
}