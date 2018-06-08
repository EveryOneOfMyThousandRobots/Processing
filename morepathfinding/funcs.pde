final float MIN_DIST = 2;

boolean linesIntersect(PVector p1, PVector p2, PVector p3, PVector p4) {
  
  PVector sub1 = PVector.sub(p2, p1);
  float a = sub1.y / sub1.x;
  float b = p1.y - a * p1.x;

  PVector sub2 = PVector.sub(p4, p3);
  float a1 = sub2.y / sub2.x;
  float b1 = p3.y - a1 * p3.x;

  float x = (b1 - b) / (a - a1);
  float y = a * x + b;

  if ((x > min(p1.x, p2.x)) && (x < max(p1.x, p2.x)) 
    && (y > min(p1.y, p2.y)) && (y < max(p1.y, p2.y))
    && (x > min(p3.x, p4.x)) && (x < max(p3.x, p4.x)) 
    && (y > min(p3.y, p4.y)) && (y < max(p3.y, p4.y))) {

    if (dist(x,y,p1.x, p1.y) < MIN_DIST ||
    dist(x,y,p2.x, p2.y) < MIN_DIST ||
    dist(x,y,p3.x, p3.y) < MIN_DIST ||
    dist(x,y,p4.x, p4.y) < MIN_DIST) {
      return false;
    } else {
      return true;
    }
      
  }





  return false;
}
