class Bullet {
  Mover m;
  boolean dead = false;
  Bullet (float x, float y, PVector initialVelocity) {
    m = new Mover(x,y,1,1);
    m.applyForce(initialVelocity);
  }
  
  void update() {
    m.applyForce(GRAVITY);
    m.update();
    
    if (m.collided) {
      dead = true;
    }
    
    
  }
  
  void draw() {
    stroke(255,255,0);
    point(m.pos.x, m.pos.y);
  }
  
}