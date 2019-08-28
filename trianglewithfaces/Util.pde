float rand_range = 50;

PVector randVector(float x, float y) {
  PVector p = new PVector();
  float r = random(1, rand_range);
  float a = random(TWO_PI);

  p.x = x + r * cos(a);
  p.y = y + r * sin(a);


  return p;
}

boolean valid (PVector A, PVector B, PVector C) {
  Polygon a = getPolygon(A, B, C);
  if (!valid(A) || !valid(B) || !valid(C)) return false;

  if (PVector.dist(A, C) > rand_range) return false;
  if (PVector.dist(A, B) > rand_range) return false;


  Area area = new Area(a);

  if (area.isEmpty()) {
    return false;
  }

  for (Tri t : tris) {
    if (PVector.dist(t.points[0], A) > rand_range * 3) continue;
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


Tri addNew(PVector A, PVector B, PVector C, Tri... parents) {
  Tri t = new Tri(getPolygon(A, B, C));
  for (Tri p : parents) {
    p.addNeighbour(t);
    t.addNeighbour(p);

  }


  tris.add(t);
  return t;
}
