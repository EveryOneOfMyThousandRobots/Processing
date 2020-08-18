
long time() {
  return System.nanoTime();
  
}


void setup() {
  size(400,400, P3D);
}

long time_last = time();
long time_now = time();
long time_delta = 0;
float dt = 0;

float angleX = 0;
float angleXi = 0.5;
float angleY = 0;
float angleYi = 0.75;
float angleZ = 0;
float angleZi = 1;
void draw() {
  time_now = time();
  time_delta = time_now - time_last;
  time_last = time_now;
  dt = (float)time_delta / 1e9;
  
  angleX += angleXi * dt;
  angleY += angleYi * dt;
  angleZ += angleZi * dt;
  
  
  background(0);
  pushMatrix();
  translate(0,0,100);
  box(width*2,height*2,1);
  
  popMatrix();
  
  
  pushMatrix();
  
  translate(width / 2, height / 2, 100);
  
  
  
  rotateX(angleX);
  rotateY(angleY);
  rotateZ(angleZ);
  
  box(50);
  
  
  
  popMatrix();
  
}
