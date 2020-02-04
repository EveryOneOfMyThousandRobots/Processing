final int MODULE_HEIGHT = 50;
final int MODULE_WIDTH = 70;
final int CONN_SIZE = MODULE_HEIGHT / 4;




ArrayList<Module> mods = new ArrayList<Module>();
void setup() {
  size(800, 800);
  mods.add(new Module(width / 4, height / 2, TYPE.CLOCK));
  mods.add(new Module(width / 2, height / 2, TYPE.OR));
}


void draw() {
  background(0);
  for (Module mod : mods) {
    mod.update();
    mod.draw();
  }
  
  if (dragConn) {
    stroke(255);
    float x = dragConnSrc.outputPos[dragConnSrcOutput].x;
    float y = dragConnSrc.outputPos[dragConnSrcOutput].y;
    line(x, y, mouseX, mouseY);
  }
}

//Module overModule(float x, float y) {
  
//}
