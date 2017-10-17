Segment head;
//Segment tail;
PVector mouse;

void setup() {
  size(600, 400, P2D);
  head = new Segment(width / 2, height / 2, 0, width / 8);
  Segment current = head;
  for (int i =0; i < 3; i += 1) {
    Segment next = new Segment(current, 0, width / 8);
    current.child = next;
    current = next;
    
  }
  head = current;
  mouse = new PVector();
}

void draw() {
  mouse.set(mouseX, mouseY);
  background(51);
  //Segment prev = null;
  head.follow(mouseX, mouseY);
  head.update();
  head.draw();
  Segment next = head.parent;
  next.follow(mouseX, mouseY);
  while (next !=null) {
    next.follow();
    next.update();
    next.draw();
    
    next = next.parent;
  }
  //seg1.follow(mouse.x, mouse.y);
  //seg2.follow(seg1.a.x, seg2.a.y);
//  seg2.follow(mouse.x, mouse.y);
//  seg1.follow(seg2.a.x, seg2.a.y);
//  seg1.update();
//  seg2.update();

//  seg1.draw();
//  seg2.draw();
//}

}