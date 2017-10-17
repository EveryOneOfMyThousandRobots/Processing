FlowField flowfield;
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>(100);
//PVector mouse;
//Vehicle v;
void setup() {
  size(600,600);
  //mouse = new PVector(mouseX, mouseY);
  //v = new Vehicle(width / 2, height / 2);
  flowfield = new FlowField(20);
  
  vehicles.add(new Vehicle(width / 2, height / 2));
  
}


void draw() {
  background(0);
  stroke(255);
  fill(128);
  
  for (Vehicle v : vehicles ) {
    PVector find = flowfield.find(v.pos); 
    //println(find);
    v.seek(find);
    v.update();
    v.draw();
  }
  
  flowfield.draw();
  flowfield.update();
  
  
  //mouse.set(mouseX, mouseY);
  //ellipse(mouse.x, mouse.y, 20,20); 
  //v.seek(mouse);
  //v.update();
  //v.draw();
  
}

void mouseReleased() {
  vehicles.add(new Vehicle(mouseX, mouseY));
}