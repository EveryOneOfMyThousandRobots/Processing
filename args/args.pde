boolean hasArgs = false;
void settings() {
  if (args != null) {
    hasArgs = true;
  }
}

void setup() {
  size(800, 800);
  noLoop();
}

void draw() {
  background(0);
  fill(255);
  int y = 10;
  if (hasArgs) {
    for (String s : args) {
      text(s, 10, y);
      y += 10;
    }
  }
}
