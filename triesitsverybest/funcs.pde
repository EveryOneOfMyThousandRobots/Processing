boolean valid (PVector A, PVector B, PVector C) {
  Polygon a = getPolygon(A,B,C);
  if (!valid(A) || !valid(B) || !valid(C)) return false;
  
  if (dist(A.x, A.y, C.x, C.y) > rand_range) return false;
  if (dist(A.x, A.y, B.x, B.y) > rand_range) return false;
  
  
  Area area = new Area(a);
  
  if (area.isEmpty()) {
    return false;
  }
  
  for (Tri t : tris) {
    area = new Area(a);
    area.intersect(t.area);
    
    if (!area.isEmpty()) {
      return false;
    }
    
    
  }
  
  return true;
}

boolean valid(PVector A) {
  if (A.x < 0 || A.x >= width || A.y < 0 || A.y > height) {
    return false;
  } else {
    return true;
  }
}


Polygon getPolygon(PVector A, PVector B, PVector C) {
  Polygon p = new Polygon();
  p.addPoint(floor(A.x),floor(A.y));
  p.addPoint(floor(B.x),floor(B.y));
  p.addPoint(floor(C.x),floor(C.y));
  return p;
}
