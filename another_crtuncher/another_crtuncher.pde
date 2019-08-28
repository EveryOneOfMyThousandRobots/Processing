PImage img;
PImage output;
boolean clicked = false;
void settings() {
  img = loadImage("002.jpg");
  size(img.width, img.height);
}

void setup() {
  output = img.copy();//crunch(img);
}

void draw() {
  background(0);
  if (clicked) {
    output = crunch(output);
    clicked = false;
  }
  image(output, 0, 0);
  //stop();
}

void mouseReleased() {
  clicked = !clicked;
}
