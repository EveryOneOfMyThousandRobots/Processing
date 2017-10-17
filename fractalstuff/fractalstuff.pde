ArrayList<PVector> path;
float res = 10;
final float k = -4;
boolean draw_circles = false;
//float pathHue = 0;

//float r1;
//float x1, y1;
//float angle;
//float angle_inc = radians(1);
Orbit sun;

void setup() {
  size(600, 600);
  background(51);
  sun = new Orbit(width / 2, height / 2, width / 4, 0);
  for (int i = 1; i < 10; i += 1) {
    sun.addChild();
  }
  colorMode(HSB);

  //r1 = width / 6;
  //x1 = width / 2;
  //y1 = height / 2;
  //angle = 0;
  path = new ArrayList<PVector>();
}


void draw() {
  background(51);
  sun.update();
  sun.draw();
  
  float pathColourStep = (255.0 / (path.size()+1));
  float pathSatStep = pathColourStep;//(255.0 / (path.size()+1));
  boolean first = true;
  float preX = 0, preY = 0;
  float pathHue = 0;
  float pathSat = 0;
  for (PVector pos : path) {
    pathHue += pathColourStep;
    pathSat += pathSatStep;
    if (first) {
      first = false;
    } else {
      
      stroke(pathHue, pathSat,255);
      beginShape();
      vertex(preX, preY);
      vertex(pos.x, pos.y);
      endShape();
    }
    preX = pos.x;
    preY = pos.y;
    
    
    
  }
  
}