MC mc;
int num = 200;
float mult = 2;
void setup() {
  size(500, 500);
  mc = new MC(mult, num);
  background(0);
}


float r, g, b;
float rd = 3, gd = 1.5, bd = 2.7;
void draw() {
  fill(0,15);
  rect(0,0,width,height);
  noFill();

  //if ((r + rd) > 128 || r + rd < 0) {
  //  rd *= -1;
  //}

  //if ((g + gd) > 128 || g + gd < 0) {
  //  rd *= -1;
  //}

  //if ((b + bd) > 128 || b + bd < 0) {
  //  rd *= -1;
  //}


  //r += rd;
  //g += gd;
  //b += bd;


  //stroke(128 + r, 128 + g, 128 + b);
 // ellipse(width / 2, height/ 2, width - 20, height - 20);

  mc.draw();

  //num += 1;
  mult += 0.01;
  mc = new MC(mult, num);
  fill(0);
  //text(mult + "," + num, 10, 10);
}