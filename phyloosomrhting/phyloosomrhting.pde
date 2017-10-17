float n = 0;
float a = 0;
float c = 6;
float r = 0;
float x, y;
float w2, h2;
float hue, sat, bri;
PVector centre;
PVector current;
float angle = radians(137.3);
float angle_brightness = 0;
float one_radian = radians(1);
void setup() {
  size(500,500);
  background(0);
  colorMode(HSB);
  hue = 0; 
  sat = 255;
  bri = 255;
  centre = new PVector(width / 2, height / 2);
  current = new PVector();
  w2 =  width / 2;
  h2 = height / 2;
  frameRate(100);
  blendMode(ADD);
}


void draw() {
  angle_brightness += one_radian;
  if (angle_brightness > TWO_PI) {
    angle_brightness -= TWO_PI;
  }
  bri = map(sin(angle_brightness), -1, 1, 0, 255);
  
  
  hue += 1;
  if(hue > 255) {
    hue = 0;
  }
  n += 1;
  a = n * angle;
  r = c * sqrt(n);
  
  x = w2 + r * cos(a);
  y = h2 + r * sin(a);
 // c = 6 + cos(a);

  current.x = x;
  current.y = y;
  
  fill(hue, sat, bri);
  noStroke();
  float dist = PVector.dist(centre, current);
  float size = map(dist, 0, width, 1, 8);
  ellipse(x,y,size,size);
}