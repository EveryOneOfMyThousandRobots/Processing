import controlP5.*;

ControlP5 cntrl;
enum COL {
  R, G, B, ALL, A;
}

void setup() {
  size(800,600);
  
  cntrl = new ControlP5(this);
  
  //cntrl.addButton("newImage").setPosition(0,0).setLabel("load image").setHeight(15);
  ButtonBar bar = cntrl.addButtonBar("btnbarTop").setPosition(0,0).setSize(800,20).addItems(split("load images, output movie", ","));
  
  println(bar.get
  
}


void draw() {
}
