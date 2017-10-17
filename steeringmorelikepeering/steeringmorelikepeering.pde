PVector mouse;
Vehicle v;
void setup() {
  size(600,600);
  mouse = new PVector(mouseX, mouseY);
  v = new Vehicle(width / 2, height / 2);
}


void draw() {
  background(0);
  stroke(255);
  fill(128);
  mouse.set(mouseX, mouseY);
  ellipse(mouse.x, mouse.y, 20,20); 
  v.seek(mouse);
  v.update();
  v.draw();
  
}