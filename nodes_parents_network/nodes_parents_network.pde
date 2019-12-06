


Network network;

void setup() {
  size(800,600);
  network = new Network();
 //frameRate(5); 
}


void draw() {
  background(0);
  //network.print();
  network.adjust();
  network.update();
  network.draw();
  
}

void keyReleased() {
  if (key == 'R') {
    network = new Network();
  }
}
