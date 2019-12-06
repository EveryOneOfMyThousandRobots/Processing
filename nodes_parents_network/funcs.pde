

float t(float x1, float y1, float x2,float y2,float x3,float y3,float x4,float y4) {
  
  float t = (x1 - x3) * (y3 - y4) - (y1 - y3)*(x3 - x4);
  t /= (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  
  return t;
}

float u(float x1, float y1, float x2,float y2,float x3,float y3,float x4,float y4) {
  
  float u = (x1 - x2) * (y1 - y3) - (y1 - y2)*(x1 - x3);
  u /= (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  
  return -u;
}

boolean linesIntersect(PVector A1, PVector A2, PVector B1, PVector B2) {
  float t = t(A1.x, A1.y, A2.x, A2.y, B1.x, B1.y, B2.x, B2.y);
  float u = u(A1.x, A1.y, A2.x, A2.y, B1.x, B1.y, B2.x, B2.y);
  
  return (u >= 0 && u <= 1 && t >= 0 && t <= 1);
}

PVector getIntersectionPoint(PVector A1, PVector A2, PVector B1, PVector B2) {
  float t = t(A1.x, A1.y, A2.x, A2.y, B1.x, B1.y, B2.x, B2.y);
  PVector p = new PVector();
  p.x = A1.x + t * (A2.x - A1.x);
  p.y = A1.y + t * (A2.y - A1.y);
  
  return p;
}
