class Particle extends VerletParticle2D {
  
  Particle(float x, float y) {
    super(x,y);
  }
  
  void draw() {
    fill(255);
    ellipse(x,y,2,2);
  }
}