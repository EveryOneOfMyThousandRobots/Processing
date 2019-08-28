class ParentCircle{
  
  PVector pos;
  float r;
  float x, y;
  
  float a; 
  float step;
  int dir;
  
  ParentCircle(float x, float y, float r, float step, int dir) {
    pos = new PVector(x,y);
    this.r = r;
    this.step = step;
    this.dir = dir;
  }
  
  void update() {
    a += radians(step);
    x = pos.x + r * cos(a - HALF_PI);
    y = pos.y + r * sin(a - HALF_PI);
    a = a % TWO_PI;
    
  }
  
  void draw() {
    stroke(255);
    noFill();
    strokeWeight(1);
    ellipse(pos.x, pos.y, r*2, r*2);
    
    fill(255);
    ellipse(x,y,4,4);
    stroke(255,100);
    if (dir == 0) {
      line(x, 0, x, height);
    }else{ 
      line(0, y, width, y);
    }
  }
  
  
  
  
}
