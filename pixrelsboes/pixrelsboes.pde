Field f;
void setup() {
  size(300,300, P3D);
  f = new Field(width, height, 4, 4);
}

void draw() {
  f.draw();
}