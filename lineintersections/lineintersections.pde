class L {
  PVector from, to;

  L() {
    from = new PVector(random(width), random(height));
    to = new PVector(random(width), random(height));
  }

  void draw() {
    stroke(0);
    line(from.x, from.y, to.x, to.y);
  }
}
PVector normal = null;
boolean intersects = false;
L l1, l2;
void setup() {
  size(300, 300);


  l1 = new L();
  l2 = new L();
}

void draw() {
  background(255);
  l1.draw();
  l2.draw();
  fill(0);
  text("intersects: " + intersects, 10, 10);
  if (normal != null) {
    stroke(255, 0, 0);
    line(l1.from.x, l1.from.y, l1.from.x + (normal.x * 10), l1.from.y + (normal.y * 10));
  }
}

void mousePressed() {
  l1 = new L();
  l2 = new L();

  PVector vec = PVector.sub(l2.from, l2.to);
  normal = new PVector(vec.y, -vec.x);
  normal.normalize();
  //println(normal);

  PVector v1 = PVector.sub(l1.from, l2.from);
  PVector v2 = PVector.sub(l1.to, l2.from);
  float proj1 = v1.dot(normal);
  float proj2 = v2.dot(normal);

  if ((proj1 > 0 && proj2 < 0)||(proj1< 0 && proj2 > 0 )) {
    intersects = true;
  } else {
    intersects = false;
  }
  
}

boolean intersects(PVector A1, PVector A2, PVector B1, PVector B2) {
    PVector vec = PVector.sub(B1, B2);
  normal = new PVector(vec.y, -vec.x);
  normal.normalize();
  //println(normal);

  PVector v1 = PVector.sub(A1, B1);
  PVector v2 = PVector.sub(A2, B1);
  float proj1 = v1.dot(normal);
  float proj2 = v2.dot(normal);

  if ((proj1 > 0 && proj2 < 0)||(proj1< 0 && proj2 > 0 )) {
    return true;
  } else {
    return false;
  }
  
}