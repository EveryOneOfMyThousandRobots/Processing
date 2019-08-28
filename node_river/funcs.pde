float t(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float t = (x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4);
  t /= (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  return t;
}

float u(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float u = (x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3);
  u /= (x1 - x2) * (y3 - y4) - (y1 - y2) *(x3-x4);

  return -u;
}
boolean OOB_ext(float x, float y) {
  return (x < -OUTSIDE_BORDER || x > WW + OUTSIDE_BORDER || y < -OUTSIDE_BORDER || y > WH + OUTSIDE_BORDER);
}
boolean linesIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if (pairSame(x1, y1, x3, y3) || pairSame(x1, y1, x4, y4) || pairSame(x2, y2, x3, y3) || pairSame(x2, y2, x4, y4)) {
    return false;
  }
  float t = t(x1, y1, x2, y2, x3, y3, x4, y4);
  float u = u(x1, y1, x2, y2, x3, y3, x4, y4);

  return t >= 0 && t <= 1 && u >= 0 && u <= 1;
}


boolean lineIntersect(PVector A1, PVector A2, PVector B1, PVector B2) {
  return linesIntersect(A1.x, A1.y, A2.x, A2.y, B1.x, B1.y, B2.x, B2.y);
}


boolean pairSame(float x1, float y1, float x2, float y2) {
  return floor(x1) == floor(x2) && floor(y1) == floor(y2);
}

PVector intersectionPoint(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  PVector p = new PVector();
  float t = t(x1, y1, x2, y2, x3, y3, x4, y4);
  
  p.x = (x1 + t * (x2 - x1));
  p.y = (y1 + t * (y2 - y1));
  
  return p;
  
}

PVector intersectionPoint(PVector A1, PVector A2, PVector B1, PVector B2) {
  return intersectionPoint(A1.x, A1.y, A2.x, A2.y, B1.x, B1.y, B2.x, B2.y);
}

boolean same(PVector p, float x, float y) {
  return floor(p.x) == floor(x) && floor(p.y) == floor(y);
}

boolean sameStart(Node A, Node B) {
  return floor(A.pos.x) == floor(B.pos.x) && floor(A.pos.y) == floor(B.pos.y);
}
