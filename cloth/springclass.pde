class Spring extends VerletSpring2D{
  
  Spring(Particle a, Particle b) {
    super(a,b,w, 0.7);
  }
  
  void draw() {
    stroke(255);
    line(a.x, a.y, b.x, b.y);
  }
  
}