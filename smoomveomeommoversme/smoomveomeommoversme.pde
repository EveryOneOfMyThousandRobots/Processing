class Shp {
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  void add(float x, float y) {
    points.add(new PVector(x,y));
  }
  
  void draw() {
    stroke(255,0,0);
    noFill();
    PVector p;
    for (int i = 0; i < points.size(); i += 1) {
      p = points.get(i);
      ellipse(p.x, p.y, 5, 5);
      PVector pp = null;
      if (i > 0) {
        pp = points.get(i-1);
        
        
      } else {
        pp = points.get(points.size() - 1);
      }
      line(pp.x, pp.y, p.x, p.y);
    }
    
    
  }
  
}

PVector m;


Shp tri1, tri2, target;

void setup() {
  tri1 = new Shp();
  tri2 = new Shp();
  
  size(1000,1000);
  frameRate(1000);
  
  tri1.add(width * 0.66, height * 0.3);
  tri1.add(width * 0.9, height * 0.6);
  tri1.add(width * 0.5, height * 0.7);
  
  tri2.add(width * 0.33, height * 0.6);
  tri2.add(width * 0.4, height * 0.5);
  tri2.add(width * 0.45, height * 0.7);
  
  background(0);
  tri1.draw();
  tri2.draw();
  m = new PVector(width / 2, height / 2);
  target = tri1;
}

void draw() {
  stroke(255);
  
  int r = (int) (random(0, target.points.size()));
  int s = (int) random(0,100);
  PVector t = target.points.get(r);
  
  PVector A = m.copy();
  PVector B = t.copy();
  PVector AB = B.sub(A);
  AB.x *= random(0.04, 0.85);
  AB.y *= random(-0.04, 0.85);
  m.add(AB);
  point(m.x, m.y);
  if (s <= 20) {
    target = tri2;
    
  } else {
   target = tri1; 
  }
  
  
  
  
  
}