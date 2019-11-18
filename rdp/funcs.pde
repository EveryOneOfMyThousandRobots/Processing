int findFurthestIndex(ArrayList<PVector> points, int a, int b) {
  PVector start = points.get(a);
  PVector end = points.get(b);
  float holdDist = -1;
  int holdPoint = -1;
  for (int i =a+1; i < b; i += 1) {
    PVector curr = points.get(i);

    float d = lineDist(curr, start, end);
    if (d > holdDist || holdPoint == -1) {
      holdDist = d;
      holdPoint = i;
    }
  }
  if (holdDist > eps) {
    return holdPoint;
  } else {
    return -1;
  }
}

float lineDist(PVector c, PVector a, PVector b) {
 



  float aa = abs((b.y - a.y) * c.x - (b.x - a.x) * c.y + (b.x*a.y) - (b.y*a.x));
  float bb = PVector.dist(a,b);
  aa = aa / bb;
  
  

  return aa;
}
