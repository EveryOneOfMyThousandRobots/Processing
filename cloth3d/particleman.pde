class Particle extends VerletParticle3D {
  
  Particle(float x, float y, float z) {
    super(x,y,z);
  }
  
  void draw() {
    fill(255);
    //ellipse(x,y,z,2,2);
  }
}