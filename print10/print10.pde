int x = 0;
int y = 0;
int spacing = 20;
void setup() {
  size(400, 400);
  bg();
  frameRate(100);
  textFont(createFont("Consolas", spacing));
  stroke(30, 255, 100);
  fill(30, 255, 100);
}

void bg() {
  background(0, 51, 14);
}

String string = "WELCOME TO BASIL";
int counter = 0;
void draw() {

  for (int i = 0; i < 4; i += 1) {
    boolean drawLine = true;

    if (y >= height / 2 && y < height / 2 + spacing && counter < string.length()) {
      if (x >= (width / 2) - ((string.length() / 2) * spacing)) {
        String c = str(string.charAt(counter));
        counter += 1;
        text(c, x, y+spacing-3);
        drawLine = false;
      }
    }

    if (drawLine) {
      if (random(1) < 0.5) {
        line(x, y, x + spacing, y + spacing);
      } else {
        line(x, y + spacing, x + spacing, y);
      }
    }

    saveFrame("/frames/####.tiff");
    x += spacing;
    if (x >= width) {
      x = 0;
      y += spacing;
      counter = 0;
    }
    if (y >= height) {
      stop();
      //bg();
      //x = 0;
      //y = 0;
      //counter = 0;
    }
  }
}