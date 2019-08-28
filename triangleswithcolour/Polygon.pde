import java.awt.geom.Area;

class Polygon {
  ArrayList<PVector> points = new ArrayList<PVector>();
  Area area;

  PVector get(int i) {
    return points.get(i);
  }
  void draw() {
    //fill(random(255), random(255), random(255));
    noFill();
    stroke(255);
    pushMatrix();
    beginShape();
    for (PVector p : points) {
      vertex(p.x, p.y);
    }

    endShape(CLOSE);
    popMatrix();
  }
  
  void add(PVector p) {
    points.add(p);
    area = new Area(
  }
}


boolean onSegment(PVector p, PVector q, PVector r) {

  if (q.x < max(p.x, r.x) && q.x > min(p.x, r.x) && q.y < max(p.y, r.y) && q.y > min(p.y, r.y)) {
    return true;
  } else {
    return false;
  }
}

// To find orientation of ordered triplet (p, q, r).
// The function returns following values
// 0 --> p, q and r are colinear
// 1 --> Clockwise
// 2 --> Counterclockwise

int orientation(PVector p, PVector q, PVector r) {
  int val = int((q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y));

  if (val == 0) {
    return 0; //colinear
  }

  return (val > 0) ? 1 : 2; //
}



boolean doIntersect(PVector p1, PVector q1, PVector p2, PVector q2) {

  int o1 = orientation(p1, q1, p2);
  int o2 = orientation(p1, q1, q2);
  int o3 = orientation(p2, q2, p1);
  int o4 = orientation(p2, q2, q1);


  if (o1 != o2 && o3 != o4) return true;


  // Special Cases
  // p1, q1 and p2 are colinear and p2 lies on segment p1q1
  if (o1 == 0 && onSegment(p1, p2, q1)) return true;

  // p1, q1 and p2 are colinear and q2 lies on segment p1q1
  if (o2 == 0 && onSegment(p1, q2, q1)) return true;

  // p2, q2 and p1 are colinear and p1 lies on segment p2q2
  if (o3 == 0 && onSegment(p2, p1, q2)) return true;

  // p2, q2 and q1 are colinear and q1 lies on segment p2q2
  if (o4 == 0 && onSegment(p2, q1, q2)) return true;
  
  
  return false;
}

boolean isInside(Polygon polygon, int n, PVector p) {
  
  if (n < 3) {
    return false;
  }
  
  extreme.y = p.y;
  
  int count = 0, i = 0;
  
  do {
    int next = (i+1)%n;
    
    if (doIntersect(polygon.get(i),polygon.get(next),p,extreme)) {
      if (orientation(polygon.get(i), p, polygon.get(next)) == 0) {
        return onSegment(polygon.get(i), p, polygon.get(next));
      }
      count += 1;
    }
    
    i = next;
    
  } while (i != 0);
  
  return (count % 2 == 1);
  
    
}
