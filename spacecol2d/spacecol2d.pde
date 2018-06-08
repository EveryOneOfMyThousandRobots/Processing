Tree tree;
void setup() {
  size(500,500);
  tree = new Tree();
}


void draw() {
  background(51);
  tree.draw();
  tree.grow();
  tree.update();
}
