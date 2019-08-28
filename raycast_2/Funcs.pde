Tile getTileAt(int x, int y) {
  if (!valid(x,y)) {
    return null;
  } else {
    return tiles[x][y];
  }
}
boolean valid(int x, int y) {
  if (x < 0 || x > NUM_TILES_ACROSS-1 || y < 0 || y > NUM_TILES_DOWN -1) {
    return false;
  } else {
    return true;
  }
}
boolean intersect(PVector s1, PVector e1, PVector s2, PVector e2) {
  
  float t = t(s1, e1, s2, e2);
  float u = u(s1, e1, s2, e2);
  
  if (t >= 0 && t <= 1 && u >= 0 && u <= 1) {
    
    return true;
  }
  
  
  
  
  
  return false;
}

float quickDist(PVector A, PVector B) {
  return pow(A.x - B.x, 2) + pow(A.y - B.y, 2); 
}



float t(PVector s1, PVector e1, PVector s2, PVector e2) {
  return t(s1.x, s1.y, e1.x, e1.y, s2.x, s2.y, e2.x, e2.y);
}

float t(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float te = (x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4);
  float td = ud(x1, y1, x2, y2, x3, y3, x4, y4);
  return te / td;
}

float u(PVector s1, PVector e1, PVector s2, PVector e2) {

  return u(s1.x, s1.y, e1.x, e1.y, s2.x, s2.y, e2.x, e2.y);
}

float u(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float ue = (x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3);
  float ud = ud(x1, y1, x2, y2, x3, y3, x4, y4);
  return -(ue / ud);
}

float ud(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  return (x1 - x2) * (y3 - y4) - (y1 - y2)*(x3-x4);
}
