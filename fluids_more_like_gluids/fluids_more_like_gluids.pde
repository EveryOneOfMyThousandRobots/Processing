final int N = 64;
final int ITERATIONS = 4;
final int RES = 8;
PGraphics canvas;
void settings() {

  size(N*RES, N*RES);
  noSmooth();
}
Fluid fluid;
void setup() {
  canvas = createGraphics(N, N);
  fluid = new Fluid(0.02, 1e-10, 1e-8);
}


void draw() {

  for (int i = 0; i < N; i += 1) {
    fluid.addVel(i, 1, 0, 3);
  }
  fluid.update();
  fluid.draw(canvas);

  image(canvas, 0, 0, width, height);
}

void mouseDragged() {
  
    float amtX = mouseX - pmouseX;
    float amtY = mouseY - pmouseY;
    fluid.addDye(mouseX/RES, mouseY/RES, 255);
    fluid.addVel(mouseX/RES, mouseY/RES, amtX, amtY);
  
}
