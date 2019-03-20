PVector A, B;

void setup() {
  size(600,600);
  A = new PVector(width / 4, height / 4);
  B = new PVector(width * 0.75, height * 0.75);
  
  
}

void draw() {
  background(0);
  drp(A, "A");
  drp(B, "B");
  
  PVector L = PVector.sub(B,A);
  float dist = PVector.dist(A,B);
  L.normalize();
  PVector Lp = PVector.fromAngle(L.heading());
  Lp.mult(dist * 0.1);
  PVector Lpp = PVector.add(A, Lp);//.mult(dist * 0.1);
  
  
  PVector N = PVector.sub(A,B);
  N.normalize();
  PVector Np = PVector.fromAngle(N.heading());
  Np.mult(dist * 0.1);
  PVector Npp = PVector.add(B, Np);
  //Npp.mult(1.1);
  
  //L.mult(dist * 0.9);
  //L.add(A);
  drp(L, "L");
  drp(Lp, "Lp");
  drp(Lpp, "Lpp");
  drp(Npp, "Npp");
  //drln(A,B);
  //drln(A,L);
  //drln(A,Lp);
  drln(Lpp, Npp);
  
  noLoop();
}


void drp(PVector a, String name) {
  stroke(255);
  noFill();
  ellipse(a.x, a.y, 4, 4);
  text(name, a.x + 10, a.y);
  println(name + " (" + int(a.x) + "," + int(a.y) + ")");
}

void drln(PVector a, PVector b) {
  stroke(255);
  line(a.x, a.y, b.x, b.y);
}
