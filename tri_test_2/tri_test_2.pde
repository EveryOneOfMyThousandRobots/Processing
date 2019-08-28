ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<Tri> triangles = new ArrayList<Tri>();
final float MIN_DIST = 20;
final float MIN_SIZE = 100;
void setup() {
  size(400,400);
  
  while(points.size() < 50) {
    PVector p = new PVector(floor(random(20,width-20)),floor(random(20,height-20)));
    
    if (points.size() == 0) {
      points.add(p);
      continue;
    }
    
    for (int i = points.size()-1; i >= 0; i -= 1) {
      PVector pv = points.get(i);
      if (PVector.dist(p,pv) >= MIN_DIST) {
        points.add(p);
        break;
      }
    }
  }
}


PVector getRandomPoint(PVector from, float min, float max, PVector... notThese) {
  PVector p = null;
  
  while (p == null) {
    
    p = getRandomPoint(notThese);
    float dist = PVector.dist(from,p);
    if (dist > min && dist < max) {
      
    } else {
      p = null;
    }
  }
  
  return p;
  
}
PVector getRandomPoint(PVector... notThese) {
  PVector p = null;
  
  while(p == null) {
    p = points.get(floor(random(points.size())));
    
    if (notThese == null) {
      break;
    } else {
      for (int i = 0; i < notThese.length; i += 1) {
        if (PVE(p,notThese[i])) {
          p = null;
          break;
        }
      }
    }
  }
  return p; 
}

void makeTri() {
  PVector A = getRandomPoint();
  PVector B = getRandomPoint(A,20,100,A);
  PVector C = getRandomPoint(A,20,150,A,B);
  Tri tri = new Tri(A,B,C);
  
  if (tri.area < MIN_SIZE) {
    return;
  }
  
  for (PVector p : points) {
    if (PVE(A,p) || PVE(B,p) || PVE(C,p)) {
      continue;
    }
    
    if (pointInTriangle(A.x,A.y,B.x,B.y,C.x,C.y,p.x,p.y)) {
      return;
    }
  }
  
  
  if (AnyIntersections(A,B) || AnyIntersections(B,C) || AnyIntersections(C,A)) {
    return;
  } 
  
  triangles.add(tri);
  
  
  
 
}


void draw(){ 
  background(255);
  
  for(Tri tri : triangles) {
    tri.draw();
  }
  makeTri();
  
  for (PVector p : points) {
    circ(p,3,BLACK);
  }
  
  
}
