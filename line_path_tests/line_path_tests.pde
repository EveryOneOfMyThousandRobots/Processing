ArrayList<PVector> points = new ArrayList<PVector>();
void setup() {
  size(300, 300);
  //for (float a = 0; a < TWO_PI; a += radians(10)) {
  //  float x = (width / 2) + (width / 4) * cos(a);
  //  float y = (height / 2) + (width / 4) * sin(a);

    
  //}
}

void draw() {
  background(0);
  stroke(255,16);
  

  for (int i = 0; i < points.size()-1; i += 1) {
    PVector A = points.get(i);
    PVector B = points.get(i+1);
    PVector C = PVector.sub(B, A);
    for (float t = 0; t < 1; t += 1 / C.mag()) {
      C = PVector.sub(B, A);
      C.mult(t);
      PVector D = C.copy();
      D.normalize();
      D.set(-D.y, D.x);
      PVector E = D.copy().mult(-1);
      D.mult(10);
      E.mult(10);


      C.add(A);
      D.add(C);
      E.add(C);


      line(C.x, C.y, D.x, D.y);
      line(C.x, C.y, E.x, E.y);

    }
  }
}

void mouseClicked() {
  points.add(new PVector(mouseX, mouseY));
  
}
