ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<PVector> Apoints = new ArrayList<PVector>();
ArrayList<PVector> Bpoints = new ArrayList<PVector>();


void setup() {
  size(400, 400);
  
}

void calcPath() {
  float angle = random(TWO_PI);
  float angle2 = random(TWO_PI);


  for (int i = 0; i < points.size()-1; i += 1) {
    PVector p = points.get(i);
    PVector q = points.get(i+1);

    for (float t = 0; t < 1; t += 0.1) {
      PVector f = PVector.sub(q,p);
      
      PVector tt = f.copy();
      f.mult(t);
      
      
      angle += radians(random(4));
      angle2 += radians(random(3));


      PVector A = tt.copy();
      PVector B = tt.copy(); 
      A.set(-A.y, A.x);
      B.set(-B.y, B.x);
      B.mult(-1);

      A.mult(3f * sin(angle));
      B.mult(4f * cos(angle2));
      
      A.add(p);
      A.add(f);
      
      
      Apoints.add(A);
      B.add(p);
      A.add(f);
      
      Bpoints.add(B);
    }
  }
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  //for(PVector p : points) {
  //  ellipse(p.x, p.y, 5, 5); 
  //}
  for (int i = 0; i < Apoints.size(); i += 1) {
    PVector A = Apoints.get(i);
    PVector B = Bpoints.get(i);

    line(A.x, A.y, B.x, B.y);
  }
}


void mouseClicked() {
  PVector m = new PVector(mouseX, mouseY);
  points.add(m);
  calcPath();
}
