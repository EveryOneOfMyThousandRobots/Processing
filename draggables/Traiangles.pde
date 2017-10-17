class Triangle {
  Node A, B, C;
  PVector AB, BA, BC, CB, AC, CA;

  PVector ABp, BCp, CAp;
  float mABC, mBCA, mCAB;

  Triangle(Node A, Node B, Node C) {
    this.A = A;
    this.B = B;
    this.C = C;
    update();
  }

  void update() {
    AB = new PVector(B.x, B.y).sub(A.x, A.y);
    AC = new PVector(C.x, C.y).sub(A.x, A.y);
    BC = new PVector(C.x, C.y).sub(B.x, B.y);
    BA = new PVector(A.x, A.y).sub(B.x, B.y);
    CA = new PVector(A.x, A.y).sub(C.x, C.y);
    CB = new PVector(B.x, B.y).sub(C.x, C.y);    

    mABC = PVector.angleBetween(BA, BC);
    mBCA = PVector.angleBetween(CA, CB);
    mCAB = PVector.angleBetween(AB, AC);
    
    PVector temp1 = AB.copy().normalize();
    PVector temp2 = AC.copy().normalize();
    ABp = PVector.fromAngle((temp1.mag() + temp1.mag()) / 2);
    ABp.mult(50);
    
    temp1 = BA.copy().normalize();
    temp2 = BC.copy().normalize();
    BCp = PVector.fromAngle((temp1.mag() + temp1.mag()) / 2);    
        
    temp1 = CA.copy().normalize();
    temp2 = CB.copy().normalize();
    CAp = PVector.fromAngle((temp1.mag() + temp1.mag()) / 2);   

    //ABp = PVector.fromAngle(mCAB + (mCAB / 2)).mult(50);
   // BCp = PVector.fromAngle(mABC + (mABC / 2)).mult(50);
    //CAp = PVector.fromAngle(mCAB + (mCAB / 2)).mult(50);
    
  }

  void drawV(float x, float y, PVector p, color c){
    stroke(c);
    line(x, y, x + p.x, y + p.y);
  }

  void drawV(float x, float y, PVector p) {
    drawV(x,y,p, color(255));
  }

  void draw() {

    stroke(255);
    noFill();
    line(A.x, A.y, B.x, B.y);
    line(A.x, A.y, C.x, C.y);
    line(C.x, C.y, B.x, B.y);
    A.draw();
    B.draw();
    C.draw();
    text("A:" + degrees(mCAB), A.x, A.y - 20);
    text("B:" + degrees(mABC), B.x - 20, B.y);
    text("C:" + degrees(mBCA), C.x + 20, C.y);

    drawV(A.x, A.y, AB);
    drawV(A.x, A.y, ABp, color(255,0,0));
    drawV(B.x, B.y, BC);
    drawV(B.x, B.y, BCp, color(255,0,0));
    drawV(A.x, A.y, AC);
    drawV(C.x, C.y, CAp, color(255,0,0));
  }
}