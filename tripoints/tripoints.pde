//imports
import java.awt.geom.Area;
import java.awt.Polygon;


ArrayList<PVector> points = new ArrayList<PVector>();
ArrayList<Polygon> polys = new ArrayList<Polygon>();


void setup() {
  size(500, 500);

  for (int i = 0; i < 1000; i += 1) {
    points.add(new PVector(random(width), random(height)));
  }
}

void draw() {
  background(0);
  drawPoints();
  drawPolys();
  for (int i = 0; i < 10; i += 1) {

    makeNew();
  }
}

void drawPoints() {
  stroke(255);
  strokeWeight(2);
  for (PVector p : points) {
    point(p.x, p.y);
  }
  strokeWeight(1);
}

void drawPolys() {
  stroke(255);
  fill(128);
  for (Polygon p : polys) {
    beginShape();
    for (int n = 0; n < p.npoints; n += 1) {
      vertex(p.xpoints[n], p.ypoints[n]);
    }
    endShape(CLOSE);
  }
}

PVector randPoint() {
  return points.get(floor(random(points.size())));
}

PVector randPoint(PVector from, float dist) {

  PVector p = null;
  while (true) {
    
    p = points.get(floor(random(points.size())));
    
    if (from.dist(p) <= dist) break; 
  }

  return p;
}

void makeNew() {

  PVector A = randPoint();
  PVector B, C;
  Area area;

  for (int counter = 0; counter < 100; counter += 1) {
    B = randPoint(A, 50);
    
    C = randPoint(A, 50);
    

    Polygon p = getPolygon(A, B, C);
    area = new Area(p);
    if (area.isEmpty()) continue;
    boolean ok = true;
    for (PVector pp : points) {
      if (area.contains(pp.x, pp.y)) {
        ok = false;
        break;
      }
    }

    if (ok) {
      for (Polygon p2 : polys) {
        Area area2 = new Area(p2);
        area2.intersect(area);
        if (!area2.isEmpty()) {
          ok = false;
          break;
        }
      }
    }

    if (ok) {
      polys.add(p);
      break;
    }
  }
}
