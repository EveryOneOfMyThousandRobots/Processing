class Resource {
  float x, y;
  String name;
  color c;
  Resource(int x, int y, String name) {
    this.x = x;
    this.y = y;
    this.name = name;
    c = color(random(255), random(255), random(255));
  }
  void draw() {
    stroke(0);
    fill(c);
    rect(x,y,20,20);
    
  }  
  void update() {
  }
}
