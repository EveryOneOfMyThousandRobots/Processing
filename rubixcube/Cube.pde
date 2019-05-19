final int SIDE_LENGTH = 50;

class Cubie {
  PVector pos;

  Cubie(float x, float y, float z) {
    this.pos = new PVector(x, y, z);
  }


  void draw() {
    pushMatrix();
    fill(255);
    stroke(0);
    translate(pos.x, pos.y, pos.z);
    float r = SIDE_LENGTH / 2;
    float a = -r;
    float b = r;
    beginShape(QUADS);
    //fixed z
    //face 1
    fill(colours[BCK]);
    vertex(a, a, a);
    vertex(b, a, a);
    vertex(b, b, a);
    vertex(a, b, a);
    //face 2
    fill(colours[FRN]);
    vertex(a, a, b);
    vertex(b, a, b);
    vertex(b, b, b);
    vertex(a, b, b);

    //fixed x
    //face 3
    fill(colours[LFT]);
    //fill(0,255,0);
    vertex(a, a, a);
    vertex(a, b, a);
    vertex(a, b, b);
    vertex(a, a, b);
    //face 4
    fill(colours[RGT]);
    vertex(b, a, a);
    vertex(b, b, a);
    vertex(b, b, b);
    vertex(b, a, b);

    //fixed y
    //face 5 
    fill(colours[DWN]);
    vertex(a, a, a);
    vertex(b, a, a);
    vertex(b, a, b);
    vertex(a, a, b);
    //face 6
    fill(colours[UPP]);
    vertex(a, b, a);
    vertex(b, b, a);
    vertex(b, b, b);
    vertex(a, b, b);



    endShape();
    popMatrix();
  }
}
