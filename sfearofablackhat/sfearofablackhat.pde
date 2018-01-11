void setup() {
  size(600,400, P3D);
}

float angle = 0;

void draw() {
  background(0);
  
  stroke(255);
  noFill();
  pushMatrix();
  translate(width / 2, height / 2);
  rotateY(angle);
  angle += 0.03;
  beginShape();
  float beta = 0;
  while (beta < PI) {
    float r = (0.8 + 1.6 * sin(6 * beta)) * 100;
    float theta = 2 * beta;
    float phi = 0.6 * PI * sin(12 * beta);
    
    float x = r * cos(phi) * cos(theta);
    float y = r * cos(phi) * sin(theta);
    float z = r * sin(phi);
    
    beta += 0.005;
    vertex(x,y,z);
  }
  endShape();
  popMatrix();
}