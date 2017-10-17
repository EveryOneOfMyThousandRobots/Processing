class Bug {
  PVector pos;
  float health;
  Brain brain;
  
  Bug (float x, float y) {
    pos = new PVector(x,y);
    brain = new Brain();
  }
  
  void update() {
  }
  
  void draw() {
    fill(255,128,128);
    stroke(0);
    ellipse(pos.x, pos.y, 10,10);
  }
}