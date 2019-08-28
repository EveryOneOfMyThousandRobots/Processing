PVector mouseV;
Mover m;
void setup() {
  size(600,600);
  
  m = new Mover(width / 2, height / 2);
   mouseV = new PVector(); 
}

void draw() {
  background(255);
  setMouse();
  m.seek(mouseV);
  m.update();
  m.draw();
  
}

void setMouse() {
  
  mouseV.set(mouseX, mouseY);
  
}
  
