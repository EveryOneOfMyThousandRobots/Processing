Polygon getPolygon(PVector A, PVector B, PVector C) {
  Polygon p = new Polygon();
  p.addPoint(floor(A.x),floor(A.y));
  p.addPoint(floor(B.x),floor(B.y));
  p.addPoint(floor(C.x),floor(C.y));
  return p;
}
