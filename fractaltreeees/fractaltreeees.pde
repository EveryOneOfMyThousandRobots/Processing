Slider slider_angle, slider_length;
float angle = 0;
float angle_inc = radians(1);
void setup() {
  size(400,400);
  slider_angle = new Slider(0,0.01, TWO_PI);
  slider_length = new Slider(20,0.1,0.7);
}


void draw() {
  background(0);
  stroke(255);
  pushMatrix();
  translate(width/2,height);
  branch(100);
  popMatrix();
  slider_angle.draw();
  slider_length.draw();
  //float sa = map(sin(angle), -1, 1, 0, 1);
  //slider.setValue(sa);
  //angle = (angle + angle_inc) % TWO_PI;
  
}


void branch(float len) {
  if (len < 1) return;
  line(0,0,0,-len);
  translate(0,-len);
  pushMatrix();
  rotate(slider_angle.getValue());
  branch(len * slider_length.getValue());
  popMatrix();
  pushMatrix();
  rotate(-slider_angle.getValue());
  branch(len * slider_length.getValue());
  popMatrix();
  
  
  
  
}

void mouseDragged() {
  slider_angle.setValue();
  slider_length.setValue();
}

void mousePressed() {
  slider_angle.setValue();
  slider_length.setValue();
}
