import controlP5.*;

ControlP5 win;


void setup() {
  size(800,600);
  win = new ControlP5(this);
  
  win.addSlider("a").setPosition(100,50).setRange(0,255);
  
  
}


void draw() {
  background(0);
  
}
