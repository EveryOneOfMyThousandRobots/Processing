import controlP5.*;

ArrayList<ActionEntity> aEntities = new ArrayList<ActionEntity>();

ControlP5 GUI;

void setup() {
  size(400,400);
  GUI = new ControlP5(this);
  ButtonBar bar = GUI.addButtonBar("buttons");
  bar.setPosition(0,width-50);
  bar.setHeight(50);
  bar.setWidth(width);
  bar.addItems(split("create remove", " "));
  
  
  
  aEntities.add( new Resource("gold", true, false, false, color(255,255,0), width / 2, height / 2));
}


void draw() {
  
  background(0);
  for (ActionEntity a : aEntities) {
    if (a instanceof Resource) {
      Resource r = (Resource) a;
      r.draw();
    }
  }
}
