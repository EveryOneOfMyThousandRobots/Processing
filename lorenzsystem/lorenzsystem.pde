import peasy.*;
PeasyCam cam;

float x = 0.01;
float y = 0;
float z = 0;

float a  = 10;
float b = 28;
float c = 8.0/3.0;
float dx = 0;
float dy = 0;
float dz = 0;


float dt = 0;

float hue, sat, bright;
ArrayList<PVector> points = new ArrayList<PVector>();
void setup() {
  size(800, 600, P3D);
  background(0);
  textFont(createFont("Consolas", 10));
  colorMode(HSB);
  sat = 128;
  bright = 255;
  hue = 0;
  cam = new PeasyCam(this, 600);
  cam.lookAt(width / 2,height /2,0);
  frameRate(100);
}

void draw() {
  background(0);


  dt = 0.01;

  dx = (a * (y  - x)) * dt;
  dy = (x * (b  - z) - y) * dt;
  dz= (x * y - c * z) * dt;

  x += dx;
  y += dy;
  z += dz;
  points.add(new PVector(x, y, z));
  pushMatrix();
  translate(width / 2, height / 2);
  scale(5);
  hue = 0;
  //point(x,y,z);
  noFill();
  beginShape();
  for (PVector p : points) {
    hue += 0.1;
    hue = hue % 255;
    stroke(hue, sat, bright);
    vertex(p.x, p.y, p.z);
  }
  endShape();
  popMatrix();


  //text(x + "," + y + "," + z, 10,10);
}