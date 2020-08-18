float u(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float u = (x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3);
  u /= (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  
  return -u;
}

float t(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float t = (x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4);
  t /= (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  
  return t;
}

boolean linesIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  
  float t = t(x1,y1,x2,y2, x3, y3, x4, y4);
  float u = u(x1,y1,x2,y2, x3, y3, x4, y4);
  
  return (t >= 0 && t <= 1 && u >= 0 && u <= 1) ;
}

PVector getIntersectionPoint(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  PVector p = new PVector();
  
  float t = t(x1,y1,x2,y2, x3, y3, x4, y4);
  
  p.x = (x1 + (t * (x2-x1)));
  p.y = (y1 + (t * (y2-y1)));
  
  
  
  return p;
  
}
