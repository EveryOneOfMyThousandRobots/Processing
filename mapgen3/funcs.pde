float t(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  
  float t = ((x1 - x3) * (y3 - y4)) - ((y1 - y3) * (x3 - x4));
  t /= ((x1 - x2) * (y3 - y4)) - (y1 - y2) * (x3 - x4);
  
  return t;
}

float u(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  
  float u = (x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3);
  u /= (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  
  
  return -u;
  
  
}

boolean same(float x1, float y1, float x2, float y2) {
  return (x1 == x2 && y1 == y2);  
}


boolean linesIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  
  if (same(x1,y1,x3,y3) || same(x1,y1,x4,y4) || same(x2,y2,x3,y3) || same(x2,y2,x4,y4)) return false;
  
  
  float t = t(x1,y1,x2,y2,x3,y3,x4,y4);
  float u = u(x1,y1,x2,y2,x3,y3,x4,y4);
  
  if (t >= 0 && t <= 1 && u >= 0 && u <= 1) {
    return true;
  } else {
    return false;
  }
  
}

PVector intersectionPoint(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float t = t(x1,y1,x2,y2,x3,y3,x4,y4);
  
  return new PVector(x1 + t * (x2 - x1), y1 + t *(y2 - y1)); 
  
}
