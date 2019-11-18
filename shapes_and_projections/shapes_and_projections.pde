
Shape shape;
void setup() {
  size(400,400);
  shape = new Shape(3,width/2,height/2,width/8);
  shape.project();
  shape.update();
}


void draw() {
  background(0);
  shape.draw();
}
