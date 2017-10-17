float len_factor = 0.5;
float len_factor_angle = 0;
float angle_inc = radians(30);
float angle_inc_angle = 0;

void drawLine(float angle_inc, float len, int count) {
  if (len < 3 || count > 31) return;
  
  line(0,0,0,-len);
  pushMatrix();
  translate(0,-len);
  rotate(angle_inc);
  drawLine(angle_inc, len * len_factor, count + 1);
  popMatrix();
  pushMatrix();
  translate(0,-len);
  rotate(angle_inc);
  drawLine(-angle_inc, len * len_factor, count + 1);
  
  popMatrix();
  
}

void setup() {
  
  size(600,600);
  stroke(255);
  //noLoop();
  background(0);
}

void draw() {

  noStroke();
  fill(0,100);
  rect(0,0,width, height);
  stroke(255);
  pushMatrix();
  translate(width / 2, height);
  drawLine(angle_inc, height / 4, 1);
  drawLine(-angle_inc, height / 4, 1);
  popMatrix();
  len_factor_angle += radians(1);
  if (len_factor_angle > TWO_PI) len_factor_angle -= TWO_PI;
  angle_inc_angle += radians(1.0/3.0);
  if (angle_inc_angle > TWO_PI) { 
    angle_inc_angle -= TWO_PI;
    stop();
  }
  len_factor = map(sin(len_factor_angle), -1, 1, 0.5, 0.7);
  angle_inc = map(cos(angle_inc_angle), -1, 1, radians(10), radians(45));
  
  saveFrame("frames/####.tif");
}