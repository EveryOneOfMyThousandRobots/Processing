class ParticleType {
  final int id;
  {
    ID += 1;
    id = ID;
  }


  ArrayList<ParticleForce> forces = new ArrayList<ParticleForce>();
  color c = color(random(255), 255, 255);
  
  
  void makeForces() {
    for (ParticleType type : types) {
     
      
      forces.add( new ParticleForce(type));
    }
  }
}
final float MAX_DIST = 100;
class ParticleForce {
  ParticleType otherType;

  float minDist = 10;
  float maxDist = random(minDist, MAX_DIST);
  float mid = random(minDist, maxDist);
  
  //float maxForce = random(-3,3);
  float angle = random(-PI,PI);
  
  ParticleForce(ParticleType other) {
    otherType = other;
  }
}
