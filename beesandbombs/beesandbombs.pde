float angle = 0;
float h = 100;
float w = 10;
void setup() {
  size(400, 400, P3D);
  rectMode(CENTER);
  ortho();
}


void draw() {
  background(0);
  //stroke(128);
  //fill(255);
  directionalLight(255,255,255,0,-1,0);
  //float h = 100;
  
  translate(0, height / 2, -100);
  rotateX(-QUARTER_PI);
  float offset = 0;
  for (int x = 0; x < width; x += w) {
    pushMatrix();
    ambient(RGB);
    float a = angle + offset;



    translate(x,0,0);

    h = map(sin(a), -1, 1, 0, 100);

    box(w, h, w);
    offset += 0.1;
    popMatrix();
  }
  angle = (angle + 0.05) % TWO_PI;
}
