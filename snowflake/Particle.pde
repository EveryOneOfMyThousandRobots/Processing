class Particle {
  float x,y;
  float r;
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    r = 3;
  }
  
  void update() {
    x -= 1;
    y += random(-1,1);
    
  }
  
  boolean finished() {
    return (x < 0);
  }
  
  void draw() {
    noStroke();
    fill(255);
    ellipse(x,y,r*2,r*2);
  }
  
  boolean intersects(ArrayList<Particle> list) {
    for (Particle p : list) {
      float d = dist(this.x, this.y, p.x, p.y);
      if (d <= r*2) {
        return true;
        
      }
    }
    return false;
  }
  
}
