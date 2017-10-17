//Path path;
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>(100);
//PVector mouse;
//Vehicle v;
void setup() {
  size(600, 600);
  //mouse = new PVector(mouseX, mouseY);
  //v = new Vehicle(width / 2, height / 2);


  vehicles.add(new Vehicle(width / 2, height / 2));
  //path = new Path(0, random(height), width, random(height), 10);
  float angle = TWO_PI / 6;
  float radius = width / 3;
  float cx = width / 2;
  float cy = height / 2;
  float sx = 0, sy = 0;
  float lx = 0, ly = 0;
  lx = cx + radius * cos(angle * 5);
  ly = cy + radius * sin(angle * 5);
  for (float i = 0; i < 6; i += 1) {
    sx = cx + radius * cos(angle * i);
    sy = cy + radius * sin(angle * i);
    paths.add(new Path(lx, ly, sx, sy, 10));
    println(sx + "," + sy + " " + lx + "," + ly);
    lx = sx;
    ly = sy;
    
  }
}


void draw() {
  background(255);
  stroke(255);
  fill(128);

  for (Vehicle v : vehicles ) {
    //PVector find = flowfield.find(v.pos); 
    //println(find);
    //v.seek(find);
    //v.follow(path);
    v.follow(paths);
    v.update();
    v.draw();
  }

  for (Path path : paths) {
    path.draw();
  }




  //mouse.set(mouseX, mouseY);
  //ellipse(mouse.x, mouse.y, 20,20); 
  //v.seek(mouse);
  //v.update();
  //v.draw();
}

void mouseReleased() {
  vehicles.add(new Vehicle(mouseX, mouseY));
}