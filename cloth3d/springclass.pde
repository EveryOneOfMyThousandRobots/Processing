class Spring extends VerletSpring3D{
  
  Spring(Particle a, Particle b) {
    super(a,b,DIST, random(0.4,0.7));
  }
  
  void draw() {
    stroke(255);
    line(a.x, a.y, a.z, b.x, b.y, b.z);
  }
  
}