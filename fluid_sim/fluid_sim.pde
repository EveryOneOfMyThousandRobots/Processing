
int CX, CY;
Fluid fluid;
float time = 0;
void settings() {
  size(N*SCALE, N*SCALE);
}

void setup() {
  fluid = new Fluid(0.2, 0.0, 0.0000001);
  CX = int(0.5 * (width / SCALE));
  CY = int(0.5 * (height / SCALE));
  colorMode(HSB, 255);
}

void draw() {
  background(0);
  
  for (int i = -1; i <= 1; i += 1) {
    for (int j = -1; j <= 1; j += 1) {
      fluid.addDensity(CX+i,CY+j,random(5,10));
    }
  }
  
  for (int i = 0; i < 2; i += 1) {
    float angle = noise(time) * TWO_PI * 2;
    PVector v = PVector.fromAngle(angle);
    v.mult(0.2);
    time += 0.1;
    fluid.addVelocity(CX,CY, v.x, v.y);
    
  }

  fluid.step();
  fluid.drawDensity();
  //fluid.drawVelocity();
  //fluid.fadeD();
 
  

}

void mouseDragged() {
  if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {
    fluid.addDensity(mouseX/SCALE, mouseY/SCALE, random(100));
    float amtX = mouseX - pmouseX;
    float amtY = mouseY - pmouseY;
    fluid.addVelocity(mouseX/SCALE, mouseY/SCALE, amtX, amtY);
  }
}
