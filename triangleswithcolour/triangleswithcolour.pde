ArrayList<Polygon> polys = new ArrayList<Polygon>();
float range = 50;
PVector extreme;
void setup() {
  size(400, 400);
  extreme = new PVector(width * 100, 0);

  while (polys.size() < 100) {
    PVector p1 = null;
    if (polys.size() == 0) {
      p1 = new PVector(random(width), random(height));
    } else {
      Polygon pol = polys.get(floor(random(polys.size())));
      p1 = pol.points.get(floor(random(pol.points.size())));
    }
    if (insideAnother(p1)) {
      continue;
    }
    PVector p2 = findPoint(p1);
    PVector p3 = findPoint(p1);

    if (p2 == null || p3 == null ) {
      break;
    } else {
      Polygon poly = new Polygon();
      poly.add(p1);
      poly.add(p2);
      poly.add(p3);
      polys.add(poly);
    }
  }
}

boolean insideAnother(PVector p) {
  boolean returnVal = false;
  for (Polygon poly : polys) {
    if (isInside(poly, poly.points.size(), p)) {
      returnVal = true;
      break;
    }
  }
  return returnVal;
}

PVector findPoint(PVector origin) {
  PVector newP = null;
  boolean foundNewP = false;
  int counter = 0;
  while (!foundNewP && counter < 500) {
    counter += 1;
    foundNewP = true;
    newP = new PVector(random(origin.x-range, origin.x+range), random(origin.y-range, origin.y+range));
    if (polys.size() == 0) {
      return newP;
    }
    for (Polygon poly : polys) {
      if (isInside(poly, poly.points.size(), newP)) {
        foundNewP = false;
        newP = null;
        break;
      }
    }
  }

  return newP;
}

void draw() {
  background(0);
  for (Polygon poly : polys) {
    poly.draw();
  }
}
