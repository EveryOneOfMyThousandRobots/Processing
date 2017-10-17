Node dragging = null;
Triangle tri = null;
//Node A, B, C;
void setup () {
  size(400, 400);
  for (int  i = 0; i < 3; i++) {
    nodes.add(new Node((int)random(width), (int)random(height), 10, 10));
  }
 tri = new Triangle(nodes.get(0), nodes.get(1), nodes.get(2));
}

void draw() {
  background(0);
 
  tri.draw();
}



void mousePressed() {
  println("pressed");
  if (dragging != null) {
    dragging.dragging = false;
    dragging = null;
  }
  Node n = overNode(mouseX, mouseY); 
  if (n != null) {
    dragging = n;
    dragging.dragging = true;
  }
}

void mouseDragged() {
// println("dragged");
  if (dragging != null) {
    dragging.x = mouseX;
    dragging.y = mouseY;
  }
}

void mouseReleased() {
  println("released");
  if (dragging != null) {
    dragging.dragging = false;
    dragging = null;
  }
  tri.update();
  
  
}