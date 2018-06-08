
Area tempArea;
void makeNew() {
  PVector A = randPoint();
  PVector B, C;
  ArrayList<PVector> list = new ArrayList<PVector>();
  list = getPoints(A.x-50, A.y-50, 100, 100);
  if (list.size() == 0 ) return;
  for (int counter = 0; counter < 10; counter += 1) {
    B = randPoint(list);
    C = randPoint(list);
    
    Polygon p = getPolygon(A,B,C);
    tempArea = new Area(p);
    if (tempArea.isEmpty()) continue;
    boolean ok = true;
    
    for (PVector pp : list) {
      if (tempArea.contains(pp.x, pp.y)) {
        ok = false; 
        break;
      }
    }
    
    if (ok) {
      polys.add(p);
      
    }
    
    
  }
}

PVector randPoint(ArrayList<PVector> list) {
  return list.get(floor(random(list.size())));
}

PVector randPoint() {
  return points.get(floor(random(points.size())));
}

Polygon getPolygon(PVector A, PVector B, PVector C) {
  Polygon p = new Polygon();
  p.addPoint(floor(A.x),floor(A.y));
  p.addPoint(floor(B.x),floor(B.y));
  p.addPoint(floor(C.x),floor(C.y));
  return p;
}
