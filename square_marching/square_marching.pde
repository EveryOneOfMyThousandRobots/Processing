class sRect {
}

class sCirc {
}

float signedDistToCircle(PVector p, PVector centre, float radius) {
  
  return PVector.dist(p,centre) - radius;
}

float signedDistToBox(PVector p, PVector centre, PVector size) {
  
  PVector offset = PVector.sub(PVector.sub(centre,p),size);
  float unsignedDist = 
}


void setup() {
}


void draw() {
}
