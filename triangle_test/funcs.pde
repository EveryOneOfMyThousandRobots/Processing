void drawTri(PVector a, PVector b, PVector c) {
  stroke(0);
  fill(255,0,0,32);
  beginShape();
  vertex(a.x, a.y);
  vertex(b.x, b.y);
  vertex(c.x, c.y);
  endShape(CLOSE);
}
boolean pointInTriangle(Tri t, PVector p) {
  
  
}

boolean PVE(PVector a, PVector b) {
  
}

boolean pointInTriangle(float x1, float y1, float x2, float y2, float x3, float y3, float x, float y)
{
  float denominator = ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
  float a = ((y2 - y3)*(x - x3) + (x3 - x2)*(y - y3)) / denominator;
  float b = ((y3 - y1)*(x - x3) + (x1 - x3)*(y - y3)) / denominator;
  float c = 1.0 - a - b;

  return 0 <= a && a <= 1 && 0 <= b && b <= 1 && 0 <= c && c <= 1;
}


boolean AnyIntersections(PVector a, PVector b) {
  for (Tri t : triangles) {




    if (linesIntersect(a, b, t.A, t.B) || linesIntersect(a, b, t.B, t.C) || linesIntersect(a, b, t.A, t.C)) {
      return true;
    }
  }
  return false;
}


float t(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float n = (x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4);
  return n / ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x4 - x4));
}

float u(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float n = (x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 -x3);
  n /= (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  return -n;
}

boolean linesIntersect(PVector A1, PVector A2, PVector B1, PVector B2) {
  if ((A1 == B1 && A2 == B2) || (A1 == B2 && A2 == B1)) return true; 
  if (A1 == B1 || A1 == B2 || A2 == B1 || A2 == B2) return false;
  float nt = t(A1.x, A1.y, A2.x, A2.y, B1.x, B1.y, B2.x, B2.y);
  float nu = u(A1.x, A1.y, A2.x, A2.y, B1.x, B1.y, B2.x, B2.y);
  
  if (nt >= 0 && nt <= 1 && nu >= 0 && nu <= 1) {
    return true;
  } else {
    return false;
  }
  
}

PVector intersection(PVector A1, PVector A2, PVector B1, PVector B2) {
  float nt = t(A1.x, A1.y, A2.x, A2.y, B1.x, B1.y, B2.x, B2.y);
  float x = A1.x + (nt * (A2.x - A1.x));
  float y = A1.y + (nt * (A2.y - A1.y));
  return new PVector(x,y);
}
