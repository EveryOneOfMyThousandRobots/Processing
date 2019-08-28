class Machine {
  float x,y;
  String name;
  boolean storage = false;
  
  Machine(String name) {
    x = width / 2;
    y = height / 2;
    this.name = name;
    
  }
  
  void update() {
  }
  
  void draw() {
    stroke(255);
    fill(128);
    rect(x,y,20,20);
    
  }
}
