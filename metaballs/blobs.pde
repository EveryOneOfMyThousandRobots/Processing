class Blob {
  PVector pos,vel;
  
  float r;
  
  Blob() {
    this(random(width), random(height));
  }
  
  Blob(float x, float y ) {
    pos = new PVector(x,y);
    vel = PVector.random2D();
    vel.mult(random(1,5));
    r = 40;
  }
  
  void draw() {
    noFill();
    stroke(0);
    strokeWeight(4);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
  
  void update(){
    float newX = pos.x + vel.x;
    float newY = pos.y + vel.y;
    
    
    if (newX < 0 || newX > width) {
      vel.x *= -1;
    }
    if (newY < 0 || newY > height) {
      vel.y *= -1;
    }
    pos.add(vel);

  }
}