boolean onSegment(PVector p, PVector q, PVector r) {
  
  
  
  if (q.x <= max(p.x, r.x) && q.x >= min(p.x, p.y) && 
    q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y)) {
    return true;
  } else {
    return false;
  }
  

}

int orientation(PVector p, PVector q, PVector r) {
  int val = (int)((q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y));
  
  if (val == 0) return 0; //colinear
  
  return (val > 0) ? 1: 2;
}

//boolean doIntersect(Point a, Point b) {
//  PVector p1 = a.pos.copy();
//  PVector q1 = 
//}