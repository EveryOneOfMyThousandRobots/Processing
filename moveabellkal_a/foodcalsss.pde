class Food {
  PVector pos;
  float value;
  
  Food() {
    this(random(width), random(height));
  }
  
  Food(float x, float y) {
    this(x,y,random(1,5));
  }
  
  Food(float x, float y, float value) {
    pos = new PVector(x,y);
    this.value = value;
  }
  
  void draw() {
    noStroke();
    fill(0,128,20);
    ellipse(pos.x, pos.y, 3, 3);
  }
}